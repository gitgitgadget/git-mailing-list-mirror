Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC0BC2D0A3
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CEF20825
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eExkhVG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgJ2MoD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgJ2MoC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 08:44:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44DBC0613CF
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:44:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z17so3159578iog.11
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xnbEqEZK6An+4SvQBfEnA9L0fvHXTWXnK0msNRDnNyQ=;
        b=eExkhVG1GFduNf9K76VrgtfotsEVWqmWaGGeuGbzqSCGwKaWax4wwIryAQoPQm+4Kj
         9S4ekZaj7SL1R/FHrAw1QMPj4yRRFOmgzBpDo7J3Z+g15uhY7Y/yg1yIsHv7oE5N5qdG
         8aLZw0J5vpv7imAampCYGzVY9nVaygOLC5YNDirtejC552kCMxpJ/gbSWKnJSjQIpCUe
         f3RLm4mWkUynOFOIA+9EZ0Bmdrpm3sjHs3LTIKvoKmzE5SWH9eZwrcZO1FC5eyUxvRux
         w9SqWuNCUrON9hiCjDhWaAbxe1mCGweuz8y9pQJQxysRx0MOisMpxNCcCPgVKtBf6IKy
         1jWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xnbEqEZK6An+4SvQBfEnA9L0fvHXTWXnK0msNRDnNyQ=;
        b=tG/N45ZuKN5nlCL5CG1+xACXxCDUviugLevHTbhIqGZV4+V1g0PY6knEJnVRFJNm9M
         BtgHyY/5non5GBtbAnCAF7QFl+8j+IlithLEKsDpBwq49wUOM5XE3aYV4oYHdSsVDU8/
         tAgO82M0fayZOa5nJ8hte+FIWDr0JUG7TDJYKSfe75iEnEDOxaLajbBs/aCxhXHBzJXX
         obkC6kY0F0/sWILWzAe2+5SvVwOWQHGCro75HyvtYRRt4Dq5u3qtA44uqEAAPK5c+4MW
         QcioVZkjVY9KM/79MBvG6f24ZMC+dtBEG9yuPOpG2XuykGiQF3R93MHcsw1nXUCHXoIo
         W2aw==
X-Gm-Message-State: AOAM531jZtlS4qnglf9yh2Q9fFATNwHpFCfpG1rhTi69xpDQxePzIHXr
        +ubYqTng1GIUx7Ogwqd8Zu3MDBmIZS3LWQ==
X-Google-Smtp-Source: ABdhPJzz2UV/2DdvkfuOe5JVvXUfgRKufIcCfELo6zOvnF+XVwKA7mGt9cQW4sGOwXsAjEK3EFrqjg==
X-Received: by 2002:a02:c6ac:: with SMTP id o12mr3489898jan.21.1603975442059;
        Thu, 29 Oct 2020 05:44:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id j5sm1934683ioa.28.2020.10.29.05.44.00
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 29 Oct 2020 05:44:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 5/6] line-log: mention both modes in 'blame' and 'log' short help
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAPig+cRFaT9ww3K368b58m-xgW843jhZWjXDspVrfdyYY-_wRA@mail.gmail.com>
Date:   Thu, 29 Oct 2020 08:43:53 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D7C25D5-E8DE-4414-ADAC-A0E0FA28CC5D@gmail.com>
References: <pull.774.git.1603889270.gitgitgadget@gmail.com> <27ef94e9cc4189c3d74e984437dcce24e1f29678.1603889270.git.gitgitgadget@gmail.com> <CAPig+cRFaT9ww3K368b58m-xgW843jhZWjXDspVrfdyYY-_wRA@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,=20


> Le 28 oct. 2020 =C3=A0 13:33, Eric Sunshine <sunshine@sunshineco.com> =
a =C3=A9crit :
>=20
> On Wed, Oct 28, 2020 at 8:48 AM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> 'git blame -h' and 'git log -h' both show '-L <n,m>' and describe =
this
>> option as "Process only line range n,m, counting from 1". No hint is
>> given that a function name regex can also be used.
>>=20
>> Use <range> instead, and expand the description of the option to =
mention
>> both modes. Remove "counting from 1" as it's uneeded; it's uncommon =
to
>> refer to the first line of a file as "line 0".
>>=20
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> @@ -889,7 +889,8 @@ int cmd_blame(int argc, const char **argv, const =
char *prefix)
>> -               OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), =
N_("Process only line range n,m, counting from 1")),
>> +               OPT_STRING_LIST('L', NULL, &range_list, N_("range"),
>> +                               N_("Process only the given line range =
(<range>=3D<start>,<end>) or function (<range>=3D:<funcname>)")),
>=20
> The "<range>=3D" bit is redundant and confusing (and ugly). =
Considering
> that the description already says "Process only the given line
> _range_", it should be fine to drop the "<range>=3D" lead-in. Perhaps:
>=20
>    Process only the given line range <start>,<end> or :<funcname>"
>=20
> This might feel too succinct, but that's often true of short -h help.
> Such succinctness is generally acceptable as long as more detailed
> documentation can be discovered easily (such as in the 'man' page).
>=20
> Same comment regarding the rest of the changes in this patch.

Yes, I agree. I've shortened it for v2 (and also made the changes you =
suggested
for 2/6 and 4/6.

Thanks for taking a look,

Philippe.


