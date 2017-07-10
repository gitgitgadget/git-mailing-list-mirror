Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C9A20357
	for <e@80x24.org>; Mon, 10 Jul 2017 17:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbdGJRSg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 13:18:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36605 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932480AbdGJRSe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 13:18:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id z6so15387263pfk.3
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 10:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=M2m8Q1QTMOzWmECqLO8AgVZByX1Jt7HeDfUHZvaXQco=;
        b=Cp+AfNpDpV/TC2czadDxTW3I8LJ2lFUfPXO/d3MukVrBPGpx402IdL/thd3XX8fwIF
         qAzyh3SUh2iBSppSKCbHP1hzlx4LDFGtVscqsmDwePZ0ENna0E2y63NnPEP9lEj313c3
         pJ38RtJyOZEes4UtZTEZND2MShp3+YqJM8v75RibMm+HePIpmKe2v8NLYJ0ivNPlIzc7
         qLUjJVnngNPXRQSnh231PcmPNOiMJeF2pREdXi6Z5XbA+7ozg9aL92W2Rij6sLitskml
         7P2K563pez582EFYUWyimMBbXk3/pgiRwW21AidEPPk6khWXMsTa46hOTDo1Ijy4Stsx
         CbJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=M2m8Q1QTMOzWmECqLO8AgVZByX1Jt7HeDfUHZvaXQco=;
        b=NgiYg5jIZEFfeDkPQ9jp/a6JN7oKRjUN5as2JgDhK5fqdwbhVX+9iMxlhdngsf36NB
         8fmy05DOKY8bVfV0YBkrg6xfNJnFu2bp6YP5ADhu5XisSc+6hWFQIsA8uURxbv7pUKZj
         5biiJgQCQ2gOg9WgIY79McHx+5YcxRie80whq0g28RDW0ZDyUa6mamNSieZ/jFf/ZfFN
         7JvHmpi7kzLEDZOhbiYeeaK7CEXtIV+hV74EVx9uj+w80WmGS8iPCAIjT/SIVH8ZK9oN
         UCGjDvo3d/kLcCYgkni4SiZm4xCrk9SDH397D/AF38w2tToRqe4Psd6Ca5pdVRgwaTJb
         IttQ==
X-Gm-Message-State: AIVw110dk+FbiayniIMAcRGTH7rgVIb65AY9MdysP7CwZ7HrDpjnhqZm
        3cHBCGb3NndU+xsN6F0=
X-Received: by 10.84.238.133 with SMTP id v5mr18896527plk.162.1499707108160;
        Mon, 10 Jul 2017 10:18:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id 66sm20574456pgh.59.2017.07.10.10.18.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 10:18:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] test-lib: turn on ASan abort_on_error by default
References: <20170710132418.d6bvzxwvbejretb4@sigill.intra.peff.net>
        <20170710132438.euiamhjgqzkzkefg@sigill.intra.peff.net>
Date:   Mon, 10 Jul 2017 10:18:26 -0700
In-Reply-To: <20170710132438.euiamhjgqzkzkefg@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 10 Jul 2017 09:24:39 -0400")
Message-ID: <xmqqinj06wil.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> By default, ASan will exit with code 1 when it sees an
> error. This means we'll notice a problem when we expected
> git to succeed, but not in a test_must_fail block.
>
> Let's ask it to actually raise SIGABRT instead. That will
> give us a signal death that test_must_fail will notice. As a
> bonus, it may also leave a coredump, which can be handy for
> digging into a failure.

Well thought-out.  Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 961194a50..1b6e53f78 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -41,7 +41,7 @@ GIT_BUILD_DIR="$TEST_DIRECTORY"/..
>  # the noise level. This needs to happen at the start of the script,
>  # before we even do our "did we build git yet" check (since we don't
>  # want that one to complain to stderr).
> -: ${ASAN_OPTIONS=detect_leaks=0}
> +: ${ASAN_OPTIONS=detect_leaks=0:abort_on_error=1}
>  export ASAN_OPTIONS
>  
>  ################################################################
