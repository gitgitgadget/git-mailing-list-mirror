From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Tue, 17 Jan 2012 13:21:33 +0100
Message-ID: <vpqr4yy1pv6.fsf@bauges.imag.fr>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjjhwvdy.fsf@alter.siamese.dyndns.org>
	<vpqhazv3m17.fsf@bauges.imag.fr>
	<7vsjjfuuwk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 13:21:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn82w-0005ps-70
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 13:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037Ab2AQMVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 07:21:45 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40883 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870Ab2AQMVm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 07:21:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q0HCJvcs022780
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 17 Jan 2012 13:19:58 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rn82f-0002rv-N0; Tue, 17 Jan 2012 13:21:33 +0100
In-Reply-To: <7vsjjfuuwk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 16 Jan 2012 14:47:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 17 Jan 2012 13:19:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0HCJvcs022780
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327407602.48198@18nUclRcDjjctHMVN//1EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188704>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> but is that the right thing to do if suffix came from "$4"?
>>>
>>> As far as I can see, "$4" is used to append "." in very limited cases, and
>>> nobody explicitly passes SP as "$4" when calling this, so it may be easier
>>> to read if you moved this before that "if we have 3 or more args, use the
>>> fourth one as the suffix" block, i.e. something like this?
>>
>> Why not, but in case someone explicitely passes " " as $4 in the future,
>> it's likely to be better to strip it for the same reason we strip it here.
>
> I doubt that would be sufficent or appropriate. If some caller _WANTS_ to
> add a SP, shouldn't we be devising a way to tell zsh to add it without
> quoting,

Yes, this is the point. But up to now, nobody found such a way so we're
just trying to work around it in the less painfull way for the user.

If someone _wants_ to add a SP, then he still can't do it portably with
your patch, because the space will be quoted for bash users, and not for
ZSH users, so one of them will be unhappy.

> So does that mean we would be forcing zsh users to add SP themselves? 

Yes, but we already do so. From my commit message:

  The absence of trailing space for ZSH is a long-standing issue, that
  this patch is not fixing.

;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
