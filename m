Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6730C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhKWSpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhKWSpc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 13:45:32 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C39C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:42:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iq9-20020a17090afb4900b001a54412feb0so1799889pjb.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 10:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wjkXHUHCZY/pQfoluPXVeSuHYobaJQB6CR2yPwYb8FE=;
        b=i1PePOXpcH4ApJbQ5BKlcFPVtkRq8uTcP31Q+zMudliO0tcYzWfO2ehf2Pt6NLaVWS
         HY3uOMDoheRnWB0cKpx2JP89ZlEd2baUJyijS1lJiRp+OY1Re5aDY7nKrDV3bnoVi9hJ
         pl97TLUedpCY7EJLYteZ7wqNmBwEnhE+if1huKWIQVp9+PwfBVDOy4e50rrTvGOhyqcS
         igBvpwU2rbjHdWelxVpnyPtxymc7kVUhVKDrpiCZfg9bWpqzEAtPuGlslC5KQThSdP6I
         ADexvzoNdOvNfVEEKMrCScDxsBFB7i/ZHHPojYWtzmhoNJ/c8TWs3D4mBz3V0IJzhyBm
         BTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wjkXHUHCZY/pQfoluPXVeSuHYobaJQB6CR2yPwYb8FE=;
        b=AvyCxQZEy0y+zvw6/QaVw0AC0bjmN5vgfdpRnnd0UtBzKzKpPyQFqomJL7knuM+A0x
         LTC6M9f9iCcpPn+HW36OvRGEP7aESnMqRC+47y2Nzca8NRQ1SdZg+tbLbSeJe+Xp8o1/
         clcGnFxBUlVpPjBb31ScpN6UuKZC38PKBDsKWMFgwcJyw4UdLixlPVFzOICiAASRXaQJ
         Fea4Msh0Lkaclts+IkhAAz1IahDa7t9/GkAk9+yBf8yCo7gBRgwoxG3bzOw2+0bqsoMI
         UJk51I1W1uZWYpszTIM1Nmv4Qr8gA45ebziPVYrstttN+smp1gNGTSBUTs/tJd9ctiz+
         1TCQ==
X-Gm-Message-State: AOAM533XL56QTDVxo+kt2t9eRK2SAF7x9zDVqCfTSVk+m8yPf6jZEKaw
        5xZoRbrfwYoYa8O93mAqvhyUAz9hFeM3vQ==
X-Google-Smtp-Source: ABdhPJyGFJpDmOdpTxKdRjkqtSPeM8/QTSd7ArjIc12SEXe4H2iwJYSG2yzm3/Er2x1p6dUklRFO9Sv0OGwW7g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:284f:: with SMTP id
 p15mr195530pjf.1.1637692943411; Tue, 23 Nov 2021 10:42:23 -0800 (PST)
Date:   Tue, 23 Nov 2021 10:42:21 -0800
In-Reply-To: <211123.86zgpvup6m.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lh7c2k92q.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211122223252.19922-1-chooglen@google.com> <20211122223252.19922-4-chooglen@google.com>
 <211123.86zgpvup6m.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH 3/4] branch: add --dry-run option to branch
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Nov 22 2021, Glen Choo wrote:
>
>> Add a --dry-run option to branch creation that can check whether or not
>> a branch name and start point would be valid for a repository without
>> creating a branch. Refactor cmd_branch() to make the chosen action more
>> obvious.
>> [...]
>> -'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
>> +'git branch' [--track | --no-track] [-f] [--dry-run | -n] <branchname> =
[<start-point>]
>>  'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branchn=
ame>]
>>  'git branch' --unset-upstream [<branchname>]
>>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
>> @@ -205,6 +205,12 @@ This option is only applicable in non-verbose mode.
>>  --no-abbrev::
>>  	Display the full sha1s in the output listing rather than abbreviating =
them.
>> =20
>> +-n::
>> +--dry-run::
>> +	Can only be used when creating a branch. If the branch creation
>> +	would fail, show the relevant error message. If the branch
>> +	creation would succeed, show nothing.
>> +
>
> The usage & test show that we've got --dry-run for branch creation, but
> not the "creation" we do on --copy or --move.

Perhaps this is more of a wording issue i.e. 'creating a branch' is too
unspecific. Maybe=20

	Can only be used when creating a new branch (without copying or moving
	an existing branch). If the branch creation would fail, show the
	relevant error message. If the branch creation would succeed, show
	nothing.

> In any case, any reason to leave those out?

No long term reason. I left those out because "create brand new branch
with --dry-run" was needed right now, but the others are not. For
consistency, we'd want --dry-run for all other actions, including copy,
move, delete, etc.
