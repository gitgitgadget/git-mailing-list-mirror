Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41631C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5FA764ECB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 08:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhBBIem (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 03:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhBBIc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 03:32:59 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11284C061573
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 00:32:13 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u25so26688525lfc.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 00:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3vDCRBDjLpYQl20ikHh58nsiM4uhZARJ3yWeMGxzSQ=;
        b=BOeVrxZ0n88vcbZO0hctK3hIA5f0qDVWO96iGRiusu87AUrtGZVBpZS60yIoe0HN0a
         E77RGQpJIuKrRWOyjXDM7tTDaWm47cpM76/DH6JLYATqZnN6e8SCJE3bKc8AM5FW2ElH
         3U3glhvpVE+EJ5hxWydPZaoENmVVvWMUbvKXNVpkWU4ms442f17Ey1bdXCGH95v0K52M
         WOC7c4Z2QmJEddZeIxF1K2oIty8jVsv5w/CzO0JoNXUrvSd5Y2t7SULg56fkOpq61EW9
         HABd9aJxwLyKNcg1RjXPterljsfQ2rZavT/9+5zvN0iVXAaSDJgByOA8SxrR4oi1Lgd7
         VNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3vDCRBDjLpYQl20ikHh58nsiM4uhZARJ3yWeMGxzSQ=;
        b=j0VCLfhjfDqLGdZQDwsZP3sjeHn6CCISj8fIh5c/RKHazQ0Ma7TBtkl1Xql/xvyb0G
         bpRtnhIowPc3uegjufRgh1HbPoCLTvecC4D1A2AgIGLiFk1H7cW1aO34d728F6jIt7GL
         YhpF+1XbDUBjOPt7q/zcVXGijc8wwFrZGysDURa0IdNQNiCW1sziVU1+TGydPX44Fb/3
         ZqD2KapVfctDQpyuOrRi+s0xds1lM4XCjPsG8xJP6u41x6f+qVLk2rdy99G31keBNOHr
         FxU5L0jzw2tp13/GU9vRf26SMciPnD98EfZg8bM5rvsYZ7O+n2qVuIow/5ctKyt0eVNu
         2mHg==
X-Gm-Message-State: AOAM530aC0KXkdki7iRCaNaP2FnkkoDxEXyQGRiYybAyE+V72050BH2b
        WJvI6KM+NVd1aeBrOzsUtkTa0dPTlLW84tGWjQHAkJR/DH6Khw==
X-Google-Smtp-Source: ABdhPJx81ulqLL728lkWodXStpIXK075iNHiQz0La9Y1tTcBt2pgtyDKkr1k0g50zBceXHRdaTlNy7XeXRtn9aK/UuU=
X-Received: by 2002:ac2:4569:: with SMTP id k9mr10000676lfm.461.1612254731602;
 Tue, 02 Feb 2021 00:32:11 -0800 (PST)
MIME-Version: 1.0
References: <CAGP6POK1s5fdzY74HyE9=0CV_B+HpbM9gU2qKuYtQAaPuc7XgQ@mail.gmail.com>
 <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
In-Reply-To: <CAPc5daUtOMQB9YqOTQL4mrHpfyATe=FM01cW9Ngd1iy8aWwMmg@mail.gmail.com>
From:   Hongyi Zhao <hongyi.zhao@gmail.com>
Date:   Tue, 2 Feb 2021 16:31:59 +0800
Message-ID: <CAGP6POJ62-HG88uRv7yHHGy3Uu+T57APQ6GiNU3nQDW2eT4cXw@mail.gmail.com>
Subject: Re: Only receive the topics I participated in or initiated on this
 mailing list.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 1:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> You can,  on _your_ end, filter incoming messages that are sent via
> vger.kernel.org and do not have your address on To or Cc.

I'm not sure if this can be done by Gmail.


--
Assoc. Prof. Hongyi Zhao <hongyi.zhao@gmail.com>
Theory and Simulation of Materials
Hebei Polytechnic University of Science and Technology engineering
NO. 552 North Gangtie Road, Xingtai, China
