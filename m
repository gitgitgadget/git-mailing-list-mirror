Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0020A5EB
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 06:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375085; cv=none; b=nkWUv8TLb66pGna3re7rfAft6/WpQockLte8t1m2R02NL9mfOe5K8sfw024wR81MR1Jj9Qt2ztXVcYx1ZFKnYCEQQk1q2cjNZ6/BDL0IoApYl5hEZLeZg+6MzKXUnW78WQhuuHvvSUNsbqD+ylpljD3p6kakra+fd9ebQ1V0uLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375085; c=relaxed/simple;
	bh=CQKZacetomdiyZQ4zd0soXc86tcjrRJUlyg5gfVAQQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kS94FYC9FtchHv/F+zcEG5dJ6GqLboUgkfzEOo94pk0ykISsF9Sa8pqdgchZwypDdUcsG0XfNJmZEyVb/JsziGJ5sZ5HzwqPsGyAHU2gJxYBMRAi+HQFClwqwv+G6Hc97EgX726DkZ1EFPLFe0n564wr42g9JOMc0kN0D2wz/AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVWgNBoL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVWgNBoL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24050da1b9eso6275055ad.3
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 23:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754375083; x=1754979883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwtrgI0Dek6GEMkkjvh34zVawCm/9GycLwobagNMcSk=;
        b=YVWgNBoLGHEtbBjZH8VMhX/Cr6uECApeSbAdqDPLOBefWunGDXaE2IPum589Pj/KvD
         PnUbkWntkkwTMWWB0x9r4kQXpDd4M08dIN/V4KfZWsVXAcqQijlcGYzMr8b91vvgbBH2
         +M0DYvQ1tHGs3NZGgzPxjxDihXfN/K0sPnDfxnTFrGub4w9dyyyLbkFgb+gwwwtNlufw
         dzx1Z/7gP8q6PlmuVqeaACatESl+nTKnKbA7T0wZoOwe03jGQygrycCfJNcUDA+LsGwC
         WnDmyXEEzGUg7EVsMAw59EWUrcbID5BIkFozv6isA2BSg2/a7ABDc+JJGQk3vhYDePbt
         XO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754375083; x=1754979883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwtrgI0Dek6GEMkkjvh34zVawCm/9GycLwobagNMcSk=;
        b=UiktLUIQF6454tfQxSGC48lzgZvFb/H+061E6zTpqcBIw/vQnVBHUXjENUkwwS5Vr/
         KBl3H7Z+DAmvRDRaqe1EHsLQAZH28U859O9U1+4VhZVF/jHoGUedBQDy5Vk9HRkzSBHP
         FWFq7TXk+gb8IqY/4t/Zl8uZ8pTgA7/yVWY4nkd3aGmBo/jsv4BFkMgcNmmwcRYW8Bb/
         jXaMtQ1tiMg+vxtmXiNQEdyrWXTpfDwt+wUsE0XkmdRL1ozwucUCAsdLehkwW+d+NbLA
         h0/5NgPYRA15R/8aepvrMBXkhfTUgiqHmRaZ56GPp5SK2PWvwNDrordKDMHQpKI9EWSY
         me6w==
X-Gm-Message-State: AOJu0YzAQJJ1iK++SK06Ld70Ec2zfg1BemNpyUs2jsBr+m4TjgPYf7V5
	SudiTot2KjlHDaWPQWTckOxLRFf49GtmeMC0rtpqM8GCe8gA4dszXC6yh9NpLQ==
X-Gm-Gg: ASbGncvLiy25q4WesDZTmuHiRpryjf8a1ru64T6K3WlT5C8I0Go8rzeIYXVSUKE6gsO
	xIOyDHnkNoJ5ca1CWOneMFGniqXivg+qXTfWV5yxmcXH2O+dcjKFXpOtp6X3BJ70oAcnnTOskPX
	6EFHONSEO95+JuBW3G3Mn3EvIaWtr2+6Y/op8c62mX6PYcI4NMb0f5Jp4d0DgtH72EuEraLUFsg
	dv7alZ729LJwwIC3QQqzUvHV2GUOl9yqeIo/Ffylo+dbIU/nbGDAQGYcLHdiTV4KtuuIY7LzZAZ
	UciS8G6E36M0pRpODUnpwLWP+wW8CTYHmnqwrtiH+Uhs1Zdy2KT84lA5C+wkkeDjEjARy2AgJVV
	YR/Go7maTCfaNtevOFq03pP0+Mn7jVA==
X-Google-Smtp-Source: AGHT+IF+t7DXMJ+1//wcR+5YRkhX8x2NJW2diDkX5KciymZiYEzZTjZkacZZ2/YmyMtDA1J7+8hFhw==
X-Received: by 2002:a17:902:f60e:b0:240:8a87:a187 with SMTP id d9443c01a7336-24246d47d6emr72264975ad.0.1754375082926;
        Mon, 04 Aug 2025 23:24:42 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976d13sm123916935ad.109.2025.08.04.23.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:24:42 -0700 (PDT)
Date: Mon, 4 Aug 2025 23:24:40 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] remote.c: remove BUG in
 show_push_unqualified_ref_name_error()
Message-ID: <2bd892b26c94133cd1a266d6ff4f2217418b0660.1754375026.git.liu.denton@gmail.com>
References: <cover.1754300389.git.liu.denton@gmail.com>
 <cover.1754375026.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754375026.git.liu.denton@gmail.com>

When "git push <remote> <src>:<dst>" does not spell out the
destination side of the ref fully, and when <src> is not given
as a reference but an object name, the code tries to give advice
messages based on the type of that object.

The type is determined by calling odb_read_object_info() and
signalled by its return value.  The code however reported a
programming error with BUG() when this function said that there
is no such object, which happens when the object name is given
as a full hexadecimal (if the object name is given as a partial
hexadecimal or an non-existing ref, the function would have died
without returning, so this BUG() wouldn't have triggered).  This
is wrong.  It is an ordinary end-user mistake to give an object
name that does not exist and treated as such.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
Thanks, I liked the way you phrased the commit message so I copied it
wholesale over.

 remote.c              | 3 +--
 t/t5516-fetch-push.sh | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index e965f022f1..4ad20110e9 100644
--- a/remote.c
+++ b/remote.c
@@ -1218,8 +1218,7 @@ static void show_push_unqualified_ref_name_error(const char *dst_value,
 			 "'%s:refs/tags/%s'?"),
 		       matched_src_name, dst_value);
 	} else {
-		BUG("'%s' should be commit/tag/tree/blob, is '%d'",
-		    matched_src_name, type);
+		advise(_("The <src> part of the refspec is an oid that doesn't exist.\n"));
 	}
 }
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c2fcfeca92..e064ea7433 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -509,7 +509,7 @@ test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 '
 
-test_expect_failure 'push ref expression with non-existent oid src' '
+test_expect_success 'push ref expression with non-existent oid src' '
 
 	mk_test testrepo &&
 	test_must_fail git push testrepo $(test_oid 001):branch
-- 
2.50.1

