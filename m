Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D5A94A
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112929; cv=none; b=lUZU/35r7gd0xv93kkc2Z1KlXCSYZ3H00VGoKfs19n8S9UViYtKSStxHIcvOvkCaIw2wciAlOw4EC3Eha5Dqk/AOu8cThdnAJFeIDDvs4cdDHMpI7xuS9GaBvOLm2iCzy2weGPRY1aF1+llgx6Nl/WIcTOqPdaLpmFbtZgylvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112929; c=relaxed/simple;
	bh=qoic+0vHRKI/9HGxfVd4tgysjcF27XFtp6k6OdB/+DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpQK/ZsG+d9oKkvBy6MCLRxQ6/Jpw2Uk/AzKZG+00ixRIgKBwSTdglh0SDPslsPxW5u9kaj0FmBMBr2IOusAqeuUw+g/L9FEIq9FKpfJjPkU8IJjbzyVs02S1LZBhSJL/rmnybzmc/r7tdZ2GH2Ev2ow+awnCf2Xy9a0s/cWHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gv9yAATj; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gv9yAATj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abbb12bea54so52127966b.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 04:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744112925; x=1744717725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5f/4Wmv60m7Ci9+MtUcogvQGrxBu4Fo/sKs19tZf3g=;
        b=Gv9yAATjSAyyH7r4XLjtiDss7glFqWqiOIzqf8Wd5QIhg4Ohj6XUqeDsWJrWAMehZv
         NL/xH1aalB5OWKubHP13pe/RNh5ybxeKaALFfNKzhcA3hOhYI7BCLmBF33IUlNoHF15v
         j5/i0sSfXrTmmfDU8q41yxcY8fsKC66U0eIkpHcI5UZR1UputxJ/UPlulQCE804vuwmt
         f1hjWEsHXXrvsbEtxuzITOPT7onQIlTC6QR7dBr3oXZ0ulBKq3qc5A2TArII569xUB9F
         ssdMJaxdZ9VpyA/z7wuVhWVqSIU94IfnFjzyVicZXdL+JpbAnP9kw0rj602VsAwALTem
         ix1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744112925; x=1744717725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5f/4Wmv60m7Ci9+MtUcogvQGrxBu4Fo/sKs19tZf3g=;
        b=dh2f95SWk3TXRB37e57jgBuaSJV7iOMEvc5ksH2HNcmw2rfez59IaZr7lAD/75Ne7n
         5oRbRqY/ddPq0nAMeudwoJygKm/JpH3nn1PeBUZ+H1VtndddpEdUDtbAhGKvobEA09sb
         98WF7ANgB0mSCOFaOUawpMSyLHCuEY4GbDFo4kEADlbk5BMQCJLoO5z9nzYG2/aJtcMn
         s66zUaRWv8bfErBVk48i+CLsClT2NTf424G30jAlaIkNk2qVyT2aN43Bihf2zg5GWLKF
         CFFKoFZ5y+9czge79ll4Mf6CBiM4Cve8/e/OnEFCfXHW4HXsn7jCnGrLJ5JqSgvLURgZ
         uZWw==
X-Gm-Message-State: AOJu0YzC2yI0fP00XvCTCzmahRzDauE2iIUye/nOOiGja4Q4j4+EgMMx
	zc26PYXp/4pchfPyvNB+BLT27IBdoKlmMd0X1SwAlF5Szc8NgfAiAaCqOqsqyg==
X-Gm-Gg: ASbGncuGku7423QpT5/OpC16kiZxrZwkcKG45BcXaSJ/rjQv3jTgMk7aFcnofrckJsI
	rYvIJu/JrUOlqBX16rhXzCPx09+sxKIvU+cRmor8/XonS8WRLxPTES3hQJIPU9uyVBw5qnxUyqO
	evlNipFPHQ1K0Y8etvaoC7Iq2Jsj3VRmc3o0t6NBEM2sRGIhkP89dAaiEADH45Ixt4K3AktrSZv
	kTK12IyT+PQegJxNYDcRyUH4GQUQZ0oeDMgWsDte2I+kUeSjVQWBjKZ7UJ1GRwrVVYNuSMOgQC+
	k5LxQsUUOBIvKdxHnDSQ3kdT3I1AcPJe9VC0QKFCW9Gz7Wjc5vU5d3pNWYEBrXD/01yFHW2w8I9
	THoI2bMKkpVQIoYGnataNuAx/5NK3vQn/+WOR3OEHgeRYH/azbg==
X-Google-Smtp-Source: AGHT+IFlj1PMnkoB8+eOylRCV3iTPXwFYtvK7V38l3zyan9np0+2fZ60vhCYGvFwYLmVcb9nArkdig==
X-Received: by 2002:a17:906:5a6c:b0:ac7:d7f3:86d7 with SMTP id a640c23a62f3a-ac7d7f389a6mr1154880766b.50.1744112925421;
        Tue, 08 Apr 2025 04:48:45 -0700 (PDT)
Received: from localhost.localdomain (host-95-230-249-134.business.telecomitalia.it. [95.230.249.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c018691csm904181266b.150.2025.04.08.04.48.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Apr 2025 04:48:45 -0700 (PDT)
From: Anthony Wang <anthonywang513@gmail.com>
X-Google-Original-From: Anthony Wang <anthonywang03@icloud.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	shejialuo@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Anthony Wang <anthonywang03@icloud.com>
Subject: [GSoC] [PATCH v5 0/1] t9811: Improve test coverage and clarity
Date: Tue,  8 Apr 2025 13:48:40 +0200
Message-Id: <20250408114841.58592-1-anthonywang03@icloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250405103718.25160-1-anthonywang03@icloud.com>
References: <20250405103718.25160-1-anthonywang03@icloud.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to expose more testing outputs, we remove the piping of `git tag` 
outputs in order to expose the exit codes. In addition, we change the 
usage of `grep` to `git show-ref --verify` to check for the existence of
expected tags in a cleaner manner, preventing false positives. We also
check to make sure TAG_F1_ONLY does not exist, as it is not expected to be 
created in this test.

--------------
changes in v5:
- moved commit message to message body, and fixed subject line
- fixed whitespace issues in patch #1

changes in v4:
- changed `grep` to `git show-ref --verify` to check for the existence of 
  tags, and added a test_must_fail check for the unexpected tag.
- consolidated the three commits into one, as the changes were not 
  significant enough to warrant three separate commits.
- added a new commit message to clarify the changes made.

changes in v3:
- patch #1 and #2 were missing my sign-off, which has now been added.
- patch #2 referenced a line number, which was not informative. A new 
  discription has been added referencing the context of the code.

changes in v2:
- patch #2 and #3 have been added to reduce confusion caused by the 
  implications of `grep` followed by `grep -q`, and increase debug 
  output.

 t/t9811-git-p4-label-import.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

