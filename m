Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463E11F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfJ1McT (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:32:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52459 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfJ1McT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:32:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id p21so9258986wmg.2
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m4IzCH2m1H4fFa97qaZUKq+4hwIax2Y2GKK24HikG90=;
        b=VI9zKoHBWzU5BklZO+eb72ttfh566kyh7JPTILZuC+ttaR8zyi4NT4HIEdyhSQ9X6c
         9snncOz4708Q9NlPRtZZA9dTIQF7qJQ0ykQyid6bT+TkKS33WyAeo8b4rS0Gvd4cMj3Z
         wqj2PH8t380obforkkUPI7WM/gY3zEjk/n9F18sWaQlDBSR74S1poV4222DkVW/CsYHD
         sizrM819Lh8lzCbdfxDm1gqg/Knarct0/8Vc/ctVOEDH7PQpK5MPtgkkn7WygRSCne0n
         0qvGmdwr4fs4kkV38RUJ1o8hOPKROxQHNTXBhjAmWZlNA+2UOtygAot4enAfkaUeejrY
         anlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m4IzCH2m1H4fFa97qaZUKq+4hwIax2Y2GKK24HikG90=;
        b=WkHn9BspqR2szHFXRU2rw+1iyax50fAQjjgPZpEiGhLQOK2iQd0XoyiEYKp8xRiVYB
         tH4U4sHEZ1m6PZSEpGQ4kFanNSOMl+w/2niIq4fnkzn/42uLvDKTGRaDM2YGWHApZ3x6
         indaTP7UJWc4cuariyH3apg77M7BXeftCWLDIPEoHSUswoqRK6voeKGW4eCZLwnlua29
         Sf11b9yCa8OBtuZbsSvwW7+T1JcbE5nt2j2KgyDnDht/wdcuQMS1knBlfPX667PnwHNa
         3XFcKD9WwYNOhU/aSrNLukvFDosWhiwqtX2E+2EItNYclTD1P7aG+UuTfanHKnoIGX8p
         shLg==
X-Gm-Message-State: APjAAAX5YCLVpdcTwEum6dhayYwHnLJgM/dV+se9fBH1TPCAw4yWqFNl
        n42jTbuepQbzkRyAsxsOvWA=
X-Google-Smtp-Source: APXvYqzts3XUq3MOaNfRwfI91xrkhKLNvT11S1u6Ct8p13nBjpVz5hPJW7OgUf2qKLETpDEtuKFOqQ==
X-Received: by 2002:a1c:46:: with SMTP id 67mr6201419wma.51.1572265937506;
        Mon, 28 Oct 2019 05:32:17 -0700 (PDT)
Received: from szeder.dev (x4db30d31.dyn.telefonica.de. [77.179.13.49])
        by smtp.gmail.com with ESMTPSA id p21sm11099422wmc.25.2019.10.28.05.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:32:16 -0700 (PDT)
Date:   Mon, 28 Oct 2019 13:32:14 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] git_path(): handle `.lock` files correctly
Message-ID: <20191028123214.GT4348@szeder.dev>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
 <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
 <8b1f4f089a6d4a2293507a1a77668c828598e84f.1571694882.git.gitgitgadget@gmail.com>
 <20191022160105.GE4348@szeder.dev>
 <nycvar.QRO.7.76.6.1910281225260.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910281225260.46@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 01:01:49PM +0100, Johannes Schindelin wrote:
> > > @@ -349,10 +349,16 @@ static int check_common(const char *unmatched, void *value, void *baton)
> > >  static void update_common_dir(struct strbuf *buf, int git_dir_len,
> > >  			      const char *common_dir)
> > >  {
> > > -	char *base = buf->buf + git_dir_len;
> > > +	char *base = buf->buf + git_dir_len, *base2 = NULL;
> > > +
> > > +	if (ends_with(base, ".lock"))
> > > +		base = base2 = xstrndup(base, strlen(base) - 5);
> >
> > Hm, this adds the magic number 5 and calls strlen(base) twice, because
> > ends_with() calls strip_suffix(), which calls strlen().  Calling
> > strip_suffix() directly would allow us to avoid the magic number and
> > the second strlen():
> >
> >   size_t len;
> >   if (strip_suffix(base, ".lock", &len))
> >           base = base2 = xstrndup(base, len);
> 
> Actually, we should probably avoid the extra allocation. Earlier, I was
> concerned about multi-threading issues when attempting to modify the
> `strbuf`. But then, we modify that `strbuf` a couple of lines later
> anyway,

Do we?  You're right, we do indeed, because in replace_dir(buf, ...)
we call strbuf_splice(buf, ...).
OK, then your suggestion below is even better.

> so my fears were totally unfounded. Therefore, my current
> version reads like this:
> 
> -- snip --
> 	int has_lock_suffix = strbuf_strip_suffix(buf, LOCK_SUFFIX);
> 
> 	init_common_trie();
> 	if (trie_find(&common_trie, base, check_common, NULL) > 0)
> 		replace_dir(buf, git_dir_len, common_dir);
> 
> 	if (has_lock_suffix)
> 		strbuf_addstr(buf, LOCK_SUFFIX);
> -- snap --
