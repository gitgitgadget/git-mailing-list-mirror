From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked
 file
Date: Sun, 14 Dec 2008 17:03:57 -0800
Message-ID: <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
References: <20081210201259.GA12928@localhost>
 <20081215004651.GA16205@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Dec 15 02:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1u5-00061Y-3j
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 02:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbYLOBEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 20:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbYLOBEI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 20:04:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbYLOBEI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 20:04:08 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B39BE879C2;
	Sun, 14 Dec 2008 20:04:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E1ADD879B6; Sun,
 14 Dec 2008 20:03:58 -0500 (EST)
In-Reply-To: <20081215004651.GA16205@localhost> (Clemens Buchacher's message
 of "Mon, 15 Dec 2008 01:46:51 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42BCB530-CA44-11DD-BCE6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103119>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Dec 10, 2008 at 09:12:59PM +0100, Clemens Buchacher wrote:
>> If a file was removed in HEAD, but modified in MERGE_HEAD, recursive merge
>> will result in a "CONFLICT (delete/modify)". If the (now untracked) file
>> already exists and was not added to the index, it is overwritten with the
>> conflict resolution contents.
>
> The following patch fixes the problem described above, but it also breaks
> t6023-merge-rename-nocruft.sh, which tries to merge "A" renamed to "B" in
> HEAD and "A" modified in MERGE_HEAD, while ignoring an untracked file "A" in
> the working tree. If we want to be able to do this, we have to handle the
> other case after rename detection.

If the breakage is in merge-recursive but not in merge-resolve, my gut
feeling is that we should not be touching unpack-trees at all.  With luck
I may be able to find some time to take a look at this myself but right
now we are entertaining a guest, so....
