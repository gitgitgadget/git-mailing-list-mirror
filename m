Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A8C2D0A3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069CC206D8
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 01:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfhhGX3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgKJBHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 20:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBHI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 20:07:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30123C0613CF
        for <git@vger.kernel.org>; Mon,  9 Nov 2020 17:07:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so10047083wrx.5
        for <git@vger.kernel.org>; Mon, 09 Nov 2020 17:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hmxC4AHI3ILlZM6ho8XOVYy5W81LJGRlfWrfrqX+3M=;
        b=vfhhGX3NbTVJnmnsTJleNgzac3d+YdqI9d0HWpO+H9BgaESxhWfFZiyXvN53YFRSNk
         5w8gR+K1sXpF8nSmh09lzGupW/YtejMAI3F6xBwbDaUNDjgI3sRSLo6tenaBuWC6pFui
         iUInj1NNw7S6ZC4SpK/hv2wx/GVeQPts9b/U1zkhFTNe6YsCYT7G8z+e+SDXniHrGlh9
         V4cshiTwUmbJILlc4Ut0FwcRF0aqZuu2NEm75hOxJETgY7xPvrbHLtvfeca/Qe6psDh8
         k+Pq+97qmXinaITTBBZU5vYtvWPy0QXVYbTlUDKMYyzTp9xxj2MnzCUww4dISdk/F1oo
         hVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hmxC4AHI3ILlZM6ho8XOVYy5W81LJGRlfWrfrqX+3M=;
        b=aoFfz/SuMvS3/y/EKiJPXUndbIYQ8ja7aUaVsaWUkV1ryk6MEIdhn5gn/xzH5CJM/k
         Qjvx6QZPXVFLGuDbrFAgNGnohEdIp8I399iVRgTZ1tnvuBq4zRdRAjwfWLMgjhdL3FAu
         oszTtTAMGnB2YMVfhXZL60x0UaUIglR5ypFh4jALuILpZEZbno1sqQgMe9cN1ndUpUEo
         vUYtbH2rp+2IalpDSe2FDwHEFnioLJxLeFnr0D6DxvfbTqKb39Lwfli3BMWiF9J9v//T
         upEPmFbWt2ZHJgR5YcXC7qmWt7s5doIWOKfI46cCYIy/ScraKXoUFCu/6pOXiUq7F0DR
         z5Lw==
X-Gm-Message-State: AOAM533qHFucvPe+H7NJhAjYhFdD+C/W5oAvXgOZraEORE6ey+23lKp2
        K33wWkp86B1a6VktsoDp0f662KyNjWu3nzIXVTM=
X-Google-Smtp-Source: ABdhPJxiMeqbjhxv1+KoGxRlrOoKofZS1/9NL8Gitu3dA9jcxUZjQSD+mszj9CFXFGeazo0Qaik9cjouULaVGT6Ibms=
X-Received: by 2002:a5d:52c1:: with SMTP id r1mr32406wrv.255.1604970426992;
 Mon, 09 Nov 2020 17:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20201109215248.461167-1-felipe.contreras@gmail.com> <20201109221939.GA670413@coredump.intra.peff.net>
In-Reply-To: <20201109221939.GA670413@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 9 Nov 2020 19:06:56 -0600
Message-ID: <CAMP44s2mZK2_aAepOQs-5fmrbYPJ74Jb4VaSgwMAEdzZXS+9ZA@mail.gmail.com>
Subject: Re: [PATCH] completion: bash: support recursive aliases
To:     Jeff King <peff@peff.net>
Cc:     Git <git@vger.kernel.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 9, 2020 at 4:19 PM Jeff King <peff@peff.net> wrote:

>  - there's no limit on the recursion if we do see a cycle. Doing:
>
>      git config alias.foo foo
>      git foo <Tab>
>
>    seems to fork-bomb the system with bash processes (well, perhaps not
>    a true fork-bomb because they expand linearly rather than
>    exponentially, but still...).

Yes. I opted for the quick and minimal solution. But if this is a
concern it can be handled.

> We do have "git <cmd> --git-completion-helper" these days. I wonder if
> something like "git --expand-alias-to-command" would be a useful
> addition, as it would let us directly ask which Git command would be
> executed (if any). And it would make both downsides go away.

Yes, but I don't think we need to wait in order to have a solution for
both issues. I already sent an updated patch.

Additionally, it might not be what the user wants. For example the
user might decide to have different completion for each one of the
aliases (_git_l, _git_lg, etc.), and if so, we would want
__git_aliased_command to exit once we find the correct completion
function.

Cheers.

-- 
Felipe Contreras
