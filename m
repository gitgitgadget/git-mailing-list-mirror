From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [PATCH] Unicode: update of combining code points
Date: Wed, 16 Apr 2014 13:51:43 +0300
Message-ID: <534E60BF.5020602@bracey.fi>
References: <201404072130.15686.tboegi@web.de> <alpine.DEB.2.00.1404152009020.29301@ds9.cixit.se> <534E0B84.6070602@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Krefting <peter@softwolves.pp.se>, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 16 13:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaNhi-0008PF-Ol
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 13:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbaDPLI3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2014 07:08:29 -0400
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:52203 "EHLO
	mo68.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755625AbaDPLI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 07:08:28 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Apr 2014 07:08:28 EDT
Received: from mail432.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with SMTP id 40D93FFC872
	for <git@vger.kernel.org>; Wed, 16 Apr 2014 12:51:47 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 Apr 2014 12:51:49 +0200
Received: from 62-183-157-30.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@62.183.157.30)
  by ns0.ovh.net with SMTP; 16 Apr 2014 12:51:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <534E0B84.6070602@web.de>
X-Ovh-Tracer-Id: 6972416648795099280
X-Ovh-Remote: 62.183.157.30 (62-183-157-30.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtdduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejvddrtdduucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246329>

On 16/04/2014 07:48, Torsten B=C3=B6gershausen wrote:
> On 15.04.14 21:10, Peter Krefting wrote:
>> Torsten B=C3=B6gershausen:
>>
>>> diff --git a/utf8.c b/utf8.c
>>> index a831d50..77c28d4 100644
>>> --- a/utf8.c
>>> +++ b/utf8.c
>> Is there a script that generates this code from the Unicode database=
 files, or did you hand-update it?
>>
> Some of the code points which have "0 length on the display" are call=
ed
> "combining", others are called "vowels" or "accents".
> E.g. 5BF is not marked any of them, but if you look at the glyph, it =
should
> be combining (please correct me if that is wrong).

Indeed it is combining (more specifically it has General Category=20
"Nonspacing_Mark" =3D "Mn").

>
> If I could have found a file which indicates for each code point, wha=
t it
> is, I could write a script.
>

The most complete and machine-readable data are in these files:

http://www.unicode.org/Public/UCD/latest/ucd/UnicodeData.txt
http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt

The general categories can also be seen more legibly in:

http://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedGeneralCa=
tegory.txt

=46or docs, see:

http://www.unicode.org/reports/tr44/
http://www.unicode.org/reports/tr11/
http://www.unicode.org/ucd/

The existing utf8.c comments describe the attributes being selected fro=
m=20
the tables (general categories "Cf","Mn","Me", East Asian Width "W",=20
"F"). And they suggest that the combining character table was originall=
y=20
auto-generated from UnicodeData.txt with a "uniset" tool. Presumably th=
is?

https://github.com/depp/uniset

The fullwidth-checking code looks like it was done by hand, although=20
apparently uniset can process EastAsianWidth.txt.

Kevin
