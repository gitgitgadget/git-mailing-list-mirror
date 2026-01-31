Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE76BFCE
	for <git@vger.kernel.org>; Sat, 31 Jan 2026 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818168; cv=none; b=Lx63t93IznSkpYBMQAs+UTxSQASRwzs8Kg4lpjc9T5I7lNFF+fbRTSROSPzvFdMibFbYC1PNOIthgj3iPKY/H4O5vDphJqm+dCx/bq1u6U/VKzCfXlAiIbujH0V/B50vlDwVnYiaUwNzICxeHKVD/SzQo0Qj3XL0YR7b8aiiHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818168; c=relaxed/simple;
	bh=wPjdSYnmYbYCaYeAld9B0/H0B3Zubsn5PPkeQoy7tzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OisOpfQdFsidldJVQ/eyc9BIDTU2JSucHdoqITeZl2I2A06K3lkeNCzUpK+rZd0O9HC729G3VIfoOxX1DxtjIivR6TaKdfizSXpsrAqy2IRQkcf5Y9ujgffmo5wMQOdISfWBV1lcRbg+REZD/quwnnnqstXwutRjczQ8T/IkjlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TK8Zrkyd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK8Zrkyd"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38319cbc8fbso22927581fa.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2026 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769818165; x=1770422965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DG6hb161c5KiUrVHxj4Tk0QKLja73RbAVnfBOUAvXwM=;
        b=TK8ZrkydSjYlIAbZ3SWFvsTPMf0oBViIeu/qaQx1tWF6goZsd+PrzWKXwbkfuO76se
         i2ueoYnvujJKWNKL47QAHN5h6T2CWN5AC/1mTuvT0LnZmw3AIa7qccJgo9jFMgI/wnyY
         kNQIojzHtFDr5bRNL0QFVIh4JrJCuhJll9R8l3yRG1rXqg3L0I+0eCiAgWiE9mg6p3HF
         7psaIFetqutcE7uDrB28PZjme7g+vicg0NZxU2hGodOkj9ZxHjdCL8fyRT+SJVpZVFmD
         weQz0WXC/qe1ndBwi4TPocCw80Iau21O9eAkE2C1sZRUDq2AHsUJtrbQ1TaJYODlHbxP
         XKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769818165; x=1770422965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DG6hb161c5KiUrVHxj4Tk0QKLja73RbAVnfBOUAvXwM=;
        b=Rr0UEc6IaytlBjHGVi7RKrETDCPXbytnGWomRzeDYNVuOmfNP7tNhNxbeMlqHNm5/p
         1m0Qg8GEXMHbXs9KLrxIYWXit2mjSMTkgxMCQECXZhBM77YdEkM4zGVzyDPaUDkZVhMY
         9fq1L7xGOxsWmQ3ih4J3gtijAYYmHOeht0fxw8UUYDzDTYIBLuMo4+VYejSIJkHnGwmy
         /9mS1oJ729kCONmXqk94WlAieyCJOE2kJuOWX7MFQ1YWao5KLkYqP/W7H0t+7EVEqJiH
         /mxwb5M/7zr7JcJQ47qxccqJ/5QHlINNICVYGxvg5xzQrmqki6A9yUV4SmWR+MriIyYj
         kb8w==
X-Gm-Message-State: AOJu0YxwSX8/FTf0IA+oqXFqVMGrhyY6YdwFWkfD7wqCoxZ4K3Xq6X4N
	tnz9pQ5c+HP19o4Ek9cYF8BOVYMqTfecw6cfHCC53U4WoyFlcbCBhc7V
X-Gm-Gg: AZuq6aIwrtNuXbKT0x2d1h6WR3dm+BWZZrC6zX7RPbM2Ib3ZX2w34PRBqUscozCsuVk
	M3H9C3rbvZDUnyY//VUiq1ojWncwTCxDwYTsDMFYkr+b/y2UBSTNy00egJvncyJleLK98UFyMJl
	u+zSzYAdMXXrq2E92TJmq3FJ3KOpC+a+MMGCpAc/TX/upNIx7aKLSAptR6JprSgFLZSJojMX66Q
	LI4reayHVUD0WjE+0kWP7dv1Cku4IgRedqEXrGYU0wo6qH+Skl6wgT4SDxGIXvMwdCQg4stx67J
	I+I5WB6HSCcvNxunFVa33d4/6NPiqWfrTOa+EZnTyzgFPxSDw6e10PUgCVML6FqjXyhXULQVjen
	kCfCeswEtAy+LPZCCY+PQIYUwEcuK8DUofSV6XUuce5wTO8dIR7YK+5yFQFgPpQLPpXRigK7GyY
	7vXlZAlHGhipRXA/r4N6GyR5Rfk6RzBYd1ntOAG5glyqrMv7X2JFY7emXtEsn8Vn82np4vh5Q=
X-Received: by 2002:a2e:a546:0:b0:383:32d:8ca9 with SMTP id 38308e7fff4ca-38646524554mr15614151fa.4.1769818165035;
        Fri, 30 Jan 2026 16:09:25 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625fca300sm16978751fa.46.2026.01.30.16.09.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Jan 2026 16:09:24 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Sat, 31 Jan 2026 01:09:23 +0100
Message-ID: <20260131000923.70152-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqpl6q69z8.fsf@gitster.g>
References: <xmqqpl6q69z8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Meaning we should feel free to ignore v3 and possibly a few later
> versions, until we hear from you?

I pushed v4 now. Please feel free to review it.

> And from what I read as _your_ use case in an earlier message,
> init.defaultBranch aka @{default} is not what you want 999/1, yet I
>think what the patch implements is still that one.  Puzzled...

I'm agnostic with the regards to the implementation as long as it solves
my problem.

I changed my mind after realizing the other approach would have required
me to set 'init.defaultBranch' on many repos -- or worse, badger the
maintainers to set it. That does not scale.

With the new approach, things run smoothly for all the repos on my machine,
so my goal of convenience is achieved there. I ran this to check that:

    for x in */*; do (
      cd "$x" && \
      echo && \
      echo "$x" && \
      /Users/Harald/git-repos/github.com/git/git/git checkout @{primary}
    ); done


Harald
