From: Enrique Tobis <Enrique.Tobis@twosigma.com>
Subject: RE: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Date: Tue, 20 Oct 2015 13:39:55 +0000
Message-ID: <cbf2c2c2c137445ebb9e2c5f1012cb10@EXMBNJE8.ad.twosigma.com>
References: <loom.20151020T131513-529@post.gmane.org>
 <vpq37x54vav.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: 'Matthieu Moy' <Matthieu.Moy@grenoble-inp.fr>,
	Johan Laenen <johan.laenen+cygwin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 15:47:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoXG4-0007YX-AJ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 15:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbbJTNrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 09:47:15 -0400
Received: from mxl2.aoa.dmz.twosigma.com ([208.77.215.146]:60851 "EHLO
	mxl2.aoa.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbbJTNrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2015 09:47:14 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Oct 2015 09:47:14 EDT
Received: by mxl2.aoa.dmz.twosigma.com (Postfix, from userid 111)
	id 9D43E600BD; Tue, 20 Oct 2015 13:40:01 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	mxl2.aoa.dmz.twosigma.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00=-1.9 autolearn=no
	version=3.3.2
Received: from EXHTNJE1.ad.twosigma.com (exhtnje1.ad.twosigma.com [172.20.32.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mxl2.aoa.dmz.twosigma.com (Postfix) with ESMTPS id B73C6600C4;
	Tue, 20 Oct 2015 13:39:55 +0000 (GMT)
Received: from EXMBNJE6.ad.twosigma.com (172.20.45.169) by
 EXHTNJE1.ad.twosigma.com (172.20.32.77) with Microsoft SMTP Server (TLS) id
 14.3.224.2; Tue, 20 Oct 2015 09:39:55 -0400
Received: from EXMBNJE8.ad.twosigma.com (172.20.45.145) by
 EXMBNJE6.ad.twosigma.com (172.20.45.169) with Microsoft SMTP Server (TLS) id
 15.0.1130.7; Tue, 20 Oct 2015 13:39:55 +0000
Received: from EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60]) by
 EXMBNJE8.ad.twosigma.com ([fe80::1882:851f:2745:9d60%17]) with mapi id
 15.00.1130.005; Tue, 20 Oct 2015 13:39:55 +0000
Thread-Topic: Commit 5841520b makes it impossible to connect to github from
 behind my company's firewall.
Thread-Index: AQHRCyz2CwRD6HgpEESy5ILy46H0Yp50Xz2w
In-Reply-To: <vpq37x54vav.fsf@grenoble-inp.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.14]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279912>

Hey!

I'm really sorry to hear that.

That change should enable more forms of authentication with your proxy, but it does cause libcurl to choose the one it finds most secure, according to the docs (http://curl.haxx.se/libcurl/c/CURLOPT_HTTPAUTH.html) What kinds of authentication does your proxy use?

Thanks,
Enrique

-----Original Message-----
From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr] 
Sent: Tuesday, October 20, 2015 07:46
To: Johan Laenen
Cc: git@vger.kernel.org; Enrique Tobis
Subject: Re: Commit 5841520b makes it impossible to connect to github from behind my company's firewall.

Hi,

I'm just Cc-ing Enrique, the author of 5841520b.

Johan Laenen <johan.laenen+cygwin@gmail.com> writes:

> Commit 5841520b makes it impossible to connect to github from behind my
> company's firewall.
>
> I'm running CYGWIN_NT-6.1 and the default git version 2.5.3 complains with a
> fatal error when trying to git pull:
>
> $ /bin/git --version
> git version 2.5.3
> $ /bin/git pull
> fatal: unable to access 'https://github.com/gargle/french/': Unknown SSL
> protocol error in connection to github.com:443
>
> Taking the sources of git 2.6.1. and compiling with commit 5841520b in
> http.c reverted gives me a working git.
>
> My http.c now looks like:
>
>  466     if (curl_http_proxy) {
>  467         curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>  468 #if LIBCURL_VERSION_NUM >= 0x070a07
>  469         curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>  470 #endif
>  471     }
>
> And it works:
>
> $ git --version
> git version 2.6.1
> $ git pull
> Already up-to-date.
>
>
>
> Greetings,
>
> Johan

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
