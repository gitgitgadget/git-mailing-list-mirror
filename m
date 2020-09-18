Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5B7C43465
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E80222211
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6elQeXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgIRSZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIRSZE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:25:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A01C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:25:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id q8so7129429lfb.6
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVpGTTAzHrCJuMaUguizB84VAop9e2Wi7SwT7oEAtng=;
        b=O6elQeXDU6a724VlMCvTagVCpDzUTmdCdZhP9aq0rhCq2t4ukf03t0SwK1KIqCDc1L
         YY4lchRUha75UbXlUfE1uo21+bm9RTL9LD4NSHlvTkbYuYSbA+CK6UYxNZyQzm+2S7KA
         VXGEyE7FK3CHBqX2juK/ZQlWlyVNrJNHD6MQjKGOS4H3tcIjmGQ9oLs4MpIqAi1NUiXt
         sPmuS2q8oL5Ss2bXVo/v7t/bNb3BPd3HvTPdc2CYdnP7kxTjq+Gzy4FdvE0DCNmvQH6I
         nIUMIyN4NEwDJXqIJ5aHZBnvOUQ7EbDRMeZA3VZM9MWggzw0hoM0lm2jKdKAC2cB9vBA
         C61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVpGTTAzHrCJuMaUguizB84VAop9e2Wi7SwT7oEAtng=;
        b=mH6n0v45lY3Tb5NWleUyHOgYEtqLr8UKhGUQQzF/8b55f5iqmYq9nE130sENqLKWQg
         Cc4PUo2+Og+B+Fc+X0AvlqdJKP2c/uT0KgZxhaA4lWERkxvDCNUvz96FL8l8eCK+1i8O
         grveBcoK9UTL4wJjUjkTtACtiD9FsCG33+b5ehI7D1eMU4Pcp8/aCmYXsAz6yIhD/Mg8
         Yxph/Kd2LhICLbNilP/xvk1ovEICHxpefGzulqwObS+9AYlEcRkfv6w7L6VCRAq6clPn
         cF+uEYgrzBpxE1Kcppv8+OhNKdu+JMLLqGf85y+DxpKk9ZNcgzb1JrtYboF362qtumz0
         MwHg==
X-Gm-Message-State: AOAM531X+TpyClL4MXrybKLwJ0ne1v4pefLjbhBO072uaXMn7YK8eu0O
        V4tT9P2LWZiEQ5Xj96ac2SUhPypylWR7j2voohY=
X-Google-Smtp-Source: ABdhPJwsQlOG9HoV0Y70WiM0NdmgTCGRx3mUULrwFcfACbxN9N1gTtCq9V3QKEP1zzhJlz4+hUFIzH1zaD5H/aMk11I=
X-Received: by 2002:a05:6512:3b5:: with SMTP id v21mr12740091lfp.271.1600453501914;
 Fri, 18 Sep 2020 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200918113256.8699-1-tguyot@gmail.com> <xmqq7dsrm0r8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dsrm0r8.fsf@gitster.c.googlers.com>
From:   Thomas Guyot-Sionnest <tguyot@gmail.com>
Date:   Fri, 18 Sep 2020 14:24:50 -0400
Message-ID: <CALqVohdQwPppBsdsJjUhpXGZsZ=XCY_he7oFj1He1T8PjRLULw@mail.gmail.com>
Subject: Re: Allow passing pipes to diff --no-index + bugfix
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 18 Sep 2020 at 13:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> Next time, please send each of such unrelated patches independently,
> not as a two-patch series that gives a (false) impression that the
> second one needs the first one to work correctly.

Hi Junio,

My apologies for not making it clear enough - the fix in the first
patch is for an edgy case of git diff-range, but the same fix applies
to the 2nd patch. Any diff --stat comparison of two pipes would return
0-line diffs although the files would be marked as changed.

It was originally just one commit; I splitted it up when I realized a
test was actually triggered by this fix (false negative without the
fix, false positive with it) as it's still independent enough to be
reviewed/merged alone.

Regards,

Thomas
