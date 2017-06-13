Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37B11FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 19:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753968AbdFMTlC (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 15:41:02 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35738 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753774AbdFMTlB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 15:41:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id s66so8671496pfs.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 12:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AQOex+1ekflsV7ifWdOA7kRKTimJRV4bUzyKbtjaQc0=;
        b=FbJOTWnaWG1ZYVlMKawx62rBKXmahGVUhGbbXyG0By5cMs989C633sBne5wE+wlQBQ
         D5gsFSgrr0qbG1Uhx6qlHojXgFJ/HIaEDCrj/Ist2lrdMPTqUVpJaGbYwFS1N2gRaJgn
         rC6OOZVJUjiK/o1Kr42bEq4E4CpNKV2+Ekzqkm6FWBZIXhZvQdfX3hwbF9ybcMOU9i8D
         xU0NpgU8xQWTYIJ5gFreBilYKlmvPqF2+PrtJDz6jynF4IVb5itdEOwPi9MNQt/tC54Q
         adiDE1dbWVqRbAHUZFDAfhJhTieuDmFRDgmzYDrvao7LIDrBV3EJ8Of6bmCTbzZjL8hf
         9VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AQOex+1ekflsV7ifWdOA7kRKTimJRV4bUzyKbtjaQc0=;
        b=fWIVPAOuBGZQAgCJB1A9HLm3IAqvHUnxu4ZgNgAUDYLdlI42iW+jlchPKdyRETBa25
         w25j/gB/FaKqrfxkS6FJ8+fqQdw7XQhdkfLmeO+TgPx8VXDuwhJvqobnbYHi87ddTV9A
         3YATDaRCuaPjKaOYhd3x5PqSBnk8wXmlsiwRb3x+tade/U9SBVWXi3LAoBnvXRgUqSsS
         oGoHZ1MAN6hJYiAIQ7P/Fygn/G08XIcUMJYPKnwr6PCl7tm7ztoVbXVmZxZqTA0bkiQv
         mqBYUrwXh0n0VqE2C8yfP/oBgq0R6BddkcXDIDEHHs5K/i+4DiQcWUMiC38m81rUpCrq
         rA1w==
X-Gm-Message-State: AKS2vOwwSiq6xU/3Acl78ma8n0AgkG5k7JNC0NJhtKaVgEXqfqmhH76B
        nk2/sJwC49DWEQ==
X-Received: by 10.98.15.134 with SMTP id 6mr1138844pfp.32.1497382860568;
        Tue, 13 Jun 2017 12:41:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id s7sm25513073pfd.86.2017.06.13.12.40.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 12:40:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 2/5] stash: Add a test for when apply fails during stash branch
References: <20170608005535.13080-1-joel@teichroeb.net>
        <20170608005535.13080-3-joel@teichroeb.net>
Date:   Tue, 13 Jun 2017 12:40:59 -0700
In-Reply-To: <20170608005535.13080-3-joel@teichroeb.net> (Joel Teichroeb's
        message of "Wed, 7 Jun 2017 17:55:32 -0700")
Message-ID: <xmqqefun65h0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Teichroeb <joel@teichroeb.net> writes:

> If the return value of merge recurisve is not checked, the stash could end
> up being dropped even though it was not applied properly

s/recurisve/recursive/

> Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
> ---
>  t/t3903-stash.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index cc923e6335..5399fb05ca 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -656,6 +656,20 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
>  	git rev-parse stash@{0} --
>  '
>  
> +test_expect_success 'stash branch should not drop the stash if the apply fails' '
> +	git stash clear &&
> +	git reset HEAD~1 --hard &&
> +	echo foo >file &&
> +	git add file &&
> +	git commit -m initial &&

It's not quite intuitive to call a non-root commit "initial" ;-)

> +	echo bar >file &&
> +	git stash &&
> +	echo baz >file &&

OK, so 'file' has 'foo' in HEAD, 'bar' in the stash@{0}.

> +	test_when_finished "git checkout master" &&
> +	test_must_fail git stash branch new_branch stash@{0} &&

Hmph.  Do we blindly checkout new_branch out of stash@{0}^1 and
unstash, but because 'file' in the working tree is dirty, we fail to
apply the stash and stop?

This sounds like a bug to me.  Shouldn't we be staying on 'master',
and fail without even creating 'new_branch', when this happens?

In any case we should be testing what branch we are on after this
step.  What branch should we be on after "git stash branch" fails?

> +	git rev-parse stash@{0} --
> +'
> +
>  test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
>  	git stash clear &&
>  	echo 1 >subdir/subfile1 &&
