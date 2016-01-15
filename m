From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SChannel support in Git for Windows
Date: Fri, 15 Jan 2016 16:53:50 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601151650481.2964@virtualbox>
References: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robert Labrie <robert.labrie@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK6hL-0006P9-FG
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 16:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbcAOPxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 10:53:55 -0500
Received: from mout.gmx.net ([212.227.15.19]:59302 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbcAOPxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 10:53:54 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lugbo-1aBY6h40Su-00zqJn; Fri, 15 Jan 2016 16:53:52
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CA+1xWaokgVthDv-up76RP+s+r4pSv5ntmePtDVND+rsKuo+-YA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Y+Xos4fM9n19QCj1N0xsBHkGmNWDSf3raMeh7nD+ZFtGmBT9J3f
 8Y22AOCuLojUZ/JOMCwhjFQmz0dEgtmymmfgY0m+0N2cWSUBDlH1iE0ToTlxG2vHo04t9lx
 +09N6Xwwl1YJGTNB4twA0eMgXYfWorgiruqVvekRyIQDrjGTE75XYdF9P2oaGXYao74pU5I
 qbrujiqMD2a9o8AqRsS6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v22YYoJgS1U=:glE+HKseKd+hO7fAl+VqZz
 VltoBjOAXfD9mVpqM9rPzdBb1CZziAmxieZVAXySQbV+hXlfd3gGF9ciG4m0akBjn//ucGTWO
 rcTL7UkES97E4PM7jlg8veQCHJS8CjcG8aQ7+j5YE4XHIT1THhEQ1wOfCdu8N5G7JWZ5gdzdd
 FCyicS5nkuayRPRgy1l2+j2vOc5YMT2Ad5hJ/NGHusgUyJ5/t7A6aJ8JcjPi07bfW+00B4SsG
 SKtPQVG9qtxTNodPzfLqapWWlKFK3KPcIaR+bDo7YN+ydKeoYH4d6cLZt9Yg51k5eGI8ZQ/UK
 EqHmEMEm4bzx1mBbD1H3VvRFzvO5jKFAuPdknRqdEEcPAbrh9i3tVdUwCiHJDU9rtJKGll/ER
 5CNvpej6SDuCft3+vJO6dUNMoNN3Mat8tno6aTacot6cxEs5Qk92lv6kSB5LnNUQ0ecKYkdUH
 3jM2BItdh1c7Qmisrkn42yK1ek31dUR4WjzAqrhQSN7ldrl/YH9NO4lptsz0pOvktMFLrZL+z
 FbIDZTh49PqwJ6FkA36h0/0aCwmkJCWfgP/EK82keNb8ZPq00Ydmxs3/Xx5tojSYvkUu+TXyO
 aBgqkT3rfFtjrS+TJon2B2T4lsi1m5JPPjEi19lvyRl+HYuAXufiMMf/M01XI5EmCHfjhluVm
 JpxDRMl5BsrWYAnn0CQShx366yILPHgJ5bD0KsEty2ik37L3d6JM/joBnQEl1V6BhMz/Gww7F
 OT2KPu6N2LIp2lO6A5j47KgBrxvYB1hyaV/HfqNRi246QttvvjSj9X8EKGgqftbey7S7QXPj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284175>

Hi Robert,

On Fri, 15 Jan 2016, Robert Labrie wrote:

> Increasingly, network admins (including mine) think it's appropriate
> to intercept TLS handshakes on the firewall, and present the calling
> application with a self-signed cert for the requested domain (ie
> github.com). On Linux, this can be sorted out by putting the internal
> issuing CAs root cert in /etc/certs (or somesuch) and on windows, by
> importing it into the "Trusted Publishers" certificate store. The
> challenge comes from apps using OpenSSL on Windows, which doesn't have
> /etc and doesn't support the windows certificate store.

OpenSSL on Windows has no `/etc`, but Git does offer a way to provide your
own certificates, via the http.sslCAInfo setting.

Furthermore, you can rebuild cURL with support for WinHTTP (which accesses
the Windows Certificate Store). Since this is a compile time switch, we do
not support that with Git for Windows (until the day when cURL can be
built with WinHTTP *and* OpenSSL support and configured via a switch to
use one or the other).

> Presently, I'm using this procedure:
> http://stackoverflow.com/questions/9072376/configure-git-to-accept-a-particular-self-signed-server-certificate-for-a-partic

It may be a good idea to summarize it here (I would consider that good
form).

Ciao,
Johannes
