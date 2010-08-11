From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes 
	staged
Date: Wed, 11 Aug 2010 12:15:23 +0000
Message-ID: <AANLkTi=DPu+roNsuWZARkK=cmKhcqMx=CDyiv6cf7tof@mail.gmail.com>
References: <20100725005443.GA18370@burratino>
	<20100725010230.GI18420@burratino>
	<201008110911.40133.trast@student.ethz.ch>
	<20100811073028.GA5450@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 14:15:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjADT-00021C-5v
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 14:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab0HKMPZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 08:15:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46531 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab0HKMPY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 08:15:24 -0400
Received: by fxm13 with SMTP id 13so30021fxm.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yVcTqMakEmw5BlQWAQHqOzy1iguLHO9fhpesxcZXAZc=;
        b=x9PEMJ4z4TRFOPE3KkXcOk+vQMy1onwl1Lj6tFTsst0RNW2tNBI0FFXdwbzzPNrRux
         mo4rhbwggeAjimDV17e5RASAFHe/qM063yalCYJlURxc1zq4qokjER70fWA/EpMAy05u
         6lfbUO+2X1yv1Zxt1a/N/lcKeg02LlxtB+sSk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ww8+fkfQRAsDBARRhLLNJ0cs0eWDhEwVMqhOjZVAhUeHjf+dL3bkJ+eqs3gAm3WHwg
         Kit3U1X+tOwBYRhpyFUbch+OuYiuV829nRx84+sCixYALcDE7ExihiIf6k7cspVod4iT
         l4Q4/vT0XaUWzWMNAo1j9yLEi3Z9yaV7Tq7tk=
Received: by 10.223.116.197 with SMTP id n5mr19882994faq.53.1281528923638; 
	Wed, 11 Aug 2010 05:15:23 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 11 Aug 2010 05:15:23 -0700 (PDT)
In-Reply-To: <20100811073028.GA5450@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153228>

On Wed, Aug 11, 2010 at 07:30, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> -test_expect_success 'status' '
> +test_expect_failure 'status' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cd test &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout b=
1 >/dev/null &&

Better to test_expect_success like my patch does and explicitly check
the output, otherwise that test will pass if any part of it fails,
e.g. if the checkout fails.

Not likely, but it's more likely that the output will change again, in
which case the grep tests I did would start failing again.

It's good to have test canaries like that for important parts of our
output.
