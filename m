Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D517ACA0ED4
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 06:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjILGLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjILGKr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 02:10:47 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F021BF1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 23:10:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-573fdb618eeso7024711a12.0
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694499013; x=1695103813; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYVLQy2w9FC3YDEqRhEUgmCDxO34sZ4WJMXPjQRDoyY=;
        b=gC2zfUGE+nHcRIAS1JOWPmlQ2dDtNHc0GRKGiDVtx3MKuq7MlkUSxZGdIHZdZEI9gB
         CcbwT56SJUPyWlkEjoicz0WFZz08uvuKPFOQXSpr9kcuwJMoNWKMccUoEQFgwMoMEEKs
         RiwPWY4fCQnRN2/MTTOwuGwpezNGoYYl+gclmdanMfG1uTSRQbtssrZe/yz8eetRjoWG
         vO3N3ShKAPRnOwNgAbk+rlepn6rlV6WvoF0mgDiGLnJFsE0oL8V4PX5BHRMLeJTuStrv
         vBhmxmIVe6Snlj64NfG48vHUWTxWzhCAUwon7O62HVhsd+f2tlhHZmM93R3eBX1GkU8Z
         yXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694499013; x=1695103813;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYVLQy2w9FC3YDEqRhEUgmCDxO34sZ4WJMXPjQRDoyY=;
        b=OH7DLPvwr3hFKGhEqZV+8iKvsFM5FCTpIRZNL9xkJtBNiAm9lGOwSgmPPLitZc8VA6
         brj9tASRMWdyPBpjDXB24qKpkDo1oxkV0k5jzlN20rUOCqRf3cfo7Vtn9MByfuj8ENaG
         NFKv2zy0W4qIHhtA0jj6TpBvb4GRltNZUixRioAfiP4onXKcTwcmXk4q5pDGAAUDYXZr
         mpDvL4G0RuJ29bX6RBgVoxbgLoL54X4Ka4sW5WZMVr2yny5y9J8oCPW5Z+C9D4ey5BG7
         7ObEpZikszphTRoly5/ZDQZWgZyFTy0HNXtLBy8K5G3BVjk0q8F4L2KpyD1ncQKn0F8M
         R1lA==
X-Gm-Message-State: AOJu0Yz2xqNfM6jznmnLMsTsnUBHv3xJZq8F2H22gwdFAZA+CKqV+dm3
        d5qZoD5j4f9XLKWUQYFaX4DeY1YIhik=
X-Google-Smtp-Source: AGHT+IG67LqgPEof2I0VUfE47nkEFl8JqPi1gOZilyqCcFIe7qQA7ltDUxzXh/qtt5H/agBDly0xaR7OtDE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a63:7353:0:b0:56a:b197:12ca with SMTP id
 d19-20020a637353000000b0056ab19712camr2400126pgn.2.1694499012878; Mon, 11 Sep
 2023 23:10:12 -0700 (PDT)
Date:   Mon, 11 Sep 2023 23:10:11 -0700
In-Reply-To: <20230818233729.2766281-4-gitster@pobox.com>
Mime-Version: 1.0
References: <20230818233729.2766281-1-gitster@pobox.com> <20230818233729.2766281-4-gitster@pobox.com>
Message-ID: <owly8r9bly64.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2 3/3] test-tool: retire "index-version"
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As "git update-index --show-index-version" can do the same thing,
> the test-tool lost its reason to exist.

I think you meant

    the equivalent functionality in test-tool ...

and not that the test-tool (in its entirety) lost its reason to exist.

The rest of the patch LGTM.
