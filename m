Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC3C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169C560F51
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbhJHUJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhJHUJW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:09:22 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7CEC061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:07:26 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id w4-20020a1709029a8400b00138e222b06aso5493072plp.12
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N+r392c/Ib+3BcWdgciaerin+fNCEnTJtgRZ/VlAJWs=;
        b=QMIPZtSMU3rcwos2ptVUi5dff9J5ECQ7ELcQrRP/wJ6kfoAi7E6ehzGdbYf33l1XRB
         NXLPY8d3fGIDZ1BGFwflf2/HYBWM0zhoCyppwbtdKL/gYbNrYqL6WNlHJivbYirOJwcK
         naC2pZVgrOjJANc6b/EPeFR9wuvMMEbwzLOqdESwLVER3D6CmnvG8BWb51k68TT5k72R
         puV0KNWEmE4TLzX/htuO9Ke6Tz/IHmmvx9RYbt+X7qc3w5/F15BrFFDBKzbYLTp8Qljm
         ccTzWLyhcSdpqAgJScqIUA8P02OH+bFgYr6FuTECjm8Ij7RAE8vr8ELbH8WI0hhjXfNO
         aM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N+r392c/Ib+3BcWdgciaerin+fNCEnTJtgRZ/VlAJWs=;
        b=Dcx5CCB7QwQ64XnFL/UZFy2kNeDh3VwU9oQLEPDglNEMlNh3buyAN6TlyzZk9S0+n9
         mJG0Ihu0x7S+rYBmHIQW3kaWYwrkJcJ5oWB6uHGs8hnC0IwLVBwYCXrIAeki0DYzwlKw
         8ebBJ1fnqmNVawgynNWozK4g9QJ44+W+8I8C1gASwv7FxAbTAOE2FVeBNB4OAREKTAp+
         y/CjlI/I4eVdW/eNGCoSBKr0yRsZlqlGxeyjbFYXO3hIH/GQIL6d1aTlYnsrwMkGhn03
         RuBOcw6zYW+KOyLKnOk/CwB2U0Osk4MIl5L5ty68rEeBPpTxyZmd0f4818PGh5BSRkTb
         iY+w==
X-Gm-Message-State: AOAM532J5rE9GQfhDxlgiBlmC06RbhpzW78MURimgHPHRIlm23i+E24l
        xLuFH6WPiRHIC64xbIzs2Gsm/+w4JjjtUDFkG78j
X-Google-Smtp-Source: ABdhPJxJX/JVSQ89MvPtNV06GJ2JRyi1rt7kCxfM1y9GBcj2XsBrOhMjGLqGoyDBd1RGPWDPRsGrjIqcaUBWL214WDSl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:903:32cc:b0:13f:c3:4ff3 with
 SMTP id i12-20020a17090332cc00b0013f00c34ff3mr11344189plr.33.1633723646070;
 Fri, 08 Oct 2021 13:07:26 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:07:23 -0700
In-Reply-To: <20211006174231.80434-1-chooglen@google.com>
Message-Id: <20211008200723.1321670-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211006174231.80434-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH] fixup! refs: plumb repo into ref stores
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> If we are plumbing repo into ref stores, it makes sense to get rid of
> the_repository in refs/files-backend.c and use ref_store.repo instead.
> 
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
> In [1], I made some changes to refs/files-backend.c to get rid of
> the_repository and accept struct repository as a parameter instead. But,
> if we're changing ref stores to contain their own repository, it makes
> sense to use this new interface.
> 
> I think the most natural place for this is this series. Let me know what
> you think :)
> 
> [1] https://lore.kernel.org/git/20210921232529.81811-2-chooglen@google.com/

[snip]

> @@ -1347,7 +1347,7 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
>  	return ret;
>  }
>  
> -static int write_ref_to_lockfile(struct ref_lock *lock,
> +static int write_ref_to_lockfile(struct repository *repo, struct ref_lock *lock,

Ah sorry, I didn't see that you already did this. I don't think that
it's natural to do it here - it's probably better to do it in another
patch set that also verifies that there are no implicit references to
the_repository.
