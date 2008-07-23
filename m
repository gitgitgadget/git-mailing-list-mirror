From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-filter-branch: Remove Useless Use of
 Plumbing
Date: Tue, 22 Jul 2008 17:05:07 -0700
Message-ID: <7vd4l5jwi4.fsf@gitster.siamese.dyndns.org>
References: <20080722222418.15372.62190.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 23 02:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRs3-0003Qm-Am
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 02:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbYGWAFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 20:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYGWAFR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 20:05:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41310 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYGWAFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 20:05:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E1703ABFF;
	Tue, 22 Jul 2008 20:05:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 57C653ABFC; Tue, 22 Jul 2008 20:05:09 -0400 (EDT)
In-Reply-To: <20080722222418.15372.62190.stgit@localhost> (Petr Baudis's
 message of "Wed, 23 Jul 2008 00:24:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 05952DD8-584B-11DD-B7A2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89571>

Petr Baudis <pasky@suse.cz> writes:

> The example to remove file using index-filter uses git update-index
>  --remove where git rm --cached works as well.

I am not sure "works as well" is a good enough justification to choose a
Porcelain command over a plumbing command in this particular context.
After all, filter-branch is a scripting enviornment, isn't it?

There also is another subtle difference.  "git rm" takes pathspecs while
"update-index" takes paths.

So after running one of these commands:

	$ git rm --cached 'Makefil?'
	$ git update-index --force-remove 'Makefil?'

output from:

	$ git diff --cached --stat

would be different.
