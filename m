Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719E8BE9
	for <git@vger.kernel.org>; Thu,  7 May 2026 00:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114371; cv=none; b=YaaQgQcXweSTfwAbOsrHd/RcywszlJ5H5nRQsoFDKXggAiehisv8okhDVWPnTs2B37Jshq6p5XdHN8YOxMKdXujtY1rJiSclYEL74Uoh9tV+85u/QIed2BPiblCGOaEZ8xLY3QKZgwhk0ExU8cWZWL2fBTCI2yoIG1JFf+g1X/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114371; c=relaxed/simple;
	bh=1w8jbC8YVIBDDVyVp3kHcbUHamm4Z0BfzzT3jcOa3HU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6FpeoJPyMQqIt0j+oYJb96vGvabUBbkgbDd3PSRwuiJEQnz0TD5hYotK9fwph35XToxsFrU0LAq13DBxB2Xrm1j9nG/vGqMoI1S4jkJA9HI6B0sE0v/UtqkI1pS7NKyXyDcGPx4JBbGVhXFFwFF7TNvdDLRQIOtHtA6iyruyk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbK5GDOq; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--snatu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbK5GDOq"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdd327d970so204753eec.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 17:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778114369; x=1778719169; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1w8jbC8YVIBDDVyVp3kHcbUHamm4Z0BfzzT3jcOa3HU=;
        b=WbK5GDOqgGAde3Tu3DwLrTLoYcnBfLjXNWrfYNWgRktmNdBVf2mhAzDW+9J62xu/3t
         JsXiQHnLDwHGFBeJp29WksfTDWzKY1AKIQ+0kEP/o3jabMJI9sEvC0NTOrEDRa9Z5pXY
         eRwfjRihgHFaPSH76+82SisoNCPjbjeMwa9TNWmLJQKCofSc/lM5GYBIOgZUfSvSfrIN
         1gy9pBY3/cNoildJkZyPlDutaHoVmyADjaMIFmix6zIJ/ZemXzyuPppU8TkfT1MQLI3w
         ZE4Q5k8UWgnlK0QeEj2k4Ce16byewTBXfOcbVT6eLJNBoKtSKzF9wVwo5DBFG7pgQPGI
         gDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114369; x=1778719169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1w8jbC8YVIBDDVyVp3kHcbUHamm4Z0BfzzT3jcOa3HU=;
        b=r6/dJbrulHCYl96idF+iwmbCjuIi8KsbKuWKEePeXf8qGI6H1R0S2sU7H7CmFly2mz
         yLF1AqmpH4FR153q2WxyLwYjkByJ+ePds2PoIsXL0ow4kJO9cwj0MjsoSN42uZi7cixf
         FApkmeUoP0OdO0wzycpVNm2N4Cwi1nR/LE09H9pYQ65xzhfT1q04tKIPj3TTOsqZeap6
         BUyDAbDw6COk5Q6Tc+AKOdy46olqiwoU/mjiA0d7oIQO1MUa9oeK7MAMCfqzrc41tUT9
         +lbq1LqoIL7Xh/3jy0bhud2XEcAku8aA11UJeJXSF3ZD/QymdokNh/5iz0wwH5zPz7zz
         RKQQ==
X-Gm-Message-State: AOJu0Yw8O/PdJ1Km1z7pbmSt46HyYGmWjRYGE98lsHZFfl5kDRm+UxC5
	rNPjFU2C0Wd6D8v4PbIoGV7ds6DIvoYwfQ2n1KNKnHNufqYLa1Wk08pvlAI6MoSFjt8ZA/BLQw2
	Eeg==
X-Received: from dybsq4.prod.google.com ([2002:a05:7301:7104:b0:2d8:e3a6:d707])
 (user=snatu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5723:b0:2d2:d5a3:e97c
 with SMTP id 5a478bee46e88-2f6e3f908ddmr308280eec.12.1778114368840; Wed, 06
 May 2026 17:39:28 -0700 (PDT)
Date: Wed,  6 May 2026 17:39:27 -0700
In-Reply-To: <a9e71e67-a853-4cfb-beb8-69b98ead720e@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <a9e71e67-a853-4cfb-beb8-69b98ead720e@app.fastmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260507003927.2739334-1-snatu@google.com>
Subject: Re: [PATCH] Makefile: link osxkeychain helper against Rust
From: Shnatu <snatu@google.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, snatu@google.com
Content-Type: text/plain; charset="UTF-8"

I have remove the Google specific paragraph, in addition to updating the description
