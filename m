Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24F1EB64DD
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 00:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGQA2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 20:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQA2L (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 20:28:11 -0400
X-Greylist: delayed 3606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Jul 2023 17:28:09 PDT
Received: from mail2.pdinc.us (mail2.pdinc.us [67.90.184.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F286E47
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 17:28:09 -0700 (PDT)
Received: from lovegrove (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 36GNRrbd008419
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 16 Jul 2023 19:27:53 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 36GNRrbd008419
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1689550073; bh=1sSS8HbOLV1KD1sdIm/Gqn/f+9DFlMN7Vq0MDQ8b02s=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=r8eGGR/tKnhPp1CEb6jt/QiXSdQxtKM4IavCyks4l22UeDj42jIjOGP9j9WsF94gf
         5OYe8pk0fQkYlveoJisx9wxlGILsaey5A4GlIN6nDeM3qCissXeTgB9buD/eG9rGb7
         2NZXTVc4YCmwvEOnBiNbV8n4GJbkJXjEznV1jRGjurIb/7sbLxggwMiDi13nOhblvZ
         tF/xYmUFCxoVGxlLRo/sh9Je+2Zctcbhye4jnewSe75mzrRgcBH/4g41h8+DGnY9A8
         Jb9u1lcAMjqtzMHZ/eoMKvfNw4B+XuoHroCYuXSy2R9gTgw45i10dvjz7enBuh3IBx
         i2m5bk2r4R5tA==
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'nick'" <nick@nicholasjohnson.ch>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous> <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous> <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous> <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
In-Reply-To: <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
Subject: RE: Git Privacy
Date:   Sun, 16 Jul 2023 19:27:52 -0400
Message-ID: <00b901d9b83d$249a2d20$6dce8760$@pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Content-Language: en-us
Thread-Index: AQHtErF6w8ZIUenaPtejiJMYrPbg0QEGGU1YAkcCJMYCq1o+QgJg3jd2AcSmUdSvRWNfUA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: nick=20
> Sent: Sunday, July 16, 2023 7:07 PM
> Subject: Re: Git Privacy
>=20
> nick wrote:
> > The time zones reveal private information about developers and they
> > don't even serve a use case, as far as I'm aware. A =
backwards-compatible
> > way to solve this leak would be to convert timestamps to UTC by =
default
> > and have a Git config option to revert back to the current behavior.
>=20
> Come to think of it, even if timezones were converted to UTC by =
default,
> time of day would still leak information about a user's likely =
timezone.

Discussed this with our policy wonks...

Short answer - no. There is no legal assumption that can be made - your =
work hours cannot be assumed to be 9-5. They also said that time zone is =
"too broad at 1/24th of the world", but understood the concern.

That being said the recommendation is to add --privacy

Where it assumes some defaults and those defaults can be controlled in =
your config or via --privacy=3Doption1,option2=20

And then some of the options can be:

date-timezone=3DUTC

date-precision=3D8hour

etc...

v/r,

Jason Pyeron

--
Jason Pyeron  | Architect
Contractor    |
PD Inc        | Certified SBA 8(a)
10 w 24th St  | Certified SBA HUBZone
Baltimore, MD | CAGE Code: 1WVR6

.mil: jason.j.pyeron.ctr@mail.mil
.com: jpyeron@pdinc.us
tel : 202-741-9397


