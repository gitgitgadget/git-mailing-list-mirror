From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Added --export option to git-send-email.
Date: Sun, 13 Jul 2008 17:44:16 -0400
Message-ID: <32541b130807131444s5e9ea0d6v9610dd5871467fc9@mail.gmail.com>
References: <20080710170735.4c5b237a@linux360.ro>
	 <7vskudr11m.fsf@gitster.siamese.dyndns.org>
	 <32541b130807131432j78e5100dyea20893268321466@mail.gmail.com>
	 <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eduard - Gabriel Munteanu" <eduard.munteanu@linux360.ro>,
	ryan@michonline.com, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 23:45:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI9Nc-0005bF-Md
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 23:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935AbYGMVoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 17:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYGMVoS
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 17:44:18 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:26191 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYGMVoR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 17:44:17 -0400
Received: by yw-out-2324.google.com with SMTP id 9so2276449ywe.1
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iWoCwwtbsGybdC1VSP9+6jsdmyoZhXdPdiy2peY8Vus=;
        b=qt8s2zq8n4qF3OBp3VgdBRZELVYKFuRcvvHHb20t3ZvBJq0xnGmAnnXEnsWipsz/DK
         BwlWcfNaoS0AcNykLKxY1pEFMAuBOLFm/wGLEweTzD4vZo2dfdJXn6beUMTquwjYxx9f
         VvVyFI3bxTPQFVP6Pb9Mq52iPa8uBPm2bnZWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=L1RBv1NNqKdH1wMRFF7eXk3B9/D4K3RRh6IkO8EATv9sz0gdDirIoIXypMraip+RjF
         UnXesno3M83pVYN+2QkWtOGINHTgI+SouliDdFXroShRpeeNYc6xV1dehxnc4QQJQCCK
         Fa+uVn0IsPkXJ+6XcBszmUYt2aXLYnplsf6+k=
Received: by 10.150.50.1 with SMTP id x1mr4390285ybx.39.1215985456581;
        Sun, 13 Jul 2008 14:44:16 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Sun, 13 Jul 2008 14:44:16 -0700 (PDT)
In-Reply-To: <7vbq11qxfb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88347>

On 7/13/08, Junio C Hamano <gitster@pobox.com> wrote:
>  >> Sorry, but I am scratching my head here.  Shouldn't this "bare From
>  >>  munging" be like this instead?
>  >>
>  >>                 $message =~ s/^From />From /m;
>  >
>  > That wouldn't be a reversible operation.
>
> So what?  Adding Cc: and stuff send-email does are already irreversible
>  anyway.

At one point the people who write mailers realized that just munging
"From" to ">From" when putting things into an mbox was irreversible,
ie, there was no way to later display the contents of the mbox without
showing ">From" where "From" was intended.

However, if you always insert _another_ ">" whenever "^>*From" is
detected, then you can also always do the opposite upon displaying to
the user, and the message is effectively not munged.  It becomes
simply a part of the mbox file encoding.

So by encoding it this way, someone with a modern mailer could view
the resulting mbox with all the munged text de-mungled.  Someone
without a modern mailer would see munging anyhow, so they're no worse
off.

Have fun,

Avery
