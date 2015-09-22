From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Tue, 22 Sep 2015 12:12:22 +0200
Message-ID: <FAA838A1-CBD8-4716-ADDE-6CC912C19BE6@gmail.com>
References: <1442829701-2347-1-git-send-email-larsxschneider@gmail.com> <1442829701-2347-2-git-send-email-larsxschneider@gmail.com> <xmqqio73abl0.fsf@gitster.mtv.corp.google.com> <E47DE9F0-6017-4E96-AC29-E6C60C4D85CB@gmail.com> <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 12:12:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeKYq-0005Qo-SI
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 12:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932824AbbIVKM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 06:12:26 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35850 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932703AbbIVKMY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 06:12:24 -0400
Received: by wicgb1 with SMTP id gb1so152418298wic.1
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 03:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=NIftwyDDy7s7C2mw5kmQAtwHQ2cxQqzjaRE3JcQLA4I=;
        b=IgUd1Ee6TMT1abwyeQqTSBxnl+yBPiP8xImuovpjq6clnwfpAeNHCrC4cCbDd70DmW
         58vGbVKK8mAMr+0RccykVUD47+p4sSzIq0n+nrka3bSWnZTwEP5bEMSwfrdN7kzsujz1
         cpSfuvm0p6FbGirnouThaLzvHrdPC0bPARIOa0MMvavm7b6XDSJC91EzUSRwVNz9Epli
         xf639kxOFwju9VGubK8nbZn9NwbYmdXpQhs3OBa/Hi2Xt/FJl/MTy3Wy3RAO9ORsUiEm
         0bZlZT1TxBbaTQBkgZ0PpWM0eM9A6tDTp2O3VJTJGHNV1nkX0bu/oSG+Usx2X91RuQGD
         yTqA==
X-Received: by 10.194.190.75 with SMTP id go11mr27574282wjc.80.1442916743341;
        Tue, 22 Sep 2015 03:12:23 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p10sm1060793wjx.7.2015.09.22.03.12.22
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 03:12:22 -0700 (PDT)
In-Reply-To: <CAPig+cRV-RCdcmAHG+bRL6_yYYNCRqQPQ+v3KCXwC81StGKibg@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278387>


On 22 Sep 2015, at 01:54, Eric Sunshine <sunshine@sunshineco.com> wrote=
:

> On Mon, Sep 21, 2015 at 7:03 PM, Lars Schneider
> <larsxschneider@gmail.com> wrote:
>> On 21 Sep 2015, at 20:09, Junio C Hamano <gitster@pobox.com> wrote:
>>> larsxschneider@gmail.com writes:
>>>> +test_expect_success 'init depot with UTF-16 encoded file and arti=
ficially remove BOM' '
>>>> +    (
>>>> +            cd "db" &&
>>>> +            p4d -jc &&
>>>> +            # P4D automatically adds a BOM. Remove it here to mak=
e the file invalid.
>>>> +            sed -e "$ d" depot/file1,v >depot/file1,v.new &&
>>>=20
>>> Do you need the space between the address $ (i.e. the last line) an=
d
>>> operation 'd' (i.e. delete it)?  I am asking because that looks ver=
y
>>> unusual at least in our codebase.
>>=20
>> Well, I am no =93sed=94 pro. I have to admit that I found this snipp=
et
>> on the Internet and it just worked. If I remove the space then it
>> does not work. I was not yet able to figure out why=85 anyone an ide=
a?
>=20
> Yes, it's because $d is a variable reference, even within double
> quotes. Typically, one uses single quotes around the sed argument to
> suppress this sort of undesired behavior. Since the entire test body
> is already within single quotes, however, changing the sed argument t=
o
> use single quotes, rather than double, will require escaping them:
>=20
>    sed -e \'$d\' depot/file...
>=20
> Aside: You could also drop the unnecessary quotes from the 'cd' argum=
ent.

Thanks for the explanation. Plus you are correct with the quotes around=
 =93db=94=85 just a habit.

@Junio:=20
If it is no extra work for you, you can remove the quotes around =93db=94=
=2E I can also create a new patch roll including the sed change and the=
 quote change if it is easier for you.

Best,
Lars
