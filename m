Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E3720A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 15:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeLJPuY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 10:50:24 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37520 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbeLJPuY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 10:50:24 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so18868110iti.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 07:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7z1Mf1x/mFdsoCb8nlYHLrH8I+qNC4TZgP67goY+W8=;
        b=ttKh38UV5MKx3naPJZhCGrb9p+Eq18cMu6LPPkjX12dQaVXD6/n9RrTxhiDY/uQyzL
         TbOX3v1OXLWcF/0gKrscWyc62SyDqJhKbAOioDsOKfV58t7+aAjAixnxChSxcLCiAEfU
         XPhFtEsfYuoE37Z6JNgy0VMZObFHP3h67Rk6nAPBgDWiGBCwQcqqF9wrDwyKU+1JATEQ
         7WKVScCNMC0mEcxyiANkVTQiVhmZXhb+ZPuuOug1gtTuafT1Ztin9xqhRjppPrRs6aCV
         +GGT2GR95gTyzmrami3pd1GWwbgVG0bKOFghrZAP4GNY8vYWgoKkwds1eCKzL+e/NATW
         Nifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7z1Mf1x/mFdsoCb8nlYHLrH8I+qNC4TZgP67goY+W8=;
        b=eQSnA64huz/bvAuG9sTEoof9+Tyq5tM8jYdP+9Zd9HdNq8SP38iepTss6VZl11bf5M
         1ty4u6rCVLG93+sXki4cnhZQJ6ogafHZp5KBNZEG+2o8CbJEpBij1gvgf3PAhHr15th9
         lb7+ANgLXGjKWoAJMlvRk7baOdK4zqLOezJTjitSho62bdqKcGG43w1dV0tFdfWrGToa
         JaF1z/TWOWFJsSWMlJ+gWjEN3+c5wZo/OhtmGCwtrujKNsJAnwZeLYhz2vDzc1AO01Ku
         pH/DSG8/fCvtRlHMa2W2AUbtDGF1AYAzS1+UHwee2G+CzTdLAibwBEcIP83be/i3LNOP
         SXaA==
X-Gm-Message-State: AA+aEWZ/XFOxs0tI5w4WR9NHdFDAZHzWhpHQcimWk8lKP1gnKSckjM7C
        lba7XJFR1BwQiUB60+qGt1QDU7AwIWeSrgTbNKM=
X-Google-Smtp-Source: AFSGD/VoOAav3xFp3fxmbqACtdxwog9nCVoIC0HwN/dRVEZtB98EpJDqbCZst3Hx9bbVPee8Zp57Jt/4CkzBLqPkYBM=
X-Received: by 2002:a24:4606:: with SMTP id j6mr9923001itb.10.1544457023971;
 Mon, 10 Dec 2018 07:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-3-t.gummerer@gmail.com>
In-Reply-To: <20181209200449.16342-3-t.gummerer@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 16:49:57 +0100
Message-ID: <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
Subject: Re: [PATCH 2/8] entry: factor out unlink_entry function
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Factor out the 'unlink_entry()' function from unpack-trees.c to
> entry.c.  It will be used in other places as well in subsequent
> steps.
>
> As it's no longer a static function, also move the documentation to
> the header file to make it more discoverable.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  cache.h        |  5 +++++
>  entry.c        | 15 +++++++++++++++
>  unpack-trees.c | 19 -------------------
>  3 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index ca36b44ee0..c1c953e810 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1542,6 +1542,11 @@ struct checkout {
>  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
>  extern void enable_delayed_checkout(struct checkout *state);
>  extern int finish_delayed_checkout(struct checkout *state);
> +/*
> + * Unlink the last component and schedule the leading directories for
> + * removal, such that empty directories get removed.
> + */
> +extern void unlink_entry(const struct cache_entry *ce);

I'm torn. We try to remove 'extern' but I can see you may want to add
it here to be consistent with others. And removing extern even from
functions from entry.c only would cause some conflicts.

I wonder if we should move the 'removal' variable in symlinks to
'struct checkout' to reduce another global variable. But I guess
that's the problem for another day. It's not the focus of this series.
-- 
Duy
