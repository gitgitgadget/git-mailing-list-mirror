From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 00:52:20 +0200
Message-ID: <1B50DC8E-45CC-4D9A-80A1-6391D762A81C@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <vpqwpurx2j1.fsf@grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, johannes.schindelin@gmx.de,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Pete Wyckoff <pw@padd.com>,
	=?iso-8859-1?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 00:52:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmUuM-0001ud-OO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 00:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbbJNWw0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2015 18:52:26 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37274 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166AbbJNWwZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2015 18:52:25 -0400
Received: by wijq8 with SMTP id q8so103551125wij.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=TCUv/14fpsuhNGr4xziturgdZSmoFBifQ2OP9krhVuw=;
        b=hGeB6RsNif6L2Wh3L3YebjuMjCYSLaieGLdYNXgIxXy9EBXGxQVvNEHlXjUEfth7av
         HDgSS4hHssic/l+fGUHN9wqDLy17lqmhrEX4zwA+MwNgCW4R6zhDx4x53BUI6I4Fwifp
         Sx/bDrxNILQBGuNLzUogcsIDPOmETNgg7vbv6QkehQOYcnMfd3/H5bZVELA6F+Q/OJf4
         B5F84nKICOBZLfAvvbMGW3GEY9Tw8kwidk7MvM5GFWB0rZMFu17vZ6C6NcrgJSuj9iv0
         eGqUUU76MnUFWPHUjkjCjC2B5GB0fFFOslBIiBdteBQArcNBv7U94K3n9nyZfeNaaCke
         FvrQ==
X-Received: by 10.194.91.193 with SMTP id cg1mr7981253wjb.88.1444863144601;
        Wed, 14 Oct 2015 15:52:24 -0700 (PDT)
Received: from [10.32.248.190] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id a9sm2511757wiy.11.2015.10.14.15.52.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Oct 2015 15:52:23 -0700 (PDT)
In-Reply-To: <vpqwpurx2j1.fsf@grenoble-inp.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279636>


On 12 Oct 2015, at 22:20, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> w=
rote:

> larsxschneider@gmail.com writes:
>=20
>> --- /dev/null
>> +++ b/.travis.yml
>> @@ -0,0 +1,46 @@
>> +language: c
>> +
>> +os:
>> +  - linux
>> +  - osx
>> +
>> +compiler:
>> +  - clang
>> +  - gcc
>> +
>> +before_install:
>> +  - >
>> +    export GIT_TEST_OPTS=3D" --quiet";
>> +    case "${TRAVIS_OS_NAME:-linux}" in
>> +    linux)
>> +      wget -q https://package.perforce.com/perforce.pubkey -O - \
>> +        | sudo apt-key add -
>> +      echo 'deb http://package.perforce.com/apt/ubuntu precise rele=
ase' \
>> +        | sudo tee -a /etc/apt/sources.list
>> +      wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key a=
dd -
>> +      echo 'deb https://packagecloud.io/github/git-lfs/debian/ jess=
ie main' \
>> +        | sudo tee -a /etc/apt/sources.list
>> +      sudo apt-get update -qq
>> +      sudo apt-get install -y apt-transport-https
>> +      sudo apt-get install perforce-server git-lfs
>=20
> Sorry if this has been discussed already, but do you really need thes=
e
> "sudo" calls?
>=20
> They trigger builds on the legacy Travis CI infrastructure:
>=20
>  http://docs.travis-ci.com/user/migrating-from-legacy/?utm_source=3Dl=
egacy-notice&utm_medium=3Dbanner&utm_campaign=3Dlegacy-upgrade
>=20
> No big deal, but getting rid of sudo would be cool, and documenting w=
hy
> it can't easily be done in commit message and/or comments would be ni=
ce
> otherwise.
I would like to get rid of the "sudo" calls, too. Unfortunately I wasn'=
t able to achieve this so far because these packages are not white list=
ed on Travis CI (see Jean-No=EBl answer in this thread). I tried to dow=
nload and install the *.deb files manually using dpkg without luck. Any=
 idea or hint?
Nevertheless I don't think this is a problem as Travis CI states that "=
sudo isn't possible (__right now__)" on the new infrastructure. They ne=
ed to find a solutions because I believe many projects will run into th=
is issue...
http://docs.travis-ci.com/user/migrating-from-legacy/?utm_source=3Dlega=
cy-notice&utm_medium=3Dbanner&utm_campaign=3Dlegacy-upgrade#Using-sudo-=
isn%E2%80%99t-possible-(right-now)

- Lars