Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8CA320401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753163AbdF0Sof (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:44:35 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36337 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbdF0Sod (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:44:33 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so5268292pgn.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Akxs1cGwwzUoxRlobvwOD1CnP5ga6keDgT989YHwCkU=;
        b=rYRQ80LFEhRI51Zg1C/gij7gWgrHGT4diLn+Ryv8l+gnxBLCaDEJCR6znU+iysjGx9
         C0IkbM20Aw77Mldfx550LxgqkRzKY4D4nMgKDjvYxX7tuNVxNQAxrJW1EhDIcLoH9FHn
         dZGcyV4o8Axxg8qvHzaVjuQ8zf9esZM+btSPKykcyTgD7n8iC3FeJSFLK0nql97WEov1
         XB0kMbX7KaEHMm7xuDQ2OhtBFDAflNzjPY+tMqlQG8N/zKlz/209BIY5Y1aQCirz9cjr
         8qbW/7om/2YlZrTl+wP6t3bIfuX8xOQ0RYX5e5R8JoljVz9fSsX4EvNjKECYZJ3YJ8qw
         pSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Akxs1cGwwzUoxRlobvwOD1CnP5ga6keDgT989YHwCkU=;
        b=ADY3uQ5/hQ9ILSpPl3OqC83jqMcnheBP+VaXTbmWd3F+2VraIdl1ZvzxwVJB09JOnb
         FkWTk4UNxel9a9g/SvDnJ98BNKVIdXv/1+gFfnsZqmJFb/Tm0L396UjyHMebCAHUBYj5
         SgcCtc3Brmjl+8MYAWkiwiYjPPuG474jf+kFSt+7WTClvA9D8LZ5Rqt4PUJAS1+I3GHh
         uozjvBmdbSyay0gv1q7gUJ29efRo6z8j5eThFXZnBD08gqflHxmgAGAb/rtCvCPyZ8pm
         fxJGzqbLYDOS+LMwvU50V0IoWKP+GE1XVd3hFzec5Lzolkpy9A3y0fAzsrkj5MNsXzj2
         phGA==
X-Gm-Message-State: AKS2vOwF/VoUr4vR9Icr/WMAY2j3+ruOn6ie9/PPJp7b1zGbAEiC1+Un
        ytcAt26vwDmrUg==
X-Received: by 10.99.112.92 with SMTP id a28mr6736707pgn.151.1498589072835;
        Tue, 27 Jun 2017 11:44:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id t67sm7266552pfj.98.2017.06.27.11.44.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 11:44:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v7 3/6] t0021: write "OUT <size>" only on success
References: <20170627121027.99209-1-larsxschneider@gmail.com>
        <20170627121027.99209-4-larsxschneider@gmail.com>
Date:   Tue, 27 Jun 2017 11:44:31 -0700
In-Reply-To: <20170627121027.99209-4-larsxschneider@gmail.com> (Lars
        Schneider's message of "Tue, 27 Jun 2017 14:10:24 +0200")
Message-ID: <xmqqfuel1d9s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> "rot13-filter.pl" always writes "OUT <size>" to the debug log at the end
> of a response.
>
> This works without issues for the existing responses "abort", "error",
> and "success". A new response "delayed", that will be introduced in a
> subsequent patch, accepts the input without giving the filtered result
> right away. Since we actually have the data already available in our
> mock filter the debug log output would be wrong/misleading. Therefore,
> we do not write "OUT <size>" for "delayed" responses.

I still do not get why you think it makes any difference that you
are hoarding the result in the mock program.  If the filter needs to
read a prepared result from a file in t/t0021/ before responding to
a real request after it replies to "delayed", would that change the
argument above?  From Git's and the t0021-conversion.sh test's point
of view, I do not think it makes an iota of difference---it's an
implementation detail of the mock program.

I am totally lost.

Isn't the point of removing the log output from response to "delayed"
that the filter does not give the output back to Git at that point,
hence generally the size would not be available in the real-world
use case (not in the mock program)?

> To simplify the code we do not write "OUT <size>" for "abort" and
> "error" responses, too, as their size is always zero.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t0021-conversion.sh   | 6 +++---
>  t/t0021/rot13-filter.pl | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 0139b460e7..0c04d346a1 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -588,7 +588,7 @@ test_expect_success PERL 'process filter should restart after unexpected write f
>  		cat >expected.log <<-EOF &&
>  			START
>  			init handshake complete
> -			IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
> +			IN: smudge smudge-write-fail.r $SF [OK] -- [WRITE FAIL]
>  			START
>  			init handshake complete
>  			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
> @@ -634,7 +634,7 @@ test_expect_success PERL 'process filter should not be restarted if it signals a
>  		cat >expected.log <<-EOF &&
>  			START
>  			init handshake complete
> -			IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
> +			IN: smudge error.r $SE [OK] -- [ERROR]
>  			IN: smudge test.r $S [OK] -- OUT: $S . [OK]
>  			IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
>  			STOP
> @@ -673,7 +673,7 @@ test_expect_success PERL 'process filter abort stops processing of all further f
>  		cat >expected.log <<-EOF &&
>  			START
>  			init handshake complete
> -			IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
> +			IN: smudge abort.r $SA [OK] -- [ABORT]
>  			STOP
>  		EOF
>  		test_cmp_exclude_clean expected.log debug.log &&
> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index 0b943bb377..5e43faeec1 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -153,9 +153,6 @@ while (1) {
>  		die "bad command '$command'";
>  	}
>  
> -	print $debug "OUT: " . length($output) . " ";
> -	$debug->flush();
> -
>  	if ( $pathname eq "error.r" ) {
>  		print $debug "[ERROR]\n";
>  		$debug->flush();
> @@ -178,6 +175,9 @@ while (1) {
>  			die "${command} write error";
>  		}
>  
> +		print $debug "OUT: " . length($output) . " ";
> +		$debug->flush();
> +
>  		while ( length($output) > 0 ) {
>  			my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
>  			packet_bin_write($packet);
