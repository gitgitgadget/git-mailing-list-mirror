From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client specs.
Date: Tue, 25 Aug 2015 15:14:13 +0200
Message-ID: <B7632D9A-BB8B-41E5-9C3D-F7376A0C81D3@gmail.com>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com> <55DC111A.6090501@diamand.org> <55DC285D.9030500@web.de> <23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com> <CAE5ih7-o6eVF-z2GORxHa_TdDaXgexLpW3jctESTnL46Mfdo8w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 15:14:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUE3R-0003l1-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 15:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825AbbHYNOR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 09:14:17 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38345 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbHYNOQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2015 09:14:16 -0400
Received: by wicja10 with SMTP id ja10so14713346wic.1
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZLXPcC2Er5jxm8k3Jq6RI17WkL3MwB6ZjqEp4nZ+iZ0=;
        b=H6u+mXya1DXGCQ8wA3+4CPABzJ+cKKPAYqTnYTE0Sd4+H+g3CCq8I8A0bx5c6e/ZHm
         /pumZ3P85Arg7ALzPtMg7CCVPi5xmOZ58TJ4uIVQ+1dNgmL+RnQAvoHmeAS2YRi+ctn1
         i4ss5TU54tkyUaUvCbZJaxPKGxTrIkZk1YdZ8S0lGDEXKLK8iymc4JFPO4OPnYpcHAM7
         lBMemUh/KXF+Zam09ZdR22XLTkT7BnHs/V2RzzXcXEQJLbSqX7ob3dMKIvs+0plm1Qo3
         fDuYnfenJYGetiLr0qPK4L2HyMhcXnPnuJevkx72jOeWvF3Z7kZCsppX/Xx/M6UELvbM
         UwHA==
X-Received: by 10.194.122.132 with SMTP id ls4mr48243322wjb.130.1440508455813;
        Tue, 25 Aug 2015 06:14:15 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id en5sm2624259wib.18.2015.08.25.06.14.14
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Aug 2015 06:14:15 -0700 (PDT)
In-Reply-To: <CAE5ih7-o6eVF-z2GORxHa_TdDaXgexLpW3jctESTnL46Mfdo8w@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276523>

On 25 Aug 2015, at 13:57, Luke Diamand <luke@diamand.org> wrote:

> On 25/08/15 11:30, larsxschneider@gmail.com wrote:
>=20
>> Unfortunately the command line option is not sufficient as the resul=
ting paths are still messed up. I added the switch but it looks like as=
 core.ignorecase does some additional magic on fast-import. You can see=
 my changes here:
>> https://github.com/larsxschneider/git/commit/b4399179ff542161c2c5b83=
c34c5b4901287ceb0
>>=20
>> You can also run the unit tests to see the results here:
>> https://github.com/larsxschneider/git/tree/lars/fix-path-v5-with-com=
mand-switch
>>=20
>> The only way I could image to fix that is to request every path from=
 P4 as shown in my PATCH v4. This would be slow and the change would be=
 rather huge.
>=20
> Yes, you're right - fast-import has special handling based on core.ig=
norecase.
>=20
> There was a thread a while back saying that it shouldn't do this, and
> instead should have a new --casefold option, which would make more
> sense, but isn't the case at present.
>=20
> http://www.spinics.net/lists/git/msg243264.html
>=20
>> I am curious:
>> I run all my P4 -> git migrations on a Linux box with EXT4 and core.=
ignorecase=3DTrue. I did not realize that this might cause trouble. Wha=
t could happen and what should I look out for?
>=20
> An obvious way it could go wrong would be if you had a a repo that
> _did_ care about case (e.g. had Makefile and makefile in the same
> directory) and you then tried to git-p4 clone a separate repo into a
> different branch. In an ideal world, you would only use the
> case-folding on the git-p4 based repo. I think while fast-import just
> checks core.ignorecase, that's not possible.
OK. Thanks for the explanation.

>=20
> So the choices are:
>=20
> 1. A new command-line option which would silently set core.ignorecase
> 2. Users just have to know to set core.ignorecase manually before
> using git-p4 (i.e. Lars' patch v5)
> 3. Fix fast-import to take a --casefold option (but that's a much big=
ger change)
>=20
I vote for 2 because that solves the problem consistently with the exis=
ting implementation for now. That means we don=92t surprise git-p4 user=
s. In addition I would try to fix (3), the =97casefold option, in a sep=
arate patch. Although this (3) patch could take a bit as I have two mor=
e git-p4 patches in the queue that I want to propose to the mailing lis=
t first.

- Lars