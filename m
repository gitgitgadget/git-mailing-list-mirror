From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sun, 12 May 2013 14:13:57 +0200
Message-ID: <518F8785.4010401@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org> <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net> <7vy5bm22f8.fsf@alter.siamese.dyndns.org> <518E0741.1060008@drmicha.warpmail.net> <7vr4hdxvtl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 12 14:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbVAw-0006ai-Bb
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 14:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab3ELMOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 08:14:45 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36259 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751112Ab3ELMOo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 May 2013 08:14:44 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 63120207B2;
	Sun, 12 May 2013 08:14:44 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Sun, 12 May 2013 08:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=C8jsSf2NvH2tUF5TmygmWP
	F4uuw=; b=U3YU+Cl3rGI8gWH9/SC+Gg75pqSHdpDvNIqFgv/C+JC63Y/wBNHrxg
	D5HyC8IuAbhKRAiCs+bL5OGEKL5srS0O7v0XbnY3B1HbJQNcPvV7LaH0tqjUsJ7b
	6d14X53oWs5nPqjPhHLmGdtG1vYBpaCefBlERQ6Cv5nVpSyux8zPk=
X-Sasl-enc: PrIN6y3MQF3C1IvcaFjNLofEf1vdQdt+fR3okG+S2lBt 1368360884
Received: from localhost.localdomain (unknown [88.71.228.38])
	by mail.messagingengine.com (Postfix) with ESMTPA id 780862000FD;
	Sun, 12 May 2013 08:14:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <7vr4hdxvtl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224045>

Junio C Hamano venit, vidit, dixit 11.05.2013 19:36:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>>>> +	if (!DIFF_OPT_TOUCHED(&rev->diffopt, ALLOW_TEXTCONV) ||
>>>> +	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
>>>> +		return stream_blob_to_fd(1, sha1, NULL, 0);
>>>
>>> It is surprising that the necessary change is only this, but I think
>>> it is correct ;-).  We ignore textconv when the command line did not
>>> mention --[no-]textconv, or the command line said --no-textconv
>>> explicitly.
>>>
>>> This (especially the first condition) may deserve an in-code comment
>>> for anybody who wonders where this default behaviour is implemented.
>>
>> It's not as if we would document behavior by in-code comments in
>> general, do we? The usual answer is "git log -S" or "git blame".
> 
> The comment and the future reader I had in mind was more like
> 
> 	Default to --no-textconv, even though cmd_log_init_defaults()
>         sets the bit, when the user did not explicitly ask for it.
> 
> sought by somebody who wonders _where_ in the code we ignore
> ALLOW_TEXTCONV that is set in cmd_log_init_defaults().
> 
> That is not something you can find with "log -S" or "blame", is it?
> 

I'll refactor and restructure anyways. That will also get this whole
default discussion out of the way:

I'll try out the "show attribute" route as indicated. I'm not sure what
to do about the object_array/context discussion, though.

Michael
