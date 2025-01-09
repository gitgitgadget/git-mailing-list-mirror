Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292672165FE
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736423356; cv=none; b=onFU5pT5tMPFeu9hxHcaol71mv5NaoOR91pLEfrcZGwT7xL9OUAH913qsk7moRJHuQCTBn6/J3V9WUWAoX54QFzJhdA3lKSkmUKy3+UQZVIhKzD/weD2WIIlmny4OsYjgeiT5mrMfPDOMraUwrFsuyZ9f7W4OT+I1yfrdtDgbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736423356; c=relaxed/simple;
	bh=A1nTSsJwl8u+NHxQ/Y8J1q/BrTekMAR+Zz93vLN+M8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CWGPM9rmdljAwjQif2cc7vU3z3lTZxyj3hW8fZRj1XIgH2R9Ll0bbeakNbWCRwktrQEcOuH5/lEj0/t8BuVBUnlaGqzLT3qM975RVnamw8xyucDqzWMiF9oSKXpUqKTr7Zqhk+lJKZ/Uw08QLCtYnrJdHDP8wUS1DK52oVVP0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com; spf=pass smtp.mailfrom=jetbrains.com; dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b=XGtPRi8c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetbrains.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jetbrains.com header.i=@jetbrains.com header.b="XGtPRi8c"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21619108a6bso11762505ad.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains.com; s=googleapps; t=1736423353; x=1737028153; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ixT83ccl1+BrHsl7v3VkX6U/MjGIfa72UPUx5TLTfH8=;
        b=XGtPRi8cXQy7Q9fWg6oz3+8eZTuSBum9FIpGnG7QkMpyDPE7jOV0lXQdcexvMnGJd+
         rhfE00atR0L0hX+7MJs8jZk59PD05VuUbAD6rl+wqDxDZB3EhLnAsr5U7T2ww364P96H
         rGxpvovZ1BQC/1tlMI0jZstAnbEkZ5vDLcGig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736423353; x=1737028153;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ixT83ccl1+BrHsl7v3VkX6U/MjGIfa72UPUx5TLTfH8=;
        b=qQ34Wnj3xtaLGcJrCMQ+wASQtg5LZY3CqhN5k40A79/VldSoupe9n8JveUSm3hlQnB
         Ubv1MTDVoyWfN+S6ciKMeovPtS+H6f2ETk4IV4xIZih0TAUNgh/fUq5BAqnNmx//9Yc+
         uwanvvZNOPmoLOWdI58z7bIwKtp233BxF5n2q7naBSBFR5GzjNfi9erhWUI2JBzhNdGL
         vj7d5YtvnsYGNhBXuke+qdSBPqRMY3iqCJcejJ139LwBetyLNMJG1f5qOOFLKrqtlNWl
         ox0a/dJ4/+h39KftrMTceOgZdNLgJsGdV8No4nnD07j7BU53NLTJ56vfVXjLzfv2Bh2c
         dhqg==
X-Gm-Message-State: AOJu0Yy3b1FH4sMu98dv9X6nXc8Vldvj9pXC+OtzJB2jp/xK2RTigQ8G
	nPEKmlEtaVEbq9rd9ekshB3IODqKW73mVKBKmhbTQEGOGZbxJRzMKAhMGq3AtMMVIx1sq7DFYl7
	Wwq1FfAbxoL0nmZjsk3YnLxlnlLBBOsZGPZl5HsrvNdXELUScam0=
X-Gm-Gg: ASbGncsIKReulnVTkqShurh3/8hu2kqaK7zlflkJgEcBQxhQn80bzINPPzuwfdQkS4P
	GI2pMUxzK8yNgJo+pDZxjMITre05h7BMoejZIWA==
X-Google-Smtp-Source: AGHT+IHFQNO8adGAZIQiE3RXRFQaJxI1eT/VCdNzWpinuiu4oJ5HRA+6lObUVZuIHnGAkA1DTJJc1ugOaYtL8rFmvSY=
X-Received: by 2002:a05:6a00:2e1b:b0:729:1b8f:9645 with SMTP id
 d2e1a72fcca58-72d21feb6damr10122863b3a.24.1736423352937; Thu, 09 Jan 2025
 03:49:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danila Manturov <danila.manturov@jetbrains.com>
Date: Thu, 9 Jan 2025 12:49:02 +0100
X-Gm-Features: AbW1kvZb3iliidUfUDgVTUgpWbIe391dOtl8QWaiUM5CbLGayiIpK8TT3Kg5L6U
Message-ID: <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
Subject: Git 2.48. Changed behavior of the git fetch
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello. I work in TeamCity and we have tests of our git integration
running with the latest master of the git repository. Some tests
started to fail since
https://github.com/git/git/commit/5f212684abb66c9604e745a2296af8c4bb99961c
I noticed that tags are not fetched with shallow clones. I published
the test repository to GitHub and reproduced it with commands, the
result is different for 2.47.1 and 2.48.rc0

git init
git remote add origin git@github.com:manturovDan/repo_for_shallow_fetch.git
git fetch --progress --depth=1 --recurse-submodules=no origin
+fd1eb9776b5fad5cc433586f7933811c6853917d:refs/remotes/origin/main
git tag | cat

RESULT:
tag1 (git version 2.47.1)
<empty> (git version 2.48.0.rc0.38.gff795a5c5e)

the repository log:
* commit fd1eb9776b5fad5cc433586f7933811c6853917d (tag: tag1, main)
| Author: Victory Petrenko <vbedrosova@gmail.com>
| Date:   Wed Feb 3 13:05:03 2021 +0100
|
|     recent commit
|
* commit 64195c330d99c467a142f682bc23d4de3a68551d
| Author: Victory Petrenko <vbedrosova@gmail.com>
| Date:   Wed Feb 3 13:04:44 2021 +0100
|
|     change
|
* commit a1d6299597f8d6f6d8316577c46cc8fffd657d5e (tag: tag2)
  Author: Victory Petrenko <vbedrosova@gmail.com>
  Date:   Wed Feb 3 13:04:17 2021 +0100

      initial commit
