Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BABDC433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 06:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346326AbiFUG7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 02:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiFUG7B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 02:59:01 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98961265C
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 23:59:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090aee8800b001ecc929d14dso797088pjz.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 23:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OjgHxy17pfET3I1uDXhK0r5US1gHoGObgpikjwJHTvk=;
        b=A1O7FTJjAMmcPchAMxYoo0f98WCQIMIdo0YMTt5SrrECxsVli+845khGafQNdlTjyt
         HmxlX7fanpyvZR4/qAnloNKIIzfziGmAxMz4/zUchh1R6FFxwt3jR9wiTWek2HOGt0hX
         WGnFJIORcXJxpYG+1/Mm8DhPko8yPOvrp6RnBxb879J2IK4pBx6res3xlc4yVwVWAg7k
         uLzXIoH6NWJpRDb5nWmuZ/Ubmn1GzIsZASyhCvJfMl106KGvCEAhIFUM23iXT1CH2dOy
         TddztRhTqlfPZsUmR15X5uSm6uw67mAboAwJVVBjNTIE6cQY4EkikXxF69dlGWNpGLgB
         YdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OjgHxy17pfET3I1uDXhK0r5US1gHoGObgpikjwJHTvk=;
        b=m8BoTLpFARJKsfipT7ZJOezkvABxZIREtVQgoRX8RTWKXxiHrtR0QPMFiSTCrK5PZ/
         CDQQCl1G+Igql6k1q6jRwbcXSNoXuJxFxPbATJzJmuQs5cHIAMqdHhjNdc1Uwj8YGUFB
         kJoUjl1WrQTXbVAST4tXrQKtQFgoX9tB78bBKtgP7SXq4Vbrff1Rzjc2VBPNDr21X/xb
         xlzQ64/4YGWzyJ2Xwo6bi2VrG8Yzg0r1c6rTy4g0PlRPoidiWJqdaG+iCHlONCK3VMJn
         xnaqsvg8w7KfEK4Pucanwzyt6hhMV4X3B1jEWQ6X5c1lbzV9zly6I2itMu0HWPHgmJY6
         97fA==
X-Gm-Message-State: AJIora+GDdPUSoCf6/Y25/WnIRhHOq0wrOnx/CHwzYIZ91eE66hIQTXP
        cPEODpKt0h59OhUA9IQ9GXg=
X-Google-Smtp-Source: AGRyM1uWwBZhuYqG3QE5b0w98w78E7UbzhdvqndSwpMiYcMl5VNHiRug79j8Zha/1QrH24H6Iz4k5A==
X-Received: by 2002:a17:902:8bc1:b0:16a:187c:8719 with SMTP id r1-20020a1709028bc100b0016a187c8719mr13087567plo.43.1655794739845;
        Mon, 20 Jun 2022 23:58:59 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.38])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902ca1400b0016a16e16c7fsm4806643pld.248.2022.06.20.23.58.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jun 2022 23:58:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap" file
Date:   Tue, 21 Jun 2022 14:58:53 +0800
Message-Id: <20220621065853.126718-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <Yqfm+rsP5DWyj95L@nand.local>
References: <Yqfm+rsP5DWyj95L@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Jun 2022 21:40:10 -0400, Taylor Blau wrote:

> I'm nitpicking, but I usually say "single-pack bitmap" or "multi-pack
> (MIDX) bitmap" when distinguishing between the two.

Ha, it's OK, I'm hungry. Your description is a better way I think.

Will optimize the relevant places.

> Odd spacing, and there should be a single space character separating "$"
> from "git" (like "$ git").

Yeah, will Fix.

> While I'm thinking about it: is the error message here up-to-date with
> the changes made by the previous patch?

It's still the same after the remake and test (actually it's just a case
not all the cases have the same error message. now by the previous path
if "core.multipackindex=false" and single-pack doesn't exist, the error
message will look like this).

> This could probably be trimmed down for brevity, but I don't feel
> strongly about it. If you wanted to make your commit message a tad
> shorter, perhaps something like:
> 
>   When a user sees output like this, it's unclear which kind(s) of
>   .bitmap exist, and which were read. For example, it's possible a MIDX
>   bitmap exists, but was not read (e.g., because
>   core.multiPackIndex=false), among many other scenarios.
> 
> would suffice.

I think yours is better, I will use it instead the listed way.

> s/TRACE2/trace2

Will fix.

> s/NORMAL/pack

Will fix as s/NORMAL/single-pack.

> s/$GIT/$ GIT

Will fix.

> The output here is quite wide, and I wonder if this whole section could
> be shortened. For example, scenario 2 is arguably more interesting than
> scenario 1 (I think readers would reasonably infer what happens in
> scenario 1 by reading what happens in scenario 2).
> ...
> And scenario 2 could be cleaned up by just showing a few of the columns
> from the trace2 output. Perhaps along the lines of:
> ...
> Reading the below scenarios, I think just showing this example is more
> than sufficient for illustrating your point.

That makes sense. I'll keep two scenarios and omit some of the output to
keep it shorter in next patch.


> I wonder, why don't we show these errors to the user? Should we
> introduce a "ret" variable and set it to (for e.g.)
> 
>     ret = error(_("failed to load bitmap header"));
> 
> or something?

Just this "load header error", I think it's unnecessary to show more
errors to uses because in "load_bitmap_header()", the function already
does, but in my patch, it's unnecessary to add "trace2_data_string()"
too, so here I will remove it (directly "goto cleanup" maybe) in
next patch.

> I'm not sure we want to dump the whole repository configuration into
> trace2 output. Is there a more convenient place to log any important
> value(s) _after_ they have been read?

I think maybe I can add a argument like "int trace" in next patch, so
the caller can decide whether to print to trace or not.

Thanks for your help, Taylor.
