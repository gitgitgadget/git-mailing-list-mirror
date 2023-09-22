Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C608FCD4851
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 18:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjIVSbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjIVSbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 14:31:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2529CA9
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:31:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85bdcbec9cso3179158276.2
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695407477; x=1696012277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEPqS8GF44USlK1ZMZPVwjg/2OgFixCERb1D/UaMgGs=;
        b=KCcHQ9qoxoqbJyTIDcd8oj2IEb4SJHGqKp5RtHXigybhRiImPb9Oi6FCdSlrRWDvlZ
         S5cD2rZ4S4ijxNUBMY21Feyz9gF335G1hho2JLLZEe5+c1lsFPVq+calE4j7smPX9QDP
         jqzT2sCrhYG3/0OnhwHlI9WVdSbLdAa/mK/aZQ7DqK+EgsrLH55Be1fRtBbEhYlx+qvb
         4mB4hddnnUfKfE7QfSKvlvYgIFBTlOCocpaygidnMhyQDNw+QWs6JWpihydYSWallfpd
         oLdAhdPL+bA3t/LlXpX/pf0VAYxWo7miRsoIXejaXx6BpDIuPL5HIn6KCnXi9aNXr+nd
         /LvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695407477; x=1696012277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEPqS8GF44USlK1ZMZPVwjg/2OgFixCERb1D/UaMgGs=;
        b=SrkAyeSTZNGnWP+IeLX/KlUjfXfYly2dfYj9/pR6il/lGfF4gnFJDWGRcf9VBsz4JU
         2S/872rTNAW2J62SZKkbqZVn43UFq3Sf8sRrG2iBm3VL4tCFBVFbWxLADikTEa4bNuzX
         ldznBoQg+b3O2hkfaRfJw0BE/VSrLhBbCPb6v3pQzjXW5QWJKp+oBs3UTvpC6rHx23tc
         4eU79ej3lIbJq1ctJVKo9gw8L4LfXUIfXy21olNvMLV+cLyaHehltBhqteIcg7cfg+hk
         eE5EDSRAUj/nOSB+8qfIDgMCKUD6v52RyFojUMwnygsuMoVkm+L2BP/Ly4aOBldUYMJ/
         Ct4Q==
X-Gm-Message-State: AOJu0Ywp7e2TaijkUdF3Wq05fM+OeHWA3NZ1/eN6mqfy2g0rdPz+T9KA
        ehh+7T63LRi2ATbAUWdbejo6D2vkUkA=
X-Google-Smtp-Source: AGHT+IE92BO4opPjGOAvcSYGR3fxJm9L7+zKyEEIsdytAcFa5tJj9CmKolHKnpNu8np1DWPwgb47eZOHH6I=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:161c:b0:d0e:e780:81b3 with SMTP id
 bw28-20020a056902161c00b00d0ee78081b3mr1324ybb.2.1695407477368; Fri, 22 Sep
 2023 11:31:17 -0700 (PDT)
Date:   Fri, 22 Sep 2023 11:31:15 -0700
In-Reply-To: <xmqqr0ms8yxs.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com>
 <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com> <xmqqy1h08zsp.fsf_-_@gitster.g>
 <xmqqr0ms8yxs.fsf@gitster.g>
Message-ID: <owly34z6t5zg.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] completion: loosen and document the requirement around
 completing alias
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * We've discussed this when we reviewed the topic that just hit
>>    'master'.  Before we forget...
>>
>>  contrib/completion/git-completion.bash | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> And here is an obligatory "test" update I will squash into the main
> patch.  The new ones copy a canonical ": git <cmd> ; ..."  test and
> remove 'git' and also the space before the semicolon.
>
> diff --git c/t/t9902-completion.sh w/t/t9902-completion.sh
> index 47e20fb8b1..a7c3b4eb63 100755
> --- c/t/t9902-completion.sh
> +++ w/t/t9902-completion.sh
> @@ -2464,6 +2464,24 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
>  	EOF
>  '
>  
> +test_expect_success 'completion used <cmd> completion for alias: !f() { : <cmd> ; ... }' '
> +	test_config alias.co "!f() { : checkout ; if ... } f" &&
> +	test_completion "git co m" <<-\EOF
> +	main Z
> +	mybranch Z
> +	mytag Z
> +	EOF
> +'
> +
> +test_expect_success 'completion used <cmd> completion for alias: !f() { : <cmd>; ... }' '
> +	test_config alias.co "!f() { : checkout; if ... } f" &&
> +	test_completion "git co m" <<-\EOF
> +	main Z
> +	mybranch Z
> +	mytag Z
> +	EOF
> +'
> +
>  test_expect_success 'completion without explicit _git_xxx function' '
>  	test_completion "git version --" <<-\EOF
>  	--build-options Z

LGTM, thanks!
