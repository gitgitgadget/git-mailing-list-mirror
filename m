From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to non-GNU
 extended regex syntax
Date: Mon, 22 Sep 2008 11:59:47 -0500
Message-ID: <i-l9YX2TO45e2OB9LuoxrAN6a2iFYaH_eEGlVmRsP0oa97XuwX4eGQ@cipher.nrlssc.navy.mil>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org> <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org> <7vy71n482x.fsf@gitster.siamese.dyndns.org> <loom.20080920T200157-713@post.gmane.org> <7vmyi21mf8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 19:02:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khoni-0001bD-7M
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 19:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYIVRBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 13:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbYIVRBH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:01:07 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37163 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYIVRBG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:01:06 -0400
Received: by mail.nrlssc.navy.mil id m8MGxmDu020740; Mon, 22 Sep 2008 11:59:48 -0500
In-Reply-To: <7vmyi21mf8.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Sep 2008 16:59:48.0160 (UTC) FILETIME=[9EEAC400:01C91CD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96498>

Junio C Hamano wrote:
> Brandon Casey <drafnel@gmail.com> writes:
> 
>> Junio C Hamano <gitster <at> pobox.com> writes:
>>
>>> Here is [1/2] to be applied on top of 45d9414 (diff.*.xfuncname which uses
>>> "extended" regex's for hunk header selection, 2008-09-18).
>>>
>>> Testing appreciated.
>>> +	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>>> +	  REG_EXTENDED },
>>> +	{ "tex",
>>> +	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\{.*)$",
>> I think you need double backslash '\\' before '{' in the two places in these
>> patterns where you only have a single backslash.
> 
> Thanks.  Any other nits?

Just a single minor one on the "fix multiple regexp semantics" patch.

This:

 	for (i = 0; i < regs->nr; i++) {
		...
	}
+	if (regs->nr <= i)

makes me use my brain (I try to avoid that).

I only mention it since I've seen discussions in the past about this sort
of ordering, and you seem to have accepted that it can be confusing to
native english speakers who would "read" the 'if' statement. The ordering
above puts emphasis on the value of regs->nr, when it is actually the value
of 'i' that is being tested (since regs->nr is unchanging).

I'll do some testing on non-GNU platforms today.

-brandon
