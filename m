Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF17516166
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909874; cv=pass; b=nLAiuFkxID0dtw5VW91xowowYHTCuDGSuPLt0IU3SrvRMqFBufKJB+2xddjrBNA9fzkbS/jiOaTDdLus2K39GtS60+tqrMPjWCvNUr2NbVTUqQGYHLtUqR5NnLTksWajbkbU/qLWPJv9ezJim21AuxkOiz9GMICfMUQntAK7oqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909874; c=relaxed/simple;
	bh=IfNU5diZ1d/4IsQHQAJ3+Hi+GU+xWgctERq+xN8gkv4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gpuN+d8uGolhcOgh8KSW2zuOjMQ5T+V2dwcPf4yWtTRk4WpATAde/fMbCSLXGgUjj2Bh/lpkVLz9T6lBjPxIKAbvaY7yo4ZpoaqvTsmWMENAAPW3ZAG1BnJQgGV/Z5WwjvsV+oEbUJ5xDpxs8fXgpTxH2OAra9wMLMTw9RKuum0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzwjBfLi; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzwjBfLi"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2834782e87.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 09:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791909871; cv=none;
        d=google.com; s=arc-20260327;
        b=UztuDF6DSWwdZz+8Gg0daklvp9zUFIbIpaSeSWT1XpIL5+Ti6B/QLh3LocOVFVaz9C
         UOkuMOV2YRouPXaS/VqeE5ZhvF//oC2mKbALZhmGIMAEJYiK5risPun9T2Mr1c5wqCGF
         wEngIZaHyE71GHH/u2P6ggCmPe8qHJoPROfnawlmBzUlg90zddjxPCyPjHb0iCUJY7kh
         ftRQj3NrBIyh9+wq7JTLTppEqHn/7ZoJZW37ycVLmqyjHZqwPDlY6kpzVHLlV0CjceLt
         evqgXow+8FxY7zbeK3EMDWTLN6CQ7IkgXsqLUr1UhO1SaZx8K1+R1hx/2E1DPuKSg84H
         lmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=IfNU5diZ1d/4IsQHQAJ3+Hi+GU+xWgctERq+xN8gkv4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=q6ugOO1hzgEVpjwgo3EnuV4AXP9JZFo0x5ODni7/aa7yxHGn8E7XssmlSoFi4VsJ4k
         lTna9YxcdP/0NtjR1d9wLSih8F/uChpePnfUEhDXsKCTWRhQT0OjOtCSGfbNofvMR2OU
         e0yxKug+VNGOxneMCYiv5nDcCCuzeqc1FT5h8l/HbEXXGwlo+mF/R1NKfZiB2d6FGA7k
         AiS6mPCcWbgzzhBQEgRetzKla1k+/6mnB4QPqENDx28Gqk+AeI+eaI0zM8EZFhfO8HMg
         nNJg4urKyuM09p9GGdbg1d/bUaUHNjZTGxeiaLmu17ZuGSCPd7xu+E54mVO21kl9RYfD
         luvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909871; x=1792514671; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IfNU5diZ1d/4IsQHQAJ3+Hi+GU+xWgctERq+xN8gkv4=;
        b=XzwjBfLityw6GVdcjz0XbU4PII1qou1QYcQSbSWsYJpXZGdsqmX9hSsPM0g3QS1Nv3
         Cu67sgEMr3M3wBzVctCzxq0hwCwWZoKWFPGdz+WJmNG93Nh6DpahpUirCjJLSDnugo+z
         RjVk2ORuK1LRtKMLcCTdCsV1cUcmyzCqba7xCJNJWFazBOnVyDr11Q+YfcYmPCHlWwAz
         WMh3nu8vm3INf5KH7Oaf97dPJKPQYwXp7IOlZyhjbPHIbmS7OHF9qusDybR+f9pClPvT
         BvSJg4eJdyi3fkjxLbQTdqWnvPYdLReEwyw4r2lBCOT2bV0tWCxspp/JcDL38BUj/q8h
         +vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909871; x=1792514671;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IfNU5diZ1d/4IsQHQAJ3+Hi+GU+xWgctERq+xN8gkv4=;
        b=XUrypzDrHv5PDjdmrnnIZ7WZOpmCf5nJFosF7PqUbeRyhzF9LMkLAgxhMGQqoPgy40
         F66iisVtmR+cyQ3NrfnhQyPNS4e8Qs9AKuH3cDsxSbi36QicHdV1DpXrJkZNa8WLjpBi
         Djn6cEP3wxGYkV67opNig4AM0384J4KCOGpi1UaFwW5CY8Sk/r5PUPUHfTTxwRfDxg1o
         MwrinBlNfY8oAbaysG05bC5lHr6ZF2jEp4JGjakCHv0d3ulNfIpKXOzhFhNsvxMKlV6O
         f6Z+PuKLob3ew79xPdA7StwtQYRpqfYC5EOPum8S+jrx6AWhRKxyBS5agK8i6DLbCGTv
         3KgA==
X-Gm-Message-State: AFq9FYKTFf+/u/Ms8e9WfcVIiSYSpLe/Vr9sBLcpyZyxGr/zLkieGYrU
	p/iObW/BlXTKIWQqK3j3ppctSRqKfb9Z2CGbweg19UE0QyWEkJ/UmsrfHj1lpMAru6qaskd74H6
	TYxeRjnHOE3ABkVLDSHacegU2DRbBFi0ETy78p/Q=
X-Gm-Gg: AYBFou31mjohnl/t9x1rc7J1KW9yXWC+aZYjJHJ8bshIQp0HiYUbcT/PKXS0p8FhjT6
	o6W2LnhBfIBmtzTIVH/LMhyrbfYNOf5jaP1w7ZEgGGvpat2ghi6o8fk7+YOokGK6b4B6q7oT3/U
	s1RowcVk7DQXxyXaXX1bZXNTnhZtlo6xQnhj/R2wWtO1y7KqqIEc8sg1TeHBMiVW9+p3E0QcwJi
	UvN80qjt6Rgb3o+f1zFkeQSQXQtU31avx8kZIsjmcokYcNHJ9OBy0T1pFOrXCEb6Un/ViyrYgY3
	9+2hBN7GZFkVFw/F7YlMmioiue7BEhSdSM5g2oeN9oA5k1UwS0+cLP/qDxDOlneI3RBBmTljOd4
	M73tL3Aqa7ellpQ==
X-Received: by 2002:a05:6512:3b2b:b0:5ba:3300:d536 with SMTP id
 2adb3069b0e04-5bcde8ceb64mr4896641e87.50.1791909870488; Tue, 13 Oct 2026
 09:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Antoni Borowski <antekborowski11@gmail.com>
Date: Tue, 13 Oct 2026 18:44:19 +0200
X-Gm-Features: AclHuK-LEznLpPHapuoJe0H_RzKJtFHxEjRY5J-WQ1n5fjgLTm86jl4Bq_sxooY
Message-ID: <CAF-UMxiZet0qic3-ugKkovurDMP1h4Wt6kRN1J8b120Uwe8sGA@mail.gmail.com>
Subject: [Newcomer] Microproject: Pluralization fix in builtin/describe.c
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Antoni, a beginner to the Git codebase. I'd like to pick up a
microproject to fix pluralization in `builtin/describe.c` by finding
strings with numeric placeholders (%d/%i) that represent counts and
rewriting them using ngettext().

Before I dive in, I just wanted to check quickly if anyone else is
already working on this file and this problem.

Thanks,
Antoni Borowski
