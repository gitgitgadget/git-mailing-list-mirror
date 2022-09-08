Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6B1ECAAD3
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 02:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIHCBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 22:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiIHCBV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 22:01:21 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FE77B2BF
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 19:01:20 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1278624b7c4so22437327fac.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 19:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8IKV4kvIUWxJSa0Xmi6XdsAOP7sTCwlj5wzdOdfg34g=;
        b=bOFFgA2KVpFSSDKqdzXsT0X1Oiy0WAVfx9z1/HW3zTg5mhkU8jKGXAb/rqp+NvGrN4
         /nFfNnQTxyOoLCxy4crPMUt+GsuMShcnltNRoG2shEMpw2MygU1IsZLLMZpwJJh9tFCo
         QWryLWui0n8FUbVxfgNdFM3/JOHBAQTz96c3op/g9kYi/5aUt1ZeyqEnB+esZOUKeLPW
         sbwnSu0xFqS2thA/iidK1jGHEcfFXSnKPzAAJlT46T9HUpjf8zb9i8f8wfC5JFrrE8GN
         Mwq1AHTU1W/nL6fhoOnAXHfC6A3/XPG9SXBeODJrelQ+sUYRgqArPE3DyLB+bRcLy6ON
         xhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8IKV4kvIUWxJSa0Xmi6XdsAOP7sTCwlj5wzdOdfg34g=;
        b=gb8Z4WcHvJQ3U++G+KSx7zaFGq5tjF9c3eObb+f1nwJ3xgkE5B0P79zN9EpzuTLtNa
         KhiYjQnk+ymok/zk0YOYCiv43LqgHXook7xEqUKRNL0HBGWmKz2pwBhZhIFLUS4Lnn9s
         h3sHeO+ES46VZSmwix4OVcr3bFglJO62UAVnQ1UWn/fKQqqwEEIMXCrt4Wq1cSDQFTnX
         M3zS2fizWp8rpqZhcNPkA7BnJcju97S6bRBdg04GPliehabQOdB5+Ja33c3x97Dc1QB4
         YjmahKMo3TdPwLF3eQm1K7p72Iz2y12bn2ckxjresFGwBYwoxl9d0w0n0KBeFQf90bK1
         tyzA==
X-Gm-Message-State: ACgBeo3tUfwss9Fq3Cf5OiR4vsFPq4YvHeechO6yBDH14y7bG3SMJGA5
        /iGwzEFTI90kDxmRtn4at+pZREyp3F8rdhLsQpI=
X-Google-Smtp-Source: AA6agR637bPHEF7Q0Js/JfmfyLfs7gUZ3lIRX/DRitzF3tERpkPKdDqZw9m6wiPPF0Fk3tDnoba47D1mAAjsy4bC1Zk=
X-Received: by 2002:a05:6808:1294:b0:344:9e65:915e with SMTP id
 a20-20020a056808129400b003449e65915emr503960oiw.251.1662602479973; Wed, 07
 Sep 2022 19:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com> <pull.1262.v9.git.1658558685407.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v9.git.1658558685407.gitgitgadget@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Thu, 8 Sep 2022 10:01:07 +0800
Message-ID: <CANYiYbFGSfg+iFV1ovhCSxW0YQSpemKUN-sS+F0BHee7KD5arA@mail.gmail.com>
Subject: Re: [PATCH v9] ls-files: introduce "--format" option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 23, 2022 at 2:54 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e791b65e7e9..779dc18e59d 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -222,6 +234,73 @@ static void show_submodule(struct repository *superproject,
>         repo_clear(&subrepo);
>  }
>
> +struct show_index_data {
> +       const char *pathname;
> +       struct index_state *istate;
> +       const struct cache_entry *ce;
> +};
> +
> +static size_t expand_show_index(struct strbuf *sb, const char *start,
> +                               void *context)
> +{
> +       struct show_index_data *data = context;
> +       const char *end;
> +       const char *p;
> +       size_t len = strbuf_expand_literal_cb(sb, start, NULL);
> +       struct stat st;
> +
> +       if (len)
> +               return len;
> +       if (*start != '(')
> +               die(_("bad ls-files format: element '%s' "

Good, the last space acts as a separator between two lines.

> +                     "does not start with '('"), start);
> +
> +       end = strchr(start + 1, ')');
> +       if (!end)
> +               die(_("bad ls-files format: element '%s'"

Missing the last space to seperate two lines, and this leads to wrong
l10n message. See:

    https://github.com/git-l10n/pot-changes/blob/pot/main/2022-08-03.diff#L70

--
Jiang Xin
