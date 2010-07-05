From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing
 list argument to for loop
Date: Mon, 05 Jul 2010 10:14:48 +0200
Message-ID: <4C319478.4070903@drmicha.warpmail.net>
References: <80typu1ozt.fsf@tiny.isode.net> <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net> <4C31796E.9050109@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 10:15:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVgqE-0001VE-Hh
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 10:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab0GEIPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 04:15:43 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:51613 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752974Ab0GEIPm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 04:15:42 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8353C114BE2;
	Mon,  5 Jul 2010 04:15:41 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 04:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6ILXB+eCjwE0fbxogmUFXyzpgJ0=; b=I9ViHJuSWu/l4DnVW/aJS9dIj6Olu0PPN+v8+NgtLwles9VYre1knHc+Ob03xcp9DtTGBSLAgL2HTOE8ZhbpqycuwDlvtt3+hZWoDBbXKyEOWfLm5PzudGRSDxlukF7tat2xoiWTiNGUSji7UHkas5YARrg6VLymjH4/OqEkUrY=
X-Sasl-enc: qKzDCT5wR9gIls9kqHh8whHbcwclw+6ai+xTFaspN+il 1278317741
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3ED324F3EC9;
	Mon,  5 Jul 2010 04:15:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8pre) Gecko/20100702 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <4C31796E.9050109@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150249>

Johannes Sixt venit, vidit, dixit 05.07.2010 08:19:
> Am 7/4/2010 20:37, schrieb Michael J Gruber:
>> Brandon Casey venit, vidit, dixit 02.07.2010 20:50:
>>> In this case, the for loop in the Makefile expands to look like this:
>>>
>>>    for p in ; do
>>>
>>> and ksh complains like this:
>>>
>>>    /bin/ksh: syntax error at line 15 : `;' unexpected
>>>
>>> The existing attempt to work around this issue, introduced by 70b89f87,
>>> tried to protect the for loop by first testing whether REMOTE_CURL_ALIASES
>>> was empty, but it does not seem to work.  So adopt Bruce Stephens's
>>
>> What does that mean? Either it works or it doesn't. I did work back
>> then. Does it (i.e.: the test for emtyness) fail to work for certain shells?
> 
> Before the test for emptyness can happen, the complete statement must be
> parsed, but ksh finds a syntax error in the statement and, therefore,
> cannot even begin to execute the statement. (ksh doesn't follow POSIX in
> this regard, where this would not be a syntax error.)

OK, thanks for clarifying. I suggest this to go into the commit message
so that the "does not seem to work" is qualified.

The OP back then (before 70b89f87) used ksh on AIX 6.1, but maybe he
left the thread without testing. I assume Hari's suggestion works on
ksh, as well?

If we go for Brandon's version: Is there a reason for small-casing the
var name? It looks as if we had two different variables with different
case (which we don't).

BTW: Is the $$var gmake specific? Has anyone tested the new version on,
say, AIX, not just on Linux with ksh?

Michael
