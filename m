Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1C4C636CC
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 05:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHFoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 00:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjBHFoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 00:44:23 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05C93DE
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 21:44:22 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id y1so15641179wru.2
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 21:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/uTTebA+nuxlsnOS1T4WLdoDWSm/wRqMcQEWKzLeWk=;
        b=IjpMxpGn9cjNTb/WeI90TLhMX1B6w8K65ZTrof52CRsy/sbo7l9JWsyjSLXC9ShfWI
         q8trby4rNB2sIFwe00EFua3BrmOt9Jsjq2vNx87PP2J13gbXdoepT3Awxdjv36nv2qSs
         d2xFgmhjR2HWWEQIJ/cdhkHUNQhBYNby8OdbCo3mYyPyI6VkMFW5Kkg4uJN4W8QpzdmR
         U39f8YdpJLuxBK0ZThgcauu0U1HwY1iI34hKfErrwq9YEHQcFZgM/cFpNq5ialAEXAAv
         tLKNhp5SvUczOJ4sck2YaeSewr+Oo2Jods7blzBZXN/yKKfiQgpp7yus3SSGvHV6HyIl
         MqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/uTTebA+nuxlsnOS1T4WLdoDWSm/wRqMcQEWKzLeWk=;
        b=7acIpaFW6yL2DXAauDox0qKrAL9EBibpgIDudDwibxSBZqLM13U+RkRiMcOGbIPNfs
         bdUFZ0OkvKg3KMJ5Y2cGWRPQAau/gZJns7dM3Z+QW/dHK97mCzJIP7yHnXvSX+16otq3
         uuMFN14+NTynwutUQfluf7Xip2xm4WIq4wTCsUuCxS3OpCxzUYWcmMlzxhn1fJR5CmBO
         wBtBD9Ok4WU9hLYN0LnLvgrR+RHBYWaKyK28YKAU46/0lCQ2ozbpCzgFPOtVAmkD0mlO
         D24KjTOfpXDOk2wOSOxqLnMZS/6qbeEWeXeZrbsIZlShkpoQobnZoDEWmpFhyqhxO+xW
         r9gA==
X-Gm-Message-State: AO0yUKW7PvoNmggEIin4UNharGJdSVlc6COBbPup4c5bhdii1BjWkZeW
        E3zhCL0CIpQ69extGzL+YvUCRA0pwFLhp3J4v5Q=
X-Google-Smtp-Source: AK7set/A5gc2eRcD6MLc9RsMzSsmgZuyFTZwa9k3QIAO/ENWUUbzJWJCod5KEC+4JByXVNwRKVIncm1p0dDly6pNAvk=
X-Received: by 2002:adf:f490:0:b0:2c3:ed5b:cb67 with SMTP id
 l16-20020adff490000000b002c3ed5bcb67mr318981wro.275.1675835060852; Tue, 07
 Feb 2023 21:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20230205145245.11078-1-cheskaqiqi@gmail.com> <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com> <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
In-Reply-To: <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Wed, 8 Feb 2023 00:44:08 -0500
Message-ID: <CAMO4yUEcweeGZDCBm-y51TQ0fgze_geKr95RXBpEEpH4AyYJuQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

On Tue, Feb 7, 2023 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:

> But this is almost certainly that you're trying to insert leading
> whitespace into a line that's in a <<-EOF here-doc, the "-" part of that
> means that your leading whitespace is being stripped.
>
> A typical idiom for that is have a marker for the start of line, and
> strip the whitespace with "sed". See this for existing examples:
>
>         git grep 'sed.*\^.*>.*EOF'


I try to use Z as the marker in front of 'a' and 'b' and use sed -e
"s/Z/ /g" in order to replace Z with white space but it still can not
pass the test.

Then I realize even if I don't add tab in front of the line but with
space in front of 'a' and 'b' like the original test script. It still
says it can't read "b" and "c=E2=80=9D =EF=BC=9A

test_expect_success 'apply at the beginning' '
cat >test-patch<<\EOF &&
diff a/file b/file
--- a/file
+++ b/file
@@ -1,2 +1,3 @@
+a
 b
 c
EOF

echo >file 'a
b
c'&&
git update-index file&&
test_must_fail git apply --index test-patch
'
Maybe the error is not caused by whitespace?

Then I try to change:

echo >file 'a
b
c'

To:
echo >file "a
b
c"

Then everything passes the test. I think double quotes allow for
variable substitution and command substitution, while single quotes
preserve the literal value of all characters within the quotes. In
this case, the string contains no variables or commands, so either
type of quote would work. Is there something wrong with my idea? Is it
good to modify code like that?

Looking forward to your reply!

------
Shuqi
