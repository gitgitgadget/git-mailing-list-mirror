Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C6AC43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F172173E
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 23:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgWcIyjO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLKXwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 18:52:23 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:39602 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfLKXwX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 18:52:23 -0500
Received: by mail-vs1-f68.google.com with SMTP id p21so297272vsq.6
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 15:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mNzR8ZMVjLXXwpViHVeAJ5kOZdra+s1i8vyeoJ0LDf0=;
        b=rgWcIyjOc3T+yUcHNx6JbygJrRkagugi3nWssviYHkhPcjOMA8Cqqe5XXuu7SHhqq4
         h5u5ojoyhPaFGHsxRfOPyAzvzv/xaOhPEyi2KSqoTCPhHDi9+i4xCxT5nXL/b4OzIUuk
         CQ0u1kbjaQXk4ON7RH7MDtgRKa3YZpLjEwldHmVf9HPkD0bteSqbFkPCxNy1WpmywQSV
         /lDIVPlrU06MNK04XRRyKvq71Wjl4GUjCNGU6lWC96hpEiBN9dAJ4GdYDau26sXLGeXv
         wM/Nni1DAGxg/CFziFY94KZJ/mU8HKyHvbjSotI71Uh1GU95y2dQ0KTXDRk527oJAlt6
         o3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mNzR8ZMVjLXXwpViHVeAJ5kOZdra+s1i8vyeoJ0LDf0=;
        b=tkK2iHLgIepDTNT1dOJh/TcYiJjqBMo7GTAMq3cF7VCg87SJv2IQyfHRBPaXRZjS9b
         GOr23w/K6m68TFw5Ykhk7wklhDGaK903LRNYkG+YuIkz4p7QGRB9xqnCzrkJWrMAvPtG
         Cd6K6FOCzmxePKwmRcsr0LjUjnIfzC4kNFrh/3s0kos7t1CQ1I4hN2YYtT1HGsZqF9pY
         4kINdMFZLWMIqKU2UC5mYEEwR9HS6iItEWruR2SeZtEbxW8pgn96tIKbJ8+SxO/5CKT1
         0dPaVbRxSGtxohzrxTzGjsn3dnxP3D4OXzTlxBlLB/HLBVFf9nZ3MfgT5J433VL5Hiz1
         +6rQ==
X-Gm-Message-State: APjAAAW7WkeTcR955mDqdQRl9hre2w6jkVur+gu//xQ+ORKhA4uur9Bz
        wJBAQIF1vUzklXjc8F+5GPuhNtJLzWxlFRRNC8s=
X-Google-Smtp-Source: APXvYqxUiL074UMAq+qd9oEo9ynqsq4XBrLvwyG7CJY59iu6cqZPBt93DbF0/M28PLPsaxi8TnHGooX8Ifp83pUQukU=
X-Received: by 2002:a67:fb41:: with SMTP id e1mr4757977vsr.159.1576108341760;
 Wed, 11 Dec 2019 15:52:21 -0800 (PST)
MIME-Version: 1.0
References: <20191211233820.185153-1-emilyshaffer@google.com>
In-Reply-To: <20191211233820.185153-1-emilyshaffer@google.com>
From:   Matt Rogers <mattr94@gmail.com>
Date:   Wed, 11 Dec 2019 18:52:10 -0500
Message-ID: <CAOjrSZsrNjzCojmA6kgSdhT9=G84twzv3Ced4VfNZD1SC2jb7Q@mail.gmail.com>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 6:38 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> If a user is interacting with their config files primarily by the 'git
> config' command, using the location flags (--global, --system, etc) then
> they may be more interested to see the scope of the config file they are
> editing, rather than the filepath.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>
> Since v1, the only change is removing locale markers around the strings
> returned from the helper.
>
> As mentioned in lore.kernel.org/git/20191211232540.GE8464@google.com I'm
> still not sure whether it's better to return "local" for
> CONFIG_SCOPE_REPO. Since that's the scope returned for both local and
> worktree (.git/config, .git/config.worktree) configs, I'm happy to leave
> it the way it is to indicate "one of the configs in the repo".
>
>  - Emily
>
>  config.c | 17 +++++++++++++++++
>  config.h |  1 +
>  2 files changed, 18 insertions(+)
>
> diff --git a/config.c b/config.c
> index e7052b3977..baab4a916e 100644
> --- a/config.c
> +++ b/config.c
> @@ -3312,6 +3312,23 @@ enum config_scope current_config_scope(void)
>                 return current_parsing_scope;
>  }
>
> +const char *config_scope_to_string(enum config_scope scope)
> +{
> +       switch (scope) {
> +       case CONFIG_SCOPE_SYSTEM:
> +               return "system";
> +       case CONFIG_SCOPE_GLOBAL:
> +               return "global";
> +       case CONFIG_SCOPE_REPO:
> +               return "repo";
> +       case CONFIG_SCOPE_CMDLINE:
> +               return "cmdline";
> +       case CONFIG_SCOPE_UNKNOWN:
> +       default:
> +               return "unknown";
> +       }
> +}
> +
>  int lookup_config(const char **mapping, int nr_mapping, const char *var)
>  {
>         int i;
> diff --git a/config.h b/config.h
> index 91fd4c5e96..c8bf296dcc 100644
> --- a/config.h
> +++ b/config.h
> @@ -303,6 +303,7 @@ enum config_scope {
>  };
>
>  enum config_scope current_config_scope(void);
> +const char *config_scope_to_string(enum config_scope);
>  const char *current_config_origin_type(void);
>  const char *current_config_name(void);
>
> --
> 2.24.0.525.g8f36a354ae-goog
>

Okay Good to know, I'm using gmail right now, so the default is to
start at the top

I wouldn't really consider it a bug so much as just something that
hasn't been an issue before.  The way config.c is set up kind of makes
it hard to pass in the information that it uses the --local option, so
that may need to be refactored, since it just passes in the
appropriate file based on the --local, etc. flags to builtin\config.c
which has never really needed that information before now.  Anyways, I
don't think it needs to be addressed right now, and I'm working on
something that would address it anyways... I just need to find some
more time to work on it.

-- 
Matthew Rogers
