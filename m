From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: Avoid dropping files from commits
Date: Wed, 25 Mar 2009 20:36:38 -0700
Message-ID: <7vy6utt0op.fsf@gitster.siamese.dyndns.org>
References: <1238014519-11683-1-git-send-email-newren@gmail.com>
 <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 04:39:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmgQl-0005is-Im
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 04:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbZCZDgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 23:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbZCZDgu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 23:36:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZCZDgt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 23:36:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 81A6DA5498;
	Wed, 25 Mar 2009 23:36:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C540FA5497; Wed,
 25 Mar 2009 23:36:39 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903252312460.26370@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Wed, 25 Mar 2009 23:13:23 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 55B130FE-19B7-11DE-A7E5-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114717>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 25 Mar 2009, newren@gmail.com wrote:
>
>> From: Elijah Newren <newren@gmail.com>
>> 
>> When exporting a subset of commits on a branch that do not go back to a
>> root commit (e.g. master~2..master), we still want each exported commit to
>> have the same files in the exported tree as in the original tree.
>> 
>> Signed-off-by: Elijah Newren <newren@gmail.com>
>> ---
>
> Makes sense.

Hmm, does it?

Shouldn't an export with a bottom commit be always considered an
incremental?  Why special case --import-marks?

When you say "I want to export master~2..master", isn't the intention
(unstated, because it is too obvious) that follows it "... because I do
have master~2 already and I would want to replay the export on top of that
state"?  If all of master~2, master~1 and master have a file "frotz" with
exactly the same contents, I thought you wouldn't even have to have that
same contents repeated in the export datastream.

Or am I (again) entirely misunderstanding the intended use case?
