Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCEFC6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 05:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCSF7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSF7a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 01:59:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB6F22014
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:59:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j11so11198541lfg.13
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679205567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv43B4+lSCO1HV8ruBU+wLXntYrDpyJx/7NCiAMd3yE=;
        b=q0Q9QbHW7l/FnCENV8QfwRXTO7fl2sWfeh5vRTZCIDMBTfAkDU8pU3kknzo7dW32jf
         lenNZ8sTJDHOUUvZnxMIRlwy2JgdNSnYxAGS9ArG0EBVS4JpzNg5i91jRLgKYzFYmp0G
         Pe1LRuDRtSQTd63ScVfTxz//OdiaH1khtyf1y+DOP+lBsCY1BQBObzqV0V3QP3Yh0Pj2
         S/0SDIysXVumRRHbyonPIXf3Ws2fe5Btw20rtcPXWYSZdVIOiBF2gnYchrPm0WwvGT+4
         vvc/DpytwLHEhAjhDAAgw781UJePDLqa1sMFvRq7UlDBnHeapJL91tcb1Lbc8in+HyPo
         mp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679205567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv43B4+lSCO1HV8ruBU+wLXntYrDpyJx/7NCiAMd3yE=;
        b=THzDYbFyDGI62SXDYafksq7yPdk7MB8/svtOmPCN3k6/+ws+snHwiU7mMHypPf+CbH
         stHNXdGKqN8LPUp2jefWBWbwDhi6HORcpRUlh3Q2E4C8AWNWlq6LNaiptzC8umfuY5u8
         yNojVgtSVQoy048iC4sVtSCDi0dLoMj3f89/AspYVAJtsJGisAYY5LKugX+d61KgWtnr
         evQFRnPNnovNyc1gjinOD0rrk7glD3LTNdbkXjyJwTy8veRJ2cTYar2OK6Se7r72BMSY
         R00Q8pBJuuav9cf6M2RVQK8SvjM6OzApHeNzC/i9ovaw1YXy33s4r2Y6h6MkEHVJVhdr
         sqMw==
X-Gm-Message-State: AO0yUKV8qdN8tcVr0vBcj1h3h90n6XsAdz4hPHqPbtUI6Mok/kahzFBO
        NhNunqzMDsJ6nGqh+ISdwF+UyO+T7zBmAZKFf6I=
X-Google-Smtp-Source: AK7set+E1ak6BluxM/+wKlKv6/oo9YJUzG5ighg+V8KjATVbhhYKnNlUUDtWq3IYJqGNhMFD4U7wBIK123Y8tnjTRho=
X-Received: by 2002:a05:6512:3d22:b0:4e8:4409:bb76 with SMTP id
 d34-20020a0565123d2200b004e84409bb76mr4378432lfv.2.1679205566959; Sat, 18 Mar
 2023 22:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-03.17-34c6b8afd6c-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-03.17-34c6b8afd6c-20230317T152724Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 22:59:14 -0700
Message-ID: <CABPp-BHhMRHcce=iym8jo=YhgwFMweN0Z=ubjFa_ApZ8ybJt0g@mail.gmail.com>
Subject: Re: [PATCH 03/17] cocci: sort "the_repository" rules by header
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 9:16=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> Sort the "the_repository.pending.cocci" file by which header the
> macros are in, and add a comment to that effect in front of the
> rules. This will make subsequent commits easier to follow, as we'll be
> applying these rules on a header-by-header basis.

Is this at risk of becoming out-of-date with en/header-cleanup or my
second series over at https://github.com/gitgitgadget/git/pull/1493
that I'm planning to submit soon?  It doesn't look like you're adding
any comments pointing at cache.h, and I'm mostly moving stuff out of
there, but I'm just curious if we are risking adding
likely-to-become-stale comments.

>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  .../coccinelle/the_repository.pending.cocci   | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/co=
ccinelle/the_repository.pending.cocci
> index 99e192736ee..84b79dce480 100644
> --- a/contrib/coccinelle/the_repository.pending.cocci
> +++ b/contrib/coccinelle/the_repository.pending.cocci
> @@ -5,21 +5,7 @@
>  @@
>  @@
>  (
> -- read_object_file
> -+ repo_read_object_file
> -|
> -- has_object_file
> -+ repo_has_object_file
> -|
> -- has_object_file_with_flags
> -+ repo_has_object_file_with_flags
> -|
> -- parse_commit_internal
> -+ repo_parse_commit_internal
> -|
> -- parse_commit
> -+ repo_parse_commit
> -|
> +// commit-reach.h
>  - get_merge_bases
>  + repo_get_merge_bases
>  |
> @@ -34,6 +20,13 @@
>  |
>  - in_merge_bases_many
>  + repo_in_merge_bases_many
> +// commit.h
> +|
> +- parse_commit_internal
> ++ repo_parse_commit_internal
> +|
> +- parse_commit
> ++ repo_parse_commit
>  |
>  - get_commit_buffer
>  + repo_get_commit_buffer
> @@ -43,6 +36,17 @@
>  |
>  - logmsg_reencode
>  + repo_logmsg_reencode
> +// object-store.h
> +|
> +- read_object_file
> ++ repo_read_object_file
> +|
> +- has_object_file
> ++ repo_has_object_file
> +|
> +- has_object_file_with_flags
> ++ repo_has_object_file_with_flags
> +// pretty.h
>  |
>  - format_commit_message
>  + repo_format_commit_message
> --
> 2.40.0.rc1.1034.g5867a1b10c5

Other than the minor comment above, things all make sense.
