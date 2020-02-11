Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88346C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1AD20714
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 23:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxVuaYee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBKXBc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:01:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41764 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbgBKXBc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 18:01:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so14658041wrw.8
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vcy4qJDaNm8ALtHHQkommgqSCygoQLKIyr2PEdF/U68=;
        b=mxVuaYeeubrSy+4VwE5/Ty9lVSDC3wLMOXLzL1JZlRuLVSoUkHk4ll97vpLNZCBfVm
         /zAzFtzFG1rBgthC36z1FLJ2Ng8ek7WbjdiGM3DczEdmVSx9TExIGvl0rnZiCi6h44K9
         HopnJn8Ukj5jxYLcmBfkWq+i1HEmHYqFa2QrnakZ4/a+TqoNd6+fynIPftTo4BnNIAqn
         FymUDk4vTTPCal2XuqHmPjwMkaIwnk44aZAarRVrA2jquVNT9egnTSYriOIwAryVxFaG
         WGGFrnoYahxxY0JCX/0QNwmUGaVtuknUl5ctRad7Bl7WocF/Fee3t5ZJ1HgvhUQiVbve
         n9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vcy4qJDaNm8ALtHHQkommgqSCygoQLKIyr2PEdF/U68=;
        b=XLPn5Pst2u+zXYrhN6ZTZMn1r9soXIbLBc4nCeDA0LnnEWioPR4jU3cgrmGujKI999
         RwYEUT8fDKgLZqrNuOT6e/Fqm2B29/PnyVL33Yimd6TGB5s3pMHctgYuDa1aiu9JJoRE
         0UxMT7n1jStWzptEeqp5DNgVjz+mmRctggr91QG1ukll7hkBNOx8s/TjYjcSf1Gx0Ngd
         vNCcRGdeOHCHGw6YEKqhzcQVB4FBcOCODbEQa+94NeP7i1qMFi+u9pLs7NtgqdMIlWLJ
         mSofHkUAdJ3XckVfkkzzpwRwJpEhrzS1dMrv4yylZeTXc7vokdHEURDElcs7HX050h7Y
         ho+g==
X-Gm-Message-State: APjAAAX//eHc18V1ieXjS71CHj8Ehug4BIosDBdWNHdtLRCiDZgfE7I1
        b8GQMj3TL5LWe2UGNyHl1o9qKuiJqGvAUoJyc3ejHhix
X-Google-Smtp-Source: APXvYqx4sJ36nRm+Pzz7zbrEj2gtPbNJZHdbIoV8w9vN5B9zRLr7rIEDnyDhRg3hF/iRsCdxNNdP4uHHLy1ihMaQrOo=
X-Received: by 2002:a5d:5403:: with SMTP id g3mr11660712wrv.302.1581462090692;
 Tue, 11 Feb 2020 15:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20200121165623.151880-1-shawarmakarma@gmail.com>
 <20200211193625.231492-1-gitster@pobox.com> <20200211193625.231492-2-gitster@pobox.com>
 <20200211194640.GA2127797@coredump.intra.peff.net>
In-Reply-To: <20200211194640.GA2127797@coredump.intra.peff.net>
From:   Eyal Soha <shawarmakarma@gmail.com>
Date:   Tue, 11 Feb 2020 18:01:19 -0500
Message-ID: <CANsz78Jv6VZPx+XeFTnRTFofrVj-jrmx2-rFtXJpbfM3XMTS+w@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] color.c: refactor color_output arguments
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Had I gotten any of those constants wrong, unit tests would fail.
It's probably on purpose that those values were chosen to be the same
but for us it's just a happy coincidence.

I also have just one value for COLOR_BACKGROUND_OFFSET, because for
both the ANSI colors and the AIXTERM, the difference is 10.  Just
another happy coincidence.  I could have split those into two
constants like with RGB vs 256.

None of those values are likely to ever change.  I think that the most
important feature of the constants is that they are descriptive.

Thanks for your help.

Eyal

On Tue, Feb 11, 2020 at 2:46 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Feb 11, 2020 at 11:36:23AM -0800, Junio C Hamano wrote:
>
> > +enum {
> > +     COLOR_BACKGROUND_OFFSET = 10,
> > +     COLOR_FOREGROUND_ANSI = 30,
> > +     COLOR_FOREGROUND_RGB = 38,
> > +     COLOR_FOREGROUND_256 = 38,
> > +};
>
> I had to double-check to make sure the duplication in the last two
> wasn't a bug. It's correct, because "38" here is really "set the
> foreground color", and they're followed by more magic for "256" or
> "RGB".
>
> So really this could be a single COLOR_FOREGROUND_EXTENDED or similar
> that gets used in both places. But I don't know that it really matters
> that much.
>
> Other than that nitpick, the patches all looked OK to me. Thanks for
> tying up this loose end.
>
> -Peff
