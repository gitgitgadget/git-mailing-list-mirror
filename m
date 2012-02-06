From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: [PATCH 6/6] Automatically switch to crc32 checksum for index when
 it's too large
Date: Mon, 06 Feb 2012 01:07:26 -0800
Message-ID: <8A80E303-311E-4B87-A4B4-4F39AA932956@apple.com>
References: <1328507319-24687-1-git-send-email-pclouds@gmail.com>
 <1328507319-24687-6-git-send-email-pclouds@gmail.com>
 <E799595D-61B3-4978-BCE1-BA6A33034B55@apple.com>
 <CACsJy8Dv9fUzL3COZKVw_KR6aF20kHaw8M4CdBXJDA9H3fbxLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Joshua Redstone <joshua.redstone@fb.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 10:08:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuKZ8-0006Nh-1P
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 10:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237Ab2BFJIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 04:08:44 -0500
Received: from crispin.apple.com ([17.151.62.50]:40651 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991Ab2BFJIm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 04:08:42 -0500
X-Greylist: delayed 1094 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Feb 2012 04:08:42 EST
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Server 7u4-23.01
 (7.0.4.23.0) 64bit (built Aug 10 2011))
 with ESMTPS id <0LYY006LNRZ8VLJ0@mail-out.apple.com> for git@vger.kernel.org;
 Mon, 06 Feb 2012 01:07:27 -0800 (PST)
X-AuditID: 11807130-b7ba9ae0000003b1-6e-4f2f984f7f88
Received: from kencur (kencur.apple.com [17.151.62.38])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 4E.3D.00945.F489F2F4; Mon, 06 Feb 2012 01:07:27 -0800 (PST)
Received: from [10.0.1.254]
 (adsl-70-231-241-90.dsl.snfc21.sbcglobal.net [70.231.241.90])
 by kencur.apple.com
 (Oracle Communications Messaging Server 7u4-23.01(7.0.4.23.0) 64bit (built Aug
 10 2011)) with ESMTPSA id <0LYY00M5SS0EXQ10@kencur.apple.com> for
 git@vger.kernel.org; Mon, 06 Feb 2012 01:07:27 -0800 (PST)
In-reply-to: <CACsJy8Dv9fUzL3COZKVw_KR6aF20kHaw8M4CdBXJDA9H3fbxLw@mail.gmail.com>
X-Mailer: Apple Mail (2.1426)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsUiON1OTdd/hr6/QetTYYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGUsvXeCteApR8WV6f9ZGhh72LsYOTkkBEwk1nVMZYKwxSQu3FvP
	1sXIxSEk0M4kcenbS0YI5zCTRN+htyxdjBwczALqElOm5II08AroSZzbNxdskLBAvMT8X9vZ
	QGw2AQ2JT6fuMoPYnALBEvNaLjOC2CwCqhLPtxxkhxiTIrF4pxRImFlAW+LJuwusECNtJF68
	mQp1w2dGiU8LlrGAJEQEdCRO3rnCCHGorMShGSsZJzAKzEK4aBaSi2YhGbuAkXkVo2BRak5i
	paGhXmJBQU6qXnJ+7iZGUNg1FBrsYFz7k/8QowAHoxIPr6Suvr8Qa2JZcWXuIUYJDmYlEV61
	SUAh3pTEyqrUovz4otKc1OJDjNIcLErivJutlf2FBNITS1KzU1MLUotgskwcnFINjA53XmXu
	+3lx4i/JB8yLuzTCRXhfR//xuhqeInrptDHDswqHCe+ObdfPmCJY78HqsGxpUru8WqePiz53
	ohjjwvPVvDdmLTqgJOjnbMHMl7y0sX91wl3GsJ5a8YRjBs96woM8ao4nbuxvfbz3Gn/A6uJ6
	xUduhd/1u56FbF63IVr5213vP7Z9SizFGYmGWsxFxYkA3lQf3jcCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190054>


On Feb 6, 2012, at 12:54 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> w=
rote:

> 2012/2/6 Dave Zarzycki <zarzycki@apple.com>:
>> Which crc32 polynomial is being used? crc32c (a.k.a. Castagnoli)? It=
 would be great if this were the same polynomial that Intel implements =
in hardware via SSE4.2.
>=20
> It's zlib's crc32.

That's too bad. Zlib uses crc32, not crc32c. The Intel instruction is c=
rc32c and is 2-3 times faster than the best software based implementati=
on.

http://www.strchr.com/crc32_popcnt



>=20
>> On Feb 5, 2012, at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>>=20
>>> An experiment with -O3 is done on Intel D510@1.66GHz. At around 250=
k
>>> entries, index reading time exceeds 0.5s. Switching to crc32 brings=
 it
>>> back lower than 0.2s.
>>>=20
>>> On 4M files index, reading time with SHA-1 takes ~8.4, crc32 2.8s.
> --=20
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
