Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F2C55186
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A2422076C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 01:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNPQunEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDWBOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWBOs (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 21:14:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515FEC03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:14:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so2065546pfb.10
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IxUmSmDZttuyU9XbElC1SYaTAkoy6LNStOYh9UMD1xY=;
        b=ZNPQunEbpfDXzfnpgE4UI0wt09TExTBx6zLJ4RyQzPKd/kS9xG4Vq/MvbaB1H+82ix
         JCD7PZ9u5c+HS5BV7dWfBmclX1X/AneSdbkO7hTFWk2q5+eQ1o+MqSpvnQ5AeRkFQ5tP
         pcBaI1LNiyuQCpPUs5JnEbCuCkhQFZwsRq9mGH4Z/QLPS/qXWQmt2+k009GJFxGFNSOJ
         GGXJrSUwJwpe9oUgZI7vBC4Ulx1LrH4vlaYjPTcCXiUUdHIPkJRS1ThbkLLK0KXHtYBq
         1l6nYK7mixrgQaNfalp5Z7qMW7VYzk3OhjqdSims2pa1U1+GLbHEgchJC4wpDsMaCbfs
         5p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IxUmSmDZttuyU9XbElC1SYaTAkoy6LNStOYh9UMD1xY=;
        b=W97xmBBIPYgKSTO8/dm7SI61gDjsh5bWw0tBppV1KxURDo4orN9H3l7vc7/TP2GIG5
         pGcfcwa/prs0u5srBo+AmJo9toi/hAUDMEZG3G1CTMWNU9oFewZp1q7yXxpVKboY+MwT
         n6YTrauXSYWX/J8Puza+rh+u0wnx7cVHmY1rP4Sicu9qxNvWpTneGfhLXYIrhWSfy1hR
         EhWRkb0Ct4Nhan35xEmRaAsrQ8CiOxNc4eRQDPJ0BInCP9P2AVs8gkcy9cyb9vyeeJ8o
         SZCKZCsIglp40OC1fBJmlY+2c/O3V7PioYg6HCfBiUYuw7Q1+6R6oF7OLgeZXOfRm309
         pCeQ==
X-Gm-Message-State: AGi0PubBhG/RBKIyaVzxxrmnYArFMPiF4WZPWlhxEU8JZufi606hbW/v
        lv10J9cH2Wfbzwf8kY79ofENNHR7
X-Google-Smtp-Source: APiQypL2jN+/9i9CenNKANJwolzIg+Y6iMFUC2e1G/QfPJJg4fCPUxmq0cZkI+CmE48/i6BvKaXf8A==
X-Received: by 2002:a63:ed02:: with SMTP id d2mr1689658pgi.38.1587604487580;
        Wed, 22 Apr 2020 18:14:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id l37sm458921pje.12.2020.04.22.18.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 18:14:46 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:14:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        newren@gmail.com
Subject: Re: [PATCH v2 1/2] t5537: use test_write_lines, indented heredocs
 for readability
Message-ID: <20200423011444.GG140314@google.com>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Taylor Blau wrote:

> A number of spots in t5537 use the non-indented heredoc '<<EOF' when
> they would benefit from instead using '<<-EOF' or simply
> test_write_lines.
>
> In preparation for adding new tests in a good style and being consistent
> with the surrounding code, update the existing tests to improve their
> readability.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/t5537-fetch-shallow.sh | 70 +++++++++++-----------------------------
>  1 file changed, 18 insertions(+), 52 deletions(-)

Sounds like a good idea.  Some nitpicks --- please don't act on them
all, but only the ones that seem appropriate to you:

[...]
> +++ b/t/t5537-fetch-shallow.sh
> @@ -25,10 +25,7 @@ test_expect_success 'setup' '
>  test_expect_success 'setup shallow clone' '
>  	git clone --no-local --depth=2 .git shallow &&
>  	git --git-dir=shallow/.git log --format=%s >actual &&
> -	cat <<EOF >expect &&
> -4
> -3
> -EOF
> +	test_write_lines 4 3 >expect &&
>  	test_cmp expect actual
>  '

Nice.

[...]
> @@ -133,14 +110,12 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
[...]
> -	cat <<EOF >expect &&
> -no-shallow
> -EOF
> +	cat <<-EOF >expect &&
> +	no-shallow
> +	EOF

Can this use "echo"?  Or if using cat, please quote the EOF in <<-EOF
so the reader doesn't have to check for $substitutions in the body:

		cat >expect <<-\EOF &&

[...]
> @@ -158,21 +133,15 @@ test_expect_success 'fetch --update-shallow' '
>  	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
>  	git fsck &&
>  	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
> -	cat <<EOF >expect.refs &&
> -refs/remotes/shallow/master
> -refs/remotes/shallow/no-shallow
> -refs/tags/heavy-tag
> -refs/tags/light-tag
> -EOF
> +	cat <<-EOF >expect.refs &&

Likewise (missing \ before EOF).

A few more nits, that probably don't belong in the same patch:

- the code in subshells would be more readable if indented
- existing <<-EOF here blocks should \quote the EOF
- the resulting history would be more realistic if it uses test_tick
  before running "git commit".  Or perhaps this can use the
  test_commit helper to handle that
- should use test_must_fail in preference to ! git
- might be simpler if http tests go in a different file

Thanks,
Jonathan
