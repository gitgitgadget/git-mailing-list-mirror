Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2C512E52
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373479; cv=none; b=eG969DIItezn+any1FXof4IB3LbSuefSZjV9KfezW846Bqd8ej1dFNZMPdPmzW+iFjGotGLSjWG8gtisJUdAiUpDgPCm+KkNbZ9VJz/J/OWSvQBHGAOH6NzyBHtf2kGHvmcDXo46mhfvZW10Ygq9uAy8sAZa3IsoxGQY/YgmYuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373479; c=relaxed/simple;
	bh=GDeuoC5bTXC5vFXFz9T2Z3qMV5s1XWKm6canprTXdKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFueC8spulzInVBU5uC6lbmL03wbxlcBJxt7Atdzm7XHldbMBT/aUx6l+N+sEl9zQfRRsKowGzChzaCQxJ3VtpS6d/b8M+JL/d7l2gfN9TrUKC3Kh+U/YTXITbuk7FxmPdsYwRbew/L2cqqzpA6D6VaP6sLXrEsyesm9Vqwlhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd5A+T63; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd5A+T63"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563d56ee65cso4797025a12.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 01:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709373476; x=1709978276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xa/SnXKc+2cZNpJqrEVnSIm5A1nE470zg23zEFwKlMA=;
        b=Vd5A+T63pob6ag8Cki51idItZvBO7G2Bmp1qCgJ2AW0awDQLLIWB+gEYhMClUuWG+h
         cmYa1rj1+XN0f1fmlaa9BQzsfpXhb7N+s2nhzWK/NQqcWZYih1e8OPXrSGL+vW1o/REX
         jAZb6MPKa+mUTO3O1wztdBniaC5+NyGqGhO42D+gWUnQu3wB4jgKkRg2KwoD65j4FBt/
         9nkrcTiji9pRozkxJK0nXL3D6yoxKHdKAXymccIO9x/AANYKtUKP1cvN8oMi7386zueO
         PyXL6ogzgbnBqbrrA0Odl4wrderUu5us5qxK3hFAC+pwMK2PQpOmf2RSyiJM/UCzAqDe
         mVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373476; x=1709978276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xa/SnXKc+2cZNpJqrEVnSIm5A1nE470zg23zEFwKlMA=;
        b=EQhhcSU/16wUqwPTdAWpC0ngMyrrHA4fpCxviK4XyejteJlhhZ+92TGTrJje75R9ti
         DltmclG6l3Q69P4wZDNSun8HTKtLJ/giVPJNQyF/T3XqDXSOTLYlT0aCbyC8LWIJc+hN
         u6VHubxl/8CQ4RIKTwdBcjEH5iwaJ+HrWb+RbnHOoM4reudM7s9EpumHs+wXcVYRp9SG
         RHeCYlIEDb++1zA3264/qMarhNTkZc0Wfxv9W0uBkjXtB5SNuSxo+NP0SgOfqC4i8ypB
         08GqCftwVuKK/pdOwQApCSl3wtYPsvTHMdAuKoRit+PjJ+iKmEOsp1jgULv45tgEVgSc
         QIfA==
X-Gm-Message-State: AOJu0Ywab+Cv3CEclDPd0IAwcKnTePBhXRQ0wtRj19/Thd73mrQDFux/
	v4+docskLkgcAPUPWUfikSVuVfIq7tbg2KYpRhV5Q5U/YfPY77VqvUw70268dyA=
X-Google-Smtp-Source: AGHT+IFIm+NegzmAR8MdWqwEMLAzjm5x3I4JF6771tNJ9xQ7Zwbtu6ay5m5kSaAfnDf3RQb2QQ5AzA==
X-Received: by 2002:a17:906:6813:b0:a43:49ca:2473 with SMTP id k19-20020a170906681300b00a4349ca2473mr3121405ejr.0.1709373475531;
        Sat, 02 Mar 2024 01:57:55 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:f403:1f77:2b7e:2436])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090608c900b00a42f36174c7sm2555693eje.92.2024.03.02.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:57:55 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: oliver@schinagl.nl
Cc: git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] Support diff.wordDiff config  
Date: Sat,  2 Mar 2024 10:57:49 +0100
Message-ID: <20240302095751.123138-1-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the diff.wordDiff config option. This mimics the
'--word-diff' option of `git-diff(1)`.

The first patch is more of a preparatory patch, which makes it easier to
add tests when the actual config is added in patch 2.

Karthik Nayak (2):
  t4034: extract out `diff_with_opts`
  diff: add 'diff.wordDiff' config option

 Documentation/config/diff.txt |  4 +++
 diff.c                        | 50 +++++++++++++++++++++------
 t/t4034-diff-words.sh         | 63 ++++++++++++++++++++---------------
 3 files changed, 80 insertions(+), 37 deletions(-)

-- 
2.43.GIT

