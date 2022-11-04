Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3991CC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 14:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiKDOnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 10:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiKDOmm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 10:42:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF730F62
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 07:42:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id cl5so7337005wrb.9
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DQFzBjZHZrBmZur6uglhIYEzBO/e0Xt0p7iOrOkkzBc=;
        b=Tn4FEEN6LTMJPvd97ogWkBhw3t78Ii/T/tzr5Rcfl0JFddT/7S0iA0v613KheWOtx3
         +deMjWmBvGyNh2FSeu/bQNGyU+bGVrtAeIm/nxiPpKx2352mBzMqY1HUyrCjx1KEWcF7
         yKIIYw5AiSe+8MNR0ZfsGWsVeGFt6YyJeQnFb4WQ73HSTn3j/hHEZizOvvn80pMBTfVv
         mc4BmHsKAof9Phhn0jhWe5Ob9q7QzwFnUkxI8/XlcVp7XAYxVocmFGkLj9xALGqZMuzG
         ApJYOnqbbVDr5QyQJTQXHluDNbXbHlWT6CfA6YtlQbBt+0ZvPH5Dhun+NnqLP2E4Jn9B
         NyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQFzBjZHZrBmZur6uglhIYEzBO/e0Xt0p7iOrOkkzBc=;
        b=bnpwDn+QKFNdS9oAC+R3V/UW0E/KKVYBOQBLv5PL0zBcdvEEuE/8inu39o5qc1u1bn
         58LdzoD/QrORXwe/J1ACZljcIqoUB3+7TxTg8BR148NN6R6bvFnqVSapnL9UtRUD2RL3
         CeAOEdBerpxGwjhW99ebXg3dXvd/E25UsrWXD6/iDztLa93nfSbwQz2bgIW64OuVMnhy
         Z6j3iJ9Gk3Wn+9az2VG7i6PwIEV27zaTgc6oTVI38M53GfmsI5bTg3y6qhvj6wSZKCwa
         OWGVdLDk/AICn/x1o1BAtsCdzTCAyG17yG/HrNl8a+raELepJPFoI/cIYv1IXQRkqb9r
         LHZQ==
X-Gm-Message-State: ACrzQf0vQAXwqXoHQYNtSlEcYGSYsAnDiXB8Lzauzv1aNfc6CneJrqYy
        HJMoz1/GFfJuINTcMasm5S0=
X-Google-Smtp-Source: AMsMyM7deLa0x3GMzZTFHiH0ZSRiKeCaw/QjDMS1VHPPngfoORhlP0vYMNh/BxwxsEhUC01DrbOy0Q==
X-Received: by 2002:a5d:448d:0:b0:235:98b:6145 with SMTP id j13-20020a5d448d000000b00235098b6145mr22630767wrq.421.1667572947533;
        Fri, 04 Nov 2022 07:42:27 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b003b4fdbb6319sm3491405wmq.21.2022.11.04.07.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 07:42:27 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f9df4dfc-6024-deb0-5277-bab96c81a875@dunelm.org.uk>
Date:   Fri, 4 Nov 2022 14:42:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 13/17] rebase: don't leak on "--abort"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
 <patch-13.17-fda9914b558-20221103T164632Z-avarab@gmail.com>
In-Reply-To: <patch-13.17-fda9914b558-20221103T164632Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 03/11/2022 17:06, Ævar Arnfjörð Bjarmason wrote:
> Fix a leak in the recent 6159e7add49 (rebase --abort: improve reflog
> message, 2022-10-12). Before that commit we'd strbuf_release() the
> reflog message we were formatting, but when that code was refactored
> to use "ropts.head_msg" the strbuf_release() was omitted.
> 
> Ideally the three users of "ropts" in cmd_rebase() should use
> different "ropts" variables, in practice they're completely separate,
> as this and the other user in the "switch" statement will "goto
> cleanup", which won't touch "ropts".
> 
> The third caller after the "switch" is then unreachable if we take
> these two branches, so all of them are getting a "{ 0 }" init'd
> "ropts".
> 
> So it's OK that we're leaving a stale pointer in "ropts.head_msg",
> cleaning it up was our responsibility, and it won't be used again.

This looks fine. One could argue that the leak is not a "real" leak as 
we're about to exit but the omission of strbuf_release() was 
unintentional and fix is nice and simple.

Thanks

Phillip

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c          | 1 +
>   t/t7517-per-repo-email.sh | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 64aed11c85d..8a8b5e34786 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1320,6 +1320,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		if (reset_head(the_repository, &ropts) < 0)
>   			die(_("could not move back to %s"),
>   			    oid_to_hex(&options.orig_head->object.oid));
> +		strbuf_release(&head_msg);
>   		remove_branch_state(the_repository, 0);
>   		ret = finish_rebase(&options);
>   		goto cleanup;
> diff --git a/t/t7517-per-repo-email.sh b/t/t7517-per-repo-email.sh
> index 163ae804685..efc6496e2b2 100755
> --- a/t/t7517-per-repo-email.sh
> +++ b/t/t7517-per-repo-email.sh
> @@ -9,6 +9,7 @@ test_description='per-repo forced setting of email address'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup a likely user.useConfigOnly use case' '
