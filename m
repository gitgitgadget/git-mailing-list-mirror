Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA53C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 20:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC3Uch (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 16:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC3Ucg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 16:32:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43553B0
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 13:32:35 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o11so19302685ple.1
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 13:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680208355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gRiwbhHMn9hG7TrS1wK2NdE//wIvmY8H7Fo5NF9xVDE=;
        b=KulyLEcp4GY0Md32FVg+0qpxcxLINSAcTB5gG9TtKRYWRg87NaVu4L0RLf799CKqay
         CwqWqOFeSjSeFIuIEtN+IvUIzf3SoQS+GX9WyK+v1vaCutWwNyX74Wslvi16CcCyCrkz
         9ZdG0KUvoAb0KjR4mZRjT06UmhkNQdS9BKoiJodeezaiptBcY3MdV9ysW5dDzWHuRe+2
         yc64FjnHXgcxOHoDYBztyFactpf//SeJ6TQK1sPD+UWMesVmGhfR/FOj5Ysu1MhFE+uy
         x0ZXsWTTIJYX041snlhmyuoY58Q+sdjK7Q9b+OMtmaDZWi4caqVZwLG4Mlh9CeKDFSsv
         83xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680208355;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gRiwbhHMn9hG7TrS1wK2NdE//wIvmY8H7Fo5NF9xVDE=;
        b=xXDyHnLb7ZV/ldgUMapWIOEG2WhZY8uG9NrpBOcnOJYnv4WyhcFFcu+cf7BDW5IA69
         c58h1/eYgkbmJ96PzpAi7ZyWweTS5n4hcDdtW83DB2OmUZQXFgZb0l1J9DaXxXexnZ45
         erLFXcDFl2YJunvX731CdQK7Ksvl/JUuwcTbxkfSsW+njfSDt3dU4TmCfLNKoID2jGk9
         yJ4Z6gs9lh42u37kLR3AD4hFEBDpD+8GFqSzeHCz91Y6JaRbZvqcYoQTaiN9Q/+X1+vs
         nL6Bn+pE3oIwVhX5V2gkI0VEukEcd3VC1Nv+NaLFAM2/rG694GUwcWl3rYilPeP1VtSa
         uo8Q==
X-Gm-Message-State: AAQBX9csJ67B2CbMC90Rha1ncN5C9hOhxt7sg70d8pAhaOvWzXikLiHe
        FbhNSOatpFVdD+Iwr++pcV4=
X-Google-Smtp-Source: AKy350ZA+lSdFgPT9EKbkq7+kl1i6OxkcE8kpggCtKekmt978vup23O5Jm32PIi0uXLqKSWX2ocxEw==
X-Received: by 2002:a17:90b:4f47:b0:23d:2f73:d3c8 with SMTP id pj7-20020a17090b4f4700b0023d2f73d3c8mr29132342pjb.42.1680208354642;
        Thu, 30 Mar 2023 13:32:34 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902a60a00b001a1f6f15c3fsm148747plq.72.2023.03.30.13.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:32:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 0/5] some chainlint fixes and performance improvements
References: <20230328202043.GA1241391@coredump.intra.peff.net>
        <20230330192712.GA27719@coredump.intra.peff.net>
Date:   Thu, 30 Mar 2023 13:32:34 -0700
In-Reply-To: <20230330192712.GA27719@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 30 Mar 2023 15:27:12 -0400")
Message-ID: <xmqqjzyyhtel.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As before, I think the first patch is the most important, and the rest
> are optimizations. But with Eric's patch to chainlint.pl in the middle,
> I think the argument for patch 4 (previously patch 3) is much stronger.
>
> Patch 5 remains mostly a cleanup, with no performance improvement. IMHO
> the result is easier to follow, but I'm open to arguments to the
> contrary.
>
>   [1/5]: tests: run internal chain-linter under "make test"
>   [2/5]: tests: replace chainlint subshell with a function
>   [3/5]: tests: diagnose unclosed here-doc in chainlint.pl
>   [4/5]: tests: drop here-doc check from internal chain-linter
>   [5/5]: tests: skip test_eval_ in internal chain-lint

The new step [3/5] makes it easier to justify [4/5], indeed.  Two
primary changes at the beginning are good as before.  The last one
does not make anything particularly easier to read, replacing one
cryptic eval stuff with another, but it does not make it any worse,
and the most importantly, it is clear to see that it does not change
the behaviour.

Will queue.  Thanks.  Let's merge it down to 'next'.

