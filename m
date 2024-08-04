Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761622086
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722795167; cv=none; b=f/CFyD5gJuKX7oqIAncoh/zEpOnlLzVyE3xWs3RJI82V96DAyZ2Hz6BWzofz5kYMIsNjOBlnDorR+e+4nZKpwGxgHK3Qbm/RQpBpINeqwmUpgLC49rD+eK+kkGPNeoZbgbDRFUbSoRPnanm8886A0WHKAuJSHESdRKdbTHgSZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722795167; c=relaxed/simple;
	bh=A2O1mGy0XG0Gb6gd8jBNbuD4httjZ2XLGzgzRbbgTTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehP51rK/YjR0xeEL3c0k7+kCXQfMSRkFgvTgzbRFbAIO0prLSjvhStJLGOjFB30PjZ8khkqTXOzTGK8d2NDmiu380B477POrMr9jS4H98MZwQl58KGE8d659818RpAlpR5SFLeWfvlqt0lDMhGHsDhnLFFASKJGXICgO+7wLHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rP5SznIy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rP5SznIy"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-651da7c1531so81898667b3.0
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722795164; x=1723399964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7Z2Te2KlbqJ/bcT6BsvFV+r63hdGgfkJMUlz4EkhCI=;
        b=rP5SznIyNCVXhZsuiP0g2f2VzZR0pEA6XuuUNUbf6421vbtcOnDUCphLHiQ41hZoVX
         0NurHIMfnltavKnYkDGMCKNpEXf2FfwcK19joAlb3PKBYkc+usGuJdHjP+tityUOHU0o
         ScUuDFU02i3UcNajEkvnmfzzk+3fU0caYvmDqujg7LIpfP7kqoOPX0/CV7pRN5bQYCJJ
         A/vqUqUd8GZtTqs+vg+bbf9K6XKKoNolrbsE9wETL6n76GHKSTITpMbFGYtB5rikEHvO
         JSN2U6q4U3UUEgDUVMJnOXDiqxvklX1Ls/DqZI50kcSMbUsGI61D62eGgkJqzQJg7629
         G6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722795164; x=1723399964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Z2Te2KlbqJ/bcT6BsvFV+r63hdGgfkJMUlz4EkhCI=;
        b=RToiqeGRFU4lM/Rwbz42OupEn/PBKQfZuOIasnBEV/Sxx+Ci76DhEgLOpQQS33fCxo
         7nu2I0sWVKP5uu6T1I8YHlJlnUCxY79w4A2QJNCi95bSI/1DQBY8VkTYJ6SaMxplixSa
         P5TVuvvpj/760Tzr+SvcFVHM7qGu3oHoa4kN+MkOKUG+gP20PibBmtnXZWf0uf6BpgJf
         eR+Vq1HmCuAC08hQdiWCdJvleMzs93ai7ok4dcIZe7FPpdQS+Kwo/TEKzVwrnZoOhi5a
         MD9gxY5JKjRepK6blx2wS9qLHxaw9Ih4Dh4BpbZo+R6D89LrvIVCFuylialtCPILUitk
         9uYw==
X-Gm-Message-State: AOJu0YxpKjDkpHfyRLovNRT4rRASkpGo9/029f4Y+hGzCy0Cm3t+Cu1G
	Tsr6eCI03ycRcXQnzlUXnbWIsugttC+ARKzIrDHdZxOQbtAzNFbKYn5jz9AluYjGXRBiacHYX0R
	A
X-Google-Smtp-Source: AGHT+IGva/l6nRE7VGPUzMjIeGB1AwhEQgcM9rATyKwtQ4VdkKSrQHcrfcqsRCoHbmkTwgchv8BZew==
X-Received: by 2002:a81:a504:0:b0:64a:7040:2d8a with SMTP id 00721157ae682-6896150ff7amr93661107b3.23.1722795164536;
        Sun, 04 Aug 2024 11:12:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b4244sm9281257b3.127.2024.08.04.11.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 11:12:44 -0700 (PDT)
Date: Sun, 4 Aug 2024 14:12:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: rsbecker@nexbridge.com
Cc: git@vger.kernel.org
Subject: Re: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Message-ID: <Zq/ElpJpbcUqB+4e@nand.local>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com>
 <ZqvgmYl8BTYvsSa0@nand.local>
 <032201dae461$c7bcc9d0$57365d70$@nexbridge.com>
 <ZqwvQUAqVozGHG/t@nand.local>
 <040801dae528$70966d10$51c34730$@nexbridge.com>
 <Zq+mF2fyL5hux+3k@nand.local>
 <04ee01dae689$90b0e0f0$b212a2d0$@nexbridge.com>
 <Zq+qHRwHC3sD14eN@nand.local>
 <04f101dae68c$c57574b0$50605e10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04f101dae68c$c57574b0$50605e10$@nexbridge.com>

On Sun, Aug 04, 2024 at 12:38:38PM -0400, rsbecker@nexbridge.com wrote:
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index < .git/objects/pack/pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
> 138 ce6131022c3a48a15f4b7a68afb6ecf3b3bcb0cd (03c2fd95)
> 12 d1ff1c9224ae5e58a7656fb9ecc95865d42ed71e (64dd3dba)
> 183 df967b96a579e45a18b8251732d16804b2e56a55 (879729b5)
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index <.git/objects/pack/pack-8f53f837597ebbdfc6f8ed173349e5cecbcfb97e.idx
> 12 ad16bed54cc61cf036075879deeff95ae977514b (239ee6ff)
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index <.git/objects/pack/pack-b8dc9aadaadc12c82b0053fdee0039ae1025a8f8.idx
> 12 4f336f3df31054eabc05ac05f98bc024c8e05423 (24bc6ce2)
> ./trash directory.t7704-repack-cruft/max-cruft-size-prune: git show-index <.git/objects/pack/pack-c2357b2b204fda52bc1f5515de94227e1db012af.idx
> 12 bd44d8aa2d22eb47ff70cef4b0bb45d1549ee49c (c2c93868)

OK, so it looks like the first repack is doing what we expect:
presumably the first pack containing three objects holds the result of
"test_commit base" (and contains the blob, tree, and commit objects for
commit "base"). Then I'm assuming that the remaining three packs hold
$foo, $bar, and $baz in some unspecified order.

So I think that everything up through the first repack is doing the
right thing.

(As an aside, it took me a while to remember what was going on with this
test. Since it was confusing to me as its author, I figured it may be
helpful to spell out some of the details. We're just making sure that
pruning a cruft object works with multiple cruft packs, and we're
adjusting the mtimes of the *.mtimes files themselves to ensure that
they are rewritten during the pruning repack. Those adjustments have no
bearing on what actually gets pruned, unlike when we update the mtime of
the loose copy of $foo, which does affect pruning).

Anyway... in your setup it looks like all three objects are gone, and we
expected only $foo to be pruned. So I suspect what's going on is that
this test takes longer than 10 seconds to run on your machine, in which
case it would fail as all objects would have passed the 10-second grace
period.

If you apply:

--- 8< ---
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index 71e1ef3a10..959e6e2648 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -330,7 +330,7 @@ test_expect_success '--max-cruft-size with pruning' '
 		# repack (and prune) with a --max-cruft-size to ensure
 		# that we appropriately split the resulting set of packs
 		git repack -d --cruft --max-cruft-size=1M \
-			--cruft-expiration=10.seconds.ago &&
+			--cruft-expiration=1000.seconds.ago &&
 		ls $packdir/pack-*.mtimes | sort >cruft.after &&

 		for cruft in $(cat cruft.after)
--- >8 ---

, does it still fail?

(There's really no reason to have --cruft-expiration as short as 10
seconds here, since we backdate the cruft mtimes by 10,000 seconds.)

Thanks,
Taylor
