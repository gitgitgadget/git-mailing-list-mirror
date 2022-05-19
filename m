Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A0C433FE
	for <git@archiver.kernel.org>; Thu, 19 May 2022 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbiESUJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 16:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244438AbiESUJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 16:09:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946348E1AD
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j24so8667924wrb.1
        for <git@vger.kernel.org>; Thu, 19 May 2022 13:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vz1KMbTP7TRQRfchwSW8qiZKYKrgb+GZUPhnNLDoePs=;
        b=p3REGiwHZ7cX4jcwSCxeqBUss19U5FTP80XdoVB4NS9SCyXBPuLdIwBulDgiDtbxVX
         Byutz26WNAmdgropIX5N3l3W9m2x2btbvvBP41+1+G+uYC6VoE510bG7vZzX0x+W/RB3
         8YVTX5pgfz0SuGqkmZoWrSqRNhFaWbplaDMtWjNYw0WEZ7jHkt/qcshLLRIoszYzJXf5
         oAUXqEgJ5YUV+RsP4ng2rqhtWl9mZkZLHC6jRC5CeD4fqSEV5PHPhqUCCNm+Nnx7Y/1j
         RjqhrzyXESo7USly0gjVtjm8kLmfBHiSizmIPZThnSHE2VaPhG3v7gSgck+KJ1CRHFZ5
         SWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vz1KMbTP7TRQRfchwSW8qiZKYKrgb+GZUPhnNLDoePs=;
        b=daa2icsY4N0cO5+0RrRPNsUn1kPXYIt7XrdBYRlm+lNk9YX3d2cJ6w9cimP30CoMuJ
         Cb+9mmaRtyg/6zoE7avl8stEg1EhCv4vNKVLg07yzJ4GL5avBl2SEDMCWnYnuq2ULSfN
         Wv1JNZAhS/KMkrCV3nWXqrIrqjRTSa5Mx7/+TadL5oWQC9uxCgjsl6uZSS2EKrRjTS9F
         VpNjJHBUq4AfIjMA//b7AyDmocvRlt8OsLo3EeS0RpvmyWm/8kYywnVx7IVmBpLJBEE1
         be40rvRGxTFvveA9VToVMUaJN8xSe+vmn0m/aPe1RY7a9TTYMWR8WcXXHnfB9Td3N+Ys
         HqMw==
X-Gm-Message-State: AOAM531Qr69OUu3oyL8n2nzGnJ6DElsBEKwad9kr7nd5v+deyMBoZVSZ
        BaPHeoIHjeTnVqAisCUrG+Gadi+Htovrog==
X-Google-Smtp-Source: ABdhPJw4zdCOVSJC5GL7CsUQTgsN3mL7VKVy1UvYSk+EpaSm4CFcQzwR0UejhmWsb19jqgEVc4N6kA==
X-Received: by 2002:adf:e5cf:0:b0:20d:80e:1624 with SMTP id a15-20020adfe5cf000000b0020d080e1624mr5527488wrn.365.1652990971769;
        Thu, 19 May 2022 13:09:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003944821105esm428152wmb.2.2022.05.19.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 13:09:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/2] Alternate ab/valgrind-fixes fix-up
Date:   Thu, 19 May 2022 22:09:15 +0200
Message-Id: <RFC-cover-0.2-00000000000-20220519T195055Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.957.g2c13267e09b
In-Reply-To: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com>
References: <377be0e9-8a0f-4a86-0a66-3b08c0284dae@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 16 2022, Derrick Stolee wrote:

> On 5/12/2022 7:39 PM, Junio C Hamano wrote:
> [...]
> This switch statement was recently added to make it clear that
> unpack_loose_header() returns an enum value, not an int. This adds
> complications for future developers if that enum gains new values, since
> that developer would need to add a case statement to this switch for
> little real value.
>
> Instead, we can revert back to an 'if' statement, but make the enum
> explicit by using "!= ULHR_OK" instead of assuming it has the numerical
> value zero.
>
> Co-authored-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>
>  object-file.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index b5d1d12b68a..52e4ae1b5f0 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2623,12 +2623,8 @@ int read_loose_object(const char *path,
>  		goto out;
>  	}
>  
> -	switch (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> -				    NULL)) {
> -	case ULHR_OK:
> -		break;
> -	case ULHR_BAD:
> -	case ULHR_TOO_LONG:
> +	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
> +				NULL) != ULHR_OK) {
>  		error(_("unable to unpack header of %s"), path);
>  		goto out;
>  	}

This whole topic-at-large is a stylistic fix-up for a case where I
obviously got it wrong, so take this with a double grain of salt.

Re the "What's Cooking" mention of
ds/object-file-unpack-loose-header-fix: I don't mind it being merged
down at all. The below is all small potatoes.

I don't think the rationale ("adds complications for future
developers") makes sense in this case.

Let's leave aside the question of whether we exhaustively check enum
arms as in the pre-image, or check "not ok" as in the post-image.

Surely we can agree that whatever pattern is preferred we're better
off consistently picking one or the other?

I think this proposed change would make more sense and be in line with
its commit message if it also proposed this:
	
	diff --git a/streaming.c b/streaming.c
	index fe54665d86e..bb4ed198463 100644
	--- a/streaming.c
	+++ b/streaming.c
	@@ -230,15 +230,10 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
	 	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
	 	if (!st->u.loose.mapped)
	 		return -1;
	-	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
	-				    st->u.loose.mapsize, st->u.loose.hdr,
	-				    sizeof(st->u.loose.hdr), NULL)) {
	-	case ULHR_OK:
	-		break;
	-	case ULHR_BAD:
	-	case ULHR_TOO_LONG:
	+	if (unpack_loose_header(&st->z, st->u.loose.mapped,
	+				st->u.loose.mapsize, st->u.loose.hdr,
	+				sizeof(st->u.loose.hdr), NULL) != ULHR_OK)
	 		goto error;
	-	}
	 	if (parse_loose_header(st->u.loose.hdr, &oi) < 0 || *type < 0)
	 		goto error;

I.e. now we've converted the 2/3 callers of the API that only cared
about "not OK", there's a third one that cares about all the enum arms
currently, so that one remains a "switch".

The reason I think the rationale doesn't make sense is because of this
inconsistency. I.e. if we suppose a developer adds another enum value,
they'll then discover those three callers.

Surely whatever our preference for how to handle those 2/3 callers
it's less complicated if they don't use different patterns for no
obvious reason.

But anyway. Looking a bit deeper at this code again I think these two
patches are where we'd eventually want to head with this API. I.e. I
think the whole business of making this a tri-state return was
premature on my part.

After this RFC unpack_loose_header() is again a function that returns
a negative value on error, and the enum is gone. As noted in 2/2
there's a slight trade-off there, which I think is for the better,
both in terms of API simplicity, and in the new "error" output we'll
omit in these obscure cases. I.e.:

	-				error: header for $bogus_long_sha1 too long, exceeds 32 bytes
	+				error: header too long, exceeds 32 bytes
	+				error: unable to unpack $bogus_long_sha1 header

This whole "switch" complexity was because the old error message
wanted to note the OID in the "header too long" message.

Again, I'm perfectly fine with ds/object-file-unpack-loose-header-fix
advancing to "next", I can rebase this on top, or drop it depending on
the consensus about whether it's worthwile. I did want to un-block
that topic one way or the other, so to the extent that it was waiting
on my feedback...

Ævar Arnfjörð Bjarmason (2):
  object-file API: fix obscure unpack_loose_header() return
  object-file API: have unpack_loose_header() return "int" again

 cache.h             | 25 +++++-------------------
 object-file.c       | 46 +++++++++++++++++----------------------------
 streaming.c         | 11 +++--------
 t/t1006-cat-file.sh |  6 ++++--
 4 files changed, 29 insertions(+), 59 deletions(-)

-- 
2.36.1.957.g2c13267e09b

