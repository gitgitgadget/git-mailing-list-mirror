From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH/RFC] Port to HP NonStop
Date: Tue, 18 Sep 2012 19:07:04 +0200
Message-ID: <001701cd95c0$085a2f80$190e8e80$@schmitz-digital.de>
References: <000201cd9569$d16515e0$742f41a0$@schmitz-digital.de> <7vvcfbojbl.fsf@alter.siamese.dyndns.org> <000401cd9575$38a98b40$a9fca1c0$@schmitz-digital.de> <7vehlznu0h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 19:11:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE1K7-0000Bs-Tl
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 19:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752243Ab2IRRKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 13:10:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52137 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2IRRKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 13:10:50 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MgaZf-1Su2D23yZ5-00NV72; Tue, 18 Sep 2012 19:07:21 +0200
In-Reply-To: <7vehlznu0h.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIRcf9f0L091TtL1apGSHAm+T2aRAItWLL2Abyv4sAB8pg/bZbZtoCg
Content-Language: de
X-Provags-ID: V02:K0:WQT8tMa9N416yYtmakRzXH+uCLfVZv3Jc/ivP8/M2Fw
 knznpcZY13qZB5+5kWIbJ9KnRXyUdgHL6sBXavWkDMiAdozJtZ
 8iNycHWiz4VRCcL8W8hfiHBef5SlrjzdcyfW+m8vRCSTjYhe8w
 PjSoLoCdKr+wYQsrkfupwDU0LniZ2DVsZKQ4CTFBY1wWrhmgtS
 7FB+wxZcn6h5R0ej1/VENKY8hu6Q7rdOZrRohXQY9r8GbmUZTt
 JXeL3yTmomupj/3ZUk5ZXHJHELt309OH0g+MnhsZHsK3emZtCf
 j5XmJAzpKDCU38+NY+Ri0uKWKjdHak4WUpXXe5om5W9YsUqjyt
 OmJVo56WANqs+w7RufLa2ks8OF0r2B70ds0A3oAwUWsYfcDTNt
 t3kFS7r8a2CTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205839>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 18, 2012 7:03 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH/RFC] Port to HP NonStop
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> From: Junio C Hamano [mailto:gitster@pobox.com]
> >> Sent: Tuesday, September 18, 2012 9:57 AM
> >> To: Joachim Schmitz
> >> Cc: git@vger.kernel.org
> >> Subject: Re: [PATCH/RFC] Port to HP NonStop
> >>
> >> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >>
> >> > Needs a different link order in Makefile: libintl before libiconv.
> >> > This may affect other platforms, so needs some checking.
> >>
> >> It will, and it needs customization, not checking.
> >
> > How?
> 
> By not moving things around to affect other people, but having them
> in the order you want only for your platform (and other future ports
> that need similar treatment)?
> 
> For example, if you need libintl before libiconv, a quick and dirty
> way may be
> 
> diff --git i/Makefile w/Makefile
> index a49d1db..9b2cfd6 100644
> --- i/Makefile
> +++ w/Makefile
> @@ -1552,6 +1552,9 @@ ifdef NEEDS_LIBICONV
>  	else
>  		ICONV_LINK =
>  	endif
> +	ifdef NEEDS_LIBINTL_BEFORE_LIBICONV
> +		ICONV_LINK += -lintl
> +	endif
>  	EXTLIBS += $(ICONV_LINK) -liconv
>  endif
>  ifdef NEEDS_LIBGEN
> 
> and your linker command line may have "-lintl -liconv -lintl" but
> that wouldn't be an error, and you know you won't be affecting
> other platforms that do not use NEEDS_LIBINTL_BEFORE_LIBICONV, no?

OK, sounds good, I'll try that and submit an updated patch if it works that way (and I'm pretty sure it does).

Anything else I should change in my patch?
