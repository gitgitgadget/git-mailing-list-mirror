Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E414A205C9
	for <e@80x24.org>; Sun,  8 Jan 2017 20:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbdAHUpT (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 15:45:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38230 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754473AbdAHUpS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 15:45:18 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 57037205C9;
        Sun,  8 Jan 2017 20:45:17 +0000 (UTC)
Date:   Sun, 8 Jan 2017 20:45:17 +0000
From:   Eric Wong <e@80x24.org>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
Message-ID: <20170108204517.GA13779@starla>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170108191736.47359-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com wrote:
> +++ b/t/t0021/rot13-filter.pl

> +$DELAY{'test-delay1.r'} = 1;
> +$DELAY{'test-delay3.r'} = 3;
> 
>  open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";
> 
> @@ -166,6 +176,15 @@ while (1) {
>  		packet_txt_write("status=abort");
>  		packet_flush();
>  	}
> +	elsif ( $command eq "smudge" and
> +		    exists $DELAY{$pathname} and
> +		    $DELAY{$pathname} gt 0 ) {

Use '>' for numeric comparisons.  'gt' is for strings (man perlop)

Sidenote, staying <= 80 columns for the rest of the changes is
strongly preferred, some of us need giant fonts.  I think what
Torsten said about introducing a new *_internal function can
also help with that.

Thanks.
