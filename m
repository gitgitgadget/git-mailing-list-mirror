Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C15C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36A1361990
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 17:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhF1REY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhF1REW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 13:04:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8146EC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 10:01:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g21so12952218pfc.11
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3npXCgeRaayiW7pHZevPx11GPvzi4R8/xUi9ToGaJo4=;
        b=ObQur93R4YluyCduQNeEtmMAHeP95BqGvOj5xSZEVrGh7eXYQlp2rerhupzkdcjgQX
         djuHUHDu36DwcW4u+n6EOnET5RcmSr6RD8ViJ3y9RnlaWnaGbIhq2w3/7p1ykMFU5/he
         kEB0Nh7rRZ4F77Ypd/CKWQnrbHorAZRUZzsq4Bt/cfrMt91QGiE69HBSLE9Uh21JISha
         dorVK/TrErrJyTdpZqR25srN6DkT4Q5mlfO/2ZheRmEqUuqm9kB8sLSWQ24HBrQbUuaE
         AaJ2ogqEE0wexsG6aQTekKD2soT17Bo4VbCWdvfY8PAKyaTNit+xyabbaBXtcvfBBFap
         xl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3npXCgeRaayiW7pHZevPx11GPvzi4R8/xUi9ToGaJo4=;
        b=bGDxFEcSRtWEumTi9VKTPYEwqGjLbHoLvjIQjZzVLJqN1zdYhUVtVkB4WIwbX3NvDA
         UPdQJY8FsHsozCApjrn25bWsQ6ICnVjFLmVeCp+eziQ73U92vel9EkaeInAXYe6mm0j7
         IlOTDSaWv0vcDwS0N/NgJajnHtAMbTwoIRUoVAwOJnbtzScxr+QAA6td+49+n5AO7/df
         lHW6OaDUCBekMSHVicSaXMJufR8U05w18ujsEckGZUbRp65xRo3HtRd9uOoy3c1PWbVI
         xGvEDXmMsjj3bG7d9C835nOrK6ZCs9w2XBm+E7dkHrXMbmjUy4qDTQ4yBht7t/29JjFZ
         2YEQ==
X-Gm-Message-State: AOAM533zueB5dKBC4CYRQHk+AXUfxJWQE7Bp7TFiO6JrTOQXK+g9jDVK
        vRoazQR6zicMkXstRlIlj+s=
X-Google-Smtp-Source: ABdhPJw7wDpwoc0/CV/FKOZaM0UlajfTAY/x4x8O+PRNIqKAUc+GjWedyaP3gIbqQULQA4tekrnvUA==
X-Received: by 2002:a63:d213:: with SMTP id a19mr24286335pgg.28.1624899715014;
        Mon, 28 Jun 2021 10:01:55 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.143])
        by smtp.gmail.com with ESMTPSA id 195sm15170223pfw.133.2021.06.28.10.01.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 10:01:54 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_6?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CACdWUYWOsU+oHDNnur_NCSBuMfea95rKqrS5z2x-JRc_C0iyfg@mail.gmail.com>
Date:   Mon, 28 Jun 2021 22:31:51 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7303CAC9-A155-44FC-AC5B-D34F28C250EF@gmail.com>
References: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
 <CACdWUYWOsU+oHDNnur_NCSBuMfea95rKqrS5z2x-JRc_C0iyfg@mail.gmail.com>
To:     Shourya Shukla <periperidip@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 28-Jun-2021, at 22:03, Shourya Shukla <periperidip@gmail.com> wrote:
>=20
>> Le dim. 27 juin 2021 =C3=A0 16:54, Atharva Raykar =
<raykar.ath@gmail.com> a =C3=A9crit :
>> Here's the latest instalment of my weekly Git blog:
>> https://atharvaraykar.me/gitnotes/week6
>>=20
>> A peek:
>>=20
>>   * Project progress and current strategy.
>>     (mostly relevant to mentors)
>>=20
>>   * Reflections:
>>     - How does Git even start?
>>       =
(https://atharvaraykar.me/gitnotes/week6#how-does-git-even-start)
>>       This was just something I was curious about, not really =
important
>>       to my project. If anyone knows the answer to what I asked in =
that,
>>       section, it would be nice to know!
>=20
> This was a nice read! I always used to wonder how exactly Git starts.
> One thing you can do is that link the file/line you talk about. Takes =
5-10
> minutes extra but is totally worth it in my opinion especially from =
the
> reader's standpoint.

Yeah, makes sense. I'll add the links.

> Do keep in mind that if you choose to link a file/line, link it from a
> specific tag (in this case a Git version) instead of the usual =
'master'
> link. There is a reason for this which I leave it to you to find out =
;)
> If you are not able to figure it out, feel free to PM us or ask on the =
list.

Right, that makes sense now that you mention it. I did not consider
the fact I have been linking a moving target the whole time.

Heh, I gotta fix all those other blog links now.

> Do give Makefiles a read in case you are not well-versed on them. It
> might make the 'Git startup' process a bit easier to understand.

Yeah, I did try reading the makefiles at first, but I found it easy to
get lost when I didn't know what to look for at first. I did eventually
understand how the startup works now :)

Reading that Makefile in the past helped me with other undocumented (to =
my
knowledge) things as well, like support for compile-time instrumentation
with LLVM's ASAN (I plan to write a short blog post about that outside =
of
my weekly reports someday).

