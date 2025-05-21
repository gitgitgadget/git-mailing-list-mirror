Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEAE1DB124
	for <git@vger.kernel.org>; Wed, 21 May 2025 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827650; cv=none; b=tDOSVemqym6Y/kKpQDIdy7oF5PvXiXvCIzILbBJ/OaO84a8jMIFVZxR5FzPCCMmFLKnqKWxmtxa8fh8i9222pt7FVAKDH2s0D1FJtH1lPU9gRo3doSrnQMz1uJgqeP6d5spmO4+uC/NBSGy8+wV19F04hwnJ7RzujpyyF9+BjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827650; c=relaxed/simple;
	bh=A8D3OZNuhfi2FF0F5VibvHtciR1g/LgNl+YStOSB4UM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=A52Xi0+rr+khBUN26tJi1GG6mVz2hZcjRe8W9Rhqzd7lQiOa2ZrWPVH4cTzi/1vu+mazf76MGqEs9AxVvF+LSjJRSVoQHI4g8fegjsn6cxLyvLAqbo1PWn8AhENBnR3r6N9L6FocL5d4hnwitypeQ2MaYQnaBxMbeRYF+qMBHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3RIZ3+V; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3RIZ3+V"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a37a243388so1675229f8f.1
        for <git@vger.kernel.org>; Wed, 21 May 2025 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747827647; x=1748432447; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zlJmqiuPIQLCetvYaojO4y02aBsD3JHXfb6GEsrRqWI=;
        b=M3RIZ3+VMtkJvJF1Tti9AI66EE1rbo6nBQAPpiBvZN27EjUSdZrf+1Jyvhjl7TSNWW
         Fucv+ePGQs1yBMnvvwd8nqwy7fVpYp1675RXCyOM9Fq5JiZpSsP3vXJlHVcWjefn3rEE
         F5OUScyWABsgGjZSyTnoG++i0WiLh9P5Pan3qDY3dClDI+gO92GtC1Ro+3erWjhPgnSV
         qdZ6Ji/jU0Mr7iq0xOro7hcYDISIiCu76bWcGl04jFGkcaA5vpfPIuHslunjMag5sics
         CSRUG2NwYM71IprWnMKwkFzlVrbwdQe1HjFjYbPUkE9LB3ihLIqsZPVqfcfK6C+nY8FY
         2JWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827647; x=1748432447;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlJmqiuPIQLCetvYaojO4y02aBsD3JHXfb6GEsrRqWI=;
        b=Y21xcJJ1l98Kl78nMOpYjIDNHLNnxFI4dCjejE5t1L6IYIgZDcDJhxyfcfRf6NLeOs
         7ntkGM5HGHxuPT5vj7ImX3Hy1d3Kr26G2WGxsdt0cCCOct7vkBPMoW236pTDgXokefTG
         ntK8/Mdznk5fdx+FPwEfSrvhJ/d9TUh0dWK16Z4TS3aNB+cg9boYyyJy45jpju7tDqJ4
         9nbOcJw2IY1yWNKwKK8LwEHuUgAfHc5L4LuGDDF2cE/3qqDoJgvUKS+nLvvdGoqWofin
         3LrEx1r1av6JJOqhum9VZzGlkB1FGiOVznwVYfGqUYOrkLB/6TCn5j4UTp3oZiNcGfGO
         JwYA==
X-Gm-Message-State: AOJu0Yzp+HiWmvyUu2bFH1iksLJL8R/LM4xk3PI27Fodfc8zuzu2WbL9
	+JthiITF1uOCxmU4Jpzhe5kK37eVxnNlvTgOPn5y9JGI37WBkXc/sStHPwkTlA==
X-Gm-Gg: ASbGncuDAO89IEsZTFDtUk/Z5Q2KzK+/VXSsGTRx2Il+jszBfQ415trkOkUz4ZDtThJ
	KxK5VRASE1yIMlUNu8CZmzs3nl/xbS3EZqP03p4IaqhFQ1FF8ByArrRz+pgpZ8KjgOxuEzFqIgC
	k43pB3jIukfDIDgPVje18c8B5Z/6T+Ks2nBKaRUHJRRJBR75lHXFk0fiSImTqmRzRVWc3Wwxcqq
	wpRE2nIj+8X4vLgXEOxgYt/D/sFFRL2gLh+XdqcZ8h76aiHZBHNurrQbFsZyRZnt2a2VmSL1LnK
	wGHSf9ZM4YI8Gi9UOCzUg23PdrWStjLUK1PMySsBL+ZpdNTAT3C0
X-Google-Smtp-Source: AGHT+IEBu4Ls4TVHG5Fev3y6jiWWxYnU5gtZ2dawZkqyQDtR+zoqLzqkSHoX9NISDu22C6VeNQzD8A==
X-Received: by 2002:a05:6000:2903:b0:3a3:6e62:d8d5 with SMTP id ffacd0b85a97d-3a36e62d9afmr8537737f8f.58.1747827646757;
        Wed, 21 May 2025 04:40:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5a841sm19768188f8f.34.2025.05.21.04.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 04:40:46 -0700 (PDT)
Message-Id: <pull.1970.git.git.1747827645129.gitgitgadget@gmail.com>
From: "Alex Mironov via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 11:40:44 +0000
Subject: [PATCH] name-hash: don't add sparse directories in threaded lazy init
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Alex Mironov <alexandrfox@gmail.com>,
    Alex Mironov <alexandrfox@gmail.com>

From: Alex Mironov <alexandrfox@gmail.com>

Similarly to 5f116695864788d1fe45ff06bfad7a71a8d98d0a
make sure to avoid placing sparse directories into the name_hash
hashtable whenever multithreaded initialization is performed.

Sparse directory entries represent a directory that is outside the
sparse-checkout definition. These are not paths to blobs, so should not
be added to the name_hash table as they must never be queried.

Signed-off-by: Alex Mironov <alexandrfox@gmail.com>
---
    name-hash: don't add sparse directories in threaded lazy init

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1970%2Falexandrfox%2Ffix-threaded-hash-name-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1970/alexandrfox/fix-threaded-hash-name-v1
Pull-Request: https://github.com/git/git/pull/1970

 name-hash.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/name-hash.c b/name-hash.c
index d66de1cdfd5..03123a8779a 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -492,6 +492,9 @@ static void *lazy_name_thread_proc(void *_data)
 	for (k = 0; k < d->istate->cache_nr; k++) {
 		struct cache_entry *ce_k = d->istate->cache[k];
 		ce_k->ce_flags |= CE_HASHED;
+		if (S_ISSPARSEDIR(ce_k->ce_mode)) {
+			continue;
+		}
 		hashmap_entry_init(&ce_k->ent, d->lazy_entries[k].hash_name);
 		hashmap_add(&d->istate->name_hash, &ce_k->ent);
 	}

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
gitgitgadget
