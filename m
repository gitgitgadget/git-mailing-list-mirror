Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FF42018E
	for <e@80x24.org>; Mon,  8 Aug 2016 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbcHHPFM (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 11:05:12 -0400
Received: from mout.gmx.net ([212.227.17.21]:56927 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054AbcHHPFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 11:05:11 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lurin-1b6cFB19ur-0108V9; Mon, 08 Aug 2016 17:05:08
 +0200
Date:	Mon, 8 Aug 2016 17:05:07 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:	git@vger.kernel.org
Subject: t0027 racy?
Message-ID: <alpine.DEB.2.20.1608081556280.5786@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aXJa4PPcM1n8Y013E1hs6jjgy0/zmvMRuF8GpQI4MPbyp/1y/3J
 ksN7cH6LExcUQqRkAfymR6LDrc0fDSluOed+xztHk0Qz1CFXaPQg2sEc1AEDyPlWKqReYqK
 00V6yQifSD7wRR0MfG6mavgXN6+gEkaf4fGq5JCr/uvwSkuyav6xCqwsW/5DB1fCxOXbWW5
 OrMOQiWQf51A9oig7pkaA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Q/C/Re+p0Ec=:G58J2O61Vlj63qjPSqjXNc
 WbB7D6VuQJsDteZtXFioAm+lfcwlab9eUpVHRTyywd8MP9rpUH0D9cEk2SEdd3oSqm+SY9zn3
 0a0X8biGCSZ6kEPQT371ePddYwbWdPaUtDmmIKCqWAPF0gmLfunyMF7fIr15YGt8YFJIvZKDf
 N7VY7T/5SHNPs8Ti6YEowucohmJdKhTDgVo3W/z4wmuH0iXprHrH0bSMecG5d4CTk2qR4v+K+
 NHDAJHWn1oYfcfZ602whPghpJe6DaIHyLUd8GGCPa0fm0vKY9T0gHbJow3Z+A+H5GedQZH5nW
 fcyKHkl+fyivJKahfWvG3zV7KACP5OCkON7bLmjq0fCgiCeRfCHctt9E2geDxPr41e0mVxnHE
 apmT8vRYMDaQoSZ5R0V+pQIdbUNwYtfFfbPKMUtDgKIHVTx4GBRbO0EgdHj/F58BYMbbQ9SMM
 x9MI4S7WGi9g6O6TRiupNeKALGeUH5XeFv12vw6m0KiUOlQ+EoIvMHpPCH/vjoGBxNRWZa6x8
 fCDrWNEn5lL10LEL51ctTUXKXz/9fh38Ww9CjdcmFDQPjufpmvTAEv29pwefcIFF4rpFjmjFZ
 BcNSInMSGdSiOQcTWw5WNqVhzcRdiE/O9vpZZoFem1UKr+nG9TUyMsK+qywlv5XHfuEsbFAc8
 XQw+Y2Vg1RXlsJeKAKbCtPSU6hKNPpTnKF4Lj+lzsGfpUk6xrdsUeCguE6AblITI/2rQYm/Ff
 tKlimu/TOamIzMqR74m/c8DJ20rWGfqdYBzxQj/heGEko/IXfxqLtLSaWC0vvESEfje4W+CTl
 SlaPaS9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Torsten,

I remember that you did a ton of work on t0027. Now I see problems, and
not only that the entire script now takes a whopping 4 minutes 20 seconds
to run on my high-end Windows machine.

It appears that t0027 fails randomly for me, in seemingly random places.
Sometimes all 1388 cases pass. Sometimes "29 - commit NNO files crlf=true
attr=auto LF" fails. Sometimes it is "24 - commit NNO files crlf=false
attr=auto LF". Sometimes it is "114 - commit NNO files crlf=false
attr=auto LF", and sometimes "111 - commit NNO files attr=auto aeol=lf
crlf=false CRLF_mix_LF".

When I run it with -i -v -x --tee, it passes every single time (taking
over 5 minutes, just to make things worse)...

Any idea about any possible races?

Ciao,
Dscho
