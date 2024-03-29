Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004D137C39
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711746742; cv=none; b=HqsxtLgco0bdy9DuvjYaf8ZPIS2setb8VBawNa8Xm7BTfXc8I6BMWQ5+PTeFBLa6sJbYDls5ce2kA2WClIkcKQv59ja/4EED/BdeVRAF2TcoDZDD+nlPbFKOWJM3/k0sv2RyjcRJHjLIY9uCJaG53Ke5Svhv3UAoeuJYztAym88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711746742; c=relaxed/simple;
	bh=iVY6pFFhSMPqfdcN+K4Xa5eE9tCX5ezRomczN3gr9Xk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=aqXy/YO9qlJp92MGmI1J8bG4drK8djMOzbeqSHVTY+RkVTrWo+JRXDj3WeQFxD2eFWJnv26VyJKjDpx7uHbcWXF/iPkMhGCyJPI+PeLt5S6I/+a1VsDSmedju3FMlbf20rglxscyBUInl36dAIyG8vPXK0rQ2tGl87/uU0FJUeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eOrqFuWE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eOrqFuWE"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4751063318so290663266b.0
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1711746739; x=1712351539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iVY6pFFhSMPqfdcN+K4Xa5eE9tCX5ezRomczN3gr9Xk=;
        b=eOrqFuWE6WBUe84Cz4bv3w0YFIRhmF4mUT4JZ9MyWjzAyVLJbznYYQylHmtFGqr+Wn
         9cQjgjSEwthnnrv9jWthZaSKxCcjVKjvaanLBHmHCC1pQa+UtMlMHflVQAbShVlB7z1r
         FwzimWTaTEIEJeefelWomVvJmZV4nMoSHORE6t4HQhAMZnHK09uOI1NNrVBP6KVVUuWL
         7x14jPU+61WsDLZdNkciltduNUWBrXOMq8+yXIhhTXxW/6Uv2wTjkU4w4CU90SX9pjAF
         EAgtyCog4L7gP60U6QtR90nl+PAYabrM4LHBvotoWGIs1oDq6VCVzPlDIr2qwSzZyF6p
         dRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711746739; x=1712351539;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVY6pFFhSMPqfdcN+K4Xa5eE9tCX5ezRomczN3gr9Xk=;
        b=Vi2HBychItrPv89Ly7sxmuY3GphsSOpGc/fjP5AF0uyy+GbKevO8zq3p49l67rHRVb
         tVblaEt+dAFhth9asgTDMp0/37SGKFxnEBgvMa8QykfBfnzG2nurSXyhv7QTTwAIVIbu
         +unJGPlkkf+5EDMgVeuwjcUi/+3IyC3uCzZdTiz+AuWw40mKX6ih2N2E3CAppoR9L6NE
         iuKWytcdBa24brCATwZU5sF5vA/FmPWZZWWfOuDQlDMCRAGNo59l97Scm/H+32ANLzQW
         H42SHPck2Mr7dBG4QhbRivif3llxBXJ8L6WQfaJStIu8CFMqzhr8uG1926qfJtMFehpX
         iD3w==
X-Gm-Message-State: AOJu0YwOUOgcRxveJhiqcUKNyJDXmm9PbVFE+4Unx8Cozpd1sV36yuou
	lwBbzHBOkZ3jvl8n8iNvhIK9DxotiD0Zk7q9y8SoKED1/41ZJck=
X-Google-Smtp-Source: AGHT+IGVp8eUGPrWC8KXIiZ31Fx/x5s7GXXpHMl1zhYLF3I+/nFcbrtASQ8Fd9kXjnnyllTAY6fq8A==
X-Received: by 2002:a17:906:b156:b0:a45:b91f:2f95 with SMTP id bt22-20020a170906b15600b00a45b91f2f95mr1996222ejb.72.1711746738638;
        Fri, 29 Mar 2024 14:12:18 -0700 (PDT)
Received: from ?IPv6:2a01:c23:8cab:ec00:29cd:2c5:d8a4:4fd0? (dynamic-2a01-0c23-8cab-ec00-29cd-02c5-d8a4-4fd0.c23.pool.telefonica.de. [2a01:c23:8cab:ec00:29cd:2c5:d8a4:4fd0])
        by smtp.gmail.com with ESMTPSA id g22-20020a1709063b1600b00a47423b4c33sm2336843ejf.128.2024.03.29.14.12.18
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 14:12:18 -0700 (PDT)
Message-ID: <6aadf39561e13681c069d4da7b1a4581f143dc92.camel@googlemail.com>
Subject: Git Gui Clone: Error Failed to create repository (with hints)
From: Tobias Boesch <tobias.boesch@googlemail.com>
To: git@vger.kernel.org
Date: Fri, 29 Mar 2024 22:12:17 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello everyone,

when I clone a git repo (from github or COdeberg) through Git Gui I get
the following GUI error (nothing in the terminal and nothing in
journalctl):

"Failed to create repository <repo-path>: Hint Using 'master' as the
name for the initial branch. This default branch..." and so on.

Screenshot
https://i.postimg.cc/66df98MZ/Screenshot-from-2024-03-29-22-06-49.png

I have no idea what is going on here. Has someone an idea what the
reason could be?

Cloning the same source into the same path from command line works.
The cloned git repo opens fine in git gui.

Best wishes
Tobias
