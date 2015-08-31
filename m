From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 21:22:13 +0200
Message-ID: <55E4A965.8040305@web.de>
References: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
 <1441035616-39128-2-git-send-email-larsxschneider@gmail.com>
 <xmqqpp23we4d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org
To: Junio C Hamano <gitster@pobox.com>, larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Aug 31 21:22:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUf1-0005w6-5l
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbbHaTW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 15:22:27 -0400
Received: from mout.web.de ([212.227.15.4]:58074 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754332AbbHaTW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:22:26 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LqlRS-1Z27zS1kn4-00eJg1; Mon, 31 Aug 2015 21:22:20
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <xmqqpp23we4d.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:CDbk+R97+lOPKKwVw20C2NyxcfLMW5ytD6vr99HQXAorGaDWc28
 zCu4QNDlQ6M4+Br1ykbB6FK1OquiLmu7ue6djeywD764Nv/OO1Y9ZxuAMD3xJC9280aTxHR
 mh/cLgOf1DDzU4radkfrkJSnQMFr3Vs/Nc6VzXagvzOlOBoYWjW3D9O9jKjMlol1TxHAJDi
 fZMWmrVeiDgVzuiKHNN0Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kD8VzOCVNrE=:MgVYnYBhCyUw703lrFdABV
 iG6KP92BUsudylzEvbKGlN68hkbRkZWgFk6TAO+uX4lcyMSLQks8H0aykF6btcUaPSdajWEXr
 78ozb68HwTLLa5Xx108/YnbkUWMa5bHprX3PanQNTXNZhF+h69cpBYzo7aDS53nCbHxM2YtqG
 ChV2Edlu+KQrYtk1ONZO+xVpRYnDCc4230WxxmdOv35MvpWuI+jtf528gU5piyuw8xGDs+h9x
 jrNy5avDlgTai7Z39mErcDEdUR8aFeAalSE3Ce3D4pKfDh7GcVbdhuphuJwpoLdeIEPLIfofa
 9eKurpNP4sAz3I/r5nhgAcV52Sf5lEw3emu0y2WI5VDV6LOpIaRokrvDKWfOEQ5Bm/wS9hG9G
 EgDuMQUbyrfxHyUaMCax+RVKaqIN1c4iI3zKijy0lezwwXspmInum10s3egUBQpOYHs3L/ZzX
 jyseUwtLnknfISr6eED9b62jk2+pkiQniY1eD/Sde6jJkfanaq0HXOKPDPhrXeR6Wul78M3h0
 DgdS2s1twn0hngrEToG5lwQpo1Lu18TqL49zRDnCLr1WZYrv2jqSY9fYitjPaN1VYefNlv0FS
 qZjzT+XCf/10ULFfpcjSrSNPn8ZPMeas+dtYVFAYWaBuuVgk6/C8pKHmOUKOzHP5xOuZ9yWzj
 6oELl+ynOpzDYuKyZJ+/fVUMfAwW2YpJ3uWe7fbyOBjNfPkVmKPqI8mX0dUTsQqeIDntcr6cx
 L2vK1y1e3jewkfgrFqr+ft9JzIlGdpRLyY4uxA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276922>

On 2015-08-31 19.40, Junio C Hamano wrote:
> larsxschneider@gmail.com writes:

>> +test_expect_success 'Create a repo containing cp1251 encoded paths'=
 '
>> +	cd "$cli" &&
>> +
>> +	FILENAME=3D"$(echo "a-=A4_o-=B6_u-=BC.txt" | iconv -f utf-8 -t cp1=
252)" &&
>=20
> Hmm, we'd be better off not having a bare UTF-8 sequence in the
> source like this, especially when you already have the same thing
> backslash-escaped in the "expect" file below.  Perhaps
>=20
> 	NAME=3D"a-\303\244_o-\303\266_u-\303\274.txt" &&
>=20
> 	UTF8=3D$(printf "$NAME") &&
>         CP1252=3D$(printf "$NAME" | iconv -t cp1252) &&
>         echo "\"$UTF8\"" >expect &&
>=20
>         >"$CP1252" &&
>         p4 add "$CP1252" &&
>         ...
>=20
Using file names and iconv like this may not be portable:
- cp1252 may be called CP1252 (or may not be available)
- reading from stdin is not necessarily supported by iconv
- creating files in CP1252 may not be supported under Mac OS
   (Not sure about Windows)


One solution could be to use ISO-8859-1, convert into UTF-8,
and "convert into UTF-8" one more time.

We can skip using iconv in the test case completely, and use
something like this:
(Fully untested)

UTF8=3D$(printf '\303\203\302\204')
NAME=3D$(printf '\303\204')
