Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B01C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 05:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbiAXF5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 00:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiAXF5H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 00:57:07 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE2C06173B
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 21:57:07 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id p4-20020a4a8e84000000b002e598a51d60so2166753ook.2
        for <git@vger.kernel.org>; Sun, 23 Jan 2022 21:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38gS3eN+iAHUag/F6axR3+zWb9MBtV6jZL6kSTOQZW8=;
        b=EuBBJtjGAVoNPp7wljl9l1P+EHCy5fUf3Kribb/WmwtIL5RGCuqHkMA7qOwAMqwJxk
         nYDbazlOVLbEwSe8xhMSd7nwEpJSclSRWdCK4XY5GFI1OFdRuA1R5/kimKs56Gg+yYgS
         oT31Zv1tH/wL5NWVr18wUhCvZ0dTLUOzixkure/Ldv3hS5dYN69V3Ibdd8wkZFq9dwZj
         pXiXdFmxB555QF7sbLoqP2nsu0A0jVVCDkRmfY9ZN/1iCKbABQEB+ezxZSCJI3cav218
         ER514BxBSV9xrpNU+7CnyytbCUEMs2rt7mAZZw9L7h7+Ha7V3DGezu8n92+P0de2Sou+
         tTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38gS3eN+iAHUag/F6axR3+zWb9MBtV6jZL6kSTOQZW8=;
        b=Uzql4erP8IjfrpHrvXz0Vbp/88p19BKnExNoZ2iiu1hTbXcF5X0JCNwinuRUAkraxb
         AGl01kQ0PIzu/T778EIs3FzbgMhG4e2fJl9jG/U6QVZORqZhyR5f62dvyDBfbThVWS0P
         NSfD4KuXDtRHglU52yyMQ0mRIJdRk/7Y2dXya4ri9XJ7XHSJEs5OnbGKhszLG1nq8XCe
         GNQQhMg18q8OSfWjWCJW3q1jDcDeyk+slTOzM0k3DSi8f66yc8zdo7mOwR9wBN/QfNrn
         OLU38XWwKT5My6lYzRFHoqRjY36Nf7Vm4CQtcSF5EerJH4znLg4+CR6ZzFi3VHXd3IvT
         Dk/g==
X-Gm-Message-State: AOAM530fSJyLzTJZCQZjt4gobWvcGPaWV0ddXnNHtcoxaJthKKwqLP7M
        Z2lJAw/M1P55PWZFalLhwmZhyzI6XPzoehAxZLs=
X-Google-Smtp-Source: ABdhPJzHr8CVRYpIyFf8OEvZqKIp8l6ihyI3NT1ZvMzbut2VJWrk9T9BzYN35j8Q1cdWWQGMA7X8l/F7DUsOR5Hy8es=
X-Received: by 2002:a4a:5403:: with SMTP id t3mr9176689ooa.72.1643003826018;
 Sun, 23 Jan 2022 21:57:06 -0800 (PST)
MIME-Version: 1.0
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
 <20220121102109.433457-2-shaoxuan.yuan02@gmail.com> <Yer/oEZK6TBFSsde@nand.local>
 <xmqqr190g6gd.fsf@gitster.g>
In-Reply-To: <xmqqr190g6gd.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 24 Jan 2022 13:56:55 +0800
Message-ID: <CAJyCBORyjNaPXshQrGjbrUCUv832MJsNew6ez-EOWJo2od9a8g@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 22, 2022 at 4:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> -    if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
> >> +    if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
> >>      then
> >>              : happy
> >>      else
> >
> > Looks very reasonable to me. Indeed, this line comes from 6adcca3fe8
> > (Fix initialization of a bare repository, 2007-08-27) which predates
> > 2caf20c52b (test-lib: user-friendly alternatives to test [-d|-f|-e],
> > 2010-08-10) when these helpers were originally introduced.
> >
> > I thought that we could probably just shorten this to calling
> > "test_path_is_file" twice: once for "$1/config" and a second time for
> > "$1/refs", but that assumes "$1" is non-empty. And to ensure that you'd
> > need another check, which amounts to the same amount of code overall.
>
> I had the same thought.
>
> Since the first "$GIT_DIR must be a directory" matters only when the
> caller is crazy enough to have a bare repository at the root of the
> filesystem and to think that it is a good idea to say "" is the
> "$GIT_DIR" (in which case, "test -d ''" would fail, even though the
> tests for /config and /refs are checking the right thing), I do not
> see much downside from omitting the first one, but I think that is
> something we need to do _outside_ the topic of this change, which is
> purely "modernize, using the helpers we already have, without
> changing what we do"
>
Yes I feel the same way, one patch for one thing :)
