Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 134431FC44
	for <e@80x24.org>; Tue,  9 May 2017 03:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdEIDea (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 23:34:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34149 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbdEIDe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 23:34:29 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so6354350pfk.1
        for <git@vger.kernel.org>; Mon, 08 May 2017 20:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tk1pSEMg8zAWNh/X0DpqqcikYF0FipxDS8Ox2i98ve8=;
        b=sXUjlqpexYury/2DEKfmK9hNrCceFFcS+keUY/fQIb3ByZ4r8749in+6tgB0qqQMII
         bKgc8EdDnAwML+4in7b4a7EXW4B5agz/b5YOZfXkuSn/abdAxXYlqStPDhpk+DLteJHT
         aZlU4Gsr5IN0pxfcPPFj5AUzhcFYgsm7ov3CtjRf9THiBHA35CNNqiOFvKGk3jA1P9ux
         LaS4URUnHomBf1VIOLSFdZAth9/vHxSjvpQGDUDwGPPLtAiBF1L7/kUAbtf5ZTpecpVE
         n+Fj04/PoIqfpNyVPvaZHH/83PTUtGrHvVrv7BCsHDz6cCjgXJ9ZKGMfTf7HwOghPQf5
         6KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tk1pSEMg8zAWNh/X0DpqqcikYF0FipxDS8Ox2i98ve8=;
        b=sMO+vWPA4/snaXflScBqaSSA4krscrjvViQ6mIZkqHVekfMSHvxAFig1tLWCt8R8UJ
         ajaS17YvwZ8RhJG7lJwJk8q11ScK5DwnkE0gjmuzW4jDFKlk3kIyyNYlOvaobBc8muUx
         zKNsGNWq9+XYfLX+8N4w7JexsHhYoZYdDGKB/JlOMGnRylJznACezXYNP2IuVycZJZxH
         1jc+s5vO13mCrMY9mSxfoaeGN6DXFM8255Vh3ZfepKvXVbnfOr/I/3gq1wUO4jnPegGj
         i6k1/pgaQjRAiDx5GBwYMJ9p+huxlDkOFspBxMvwdK6qmp6TwHQ8DofGi9AUaBHd9zBW
         njiA==
X-Gm-Message-State: AODbwcCHpsSvSky2/9cmX5ZvYBVazp7eWUkC39scVkgoACKZwl6UNNIO
        g3iokG+ux74iZAnmKMuqRQ==
X-Received: by 10.99.173.12 with SMTP id g12mr1772127pgf.225.1494300868676;
        Mon, 08 May 2017 20:34:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id l186sm21137919pgd.42.2017.05.08.20.34.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 20:34:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 2/2] receive-pack: verify push options in cert
References: <cover.1494279020.git.jonathantanmy@google.com>
        <cover.1494027001.git.jonathantanmy@google.com>
        <cover.1494279020.git.jonathantanmy@google.com>
        <cc21a5566dcf10e4683465ac253c76370b7b6a7f.1494279020.git.jonathantanmy@google.com>
Date:   Tue, 09 May 2017 12:34:27 +0900
In-Reply-To: <cc21a5566dcf10e4683465ac253c76370b7b6a7f.1494279020.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 8 May 2017 14:33:51 -0700")
Message-ID: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	# Tweak the push output to make the push option outside the cert
> +	# different, then replay it on a fresh dst, checking that ff is not
> +	# deleted.
> +	sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&

This is not portable.  Didn't you get an error from the lint
checker?

The attached may not be enough if "push" is a binary file, though,
in which case perl may be your friend ;-)

 t/t5534-push-signed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 0ef6f66b5d..effe769688 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -152,11 +152,11 @@ test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 	# Tweak the push output to make the push option outside the cert
 	# different, then replay it on a fresh dst, checking that ff is not
 	# deleted.
-	sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
+	sed -e "s/\\([^ ]\\)bar/\\1baz/" push >push.tweak &&
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
 	git -C dst config receive.advertisepushoptions 1 &&
-	git receive-pack dst <push >out &&
+	git receive-pack dst <push.tweak >out &&
 	git -C dst rev-parse ff &&
 	grep "inconsistent push options" out
 '


