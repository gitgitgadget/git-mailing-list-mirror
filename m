Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB981CD2F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127085; cv=none; b=tBzVWrIj0dSyMsnnJH68DfyQEvCuhCK/WcI5P4cC122h51dXdDMMeEaAdCdQvs4UxntB3pG9xxpLgDtrAfnA4TB2wSIGl3QOIhDYqWlk22v0uzFMIatkGXR/jZiPkCUAn4cL75O6eEnfwo6Ltm+CHC/SRcZwAMkpjgkCth+o1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127085; c=relaxed/simple;
	bh=+oS3/SY9fEJqPbn8ogDisthtp1CaZwOLyiadU4RnacM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khxZSvrIexBkWw3Cj3ghkxpMkqvwuDqSGSKmc0TozC6rMfanE65Fq8gI9x1MCreTLuOMaJdNyvEJXGXUP/USdf9GQKADht1QqX3paY3Fa4hP3XBYq1j64K82zsEv8BxAbZqgYDVXadgedmtS9Y+CCkht7Ct9jbtfyRhUaT9j3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=g7dJ7ua0; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="g7dJ7ua0"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a08b250a2so55780637b3.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 10:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1718127083; x=1718731883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DI+NvinNORzKI9dyWbrw1O16aJOlgF6M31kvFSpcX6Y=;
        b=g7dJ7ua0F0DrAhVO8rnT+kSqQTP3Eied6g7hEKdBqD+xvPt7YBjiTSER4EXPfRFW1a
         l5ajuyGbkfp+fMMvoz4CoAGfQls6G1wmNJHGTcm7zycmTNwnwfehA1T2ZVQRPK6bh1z2
         vPF6iY81jat1M38+6m4r51TEZfVbvSnZlrkrCXHBkmeK9YqHDsBikw8Zu3hw+u/r91xx
         oAWx8vXVsmLPvX6+akRFMVgWK7OyaPkJnhj1KjWvsPqPbvAvzw/vFb9RC/E5oLIUtTtO
         iE8XSBSdWQUG6c3033CchxaAnFJ1l0jq3LeFRXSIyrzbwqJ0nPB7n9539EYmY43f9WJx
         hxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718127083; x=1718731883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DI+NvinNORzKI9dyWbrw1O16aJOlgF6M31kvFSpcX6Y=;
        b=Ex0FH5ORSwpBlgKLHTtO6Wha5sqJVOSaWCAsKOVV4xee/cqqYoTsBIG0Tx7Qz1C9N0
         rLcgAo25q8bibT8AiX986ENYy45nsxFsyT7gPBeR8anMYgQAOJbIQJGfKIJSSPkBGuqV
         MeJ3Xpf1VYv7wBrsuZid8S94TR8huIj9hVuTBwGBNO8xwCs/L0JreXhXkMgKIPLzt9X4
         Pdby/KQq/ZA99xrUbI51YXh0e5abgMh6mrA43nSsiHHQSap987dtQ41V7tf9gZrQHyZA
         MQ871mPFdzsFNXfkXBojmmFqjZ1MBKH5gopsgOGX8tkNVwa3JYn0zB3CPmHnUcJE15tl
         7teQ==
X-Gm-Message-State: AOJu0YwGjC6am0O2sDGGLkrHrMAz9+rA8sqU42g+dFstvO6eTj0SA0Hy
	PELW9jP1TBkzKNs2Lwv7ZxzltWe8x39Fgwm/pYxVZzoeRu5XU16mH0p0ba2SVw7L27ubDtfFPJe
	72To=
X-Google-Smtp-Source: AGHT+IGZkH9bFOcM9d9Hec50Gmj1YLGZyPCk6UDoP1waOkek3QL95dRPcMmuEWdh1WQFqlOovMmOIw==
X-Received: by 2002:a0d:dfcc:0:b0:615:7899:65cb with SMTP id 00721157ae682-62cd5653737mr116195107b3.36.1718127081944;
        Tue, 11 Jun 2024 10:31:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b0860ffaafsm16285716d6.39.2024.06.11.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 10:31:21 -0700 (PDT)
Date: Tue, 11 Jun 2024 13:31:20 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 0/3] midx: various brown paper bag fixes
Message-ID: <ZmiJ6H6xkvc5WnC9@nand.local>
References: <4aceb9233ed24fb1e1a324a77b665eea2cf22b39.1717946847.git.me@ttaylorr.com>
 <cover.1718126886.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1718126886.git.me@ttaylorr.com>

On Tue, Jun 11, 2024 at 01:28:07PM -0400, Taylor Blau wrote:
> This series fixes a couple of brown paper bag bugs in the MIDX/bitmap
> code.
>
> This version is basically identical to the previous round, except that
> we use the sentinel value "-1" as the 'pack_int_id' when reusing from a
> single (non-MIDX'd) pack. This is a "garbage in, garbage out" measure to
> ensure that we notice any regressions here loudly.
>
> Thanks in advance for your review!

I must have forgotten to tag my original "v2" as such, since my scripts
decided that this is actually v2. Apologies for any confusion, this
latest version is certainly v3, the range-diff looks like so:

--- 8< ---

1:  c62daacd1d = 1:  0bdf925366 midx-write.c: do not read existing MIDX with `packs_to_include`
2:  9b78fa2923 ! 2:  4b006f44a5 pack-bitmap.c: avoid uninitialized `pack_int_id` during reuse
    @@ Commit message

         Avoid the uninitialized read by ensuring that the pack_int_id field is
         set in the single-pack reuse case by setting it to either the MIDX
    -    preferred pack's pack_int_id, or '0', in the case of single-pack
    +    preferred pack's pack_int_id, or '-1', in the case of single-pack
         bitmaps.  In the latter case, we never read the pack_int_id field, so
    -    the choice of '0' is arbitrary.
    +    the choice of '-1' is intentional as a "garbage in, garbage out"
    +    measure.

         Guard against further regressions in this area by adding a test which
         ensures that we do not throw out deltas from the preferred pack as
    @@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitm
     +			 * process the pack via try_partial_reuse(), we won't
     +			 * use the `pack_int_id` field since we have a non-MIDX
     +			 * bitmap.
    ++			 *
    ++			 * Use '-1' as a sentinel value to make it clear
    ++			 * that we do not expect to read this field.
     +			 */
    -+			pack_int_id = 0;
    ++			pack_int_id = -1;
      		}

      		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
3:  e08f679dec = 3:  06de4005f1 pack-revindex.c: guard against out-of-bounds pack lookups

--- >8 ---

Thanks,
Taylor
