From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Fri, 24 Aug 2012 07:30:01 +0200
Message-ID: <002101cd81b9$828f1380$87ad3a80$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org> <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> <7vk3wq964r.fsf@alter.siamese.dyndns.org> <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de> <7v7gsq94gd.fsf@alter.siamese.dyndns.org> <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de> <7vwr0q63po.fsf@alter.siamese.dyndns.org> <000601cd8101$a6f81900$f4e84b00$@schmitz-digital.de> <7vlih52tag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 07:30:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mTW-0007F0-5A
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367Ab2HXFaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 01:30:24 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:57513 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab2HXFaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:30:22 -0400
Received: from DualCore (dsdf-4db5d8d2.pool.mediaWays.net [77.181.216.210])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MQM9c-1TEnOw0aBo-00UOS6; Fri, 24 Aug 2012 07:30:10 +0200
In-Reply-To: <7vlih52tag.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchAO6Wu9cBkiD+9QGuygBoAMLnBsUBv8N3IgG0C8qlAfdwMNsBrrMfU5bJ9ttw
Content-Language: de
X-Provags-ID: V02:K0:BMJYsEyzCDQLbXtSixvXt73aTaajgG/kvJLsDZVseKP
 ySslA8DC/YN6xfEtFLWVv8rY2EPxmWYgO4oqN6xlXC/2OgvxZP
 11sKkUGkNu1D7o9CJ/Lhhu/Yvvv3mVlTO8Pjf3xI3je6C8E7V9
 XBiP8IzA2mHINLdf78PRYSJwuMrG9mfceDDVvcITAFjJNr4Zso
 jHtDJA70mLYGWTty9Pv3eBMo90biM3JPfemMO4tUDEsEOK+K7v
 s7wFd1gz9A5Mn4hPZeHvS74rELWcCTpRBeJHOq7usxtWqH0s6L
 7FZpOMNg/4DDFO8dQjInmvHxTe+o+tynvmYYxQtFnj3IncQTfd
 NrqHeEO/sC8EeJltPfutV25WQkcKFxFTzbVecmVOG+812F0YVn
 WmilDI1X0/hpg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204180>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Thursday, August 23, 2012 11:27 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> >> Sent: Wednesday, August 22, 2012 11:06 PM
> >> To: 'Junio C Hamano'
> >> Cc: 'git@vger.kernel.org'
> >> Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> >>
> >> > From: Junio C Hamano [mailto:gitster@pobox.com]
> >> > Sent: Wednesday, August 22, 2012 11:02 PM
> >> > To: Joachim Schmitz
> >> > Cc: git@vger.kernel.org
> >> > Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> >> >
> >> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >> >
> >> > >> > diff --git a/http.c b/http.c
> >> > >> > index b61ac85..18bc6bf 100644
> >> > >> > --- a/http.c
> >> > >> > +++ b/http.c
> >> > >> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
> >> > >> > *result, int target, int options)
> >> > >>
> >> > >> Likewrapped X-<
> >> > >
> >> > > Any suggestion?
> >> >
> >> > Other than "don't wrap" (or "get a real MUA and MTA" X-<), unfortunately no.
> >> >
> >> > I do not know if you have checked MUA specific hints section of
> >> > Documentation/SubmittingPatches; there may be environment specific hints
> >> > described for a MUA you may have at hand (or not).
> >>
> >> I checked, but Outlook isn't mentioned :-(
> >
> > OK, Outlook inserts line breaks at position 76. I can't switch it off completely, but can set it to anything between 30 and 132.
I
> > set it to 132 now, does that look OK now?
> 
> Yeah, modulo that with all the above noise and with "---" before the
> log message you inserted by hand before the real commit log message,

OK, those are not allowed then? Or would they need to look different?

> and also the log message is not properly line-wrapped, it is getting
> closer to what is expected of a patch to be applied.
> 
> I've applied it by hand and fixed the log message up, so no need to
> resend this particular one.  Thanks.

Thanks

> > This reverts be22d92 (http: avoid empty error messages for some curl errors, 2011-09-05) on platforms with older versions of
> > libcURL.

You meant that linewrap between "of" and libcURL?, Or well, that was the 132 position... Or do you want these messages being wrapped
at <=80?

Bye, Jojo
