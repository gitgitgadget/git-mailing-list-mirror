Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074519F410
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 23:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732233019; cv=none; b=Q5Mmy7+jt8f5gLxpe9HiWFKpCPSS0K8biC/+ilQR769/Sy0TNB/BvkdCTB0lcRoozcsdYLmbj2aWOhvjRkuHDU0nsZKxigopNxKZcdQS0GwXv0tIH1weI5k/+za5ouOZlUWkA4JSulMQdZ5RZXvFUgjF56fX+J/IfZHRhpTrzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732233019; c=relaxed/simple;
	bh=pmglHKNcPi6ZX+UyEjo+4Afwm5vZqnWdlqMx2qsnHn4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eIkslKYb6o9dyLmd/X7btKmCSuyoqJwr/xrQbNqrrKXuqaoi9GGyWqCqvS2P3Djvu7+zJqGiElieXrmCzNFWsTfcaJV37tdecZqp5nBZAPBxMOyANi5B1nxhBUaguwqtmKUvulC/rlWHEZhPe9MLSavmQWWpbEY7RgTOBMiIhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vM2J7yvH; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM2J7yvH"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30b8fd4ca1so2304182276.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 15:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732233017; x=1732837817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1q+1CgwsTgNQRqaAujJQ7u1oW7GD8ovkJPHYuqc0OfE=;
        b=vM2J7yvHxl+vU4ym7knc5nbeNHqp6NKzWFy7jzax+pMG3WQMt23jrihcY9enulLZer
         qs5LNXVhxAcCMA73crPojfjwevUaYYFfGZjCA4SzpTVwiVJfVDIPh4Wm0UUeJ1aMpCBt
         BYzJ8r6yJoc1a/HZdIOYhdrh+j8hSrpnPAw1Fv+FQUXM7lQKk2UDe2xo+RbYqMYkRsrX
         lo1NehdVoDOQhwCbkC54ctfDe08ZohD1rqSlLU74PMF/lfBk1a7C+H8rOHQhMInyGYZJ
         7sWydTEzMwYj1+lm9i887VVrKZeWYCt7aOJOZHB5DaWcWkLs52l4uE80fQ0qCwBpqyM2
         gLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732233017; x=1732837817;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1q+1CgwsTgNQRqaAujJQ7u1oW7GD8ovkJPHYuqc0OfE=;
        b=A1AWkQLk+WGSocvJSiXbqDlCTAMAl+28L80n/4fv4WRVjt7gxlOvidvSMajZf7AWkn
         TcsIfQOuhZvyirgGZhxO9pAHn6ILOJiY7i6KyrvmhInJtjcGTfwKFpsZG4wb+AvHkv8J
         nnq/nBVcVhoBGCDKLX9EpRMW28QpMqmutl4zr9W/yFTVK5DagYfK6gO1aJ+sn9izYoQC
         aJ+tmlbzBnpQoNK7JgEkHOpl529HOK0hmXxSuKspDp91Iz+NhyN0oJ7qwv/Q9qE0hb3b
         amkUIzcBHpWjvMQivt7m/G+HVrH1cdFMiFK8ptnzsWxnBPPEsL4G8MvWB73i3i5BV1Gi
         XJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCUkkljNSSpVa5sGNJMQYSTKdka05TH9JJnyl7b92EQ4L46QQSktWhLigLDihFh5wjOQvKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybcdpF559RYY2l19ioWTSI+lwh6sDfQIyjfzQGJzi96XYNCu8N
	FMiiMItezBNG9u/j7KL5H6GmFg/oVcjStikhbxpqsr2IkTI4+WdUbGed9cNlguxh+B7mrD7Sb5/
	W9Mxe2CgSPEnvQKK6nWC/8j1Pdzld6g==
X-Google-Smtp-Source: AGHT+IFJafCHkyE8FHnKeRxHfHWOe7SEa1h1nhK3ZpZVcInewekQJPOgWE96FvyCrr27+38WmNuQQ7i0N+4hNvaRDEPN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:d214:e3cc:8644:78ef])
 (user=jonathantanmy job=sendgmr) by 2002:a25:adc7:0:b0:e38:b443:99f9 with
 SMTP id 3f1490d57ef6-e38f8c001b3mr294276.9.1732233016362; Thu, 21 Nov 2024
 15:50:16 -0800 (PST)
Date: Thu, 21 Nov 2024 15:50:14 -0800
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121235014.2554033-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/7] pack-objects: Create an alternative name hash
 algorithm (recreated)
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> This series introduces a new name-hash algorithm, but does not replace the
> existing one. There are cases, such as packing a single snapshot of a
> repository, where the existing algorithm outperforms the new one.

I came up with a hash function that both uses information from a lot
more of the path (not the full name, though) and preserves the sortable
property (diff at the end of this email). It also contains fixes to the
existing algorithm: not wasting the most significant bits of the hash
if files in the repo mostly end in a lowercase alphabetic character, and
the cast from a possibly-signed-possibly-unsigned char to a uint32_t.

The results look quite good. In summary, the pack sizes are comparable
to Stolee's results in the case of fluentui, and better than Stolee's
results in the case of git.

Here's one run on the fluentui repo (git clone https://
github.com/microsoft/fluentui; cd fluentui; git checkout
a637a06df05360ce5ff21420803f64608226a875^ following the instructions
in [1]:

(before my change)

Test                                               this tree         
---------------------------------------------------------------------
5313.2: thin pack                                  0.03(0.01+0.01)   
5313.3: thin pack size                                        1.1K   
5313.4: thin pack with --full-name-hash            0.03(0.00+0.02)   
5313.5: thin pack size with --full-name-hash                  3.0K   
5313.6: big pack                                   1.60(2.87+0.32)   
5313.7: big pack size                                        57.9M   
5313.8: big pack with --full-name-hash             1.41(1.94+0.37)   
5313.9: big pack size with --full-name-hash                  57.8M   
5313.10: shallow fetch pack                        1.69(2.70+0.22)   
5313.11: shallow pack size                                   33.0M   
5313.12: shallow pack with --full-name-hash        1.49(1.84+0.34)   
5313.13: shallow pack size with --full-name-hash             33.6M   
5313.14: repack                                    75.10(537.66+5.47)
5313.15: repack size                                        454.2M   
5313.16: repack with --full-name-hash              18.10(92.50+5.14) 
5313.17: repack size with --full-name-hash                  174.8M                                

(after my change)

Test                                               this tree         
---------------------------------------------------------------------
5313.2: thin pack                                  0.03(0.01+0.02)   
5313.3: thin pack size                                        1.1K   
5313.4: thin pack with --full-name-hash            0.03(0.01+0.02)   
5313.5: thin pack size with --full-name-hash                  1.1K   
5313.6: big pack                                   1.62(2.94+0.28)   
5313.7: big pack size                                        57.9M   
5313.8: big pack with --full-name-hash             1.35(2.07+0.37)   
5313.9: big pack size with --full-name-hash                  57.6M   
5313.10: shallow fetch pack                        1.63(2.52+0.29)   
5313.11: shallow pack size                                   33.0M   
5313.12: shallow pack with --full-name-hash        1.50(2.10+0.23)   
5313.13: shallow pack size with --full-name-hash             33.1M   
5313.14: repack                                    74.86(531.39+5.49)
5313.15: repack size                                        454.7M   
5313.16: repack with --full-name-hash              19.71(111.39+5.12)
5313.17: repack size with --full-name-hash                  165.6M  

The tests were run by:

  GENERATE_COMPILATION_DATABASE=yes make CC=clang && (cd t/perf && env GIT_PERF_LARGE_REPO=~/tmp/fluentui ./run -- p5313*.sh)

The similarity in sizes looked suspicious, so I replaced the contents
of the hash function with "return 0;" and indeed the sizes significantly
increased, so hopefully there is nothing wrong with my setup.

The git repo was called out in [1] as demonstrating "some of the issues
with this approach", but here are the results, run by:

  GENERATE_COMPILATION_DATABASE=yes make CC=clang && (cd t/perf && ./run -- p5313*.sh)

Test                                               this tree        
--------------------------------------------------------------------
5313.2: thin pack                                  0.03(0.00+0.02)  
5313.3: thin pack size                                        2.9K  
5313.4: thin pack with --full-name-hash            0.03(0.00+0.02)   
5313.5: thin pack size with --full-name-hash                  2.9K                                                                                                                                                  
5313.6: big pack                                   1.69(2.80+0.28)                                                                                                                                                  
5313.7: big pack size                                        18.7M  
5313.8: big pack with --full-name-hash             1.68(2.82+0.31)  
5313.9: big pack size with --full-name-hash                  18.8M  
5313.10: shallow fetch pack                        0.96(1.47+0.16)  
5313.11: shallow pack size                                   12.1M  
5313.12: shallow pack with --full-name-hash        1.01(1.51+0.14)  
5313.13: shallow pack size with --full-name-hash             12.1M  
5313.14: repack                                    17.05(69.99+4.33)
5313.15: repack size                                        116.5M  
5313.16: repack with --full-name-hash              15.74(67.03+4.18)
5313.17: repack size with --full-name-hash                  116.1M  

[1] https://lore.kernel.org/git/c14ef6879e451401381ebbdb8f30d33c8f56c25b.1730775908.git.gitgitgadget@gmail.com/

> | Repo     | Standard Repack | With --full-name-hash |
> |----------|-----------------|-----------------------|
> | fluentui |         438 MB  |               168 MB  |
> | Repo B   |       6,255 MB  |               829 MB  |
> | Repo C   |      37,737 MB  |             7,125 MB  |
> | Repo D   |     130,049 MB  |             6,190 MB  |
> | Repo E   |     100,957 MB  |            22,979 MB  |
> | Repo F   |       8,308 MB  |               746 MB  |
> | Repo G   |       4,329 MB  |             3,643 MB  |

If the results are similar for some of the above repos (I do not have
access to them), maybe it's worth considering using my hash function (or
a variation of it).

I'll also take a look at the rest of the patch set.

---
diff --git a/pack-objects.h b/pack-objects.h
index 88360aa3e8..c4f35eafa0 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -209,23 +209,24 @@ static inline uint32_t pack_name_hash(const char *name)
 
 static inline uint32_t pack_full_name_hash(const char *name)
 {
-       const uint32_t bigp = 1234572167U;
-       uint32_t c, hash = bigp;
+       uint32_t hash = 0, base = 0;
+       uint8_t c;
 
        if (!name)
                return 0;
 
-       /*
-        * Do the simplest thing that will resemble pseudo-randomness: add
-        * random multiples of a large prime number with a binary shift.
-        * The goal is not to be cryptographic, but to be generally
-        * uniformly distributed.
-        */
-       while ((c = *name++) != 0) {
-               hash += c * bigp;
-               hash = (hash >> 5) | (hash << 27);
+       while ((c = (uint8_t) *name++) != 0) {
+               if (isspace(c))
+                       continue;
+               if (c == '/') {
+                       base = (base >> 6) ^ hash;
+                       hash = 0;
+               } else {
+                       uint8_t nybble_swapped = (c >> 4) + ((c & 15) << 4);
+                       hash = (hash >> 2) + (nybble_swapped << 24);
+               }
        }
-       return hash;
+       return (base >> 6) ^ hash;
 }
