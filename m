Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C54C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 05:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiEXFx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 01:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiEXFxz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 01:53:55 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF387A06
        for <git@vger.kernel.org>; Mon, 23 May 2022 22:53:53 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id rq11so10978627ejc.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 22:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3TlyDP02FqSRcHC6w6HebNDFwuyTA+tXcbf2gj1e7Dk=;
        b=aPUzC0NnA99s1HiLg6tR+93buNSz1RFwFHylPshwnU0hrWR2n8vmbk6RlMZYoqT8tW
         ZiHFFQ3mgBXrNXfneNUtz3UFvutW2ObavdKDNUPtUHJ+wR+nSP63rJ57RpN9babp/W9K
         V4JdaOvoFZz5iwhoyHTQnnmd8kwzvDCTID9c8pW2tKzk62Ur2U5T9W25YOxU5MBXUoL9
         Nx6qkpa0HZ0/N37DnftnWWaAKbEBJCaqkIZXrgUBjdsT1yFrVluNd/r1M8BLNmHxqGF+
         pbAroVS+//1cwi89f0JRN7BjhMi+NXI1SpSBv1CIK0rdvzttVP5RLH3pYSMOJD33Vrb0
         E3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3TlyDP02FqSRcHC6w6HebNDFwuyTA+tXcbf2gj1e7Dk=;
        b=Xmb+UljjGAYGy9kWhL9YfrGjpeM0LlVy8ZMP8khNUY7z2rIlNukg96mRrQoPibkLuF
         riWXqa9nHhterFrwugpuE8QRojPRL2zOQcFQge53/YjCiFmsNbbvx5lkMMR6gW/v1Nzn
         hM+356FqJVqKkE58OVeUalumQtm1LV4lxTti7DuVqM3+Qn4KO7EvdiHrCwp0o5K6zi+a
         WFWY4EPwJOj2DDHFFUeAxIKm7G2JatHsdjNJoaQOMW2PWlAoTD36RhCR1pDvhXpw+2kY
         ZaQ8SWv2ojrjw4/7/s8EQau52Ly+P27DHTccS3iTfyZKXIe3E9CI9YlKJI/sDndZfX55
         ig5Q==
X-Gm-Message-State: AOAM533z/mfacEwcD9Vs4U3zK7GzWabaU7MzRTk7oP+qC63ixWN31b0t
        Av+47Ewg5cBK0ome6CGw00zkv3+zXusUwQ==
X-Google-Smtp-Source: ABdhPJyYOUCw23rQQKcxm0YVkIZ6fGNYPOa2yux87BNYQzbXu9mrzuC8sewhPFDT7/Zw8Y5lgdlzvw==
X-Received: by 2002:a17:907:3e18:b0:6fe:cf44:8692 with SMTP id hp24-20020a1709073e1800b006fecf448692mr9416924ejc.601.1653371631319;
        Mon, 23 May 2022 22:53:51 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d23-20020a50fe97000000b0042ac2b71078sm8977748edt.55.2022.05.23.22.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 22:53:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntNUL-0034hr-8c;
        Tue, 24 May 2022 07:53:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/4] dir.c: avoid "exceeds maximum object size" error
 with GCC v12.x
Date:   Tue, 24 May 2022 07:53:20 +0200
References: <pull.1238.git.1653351786.gitgitgadget@gmail.com>
 <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <365889ee96e37dc9dcbe60d98880eb256dae90ee.1653351786.git.gitgitgadget@gmail.com>
Message-ID: <220524.86k0abxyqa.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Technically, the pointer difference `end - start` _could_ be negative,
> and when cast to an (unsigned) `size_t` that would cause problems. In
> this instance, the symptom is:
>
> dir.c: In function 'git_url_basename':
> dir.c:3087:13: error: 'memchr' specified bound [9223372036854775808, 0]
>        exceeds maximum object size 9223372036854775807
>        [-Werror=stringop-overread]
>     CC ewah/bitmap.o
>  3087 |         if (memchr(start, '/', end - start) == NULL
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> While it is a bit far-fetched to think that `end` (which is defined as
> `repo + strlen(repo)`) and `start` (which starts at `repo` and never
> steps beyond the NUL terminator) could result in such a negative
> difference, GCC has no way of knowing that.
>
> See also https://gcc.gnu.org/bugzilla//show_bug.cgi?id=85783.
>
> Let's just add a safety check, primarily for GCC's benefit.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  dir.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/dir.c b/dir.c
> index 5aa6fbad0b7..ea78f606230 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3076,6 +3076,15 @@ char *git_url_basename(const char *repo, int is_bundle, int is_bare)
>  			end--;
>  	}
>  
> +	/*
> +	 * It should not be possible to overflow `ptrdiff_t` by passing in an
> +	 * insanely long URL, but GCC does not know that and will complain
> +	 * without this check.
> +	 */
> +	if (end - start < 0)
> +		die(_("No directory name could be guessed.\n"

This should start with a lower-case letter, see CodingGuidelines.

> +		      "Please specify a directory on the command line"));
> +
>  	/*
>  	 * Strip trailing port number if we've got only a
>  	 * hostname (that is, there is no dir separator but a

