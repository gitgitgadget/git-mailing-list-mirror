Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF70145A16
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731144521; cv=none; b=GeCmnRWSy+yRt/bFblyyBVxJxpK/3DEayKrLsIwkOHC198Rq4oAsGuuoFZtSPn1pjzjp+vzPyvYXqnZUTJd9QunoSkcMb8sqBB+JAShMHGikgDpDFTsUiIqZVnn2B6z1mrWVFAC7luEl0tma4A3EIpHZdE0h40HJNR0CQVTNsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731144521; c=relaxed/simple;
	bh=OKsXTJsIjdvqqVHGmKscm83iu/VSYJx2JRuXJr+hm48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtTSnLRV93xlbni6+coF4HD/a2DgYm8uWP8MUMqX7urU8mS+5Rs+2XEhBGPIJi+M0fxipVgZbSXkC7KP6WYfGk7mzlSPSIMydtR2G11c4+BWNang7CAGqYb48gNho3IRiV0bDvOC5Rh4ybzp6I1N90HJh7rFDZG23YAOsT7mlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U00kbeCt; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U00kbeCt"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e88cb0bbso2358851a91.3
        for <git@vger.kernel.org>; Sat, 09 Nov 2024 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731144519; x=1731749319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whFwBZPKvFO2CdlVJzr3OeNadRquLmN6A4XA2cQ4UBQ=;
        b=U00kbeCtI0Y24Gh72qdea/4qAS7IK5ej8PGQ3/pb4nTFeEJJQ6Q8M0MHK7y8AXTUL0
         DNX12g8cO5Cf4S7HZn0lIh0Sj0pwRmMlhZrKgGgi3NNm0N8MIptoPyiY65yoJmQcExcG
         FgtW9Q6MD922N45cu+xFtlX5VJv0Ocfse6SoU3NABLe1jPgGSuMxvjZ0nTdCrSUiL06d
         ju/5u8lbrBoU4Pz5JXu72A5VuSRfhZKx7BAGo6MfL7GIYZ11fN9TvwmeYoPo3TLkLi90
         xHNYaWI0+MELJPUswpDvl/hj8K4kKJBc0+6XF5Jg00O25pnkLoBc2gikpz96FdH1gF6a
         0gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731144519; x=1731749319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whFwBZPKvFO2CdlVJzr3OeNadRquLmN6A4XA2cQ4UBQ=;
        b=LkS1ayCBJ5LA8wrMM6pxDg9R/qI5oaF1yqfNB2V3tqDli8A1aWJjKu5wUTz7XzC0Nh
         x5fixYK698msP4e5auPpECcdb5EiJ8okrs/JtObAbff7S1P2u0rSVeFPR+vF3RC3I+Wu
         J/w1/5khDxAY4hgrdCnYPSmnvOM3QeUkYcDwk2uFMUgJsJiRKWkS2k5sG0dL6TMOJW9D
         IIPdReaARls/8d7gXHpZaeBkFcwagfaT3KQYZGuXb9qHDZxgQzcwmkapaYv/cxmgKv68
         T/KM91WJxj/E8+xwGMbbye8yE534eizWE6PzKLssIEoPSQSMhLbpLo+obviVMDdThbAU
         rlwg==
X-Forwarded-Encrypted: i=1; AJvYcCU+FV0bbfHdlSz58Fs9iucvz0I5cB+Vck/Jhjrl5ESs/sgXvzjI5Qkqct1m0+i7wWQ0V/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YynOrtX+dRzf6uWDZ+3U4HObReIG+fGqdspNuuSkCdjS47tkATO
	hdbYFEXNRE6ito96/JKXIeVGSBoqrZF5GKDyX3Fcf6qF5jA2GXcW
X-Google-Smtp-Source: AGHT+IEAS1xFrHbzVDcohkXp6qG8ZXqLQDP+hdcH9LyCCnAqJionhLKGewTHHfeUnqzKz4053mURxg==
X-Received: by 2002:a17:90b:38c4:b0:2e2:c6a6:84da with SMTP id 98e67ed59e1d1-2e9b1799123mr7969228a91.34.1731144519193;
        Sat, 09 Nov 2024 01:28:39 -0800 (PST)
Received: from localhost.localdomain ([103.171.210.156])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e41651sm43309455ad.134.2024.11.09.01.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 01:28:38 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v6 0/2] show-index: fix uninitialized hash function
Date: Sat,  9 Nov 2024 14:57:37 +0530
Message-ID: <20241109092739.14276-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <xmqq4j4mv5o6.fsf@gitster.g>
References: <xmqq4j4mv5o6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Nicely described.

Thanks!

> "git help cli"; dashed options first and then other arguments.

Applied.

> Hmph, is the above a roundabout way to say
>   git -C explicit-hash-$hash rev-parse one >in &&

Applied.

> or am I missing some subtlety?

No, I don't think you are. However, I would like to point out that the code
which I used as the inspiration also does thing the same way:

	test_expect_success 'pack-object <stdin parsing: [|--revs] with --stdin' '
		cat >in <<-EOF &&
		$(git -C pack-object-stdin rev-parse one)
		$(git -C pack-object-stdin rev-parse two)
		EOF


> When this test fails (e.g., the number of lines in the show-index
> output is not 1), explicit-hash-$hash is not removed, because &&-
> chain short-circuits.
> 
> Perhaps join thw two into one and use test_when_finished, like this?
> 
> 	test_expect_success 'show-index with explicit --object-format=$hash outside repo' '
> 		test_when_finished "rm -fr explicit-hash-$hash" &&
> 		git init --object-format=$hash explicit-hash-$hash &&
> 		...
>                 nongit git show-index --object-format=$hash <"$idx" >actual &&
> 		test_line_count 1 actual
> 	'

That makes sense, applied.


Abhijeet Sonar (2):
  show-index: fix uninitialized hash function
  t5300: add test for 'show-index --object-format'

 builtin/show-index.c   |  9 +++++++++
 t/t5300-pack-object.sh | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

Range-diff against v5:
1:  05ee1e2ea5 = 1:  05ee1e2ea5 show-index: fix uninitialized hash function
2:  c8a28aae55 ! 2:  778f3ca18e t5300: add test for 'show-index --object-format'
    @@ t/t5300-pack-object.sh: test_expect_success SHA1 'show-index works OK outside a
      
     +for hash in sha1 sha256
     +do
    -+	test_expect_success 'setup: show-index works OK outside a repository with hash algo passed in via --object-format' '
    -+		git init explicit-hash-$hash --object-format=$hash &&
    -+		test_commit -C explicit-hash-$hash one &&
    -+
    -+		cat >in <<-EOF &&
    -+		$(git -C explicit-hash-$hash rev-parse one)
    -+		EOF
    -+
    -+		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in
    -+	'
    -+
     +	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
    ++		test_when_finished "rm -rf explicit-hash-$hash" &&
    ++		git init --object-format=$hash explicit-hash-$hash &&
    ++		test_commit -C explicit-hash-$hash one &&
    ++		git -C explicit-hash-$hash rev-parse one >in &&
    ++		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in &&
     +		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
     +		nongit git show-index --object-format=$hash <"$idx" >actual &&
    -+		test_line_count = 1 actual &&
    -+
    -+		rm -rf explicit-hash-$hash
    ++		test_line_count = 1 actual
     +	'
     +done
     +
-- 
2.47.0.107.g34b6ce9b30

