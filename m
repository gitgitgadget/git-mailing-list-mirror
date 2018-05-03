Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42470200B9
	for <e@80x24.org>; Thu,  3 May 2018 19:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeECTIT (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 15:08:19 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:43734 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeECTIS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 15:08:18 -0400
Received: by mail-yb0-f193.google.com with SMTP id x145-v6so6048827ybg.10
        for <git@vger.kernel.org>; Thu, 03 May 2018 12:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HN1vhohIEDyALw/NMzNx/omkin5lasWSy7+0maIKOmo=;
        b=FYb1Mj5tHPeWl1nnR6BgQTmKGS1uubh8U2ephNJA/C8xV/ZJEqatmwwXxK4wmqXTOu
         2n2pduxloos1lMyMPliv3X/a0yeenfm1PMclDXy4pQw5SaIPou1joo90VDCIhWI5kW6A
         NgGsvDDdkYSptHDaLrJTNRxCsmbjRG+6OeYMykseMyrAcSA1CGB0PCLe1oWaoQt3b+Bu
         igwNs/pWIUQ06LD+sKzPw9JPGZmArisRSgKnpEIqjIP7OKhDaCrkAWICOVTms19nO4lZ
         kdAhrmekRhueDAPDZtlFg78lO1+SQ9P4o6m/U1crD1ldyXJBnYiB6U7sGUAKlitifPBe
         TGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HN1vhohIEDyALw/NMzNx/omkin5lasWSy7+0maIKOmo=;
        b=pkVEI4gGiHITDonFInQ+CZiT+b+vnhd4xSUXhLQNcJfwsLmBgXsmL6mZrPj5rjHT3+
         hIBP5FvDVRg+ZI255T8JpwHOVRV5F3JN+1nt8n6qxl0kYtf0qvX6rGRDm7XApxtuBREV
         SRa8v75JvVY3h/qQ9U7GBSjgA+1NqY6RMFs6yzGt2/skwv3eCeJX7V66DSuu4Ad+U6Cr
         POd5v0Rue10tDrt0KbJn6d+OJe+Rbl41lOt05nFfC6whSngJuLsXA00TcleL2JnALlY5
         d4JHPx0KsSsMiC5+GWehauyBOVkiNufGme7iIYxTMgCSkdm0PFkOfESm6TfLZByN7zML
         iDKA==
X-Gm-Message-State: ALQs6tAIBsYvz4P6B7KgqrSyZzR3verlIsTHiXz5sCzPNf7aEqlJwrYi
        8aj+N4rRngZRFu8hHCqxZcwsJFQJ8HMPbOPdRx3XOA==
X-Google-Smtp-Source: AB8JxZqCNMniS+Q02zjkyVQhD2UitX3+wvcz4rSvHKRSlJjW4oc3kMaKWbnp/7e3+I7Y9JwGyASce3RRwfexjxQcthI=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr12862154ybi.515.1525374497205;
 Thu, 03 May 2018 12:08:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 12:08:16 -0700 (PDT)
In-Reply-To: <6e85aaa555f6789156626330327085207b2d2dff.1525220786.git.jonathantanmy@google.com>
References: <cover.1525213052.git.jonathantanmy@google.com>
 <cover.1525220786.git.jonathantanmy@google.com> <6e85aaa555f6789156626330327085207b2d2dff.1525220786.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 12:08:16 -0700
Message-ID: <CAGZ79kb4gHO=5aYMbT=AhZrOexkmkRakJRPRZd_GMrQJTF3WwQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] upload-pack: read config when serving protocol v2
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 5:31 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> The upload-pack code paths never call git_config() with
> upload_pack_config() when protocol v2 is used, causing options like
> uploadpack.packobjectshook to not take effect. Ensure that this function
> is called.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  t/t5702-protocol-v2.sh | 14 ++++++++++++++
>  upload-pack.c          |  2 ++
>  2 files changed, 16 insertions(+)
>
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 56f7c3c32..0ead99993 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -201,6 +201,20 @@ test_expect_success 'ref advertisment is filtered during fetch using protocol v2
>         ! grep "refs/tags/three" log
>  '
>
> +test_expect_success 'upload-pack respects config using protocol v2' '
> +       git init server &&
> +       write_script server/.git/hook <<-\EOF &&
> +               touch hookout
> +               "$@"
> +       EOF
> +       test_commit -C server one &&
> +
> +       test_config_global uploadpack.packobjectshook ./hook &&
> +       test ! -f server/.git/hookout &&

test_path_is_missing ?


> +       GIT_TRACE=/tmp/y git -c protocol.version=2 clone "file://$(pwd)/server" client &&

Why do we redirect GIT_TRACE outside the test suite? do we read that
back or want to read it out of the hook?

Is it possible to redirect to  /$(pwd)/trace or such?

> +       test -f server/.git/hookout

test_path_is_file ?


> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> diff --git a/upload-pack.c b/upload-pack.c
> index c4456bb88..113edd32d 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1376,6 +1376,8 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>         enum fetch_state state = FETCH_PROCESS_ARGS;
>         struct upload_pack_data data;
>
> +       git_config(upload_pack_config, NULL);
> +
>         upload_pack_data_init(&data);
>         use_sideband = LARGE_PACKET_MAX;
>
> --
> 2.17.0.441.gb46fe60e1d-goog
>
