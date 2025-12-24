Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C925F98B
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 10:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766572719; cv=none; b=X9bJPPnTgs/oAosntKjOlCBcPJKHXCfWG5iimqYB9etpuJQgdHlL9vFAbKnbgGcMSKXFiRCn7wdcytrnxYrZ7lQ537x/bCsBtMufzo6badnvyoEfsloijRsWAZZHltyNBKLVpPqhZrYld5exHa60TFz2FDUoZH+5/92j51IC+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766572719; c=relaxed/simple;
	bh=AmRol9o1f1oXuwoWczFo3ujMAe7xQZ7TSkAMk6N971c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bB692cU93u17f36OCWgJYWUsiKVNPq1y1csur6AcJbwGK/WH9z9Y89dy+WhRIljmgBTJLhNfyE1YSTKjwlQLNNWrDAUU4qboc0qvt3p2/6NbKGqVCnooP7QpKkGYMkSE95RypoNxp3ko0dLGGQHqeQzBtTZcN9iQpq+6EvDdw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FhEoe8oc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhEoe8oc"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a288811a4so65957126d6.3
        for <git@vger.kernel.org>; Wed, 24 Dec 2025 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766572717; x=1767177517; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2C6mm2u9FO12i40ANrOqlqF+IonW4HKjohSLaZZYG04=;
        b=FhEoe8ocT944qQG356MnV2ajk/L785YXMwM/5l2F5DExsasPha6YhtmMf1p6086krL
         2vt6HOvtkC9CfEPCMeqJPSh9mAJKIlswLQ29T4bMD1sJQSC1jQvXsNmEPuV9p8uXtkSc
         ZnkGYa8nDOcv+cHIoSdIAGI1bXYyAki4KFd0T0qXm3QmsoRx66xVBwyjrbV3J4mebsw9
         +nej3dKluk4nCQhvo3morkJe65TGt6rqKasIo/PjEXdFws5JGIa3FjgH3xeZ//X6AM3m
         4+iRcVjSgJxtQW9a7QLfoAExDV3exLvm1OUgUoravc9emi+os/96uCiHMNsaNhpE27bx
         fSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766572717; x=1767177517;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2C6mm2u9FO12i40ANrOqlqF+IonW4HKjohSLaZZYG04=;
        b=C8Bq+Gwcmv8EG8oIXaMb645BYAqeqQFRJrevRgmqpg7TidLwolVZM8FNNYTv2HBs6I
         bzIYIfSbUwajRaH2DbDeHvaTQTru8prbzdg2O11J8al7O1KPr4vIWaRdpngHQpN03/U/
         EKVeFObmWEIonMcjZXlt3KX5EaDQvwd41gtoGWEXL8GcRfRXwJ+5uCq1CSEPclyaNTJD
         iJ7UnNh5Q306tHsSJu44Wn8EM/rrANIC3tuuw9ZQ0OTb8rd7fnx35tlmdOLsyTdYwYSU
         FJz6IyTRnmqhTfznfoB0zZN1JLTJWlfI52evZ7SG3+vV0BsbfxfsbCDChw/VXMSl6+fw
         5QKw==
X-Gm-Message-State: AOJu0YzD+SOlY9OhWFq0McjWYY7FEXthg82qyv1RWxOyrgBhc2ppgdV6
	k5+Y19rDpi2DJMaRN8kx5sbEOTgV6M1qgV9sJ8VxPBj2aviZqHQm69DREDNEHpfg
X-Gm-Gg: AY/fxX7pTDy9gOTfST+/7+uBmE7FIvAKh6upQz9aA1kR2XH8EY7k+YeRCwOUjviOfVd
	pwqb3LbNMTmlavVNtenBfZJ/NYriOcV5V7GcArIPjrEYnuNeWqaYaEWFK7xpag17+KnxGDHaelG
	G4Yn3njl66YyTDmpg/ZdbFRxCGTiRvgljOb4XdA3qUoncr3PGeoslwvIV+ED6l+NbAbX+gh18wG
	ljC3tP84M2Gx/y5hXdzLHIdgFXErqJhK8fBpWAjISLy3/wJiac9ObnxLethW5i/dO2fE4i3hVI4
	u95ggj3hoUWnPnPTcba5fnpBttTNt1Gx2vhjo5jDtFW1TWhzM1sumenExaQ1EyJc7NQXjz8IRAH
	x98dQDZtAc/2I6q+xrjPMvE17tN78/1oVdXqqe91lNzbYhpW4Y7nHa1PYb/PlMNGEMayDh4yVo4
	q/Ry107/nNV4vq
X-Google-Smtp-Source: AGHT+IGjqQ0U6jWbVziDspRHxzpv3w+1m+MB2v7xdeEnjpC03UIHh4bIUQSh7+FxjqIce/4mh/Sf6Q==
X-Received: by 2002:ad4:5c8a:0:b0:880:4272:9a5b with SMTP id 6a1803df08f44-88d83d66e33mr293548376d6.50.1766572716696;
        Wed, 24 Dec 2025 02:38:36 -0800 (PST)
Received: from [127.0.0.1] ([64.236.153.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d9680c323sm121844686d6.13.2025.12.24.02.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 02:38:36 -0800 (PST)
Message-Id: <pull.2138.v5.git.git.1766572715.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
References: <pull.2138.v4.git.git.1766571587.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Dec 2025 10:38:30 +0000
Subject: [PATCH v5 0/5] status: show default branch comparison when tracking non-default branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Chris Torek chris.torek@gmail.com cc: Yee Cheng Chin
ychin.macvim@gmail.com cc: "brian m. carlson" sandals@crustytoothpaste.net

Harald Nordgren (5):
  status: show comparison with upstream default branch
  Simplify default branch comparison logic
  Use repo.settings.statusGoalBranch config for status comparison
  Rename default_remote to goal_branch
  Add warning for malformed statusGoalBranch config

 remote.c                 |  92 +++++++++++
 t/t6040-tracking-info.sh | 340 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 432 insertions(+)


base-commit: c4a0c8845e2426375ad257b6c221a3a7d92ecfda
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2138%2FHaraldNordgren%2Fahead_of_main_status-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2138/HaraldNordgren/ahead_of_main_status-v5
Pull-Request: https://github.com/git/git/pull/2138

Range-diff vs v4:

 1:  a3800aed18 = 1:  a3800aed18 status: show comparison with upstream default branch
 2:  417f2075fb = 2:  417f2075fb Simplify default branch comparison logic
 3:  c9ec5d9610 = 3:  c9ec5d9610 Use repo.settings.statusGoalBranch config for status comparison
 4:  0e308141da = 4:  0e308141da Rename default_remote to goal_branch
 -:  ---------- > 5:  441678939f Add warning for malformed statusGoalBranch config

-- 
gitgitgadget
