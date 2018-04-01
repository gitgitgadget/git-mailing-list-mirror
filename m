Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849DF1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 05:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750862AbeDAFAb (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 01:00:31 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37835 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeDAFAa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 01:00:30 -0400
Received: by mail-wm0-f54.google.com with SMTP id r131so22133364wmb.2
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uLDiUwtA6e4OlbRVQ31DG07SHecmoJl5RXQEl8L+uek=;
        b=bbxjQhvs7z134rHW8FyvfT44BWkcnI+yGAvaOkbIZlWw7gTOLgVW8eqCvHuiAGsFos
         vR78QozQ6J2aF5WKUeaEVagFxaadzHN2uHc/CaRN8l98xsId7Sfo/cvH2B5HCCyaJxJx
         29kudkdi/U23g7FrxTmun39Ejb3702vsCgX29TMIgk96tN14qmaFNEPtCjEdBf3HqEdb
         8qwSdkjcEl1JwmxTeVaxwTm1+eUzL0F9iKVCGFy6cPw5HI82HA2WT44bQ8hnSnNSxpfv
         CHi0ziJXM2LxHhBeyJILdqSS/g/YB27XBUZdKV0ruBRIZ+U0ooPlKvdheyjZT4aiz5ls
         r7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uLDiUwtA6e4OlbRVQ31DG07SHecmoJl5RXQEl8L+uek=;
        b=OLk/cGPYxGyjTyol9k+U9TRhdIZNPlonFX8lW8v1PlJ9KDytGZq3uNzyANFaGvsf60
         aM31pZmoLNZTiyUGqWJzRCA33fzH2tNYMOBOUqqalpNGyPvDpeRm9r4el4931zeQuwVf
         ZlNYQbCa02t/R1JduAOXuA7qKU/vQ6nVXxWMuJdpG+O+CqjR74ulRmQfI8BWZ8Qvchkw
         up8OmA+UUjyI541Jc8sIXEsgrK+CwwH2Xs2w6cax9bxX0mrwI0EDXlfKdf8uEba0r/cr
         RW5t4ExGoaFYRBHLSV8EjwdKuMwcEcTSocSK9D+SUV8t4r0/iUlmdDBS192qwE3qOsZn
         uZOQ==
X-Gm-Message-State: AElRT7HDU58i3vrpHXRifldKZu3X7XBkH6Hnn7tdGnLGhqZFIFw0UA5s
        M0B839hpV38N0mpbUnKaOUo=
X-Google-Smtp-Source: AIpwx488OTg5wPq8YAPePNG8A6DE6HlE10DTceBeLiZjqRDiohrj+HbuZVSkwpi+83qZQERfGj0m4g==
X-Received: by 10.28.10.195 with SMTP id 186mr5877275wmk.136.1522558828662;
        Sat, 31 Mar 2018 22:00:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p4sm9066369wma.5.2018.03.31.22.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 22:00:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] add -p: fix 2.17.0-rc* regression due to moved code
References: <20180331123605.30076-1-avarab@gmail.com>
        <20180331125058.4506-1-avarab@gmail.com>
Date:   Sat, 31 Mar 2018 22:00:26 -0700
In-Reply-To: <20180331125058.4506-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 31 Mar 2018 12:50:58 +0000")
Message-ID: <xmqqbmf31pxx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index d190469cd8..c1f52e457f 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -1561,13 +1561,13 @@ sub patch_update_file {
>  			elsif ($line =~ m|^/(.*)|) {
>  				my $regex = $1;
>  				unless ($other =~ m|/|) {
>  					error_msg __("No other hunks to search\n");
>  					next;
>  				}
> -				if ($1 eq "") {
> +				if ($regex eq "") {
>  					print colored $prompt_color, __("search for regex? ");

Ah.  That "unless ... { }" thing is what was inserted recently, and
the patch is an obvious fix once the problem is pointed out.  Thanks
for a careful reading.

It makes me wonder what the original author, who already captured $1
in $regex, was thinking when he wrote the comparison with $1 there,
but that is OK---ithappend long time ago in early 2009.

Will apply.  Thanks.

>  					$regex = <STDIN>;
>  					if (defined $regex) {
>  						chomp $regex;
>  					}
>  				}
