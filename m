From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Thu, 11 Dec 2014 17:54:56 +0100
Message-ID: <5489CC60.7080704@drmicha.warpmail.net>
References: <1418290234-21516-1-git-send-email-mail@eworm.de> <5489B90B.6070706@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Christian Hesse <mail@eworm.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 17:55:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz715-0005k1-OL
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 17:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756013AbaLKQy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Dec 2014 11:54:59 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45650 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754591AbaLKQy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Dec 2014 11:54:58 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 57CF1210AF
	for <git@vger.kernel.org>; Thu, 11 Dec 2014 11:54:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Thu, 11 Dec 2014 11:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KYckDJBPBOk1nyUpMhlGQQ
	jh4ko=; b=uDCTLZi5AhxNK7mBsd/x8NoAt9Jkjw2D8dpYMvi2MCj3ROwsoGZPam
	qn7vUtig2o2K4stQCo5GG6Bxk/fwPIoyQIIPrSCoYkycfsp1Sq50NrP3kmGqlfiK
	TduVokOn0ad9L2jMBeCq49zTsGsJ2eeiWmfVOl8g3iGpR2qUt6OYI=
X-Sasl-enc: FOoT5hzBXzHzI4evAluBn+41CbuHK5e4oCS/ugMS+aru 1418316898
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AAC32C0027D;
	Thu, 11 Dec 2014 11:54:57 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <5489B90B.6070706@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261285>

Torsten B=F6gershausen schrieb am 11.12.2014 um 16:32:
> On 11.12.14 10:30, Christian Hesse wrote:
>> ---
>>  t/lib-gpg.sh   |  6 ++++++
>>  t/t7004-tag.sh | 14 +++++++-------
>>  2 files changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
>> index cd2baef..05b07c6 100755
>> --- a/t/lib-gpg.sh
>> +++ b/t/lib-gpg.sh
>> @@ -22,6 +22,12 @@ else
>>  		GNUPGHOME=3D"$(pwd)/gpghome"
>>  		export GNUPGHOME
>>  		test_set_prereq GPG
>> +		case "$gpg_version" in
>> +		'gpg (GnuPG) 2.1.'*)
>> +			say "Your version of gpg (2.1.x) is missing some legacy features=
"
>> +			test_set_prereq GNUPG21
>> +			;;
>> +		esac
>>  		;;
>>  	esac
>>  fi
> We do not really need the GNUPG21 (and we don't need to touch the TC =
at all)
> 		case "$gpg_version" in
> 		'gpg (GnuPG) 2.1.'*)
> 			say "Your version of gpg (2.1.x) is missing some legacy features"
> 			;;
> 		*)
> 			test_set_prereq GPG
> 			;;
>=20
> 		esac
>   		;;
>=20

That would disable all GPG tests, which is pretty harsh.

If gpg 2.1 is the future of gpg (which I don't know), which should
rather prepare for that and make our tests independent of the version.
Is gpg 2.1 stable enough to cater for its special needs?

Michael
