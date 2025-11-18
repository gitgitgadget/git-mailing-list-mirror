Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A01FA859
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 22:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763505268; cv=none; b=E1mvmKSEuKT09qFPRIu5BCsAO/rdPg0wYbqLVjJw45LIZoGlVyQy1wf3vdqNjBiZVeT/fwzpVY350PHfGhbRgy95fLpafRQtnUoIW/KqwP90vZoOjabWREUF6+6K9BH/NDzk/91JIoPlPPDRUt0e9KJ0Ozd/drVVeAU+gUQc13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763505268; c=relaxed/simple;
	bh=jeJVuo8REtcyXkkjoEV0zgg27pOBBnqK/Z4hsC+Uszs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ujwJ18cgkFQh6qJ7YWMpwAy5v5uUXZsygBRraRLKNZNgEhfxL8RwTvMYXHc2/yzmwJxK2bmmnTGLQ0ijJyniRz2bnsOwjs18FGufuT5HuI912hGoEw39Ka4aA7alOrLfYyrKrRpafKVnXU6jHDYeuqqJT9Ljfw3jb2heKUiwB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuLoACK7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuLoACK7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6136652b3a.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763505266; x=1764110066; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is+Y4OtDniKKLO2QyFgOzpMa/iDGzBTXGW05qdr/U2U=;
        b=kuLoACK7gvkDmj3oCtWSnmuGp9cm3vLbUiLUjYx1z2UV0GqZZYa15m5WuSSF+MtOuI
         rj+/8fRvNyV8N70fV4pO/A80h2aapLQSlPUSDFOQfXq1BZcy8Z0fj8GH/gg+2AFzkccp
         q7pF34fMSAvS/qkCi3EpJUhBOWkfos3UBcd/PDwJLq3asPbYlWvP0vQWBIio2ZiluGJR
         0ZRKBfgWA11Y1pFD4l4pPaB5auzeMLNbCOIbAVz89FsxxclCNPaRY4560a6KfabKpNhR
         r8oxK158plOCrL+863T+QtwTh5U+gmIvqk7/PFK/nOz/Uc6aL/lupPMOfdo8BtyBpXij
         4keg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763505266; x=1764110066;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Is+Y4OtDniKKLO2QyFgOzpMa/iDGzBTXGW05qdr/U2U=;
        b=Ca8PKaIqNpqYkPwI4TPCqXzIKazHuz5nq1rKvO/3eHk5sRGh8Jjh7Ekj7oBFXpIIkm
         jM+y1VNBmkrfj9LQRky3FTzpD/NLZ2XQEy86vNP7o+BHx8qqISpn+YDrLaQJUkgmNefi
         1oOBLOzATLkEN2jss92kbfBJWPUYQTwVIKhh66PtBr/Bo70g1JahrAs+Hh9GCN+KNbsF
         zMISMLs7+tNRieuT3xNnIIwwNy+2T/1PA/bAF2NPNSqGT8DZVwC8Gqy38GkPgtxKsku7
         o45YbHwfSsh1oX9Up2GJTHk3C6DlqlRwn9YwV9VlFQY7m/V4RxZrMEDW0LD6ycS1F4Nz
         RDRA==
X-Gm-Message-State: AOJu0YzTY8Svs/6qxTRmhZnIVyDOGElRMBAsqo57UNjM4FAKCzcCEYh8
	nIOvnz/79uyn3lMPsVlEJzqfl+mEfvpMRjlhKxyBgom3akUKe4D9xSAZUZcCpQ==
X-Gm-Gg: ASbGnctBXHTZKT+FoxLeAl1/8dH7rnwylHbkKBWlLjPJpGcfiPWCdvtFB1j/6q/a4ZZ
	RnqUyRM38Dp75PHHjOxw5ljNDw3dHyZf4cvEFf+Mumq1mpxoD42Fxgnhi2ES9HcdByBvSvCHPpe
	4iceA9FdE60/kbFmSs4mk72l0uRdJ4LwwngmNuFI9SubjIzwXJsEVeqYCad5GunxAIwbabID3qi
	Wozk44nMhw7Xon257LjKc917Kv/xl+sGE4vIlGg8KIAeq1ygkX6HkW182IoxjoXgLG+kHTNjITN
	OcbH6x8efGBInTespYgGE/xvxDQuXLlhmiYKwX6gbN5YIcXRb34uHKcx5ywLCvcqoAG9AZXIbbh
	UswhFJ7FJAkhfdF48KUl1XKMXBfk2HgnhQFWNCLq1wmp6/KoOI23XsO2YWfswYBvrpct82BE/bt
	7n6rezcd1DvpyLd3yuuu+PGT4cWYpjVM3NYA==
X-Google-Smtp-Source: AGHT+IEYOgv6RyPJDrGVGeMg6QgDaSZO+War3NMfvWjiTSTeiUQX7pl8RO8Pb2SnHArHMokZIxspJg==
X-Received: by 2002:a05:6a20:2586:b0:33e:eb7a:4465 with SMTP id adf61e73a8af0-35ba058002cmr21065734637.22.1763505265993;
        Tue, 18 Nov 2025 14:34:25 -0800 (PST)
Received: from [127.0.0.1] ([68.220.62.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cda04sm17391080b3a.19.2025.11.18.14.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 14:34:25 -0800 (PST)
Message-Id: <c4193d11f552547195e04c1318f0c2745d6a59ff.1763505262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
References: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
	<pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Nov 2025 22:34:14 +0000
Subject: [PATCH v5 02/10] xdiff: use ptrdiff_t for dstart/dend
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ramsay Jones <ramsay@ramsayjones.plus.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

ptrdiff_t is appropriate for dstart and dend because they both describe
positive or negative offsets relative to a pointer.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index f145abba3e..7a2d429ec5 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -47,7 +47,7 @@ typedef struct s_xrecord {
 typedef struct s_xdfile {
 	xrecord_t *recs;
 	long nrec;
-	long dstart, dend;
+	ptrdiff_t dstart, dend;
 	bool *changed;
 	long *rindex;
 	long nreff;
-- 
gitgitgadget

