Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5622AC433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbiAJRTu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbiAJRTu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 12:19:50 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9649C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:19:49 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id f9so14346586qtk.3
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 09:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U38SS138Rsck5Lft+MMpM6xCEprtKDdXQkTm7vegOvI=;
        b=G6xO0a6Dj2wv7TKkNbR+iPwPkk58eVnofdBU9vBpU6syQ89Iik91mDYdZV/LssnuXJ
         DUpCTQgiKAiBuTmgIyLB845LLNdz/XhrtaXk5ZzE5Sr6qmJmsep9RsjsK+ZwiAJvACQN
         MRqmUjkq53fcw2V+P9SLjKJkCgkHmCvNDocs9B3O+GEPC1rEYGGV8uuoNzvixsV2GZSp
         5T+xLaMvaUQ70DreqYKtb43NsMISmV7tgAqcDqYcN9HqegPlQRgDXBHfYVb4+Yig4Xk9
         RojYldZGffulmUcoTlRqG9+1KBktZ1RvizybgSlDiz8+e7jjfOQnuuVnyDQ8kRnXQXag
         abXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U38SS138Rsck5Lft+MMpM6xCEprtKDdXQkTm7vegOvI=;
        b=GDJhpg58Xcl5GK8Ribi0dN9Q8/vZ2uAamJgEi2NQv/nhTim6oWZhwXc04unH2jC8y/
         MOhBFi3l118AlfXGqGwLMAOFvweshLFXHOks/xAwcaZrrLALhnprccUKxaMyIK8Bzx2s
         spXAkxPwqhcT+gVBy4h1aKh+u9ai2LFlmd5LOPsbNrs4YXrB7vf7gGzPPwGfue4jaJE4
         DNkLBqeLVacz7IiPtRqzBbEzJXFHH+1XixcHa422ORvXUBE++9655Q6Wtx8Y+f2axLoK
         EFOI6Vzc6ZZ8DZElPpbomoSGkt3tQiPZbMcXUyEG/j/N3kNLtTUZXeQgK0PWUIe/KJjK
         OIug==
X-Gm-Message-State: AOAM533WAxuvuDxQN/aNpRNoBHI4ii4b5M9z9qzFdUOqVE78R9LKkzRd
        yaSS5p3/Pmn2B1zYNHfnpQ0Pbg==
X-Google-Smtp-Source: ABdhPJyVGfxMa9v9AXgRZev8qgPweg4DTGh49BjLAmwUcybGIzsWlxpvHwIoTTK8kNI6M8fi1Mr7qQ==
X-Received: by 2002:a05:622a:1103:: with SMTP id e3mr621598qty.378.1641835187702;
        Mon, 10 Jan 2022 09:19:47 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y8sm5030405qtx.74.2022.01.10.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:19:47 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:19:46 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: git ssh signing changed broke tag merge message contents
Message-ID: <YdxqshqXB/+ApOn2@nand.local>
References: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whXPxWL7z3GiPkaDt+yygrRmagrYUnib7Lx=Vvrqx2ufg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 08:42:07AM -0800, Linus Torvalds wrote:
> So I made the mistake of updating my git tree as I started doing my
> merge window for 5.17, and suddenly all the messages from signed tags
> disappeared from the merge commits.
>
> I bisected it to commit 02769437e1 ("ssh signing: use sigc struct to
> pass payload"), but haven't done any other analysis.

Thanks for the reproduction and bisection.

> I assume it's the change to fmt-merge-msg.c, but have no time to actually check.

Yes, 02769437e1 appears to introduces an inadvertent use-after-free.
I'll write up the details and post the patch shortly, but an easy fix
is:

--- 8< ---

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index e5c0aff2bf..baca57d5b6 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -541,7 +541,6 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			else
 				strbuf_addstr(&sig, sigc.output);
 		}
-		signature_check_clear(&sigc);

 		if (!tag_number++) {
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
@@ -565,6 +564,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		}
 		strbuf_release(&payload);
 		strbuf_release(&sig);
+		signature_check_clear(&sigc);
 	next:
 		free(origbuf);
 	}

--- >8 ---

Our coverage in t6200 (which should have ordinarily caught such a bug)
is lacking and does not search for the tag message in fmt-merge-msg's
output.

Thanks,
Taylor
