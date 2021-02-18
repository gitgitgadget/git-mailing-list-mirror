Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A544C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3374564DFF
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 16:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbhBRQxr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 11:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhBROjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 09:39:53 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601EDC0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:38:47 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id q8so977933qvx.11
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 06:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4jkLmQqUvp2wVbDop2nSjRdn/jDJpqdRnblfJ2o+Vg=;
        b=g71pOOParExmioooYNLQcAriUFQJZCnhwDRvm6dfO8nt9rpl3oMDg8E3sCVAa2JTCT
         GqamXlFItPtkdUxgl7sS/IVN9Da7A6pllHGIwCqYG8V2yT7hYP7pQ8t+NOdSegk8FMzK
         uN1KFUSSIIAtZJH7fIu6w4pr3ldHMr8qvYV1xVRK9UgFH1CtdZp7jGn/jR6lvDEWONm8
         OUodGTQLTE2i5jnhQMGsMk163256hX1mBXIGnyMT0kju5qLk/YEji/nPsfCLLaziYmcN
         MgwFcJP02LscHADBb5eeigZGqNqSFF7nlTabn3y6nzq1Y/VXy+GzupWaMeq3HF0ua7fh
         Bqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4jkLmQqUvp2wVbDop2nSjRdn/jDJpqdRnblfJ2o+Vg=;
        b=NDLrGHv3QpjPwNqL6WYf4VqsJfF54clQnsFdgZqxvwAl34R/GhmBR6Q7hfajYFPR9Y
         9mugpm4mQ9j46G7sFMPKzsm+BLkDcd5GtGtA1W8+rWiTizrYzo6LEqN7uCU94eGzWs61
         gFgNhl/Jltj5RFdCNum8KzxiGrdosZfOsgA5b5XUBjV1ToKoy6aDzRIgq3nkoN+eAqAq
         V186CxIxuG5ee6iGhJgw5AFE3eyZsus8KfuV3B4XqEiBResiPHTPoJ+Z7GOBPb/SNfeL
         ev9gMaObePY3jj6gWbUzChBVRNPPsuvoQgvJhBLcsqec5wclg677Dk6wEdSn4vJf2tWT
         DDYQ==
X-Gm-Message-State: AOAM531lFS8iDkBYelTjGHBOzgk5HhQcHw6wh3wVBb3qi80IejHK5ePz
        rJhRjHdP+6wp04ZkYDC3drPk9w==
X-Google-Smtp-Source: ABdhPJxz7bAMrDPGCXsDlLl1KC+o+ku76ayqJT94vcWREFRYcm/iQC/jKJrF1OXtw9++R+sbSkGSkw==
X-Received: by 2002:a0c:a8cf:: with SMTP id h15mr4360845qvc.20.1613659126651;
        Thu, 18 Feb 2021 06:38:46 -0800 (PST)
Received: from mango.meuintelbras.local ([177.32.118.149])
        by smtp.gmail.com with ESMTPSA id u126sm3958491qkc.107.2021.02.18.06.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 06:38:45 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, newren@gmail.com, stolee@gmail.com
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
Date:   Thu, 18 Feb 2021 11:38:37 -0300
Message-Id: <20210218143837.16527-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
References: <CAHd-oW6b0n7ezA-C8NuUOkHUSfM8TFLmkJtwwSRv7FRtbOWjsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 18, 2021 at 12:07 AM Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
>
> On Wed, Feb 17, 2021 at 8:01 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Matheus Tavares <matheus.bernardino@usp.br> writes:
> > >
> > > +test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
> > > +     setup_sparse_entry &&
> > > +     test-tool chmtime -60 sparse_entry &&
> > > +     git add --refresh sparse_entry &&
> > > +
> > > +     # We must unset the SKIP_WORKTREE bit, otherwise
> > > +     # git diff-files would skip examining the file
> > > +     git update-index --no-skip-worktree sparse_entry &&
> > > +
> > > +     echo sparse_entry >expected &&
> > > +     git diff-files --name-only sparse_entry >actual &&
> > > +     test_cmp actual expected
> >
> > Hmph, I am not sure what we are testing at this point.  One way to
> > make the final diff-files step show sparse_entry would be for "git
> > add --refresh" to be a no-op, in which case, the cached stat
> > information in the index would be different in mtime from the path
> > in the working tree.  But "update-index --no-skip-worktree" may be
> > buggy and further change or invalidate the cached stat information
> > to cause diff-files to report that the path may be different.
>
> Oh, that is a problem... We could use `git ls-files --debug` and
> directly compare the mtime field. But the ls-files doc says that
> --debug format may change at any time... Any other idea?

Or maybe we could use a test helper for this? Something like:

-- >8 --
#include "test-tool.h"
#include "cache.h"

int cmd__cached_mtime(int argc, const char **argv)
{
	int i;

	setup_git_directory();
	if (read_cache() < 0)
		die("could not read the index");

	for (i = 1; i < argc; i++) {
		const struct stat_data *sd;
		int pos = cache_name_pos(argv[i], strlen(argv[i]));

		if (pos < 0) {
			pos = -pos-1;
			if (pos < active_nr && !strcmp(active_cache[pos]->name, argv[i]))
				die("'%s' is unmerged", argv[i]);
			else
				die("'%s' is not in the index", argv[i]);
		}

		sd = &active_cache[pos]->ce_stat_data;
		printf("%s %u:%u\n", argv[i], sd->sd_mtime.sec, sd->sd_mtime.nsec);
	}

	discard_cache();
	return 0;
}
-- >8 --

Then, the test would become:

	setup_sparse_entry &&
	test-tool cached_mtime sparse_entry >before &&
	test-tool chmtime -60 sparse_entry &&
	git add --refresh sparse_entry &&
	test-tool cached_mtime sparse_entry >after &&
	test_cmp before after

What do you think?
