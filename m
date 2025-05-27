Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAFD1D6195
	for <git@vger.kernel.org>; Tue, 27 May 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333669; cv=none; b=DfmewyoP6CRUJiVN7oCFtlZhbbCm8IzwdZxYFy+E9GmlPBHIa08GVl0wpzLjhdj4x85UmPEznUdCAeKFSsOy43Gdu8admZNsq8PqpMMZtiYO8cCtNSkjgZL2PFyE3pewueo+PkGqDlQg2MkawmFlBWHLqt3xre2ej2iOf8bHX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333669; c=relaxed/simple;
	bh=C4LmyfY0GuP7Whjko3jLxxp+IxeixXF5rvuICuRBQ0k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=advRHQ11Kr6BpQLklby2poOWswaHkmgQ+OezLvhCO7nkmUr5qlzbHr/9UY6CRJQ1NCAFH4Z16glNbSeIICVdLl2Tlqoq8lKN99ORlUhXZ4AIM6a+4vbr7pks44rsQQBKuR5f8yHbJYCsP0wrZs3HnW+4hjuP9bf2SsXPmNFhHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrCUr5w2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrCUr5w2"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-742c9563fafso1985002b3a.0
        for <git@vger.kernel.org>; Tue, 27 May 2025 01:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748333666; x=1748938466; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4LmyfY0GuP7Whjko3jLxxp+IxeixXF5rvuICuRBQ0k=;
        b=SrCUr5w2QVP7t4wPb7Zbuuk0xlOyzWOkK3K5xxc9ymoMbc/AsPxUgO03UqBpXl8dAM
         1bgzJvLPNNI6cu4YsPMF0Iny84JOIIpcagTKv8NUrtR8LZbsa0MfaLo+Lw5y/iLbSQSV
         nA/GAYPSe7U6R/TdA9GgdvnUk4QnqVVs7vgQtrSPf9HXncJQGEp80Di64oICkAcHSDsK
         QiiEsp0sUzwyZ0UQUmn3vJ5eaBf30oXQ90atBqzfRLFDpEkyHyqHVDQe3K6h6fLqWGqZ
         kg5ZJUakWmTSYcIYic9KjQLv0QQOsht211QKpAXtDNDclg6DuPAlOpVp76gCVZu3XOLB
         A9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748333666; x=1748938466;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4LmyfY0GuP7Whjko3jLxxp+IxeixXF5rvuICuRBQ0k=;
        b=AmPoyO5yxNy3Xg9QBbYqTDMpwLVpj2PDbX4qSEu70vpoZTmKq4H4+iaJ+Yp7dLsPR2
         mWfIaAdjZT0CWEzmWChDjFu1KQq/Ns9NxYpvhSMVg/qbB7WGd9RyihXLf9ip6MMr4VpU
         LUIYlWHM4g2w0Y/n8HPnVBuTyAloDICzmLQ/sTNzgdKDv1Q+Qbw+L1jeclwpHNRtpheH
         EI2YJXr+/gDc0grF36n44qazMeASiEck0dyntjXPMI2sZcqtJf2qqsvv0vsmGnT/k1Rx
         V9OCoEPkUTqBEFFNrSULm10JQVeKTqvlm8DJWs3TkFHOYvN7lqBUckaiaaFjUYp8Af7u
         9XPA==
X-Gm-Message-State: AOJu0YwMeyaqAM2MWyE30oOVPOlvBzM+T2pQp4ZlayRC7M4IFmO/NKD0
	2s+3zOoaf5CZmR5mESc4ND38vKzvoPcPO+zn2UriJTJFO+VCqbwZaGQQtW4CdyCSc1oP0IrMKeN
	zxMZezVAvD9M95IFsfW7Naz70b9vQjsp4jJ0U
X-Gm-Gg: ASbGncsFK2S0Wq1nXaAAHlTJNsLBZN7ygktI2B9jZBRmpmVxkgX1inlj4A5Uy5Xo1Ga
	jGCU2ne9KwcHebQrPImhgu+QiSLlBxwVTGDh/olMLcHq8SoZoziP/2CIXlWpthHdFg+xKg6XdIF
	jHUelCfLjbCCU6A5WRl1Y0AItOTnCYPgf3eMY=
X-Google-Smtp-Source: AGHT+IFpuR+TAy4hO8C5a9lQEygeX8QoAsCLwOjV74IhPQ1v9yhImzgzKwPQjM83YZUOtrXtiwF6gupx8gaQkUpZugE=
X-Received: by 2002:a17:90b:3d4f:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-3110f0fa694mr18487198a91.3.1748333666299; Tue, 27 May 2025
 01:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Tue, 27 May 2025 08:14:10 +0000
X-Gm-Features: AX0GCFsl4usN3FvOEQ7D1wYSUQcbTkNjz5uiS3qlUUb8S7qWfh23QSbnz6_G370
Message-ID: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
Subject: [BUG]: Non-matching exclude pathspec causes an error in empty
 repository when the flag "--update" is present
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I found a regression in version 2.45.0. (It's still present in the
current next - 2.49.0.1266.g31b7d2e469; earlier versions work fine.)

When you run "git add --update" with an exclude pathspec on an empty
repository, the command fails, showing an error about not being able
to find the specified files.
This happens only if the repository contains no files. Adding any
files (even with "git add -N") or making a non-empty commit fixes the
issue, regardless of whether the added files match the exclude
pathspec or not.

Way to reproduce:
git init
git add --update -- ':(exclude)foo'

This results in:
error: pathspec ':(exclude)foo' did not match any file(s) known to git
error: pathspec '.' did not match any file(s) known to git
