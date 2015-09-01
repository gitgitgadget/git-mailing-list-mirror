From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 1 Sep 2015 14:47:15 +0200
Message-ID: <6BD3F017-37E4-4677-BCCE-D84E7031B780@gmail.com>
References: <1441059026-66814-1-git-send-email-larsxschneider@gmail.com> <1441059026-66814-2-git-send-email-larsxschneider@gmail.com> <55E52BA7.6020303@web.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, luke@diamand.org, gitster@pobox.com
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 01 14:47:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWkyH-00042o-OL
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 14:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbbIAMrU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 08:47:20 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38167 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbbIAMrT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2015 08:47:19 -0400
Received: by wiclp12 with SMTP id lp12so29565802wic.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4SZ00JY2g4DY2d9KltQDY9MeREEuiOlzN3Lw+0st9nY=;
        b=JZAkXkL5wZSng3vtAz/BNwPst6Dk5mKpB2MLnDV/WdnM4lZ9+SIJehzXM8BAl1SGxp
         hIyQQqZ02q74X/lqPVYy8YlyVRhTx7bo8N3AaTomOwHI2xLgy+SAhgyRsyneR9p1getQ
         Dn3aTBSLYduYjyO+fWK+8gNqbKobUIy95f1PROqXsth5HHY4+vyZYLo65G2YZa6NgFOe
         0PEjKX8RZdL7kaETqIyQgOYF0kMJfWQLPuWH0P6wFb5Uy4E3cTGIexICvSKTnrOIA+Bh
         dwjp8Ejz0XUUC3ydpUhPOop1/Ja5qXY8wVSciEmJmHk/txHMOBUVtJznaPncnBCE3agB
         Abrw==
X-Received: by 10.194.179.73 with SMTP id de9mr278456wjc.91.1441111638877;
        Tue, 01 Sep 2015 05:47:18 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p20sm2617367wie.5.2015.09.01.05.47.17
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 05:47:18 -0700 (PDT)
In-Reply-To: <55E52BA7.6020303@web.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276976>


On 01 Sep 2015, at 06:37, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 01/09/15 00:10, larsxschneider@gmail.com wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>  Documentation/git-p4.txt        |  5 +++++
>>  git-p4.py                       |  6 ++++++
>>  t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++=
++++++++
>>  3 files changed, 49 insertions(+)
>>  create mode 100755 t/t9821-git-p4-path-encoding.sh
>>=20
>>=20
<snip>
>=20
>> +
>> +test_expect_success 'Create a repo containing iso8859-1 encoded pat=
hs' '
>> +	cd "$cli" &&
>> +
>> +	ISO8859=3D"$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)=
" &&
>> +	>"$ISO8859" &&
>> +	p4 add "$ISO8859" &&
>> +	p4 submit -d "test commit"
>> +'
> Sorry for being persistant,
> but you can't create files with names that  are ISO-8859-1 encoded un=
der Mac OS,
> we end up like this:
>=20
> a-%E4_o-%F6_u-%FC.txt
You are right. However, my goal is not to create a file with ISO-8859-1=
 characters in Mac OS. My goal is to create this file in Perforce and t=
his approach seems to work.

>=20
> (And I'm still not convinced, that we need to call iconv each time we=
 execute the TC,
> for a string that is always the same.
> The string can be converted once, and embedded in the TC:
> The following should work under Mac OS (but I don't have p4 to test i=
t)
>=20
> ISO8859_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
>=20
> UTF8_ESCAPED=3D"\141\055\303\203\302\244\137\157\055\303\203\302\266\=
137\165\055\303\203\302\274\056\164\170\164"
>=20
> ISO8859=3D$(printf "$ISO8859_ESCAPED=94)
OK. However, how about this?

UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
ISO8859_ESCAPED=3D"\141\55\344\137\157\55\366\137\165\55\374\56\164\170=
\164"

# You can generate the ISO8859_ESCAPED with the following command:
# printf "$UTF8_ESCAPED" | \
# iconv -f utf-8 -t iso8859-1 | \
# xxd -ps -u -c 1 | xargs bash -c 'for v; do echo "ibase=3D16; obase=3D=
8; $v" | bc; done' bash | \
# tr "\n" "\\"



>=20
>> +
>> +test_expect_success 'Clone repo containing iso8859-1 encoded paths'=
 '
>> +	git p4 clone --destination=3D"$git" --path-encoding=3Diso8859-1 //=
depot &&
>> +	test_when_finished cleanup_git &&
>> +	(
>> +		cd "$git" &&
>> +		printf "$UTF8_ESCAPED\n" >expect &&
>> +		test_config core.quotepath false &&
>> +		git ls-files >actual &&
>> +		test_cmp expect actual
>> +	)
>> +'
>>=20
> The ls-files can be written shorter (if we like short code)
>=20
> +		git -c core.quotepath=3Dfalse ls-files >actual &&
=46ixed. Thank you!
