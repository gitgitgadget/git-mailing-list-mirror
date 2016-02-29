From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: 50a6c8ef - xmalloc_array
Date: Mon, 29 Feb 2016 07:30:02 +0100
Message-ID: <56D3E56A.5010608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 07:30:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaHLc-0002rQ-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 07:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbcB2GaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 01:30:20 -0500
Received: from mout.web.de ([212.227.15.3]:63040 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbcB2GaU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 01:30:20 -0500
Received: from [192.168.88.158] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0Lcxjk-1a9i192pvM-00iBrw; Mon, 29 Feb 2016 07:30:07
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
X-Provags-ID: V03:K0:JuYIiLJqFrMKZyownVnHPBuYEfPBiVZ/Dt9sjznNs2fEmjDZLJD
 XbomJ4nof3o/1DtCy6XyGlSPacuaebQp6hFXrA/R2OZ2r9bm4CXLzx0OM7MtRz/aBXVqZEE
 bAjfWDw+wanpreM47V1s0bctWkbh2G/FmJ46y2/zqEzxTzrREOykaxGUFMPdRfMiUjQ5AyN
 qZ40HFOVwMp8TjiEZNhRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3E2waOHrdcc=:eqjoem40d6KcIQwZz6wOll
 mxkqxXdqaV7SKOgWKrF354yr70eI4ZsyUOaWUf5FJUlMtCIYQKxwFJdA2G67v99Bd7xVWtCGc
 H1F08SS9lDkGCuit63+92lnuKt0CJZp2mnNAn71O0gEYFx8iZGDzaySaaB0gGFeTOjUwuqFB3
 VkWtmR3aQ3rcNRDBAHgmX5HU6QPqVH/jA5GlBSyriJOdgHHYc97MKSjWDi0L+AAeYvim1RpoG
 +24Ra9U8k2kLSamdjzWhBdO7Na9Yqsu72XdkK2zD9cXuhYND3G3+GlPtayLrIRSzGg55bZq2J
 J7FmGp/FqJDk8057B4N/Fqg5qmA1Nx7NqT54H6nEpoGXLGmemvEtj7pDkST0M25Xsy9Vth0rZ
 iZYKxM2P9KOElIj3oIkJrN9ZpQdsczqKUt254aU3XdSs1YHD9E4EDUuwonK+g2YoyuL1SDCS9
 ijbmpy/Zy5LMXVKCKP3xoiocmvQbQbny7ndiFtaGT/sSy+eY9cwjL9VcS7VcenXtqU5GTrwf5
 hpcXRPkCx5BUeV6Y6tz3L31UCxy0t722JAE1RDsPmHtqZ/40RyyiIdduwdHuFBvntx8ceZbJs
 +TAOQGv9Zjcw/s6nv9nRPVdxS7XKrXbZEhznwxE+AhD4Boa+xtn8W0PncqqDYZ2hf7+2ftx0x
 kPBqVRbpjlD9hl4QRbwNCp0SATVH/eCoSI0xunfNx0pkkb4XLRrQCOdKtzqZAv0yGCy/5eP/z
 zCB1e/RaS2XJ1GM/clMwrsJjhdbp2bh2jydM6YzGDFn6yPWFqFiTFf8nGlPsk5NuWDAnh7pd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287801>

I haven't digged further,
but trying to verify t9115 under Windows gave this:


compat/mingw.c: In function 'mingw_spawnve_fd':
compat/mingw.c:1072:10: warning: implicit declaration of function 
'xmalloc_array' [-Wimplicit-function-declaration]
   wargs = xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
           ^
compat/mingw.c:1072:8: warning: assignment makes pointer from integer without a 
cast [-Wint-conversion]
   wargs = xmalloc_array(st_add(st_mult(2, args.len), 1), sizeof(wchar_t));
         ^
--- and later ---

libgit.a(mingw.o): In function `mingw_spawnve_fd':
..... compat/mingw.c:1072: undefined reference to `xmalloc_array'
collect2.exe: error: ld returned 1 exit status
Makefile:2014: recipe for target 'git-credential-store.exe' failed
make: *** [git-credential-store.exe] Error 1
