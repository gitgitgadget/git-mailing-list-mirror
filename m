From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Mon, 16 Jan 2012 12:49:08 +0100
Message-ID: <vpqhazv3m17.fsf@bauges.imag.fr>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vsjjhwvdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 12:49:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rml3v-0004Yb-CW
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 12:49:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab2APLtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 06:49:14 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47940 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596Ab2APLtO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 06:49:14 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q0GBlZKu019656
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jan 2012 12:47:35 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Rml3k-00043a-AU; Mon, 16 Jan 2012 12:49:08 +0100
In-Reply-To: <7vsjjhwvdy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 14 Jan 2012 18:29:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 16 Jan 2012 12:47:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0GBlZKu019656
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1327319256.50467@0keopa9ALD1jib1TkVR/iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188629>

Junio C Hamano <gitster@pobox.com> writes:

> but is that the right thing to do if suffix came from "$4"?
>
> As far as I can see, "$4" is used to append "." in very limited cases, and
> nobody explicitly passes SP as "$4" when calling this, so it may be easier
> to read if you moved this before that "if we have 3 or more args, use the
> fourth one as the suffix" block, i.e. something like this?

Why not, but in case someone explicitely passes " " as $4 in the future,
it's likely to be better to strip it for the same reason we strip it here.

I don't care much either way in this case.

> +	# Because we use '-o nospace' under bash, we need to compensate
> +	# for it by appending SP after completed word ourselves.
> +	local suffix="${BASH_VERSION+ }"

Not sure why you reworded the comment, but I don't think it's a good
idea to remove the "ZSH would quote the trailing space added with -S"
that I had added, because this is really the reason we do a special case
here. Your version is misleading, because we use -o nospace for ZSH too.

So, overall, I prefer my version ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
