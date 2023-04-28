Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2FBC77B61
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 22:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346835AbjD1WmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 18:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345956AbjD1WmV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 18:42:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B31FD2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:42:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-640f6f95532so560460b3a.2
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 15:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682721739; x=1685313739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x7SyDsITP+EJ5TT8+/lU5/qkoPSyTfSqen9T38Ju+Wk=;
        b=xd8yVPCL2Pt95LVYVbACM6fv07f9Skv3vKmt5xsbFmFXkqEu9t4Rm2glesy8t/4lNR
         7MPF60WbBeYmf8m0nseZU/WbGvyPATEtbKAkYonN3EODVM4/E6RdCU/KKgHq7fDA5CgO
         /4GtZrPxMTQKBo7zRrk2nuQ8SEwK+ruFyx4XCAtOJlkA0My+gZmWEuswWN2CdxVIKXHd
         gyzuVmmRwPYImuVLf0UQQ3algbbRxxpnO8P0Lz9amvA/Q201FMPSWXlooJtAZoSbyRS/
         ERqAxfQ4Kxfq0O5OQTRks97n53864/fIzktmNXJnRW623shxROEoW53sBP52Reo3rDRn
         f5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682721739; x=1685313739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7SyDsITP+EJ5TT8+/lU5/qkoPSyTfSqen9T38Ju+Wk=;
        b=ED1QOGXynm8r/xk+d57qrfTOICC4ycHD1onLazPGceo2R3wHkGxxMH1YRrsKrgMQQ1
         WhhLyUrxSRZMqxW5aeGST8wHMPakX8hFkC4mO2XQgSRZy2E6Z7nvZmQ8o/reZQ3QqzW5
         E3G1lsbTjd3Ze2+4s59/lwsfo8BwmidOe/O8uqedHAfTvMZRX9mb2y/NXxan4yDKA2cR
         fw3oLipzZfJmOcn6XaT8ct800p+dgbEifaRrY7oHD11FnA985jnNow6zkiLLR8BD90DF
         8RLQzW6cDPrdLe2g3Eo38+LKNh/SrJkcY74Pp6jCUbpOutbm9NokM+J+SvqMcP7QJ1GZ
         XZzg==
X-Gm-Message-State: AC+VfDwoO7HE42IMa7U6Ikc0a9k+ilMjHl8clqyMuU9zB3TsrCT38BRr
        N8bSqEDKjHkb68eIhnKskgyCZwnjGGnw8A==
X-Google-Smtp-Source: ACHHUZ73jkq2P4LUkD67++T+aGs5paM86fJOPFF8fGBp0L+F5weX68pBCGAqSk5wctq01oGBFtXJscPeYglXRA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:bc4:b0:63d:2cff:bfbc with SMTP
 id x4-20020a056a000bc400b0063d2cffbfbcmr1763475pfu.3.1682721739609; Fri, 28
 Apr 2023 15:42:19 -0700 (PDT)
Date:   Fri, 28 Apr 2023 15:42:18 -0700
In-Reply-To: <d7c1bc1a80406ad320c2de684e0c97ba14827c7a.1682593865.git.ps@pks.im>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <cover.1682593865.git.ps@pks.im> <d7c1bc1a80406ad320c2de684e0c97ba14827c7a.1682593865.git.ps@pks.im>
Message-ID: <kl6l354j39yt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 8/8] fetch: introduce machine-parseable "porcelain"
 output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> A notable ommission here is that the output format does not include the
> remote from which a reference was fetched, which might be important
> information especially in the context of multi-remote fetches. But as
> such a format would require us to print the remote for every single
> reference update due to parallelizable fetches it feels wasteful for the
> most likely usecase, which is when fetching from a single remote. If
> usecases come up for this in the future though it is easy enough to add
> a new "porcelain-v2" format that adds this information.

We discussed this elsewhere in the thread, but if we are just adding
information (and not omitting existing information or shuffling it
around), I would prefer for us to make the format extensible using flags
than to add a whole new format enum. We can't imagine what other
information users might want (maybe the remote ref name?), and it would
be nice to avoid bumping the 'porcelain version' unnecessarily.

I agree that this format is good enough as a starting point, though.

It's not new to v2, but I've mentioned my reservations on
--output-format on:

  https://lore.kernel.org/git/kl6ledo33ovx.fsf@chooglen-macbookpro.roam.corp.google.com/

I will be out of office all of next week. If, in the meantime, everyone
else decides that --output-format=porcelain is good enough, I'm happy to
accept the result.

> @@ -127,6 +193,24 @@ test_expect_success 'fetch output with HEAD and --dry-run' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
> +	test_when_finished "rm -rf head" &&
> +	git clone . head &&
> +	COMMIT_ID=$(git rev-parse HEAD) &&
> +
> +	git -C head fetch --output-format=porcelain --dry-run origin HEAD >actual &&
> +	cat >expect <<-EOF &&
> +	* $ZERO_OID $COMMIT_ID FETCH_HEAD
> +	EOF
> +	test_cmp expect actual &&
> +
> +	git -C head fetch --output-format=porcelain --dry-run origin HEAD:foo >actual &&
> +	cat >expect <<-EOF &&
> +	* $ZERO_OID $COMMIT_ID refs/heads/foo
> +	EOF
> +	test_cmp expect actual
> +'
> +

Now that the earlier test also tests without --dry-run, shouldn't this
one too?

