Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DB5C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjBBLho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBBLhn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 06:37:43 -0500
Received: from mail.wijmailenveilig.nl (136-144-226-130.colo.transip.net [136.144.226.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4148A64
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 03:37:41 -0800 (PST)
Received: from mail.wijmailenveilig.nl (localhost [127.0.0.1])
        by mail.wijmailenveilig.nl (Postfix) with ESMTP id 4P6xbk4BdfzGpGH
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:37:38 +0100 (CET)
Authentication-Results: mail.wijmailenveilig.nl (amavisd-new);
        dkim=pass (1024-bit key) reason="pass (just generated, assumed good)"
        header.d=dulfer.be
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dulfer.be; h=
        content-transfer-encoding:content-type:in-reply-to:subject:from
        :references:to:content-language:user-agent:mime-version:date
        :message-id; s=dkim; t=1675337857; x=1676201858; bh=iJ/eD/bw2EED
        qqPQigOAGoYICk1q2Xr72ngZLWmVtWA=; b=X3voyACuiXeM4e0rc8Za3QRAVZdy
        2mGpvroXa3PJVC280XrES4hO2mv+UlB9jy7Y/lzEs5BcMdWsxonULXD/8dWxwwQj
        CvNSrgO2Y5YK3rQnSv0pD64h5Pa/zvx990YT5jOMz+mNzwiAFNtwrbL/ZvXeCFqR
        4AOIHpe1efWjiHE=
X-Virus-Scanned: Debian amavisd-new at mail.wijmailenveilig.nl
Received: from mail.wijmailenveilig.nl ([127.0.0.1])
        by mail.wijmailenveilig.nl (mail.wijmailenveilig.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id P_1iqiErQhcs for <git@vger.kernel.org>;
        Thu,  2 Feb 2023 12:37:37 +0100 (CET)
Received: from [130.89.170.143] (mobiel503eaa12060b.roaming.utwente.nl [130.89.170.143])
        by mail.wijmailenveilig.nl (Postfix) with ESMTPSA id 4P6xbj57DwzGp4s;
        Thu,  2 Feb 2023 12:37:37 +0100 (CET)
Message-ID: <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
Date:   Thu, 2 Feb 2023 12:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20230201155712.86577-1-rafael@dulfer.be>
 <xmqq5ycl1c6h.fsf@gitster.g> <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
 <xmqqy1phxabi.fsf@gitster.g>
From:   Rafael Dulfer <rafael@dulfer.be>
Subject: Re: [PATCH] rev-list: clarify git-log default date format
In-Reply-To: <xmqqy1phxabi.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Add "on day X at time Y" here, and I'd buy that =F0=9F=98=89

Feels to me that adding "on day X at time Y" is a bit superfluous, since=20
it's quite obvious from the examples, but I guess it can't hurt to be exa=
ct.

I think it would be a good idea to still have _some_ text for=20
`--date=3Ddefault`, just so the structure of the sections stays the same=20
over all the date options. Maybe just something simple like.=20
"`--date=3Ddefault` is the default format. It is a custom format based on=
=20
rfc2822". And then below that we have the table (which is more a=20
conclusion to the section, as it provides examples for a few, more=20
unclear, formats)

On 01/02/2023 23:58, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> That is
>>>
>>>      The default format `--date=3Ddefault` shows a single line with
>>>      three-letter day of the week, three-letter month, day-of-month,
>>>      hour-minute-second in the "HH:MM:SS" format, followed by 4-digit
>>>      year, plus timezone information unless the local time zone is
>>>      used (e.g. "Thu Jan 1 00:00:00 1970 +0000").
>>>
>>> or something like that.
>> I think that following such a description in prose is still more
>> confusing than just showing an example. E.g. we could say:
>> =09
>> 	Assuming a user in timezone +0200 (Central Europe) values of
> Add "on day X at time Y" here, and I'd buy that ;-)
>
>> 	these `--date` argument would produce:
>> =09
>> 	|---------------+--------------------------------|
>> 	| rfc2822       | Thu, 7 Apr 2005 15:13:13 -0700 |
>> 	| rfc2822-local | Fri, 8 Apr 2005 00:13:13 +0200 |
>> 	| default       | Thu Apr 7 15:13:13 2005 -0700  |
>> 	| default-local | Fri Apr 8 00:13:13 2005        |
>> 	|---------------+--------------------------------|
