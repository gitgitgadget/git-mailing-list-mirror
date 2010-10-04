From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] do not depend on undefined signed integer overflow
Date: Mon, 4 Oct 2010 21:47:01 +0200
Message-ID: <AANLkTimx0PbyTPgwq8=VoE2Ldihf44c2UkDGYom4TAcf@mail.gmail.com>
References: <1286221388-4908-1-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 04 21:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2r0U-0006Sv-HC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 21:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481Ab0JDTrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 15:47:25 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52561 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab0JDTrY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 15:47:24 -0400
Received: by ewy23 with SMTP id 23so2169893ewy.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 12:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=HbIW7605NwYdcZyUzu8iYqD292kFj2lWYCU4sgpbHAY=;
        b=hmTYSTmkq65VCBdmCEKUPttPikAudKQyUaKmwx1xEdU5cG9AsqnKe5iv7JMFqyjPwU
         s4ED5xk4HFumnxoIDrqnSpXKblHBLDAJY8aS3SzCWwX2f8RJGtQ2eE1qtNzvMuYw+jW8
         azXyno5IdrSqMcqtaw4sH3tvX/DlfOIsT01SY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=mwQTpIToDqs3/TngiURNazRxbVGj80F5wh1s+9fkcWDSEz4N6FkZWS5RAMhckAoLYf
         +ynFwN/+twMtrkFh2d3vzu57LDmvFU9x/IWtdGO8/GsMEfcu9oKxHcQNnjxGN7+MoMg7
         tKy4mekf366tHwrgGuWvgBEbi5KpSMiWPMwVc=
Received: by 10.223.117.67 with SMTP id p3mr9611805faq.107.1286221643218; Mon,
 04 Oct 2010 12:47:23 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Mon, 4 Oct 2010 12:47:01 -0700 (PDT)
In-Reply-To: <1286221388-4908-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158106>

On Mon, Oct 4, 2010 at 9:43 PM, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
> +/*
> + * Signed integer overflow is undefined in C and some compilers take
> + * advantage of this when optimizing, so here's a helper macro to fo=
rce
> + * wrapping when adding two integers. The size to wrap to is taken f=
rom
> + * the first parameter.
> + */
> +#define signed_add_overflows(a, b) \
> + =A0 =A0((b) > ((INTMAX_MAX >> (bitsizeof(uintmax_t) - bitsizeof(a))=
) - (a)))
> +

*Sigh*, I already see that this comment is out of date (I did a
different approach before this one). Sorry, I will fix up this comment
for the next round.
