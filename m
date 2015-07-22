From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Fix sed usage in tests to work around broken xpg4/sed
 on Solaris
Date: Wed, 22 Jul 2015 11:52:32 +0200
Organization: gmx
Message-ID: <9b162fbacc41120c8c6edc053a017ba5@www.dscho.org>
References: <1437232892-27978-1-git-send-email-bdwalton@gmail.com>
 <55AB49C1.8010105@kdbg.org> <fadc4ff7e755913a4c6076165556b56c@www.dscho.org>
 <55AB6290.2090003@kdbg.org> <xmqqd1zmzuc7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Ben Walton <bdwalton@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 11:52:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHqhh-0008P2-MR
	for gcvg-git-2@plane.gmane.org; Wed, 22 Jul 2015 11:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933450AbbGVJwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2015 05:52:41 -0400
Received: from mout.gmx.net ([212.227.15.18]:57422 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933303AbbGVJwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2015 05:52:40 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MRWzQ-1ZOLzV3gBk-00SfGs; Wed, 22 Jul 2015 11:52:33
 +0200
In-Reply-To: <xmqqd1zmzuc7.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:X6EqCTIq84ZLQLhniUd3mtyNBzPYdn2ByoVit72u9MbvNclBJBq
 wJ1NfSyfk6ngoh6qbb2Me5BW3WBBktpoVaOcVCGl3TpfDFY42OcRUuGqYsVmzQXrIjaDJyl
 LZtE1tLg/EGA33GwBvDY8Ra2dokh8XhOZcBG5vkH0GH56tSIxX8BS5LwLQFg/fjp9cKU/2W
 O8cQCz2MeIbJ9I0FpKb6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:arZtvvvsUFo=:B907sLz8ZMARdeIztBqSUo
 g2XpFZ7gmlpsl1LvHIuX21Gv6rzBP59VuacCi5F1tCDvju0DgcGFEsWJBMqTU6pzLTbCI+r5F
 lfnn9cUgOEh3ZK8241NfR2tuBxWmYqkXUoTWbt9DKXWHB9tfrMlXrIEtyAbZwbF4cjGrhTHkp
 YT/1ReZ2QFz7XgVDeoQwPZ0SKLpHCW6SaKrpqaPo/It3HONyEK+u1G1I4CU3OynwE8Hi0w139
 9niEF4VadQzgMVIBlVeUpjNf/Ck6OrIWNJONy0NIpHKwgojhiSF9G/ZPVqHnzI+zOfqyqcf3P
 xCHpU/QvVD8bSa8cQHdlniE6HsGHty9zmiHBezB0jODNPt12Db5N+m750XwLXxBmh0mcwkZyM
 K/DeSa+oZ6PirFHu/LNsAirZ2nKHPKZET/tchfG9htmTmETGrSB0eJmm/g0iN4cjUKKbtCeLm
 jXQ+9uXkhb5nYcp7Sd/v2+9kptEhBgjzVfox/M/Z3YfjEvIthUBHhnpD/Q7HtddC6Ld9erwes
 i28tg/LYR3nQZE9ZsCNOOFcZUgXMkYFdcUiNl7G1e3ZKFSKZ2tCX1X0cxrbej1I3y0dXg2bZq
 zn2Wh+PNe/z9VPWwHUhzhBDINeJZejcVlBOumb2M85+xruez8k+90o06VqRXOU0G13V0Pb12f
 zvMkj5NXE/loXNCe9rhmJMRKhzzizqLqKkcxOdtulvZNs125uUJeX3OFllQs+Yc0Wcxc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274439>

Hi,

On 2015-07-20 18:07, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> I really wonder why the previous ">file+ && mv -f file+ file" dance
>>> needs to be replaced?
>>
>> The sed must be replaced because some versions on Solaris choke on the
>> incomplete last line in the file.
> 
> Switching from sed to perl is not being questioned.
> 
> I think Dscho is asking about the use of "-i", when the original
> idiom ">target+ && mv -f target+ target" worked perfectly fine.
> 
> I.e.
> 
> 	perl -p -e '...' file >file+ &&
>         mv file+ file

Thanks for translating from Dscho to English.

Ciao,
Dscho
