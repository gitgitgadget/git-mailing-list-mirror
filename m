Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197E8C433F5
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 16:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJDQ1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJDQ1a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 12:27:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D061213E15
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 09:27:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b15so5239837pje.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 09:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bhnuvgGMach1oZC9+Z/MYREUJbY0vwFIQZavkbuyk4=;
        b=Kwg5IUjkhBpOtc28CmvZdNSTUiyPQcC4Fudomfe16boVA0IZYEvd65ZXevN8A02iZF
         fTJYRsubCo7deiWx0y4rEzc7RraVB6DLnitj94TVAwEYCch3cbx07VTEbokI3TYEmqie
         Dxwre1CvKkXz1qLGDZYdzfZYet4Ftkok4u+1eRRIYDjV0C6a8CCcSGdlk9IG9ySxxEiK
         KEkJwOWZWfXR5FXl0QdlGqmV7AQ6zYgAtMGrIcBUc+NWyj26WlpPIlhiawErf4vhDNep
         1JP5yH5c8wnAIZF6BXrrl2xCuUEuIJH9xhVTzzSWMu0YRU7iUv/1eSKGA8M/1eIPHPFg
         7nvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bhnuvgGMach1oZC9+Z/MYREUJbY0vwFIQZavkbuyk4=;
        b=ou/mcpF1Hco9io6VHF/dfpSgPDaVHe1L3jOwrKHHXztr2i3ZfIkv11C7Guj7+MaupE
         EQ3y/LEQ0PMF7pa4hwjHCExrsfZXCA9x8Nv3fXUTq7L+YBCIRmbIiI4GEHMS788lmsKr
         lbB0hQm/G855730XjbpiUX92VIbPFgZyY9C4Zw5AKmMgMSa175wcbpq7QPsZ6SR7t++S
         1KHeIiwGAVbIHqGj3AaWAuzAs3YQkNXKBwhPdL7v/J2MYd0ZuIlFmLAMLDb1NbZnClRj
         0soo103vjygQ/km/ZeSVpsKLBI1wzDNCeYr3f6VKDnyc3MnL76TDfnCAeRcD6hgAOAfv
         baZA==
X-Gm-Message-State: ACrzQf2SYWa5wUyIWz6FOE+VfzVZ/DXKOhejgPrw5WAycCJhUjwHF+K5
        7zF0Jb1FpMIS20C5Xunp62o=
X-Google-Smtp-Source: AMsMyM5eDyRpu8F5whTtIzB3xGdhh5rZaDBh5oSRJh7bRKIcK9Ip83ykHnhKs8rF21CEJLxnOAZtpg==
X-Received: by 2002:a17:903:258e:b0:17b:a251:c80a with SMTP id jb14-20020a170903258e00b0017ba251c80amr25874816plb.110.1664900848188;
        Tue, 04 Oct 2022 09:27:28 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902d50e00b0017a122e3f09sm9166134plg.195.2022.10.04.09.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:27:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 16/34] doc txt & -h consistency: fix mismatching labels
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
        <patch-v4-16.34-563ccaab6a9-20221004T132211Z-avarab@gmail.com>
Date:   Tue, 04 Oct 2022 09:27:27 -0700
In-Reply-To: <patch-v4-16.34-563ccaab6a9-20221004T132211Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 4 Oct
 2022 15:23:30
        +0200")
Message-ID: <xmqqlepvsgeo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
> index 91742633fa8..61b6d8667a4 100644
> --- a/Documentation/git-clean.txt
> +++ b/Documentation/git-clean.txt
> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
>  SYNOPSIS
>  --------
>  [verse]
> -'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
> +'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <pathspec>...
>  
>  DESCRIPTION
>  -----------
> @@ -20,13 +20,13 @@ Normally, only files unknown to Git are removed, but if the `-x`
>  option is specified, ignored files are also removed. This can, for
>  example, be useful to remove all build products.
>  
> -If any optional `<path>...` arguments are given, only those paths
> -are affected.
> +If any optional `<pathspec>...` arguments are given, only those paths
> +that match the pathspec are affected.

OK.  But ...

>  OPTIONS
>  -------
>  -d::
> -	Normally, when no <path> is specified, git clean will not
> +	Normally, when no <pathspec> is specified, git clean will not
>  	recurse into untracked directories to avoid removing too much.
>  	Specify -d to have it recurse into such directories as well.
>  	If any paths are specified, -d is irrelevant; all untracked

... this "any paths are" needs the same treatment.  I didn't point
out every instances of the same error in my previous review, but was
hoping that a reroll was done a bit more care than just fixing exact
locations pointed out.

There may be other such instances in this round, but this somehow
stood out in my quick scan.  I am offline today, and will not
reading the other patches until tomorrow.

Thanks for  working on the topic.

