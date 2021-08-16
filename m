Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBDBC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2C70601FA
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhHPVzc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhHPVzb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:55:31 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857FC061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:54:59 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a12so15505961qtb.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/SP92o31Ctet5gwaQc+4BGrAcLcbg5DFHkkuRyxpF/o=;
        b=GyIw6yLfty87wKFUADyPuo7HH5LELxyghbqfh/oInJO2xDzn+cCnZ3muijmAD5SFD4
         Type2F8+/O/1Z6Fnkt7tRri7SdnNPy5zkMBPpd1mM/6fzFzf7ic5UECEmhvWS4jrB3Ym
         d+GkdrGeFlIfQnwUlm8jsqi9q2EBEY0pEWdE/vGoUNzTEEPNcCvJ1Q55s3t8vNdxq4gC
         AaAQpPHEQKZ01rcPvtXVqHW8uuNmE0qdUTw4ewBOWixLSifLj3vQ9Cr078xr7YS8sdoa
         kE5t4amidEsH//yHAFfqWdvhsI4lL3iIqjwRinUhDjKJxqciRHYOZFqHgRUD26bXvvDv
         OBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/SP92o31Ctet5gwaQc+4BGrAcLcbg5DFHkkuRyxpF/o=;
        b=Of0f9bKXQCuBTOasKOiDcGpYQSNivO8Jqg5FLsgDlszWJPTIEQ9G8Mgvp8xks+y8nm
         JC0pU9MLND5UE9F8bC5D8hwyo76oDdLUad2weIakAYCiM9wIRLxahyY2KTKU+AdUIKDZ
         NyfDAJJcevF94Lv/meHpQT3YD5qzvk/ELgaQlVtakofJlWEzPpm3yJFjN3VTfcyilFan
         kQGsRzR9/fOAKWEWAdOaciOjWkTO1aDbrCsBvjPN7tFqM+FB6unw/WvXQORZYKEdB/yg
         YZn1XFGiY1zVi8sSWq6AR/M/AbekX1lkFSE0KX2ruaf9ONQrpjIUVMw5YJQny5SNk/if
         tGRQ==
X-Gm-Message-State: AOAM533dnaZ73HOxB3WBY2o7s1WQyWygznpU3RbNfgeV8W0saR7eV1Ir
        7qrUd5d2OpaujKD/e17g6TQ=
X-Google-Smtp-Source: ABdhPJx74NXsxOjKml8h78s6L6omS8MvgPRKdqVx08+2Sp62TIMMgJqpRCk+akhVHs85VuZO1VSMoQ==
X-Received: by 2002:a05:622a:14ce:: with SMTP id u14mr125399qtx.165.1629150898829;
        Mon, 16 Aug 2021 14:54:58 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id w19sm101130qki.21.2021.08.16.14.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 14:54:58 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:54:56 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 07/25] reftable: (de)serialization for the polymorphic
 record type.
Message-ID: <YRresPEnuv9EwBgS@carlos-mbp.lan>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
 <pull.1054.v2.git.git.1629145036.gitgitgadget@gmail.com>
 <282d8e4d817f969a3c4d882cc833dd76f4451764.1629145036.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282d8e4d817f969a3c4d882cc833dd76f4451764.1629145036.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 08:16:58PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
...
> +	union {
> +		struct {
> +			uint8_t *new_hash;
> +			uint8_t *old_hash;
> +			char *name;
> +			char *email;
> +			uint64_t time;
> +			int16_t tz_offset;
> +			char *message;
> +		} update;
> +	};

the use of an anonymous union here (which requires C11) could be made
C89 compatible without any impact AFAIK by doing instead:

diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 7985b94ae2..136ff24910 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -84,17 +84,15 @@ struct reftable_log_record {
 #define REFTABLE_NR_LOG_VALUETYPES 2
 	} value_type;
 
-	union {
-		struct {
-			uint8_t *new_hash;
-			uint8_t *old_hash;
-			char *name;
-			char *email;
-			uint64_t time;
-			int16_t tz_offset;
-			char *message;
-		} update;
-	};
+	struct {
+		uint8_t *new_hash;
+		uint8_t *old_hash;
+		char *name;
+		char *email;
+		uint64_t time;
+		int16_t tz_offset;
+		char *message;
+	} update;
 };
 
 /* returns whether 'ref' represents the deletion of a log record. */
