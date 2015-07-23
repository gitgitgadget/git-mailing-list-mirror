From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Git doesn't detect change, if file modification time is restored
 to original one
Date: Thu, 23 Jul 2015 16:17:08 +0200
Organization: gmx
Message-ID: <ae5d01d5685d9db4cedcada1ce58f71d@www.dscho.org>
References: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Konr=C3=A1d_L=C5=91rinczi?= <klorinczi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 16:17:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIHJG-0003k2-3w
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 16:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbbGWORO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Jul 2015 10:17:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:49898 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752613AbbGWORM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 10:17:12 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LqV4f-1Yenh62rmj-00e1OI; Thu, 23 Jul 2015 16:17:09
 +0200
In-Reply-To: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Vs389CKouuEr5i4B0yew6KIKVfdgJFr8WLUDuiqsBfwPq4iUGi/
 a5AElMyvbXTUMxkwIQydyXwgL+45dVG9h3J1Di3Sps98jfinokiwALYzqbviOmSXedjvrv5
 PA83kwK4SDioR0rU6soVBouHWAO/EPSY7Q4EZ2JhyygbT1isBtncvdModlZtzg9qY/g7nrr
 AKF17UNHSucoje8BcMfow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r26rYgs2N9Y=:ITL2IQUnUh65eJ43buLXDa
 SZvb/YqSy+Q7U8jEj8dpgviLyfdt4oLQEstT0B1WKuxWXnQIaoUCb/isDvqnXhnpcYvuyOUGZ
 ERQdfIRVde9BzbyhI0K2juBo6we10S2xt5ojCnTgbeAPU8mC+97nvZegc96c3zV2MOUONMg+m
 FSc6VdlasVlZ0PWFLQaI4HfYUS2hPSM3ibeRGbA9MINAfhpH9gJ6k/D3Lhn5bIBtJ7Vwpb6WK
 wiHmGgbjLLFTMpULHju/L8lSPy3yTYVxA2zhwz6pVPA2KYgN2zEUl8aOv3CvWk0yhNRIhEurd
 cN4wuPyrh7Kpx6l6RVg1ZiT2sxG2n5d75tJgeE6ORqFGV6c6Tt547qV5HLCaGF82Dv1Gp29Ar
 ja7pXvasQV6XiYxgjJ2Bi9zXv/zTWXg1OjuMZgFd5IZWeEsWPXCZfK3CiIB6LP/4BKjelxh50
 S48Y+LVb41tiJ7k2aNoIUVaT0m4vUQgb51chayngSiIPTFl/OdFHeUuf4zXrOtrSwNY7yNvOi
 4MI3Aa2Cujxx0dSYYze2veSgSvlUbc9Ey65DOCedrt/ct6GCUbZQJYXdNXS7dfvoR7CGLiDqy
 DmE1HPsU7HWMV4gsjTpmAT32xn+KzwZtjWwb7tbKzHVtBhqw/l43vv+hE78qmPGoPNBNU2xwr
 fP1mdKxc4fi4x0gnL0rvhEPhnkp6e13Ogv0MJ8HVqbVDTeBY2u9xHQni7D8h6yWZ8hXc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274497>

Hi,

On 2015-07-23 09:29, Konr=C3=A1d L=C5=91rinczi wrote:
> I wrote a search & replace perl script, which recursively searches
> files and replaces text in them. After replace, it restores original
> modification time (mtime) of file.

Since this is almost identical to https://github.com/msysgit/git/issues=
/312#issuecomment-124030520 I assume that you wrote that.

In my answer on the (already closed) GitHub ticket, I wrote this:

-- snipsnap --


    I wrote a search & replace perl script, which recursively searches
    files and replaces text in them. After replace, it restores origina=
l
    modification time (mtime) of file.

By this "restoring" of the original modification time you broke the con=
tract: the mtime should reflect the time of the latest change. You repl=
aced something, i.e. changed the file contents. Git expects the mtime t=
o be adjusted in that case. By painstakingly faking it back to its orig=
inal value you essentially told Git: don't worry, this file has not cha=
nged since you last saw it.

There is nothing Git can do to outguess you when you go out of your way=
 to break the most fundamental promise of the mtime value.
