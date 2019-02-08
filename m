Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 423511F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfBHTzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:55:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36564 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfBHTzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:55:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so5109820wmc.1
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 11:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=STVPLWVfLsMV3k/F01EsrcF51O8WmYVCuDnkWzm3u/0=;
        b=CR0ETJJyeDeCr/B2vOpar5c+dy6V+l3xejrAWYVv1AtBsz4u7s8l5xHzvaH/pT+iiT
         OMy1dbNe2S0ZD3VXRvAIoo1hYn8lSEGghScJpNKSdMeKC2EWih1S9bEMldMRIq9IxWCr
         uLq7jFt2kgcXupd7c210trDrMrsZ/SLV+gE56MtiEXcwezOJ2gShQwd/WU6tzu3g8oFx
         htuaoJfxHhG8jDq/sT7FaRElo1vqeCgo9VsaAZgBCFQGIfGQDUziJIpX4mbIzZM9+eia
         2oxHMrP5HBaxlJ6kJ9Xolq0g93GmNIG30465fMp7H71bnYnBsmysqkdcrAQxtUpYSKIy
         Mvhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=STVPLWVfLsMV3k/F01EsrcF51O8WmYVCuDnkWzm3u/0=;
        b=NfT04Cws+XwK27H+hBnQr9POZGOY1f4EVu77ck7njOABKsG5LDucuAvC9Xkq7iyJuy
         CfCCDjt1sUsAFy73zxSQWSM0fejdLpsv15H2cbooLru0ivslanMUvrh8wq4H9JHarYoS
         WLHIl5Z5LV1BAa4h2ksbGUVzJ1zvdO0irUtjePaYk6R7F1dvFe+DhANxaz/Nbeq/7xgG
         FGSXFfEeMGTW5Fls7IaiHtJSwavowT8/Xlp4lIGQq+Hc37oc8JlVcXc1L6Urm7Ku10VR
         WwmLSTeB0iY3gFfT5ClqjrFbM3yTgbdd5R+XYcAZnkOl6bfTskIW383bvGxuidfn8eNQ
         OL7w==
X-Gm-Message-State: AHQUAubPF2Bih9Tzn6CnJ84ysQRA7lsl84HinK5d8RKIzVBL3wK6ou9d
        rACSH0j7MlP7RWm1kiMW3+GeGUj/
X-Google-Smtp-Source: AHgI3IbUUAfOVHcpqDKtiQt7O4TwF05p7WXniAw5ljVSQU0/rZdVKS6ZdlRsvGFLJMGUc3YxlfmHZw==
X-Received: by 2002:adf:ef8a:: with SMTP id d10mr892250wro.321.1549655738631;
        Fri, 08 Feb 2019 11:55:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r200sm9189766wmb.36.2019.02.08.11.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 11:55:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Fix v1] t5403: correct bash ambiguous redirect error in subtest 8 by quoting $GIT_DIR
References: <20190208113233.14544-1-randall.s.becker@rogers.com>
Date:   Fri, 08 Feb 2019 11:55:37 -0800
In-Reply-To: <20190208113233.14544-1-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 8 Feb 2019 06:32:33 -0500")
Message-ID: <xmqqh8dejbra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> The embedded blanks in the full path of the test git repository cased bash
> to generate an ambugious redirect error.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---

Thanks.

>  t/t5403-post-checkout-hook.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index a539ffc08..a39b3b5c7 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -67,7 +67,7 @@ test_expect_success 'post-checkout is triggered on rebase with fast-forward' '
>  test_expect_success 'post-checkout hook is triggered by clone' '
>  	mkdir -p templates/hooks &&
>  	write_script templates/hooks/post-checkout <<-\EOF &&
> -	echo "$@" >$GIT_DIR/post-checkout.args
> +	echo "$@" >"$GIT_DIR/post-checkout.args"
>  	EOF
>  	git clone --template=templates . clone3 &&
>  	test -f clone3/.git/post-checkout.args
