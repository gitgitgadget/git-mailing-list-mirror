Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA3E13AA2D
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459543; cv=none; b=QPL6PUpKqKXIuiub2hSgN5Q87Y5rkyivBF8keq+S3L9EZsn4hw41QkQ5oLdhVzd48raUf3ofYGQ0uIrVKNvJPbn/QHS8qOuQLPmELpVETcYhGqiWCguzmVnUkRa77bgXfvBmrrgUpGH5IcZtW4wrbsZ82d+4GyJyjaAY88+Txbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459543; c=relaxed/simple;
	bh=MhA1fjptoZvnvEa4eic+g8rKfBpS6uEDxjDRa+47ebs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=sgsbjInM8cNnYBpGXx9Z5EfMtGaXJzf56/JVZr5+l7hgArpIPsl8g0PiomMt26dZYxHJDz75es4vtJF2sNVgdEjUhOjD/E1uWa1XSODLgW9Y87fjpdwPyaZyQq2f/LCpRV0Zxmuv/pv7BMlAXhXD4lplE0iXG1mZPe6HVTRTlWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc+o2m6i; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc+o2m6i"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-307263ad0cbso3873121eec.0
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 10:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781459542; x=1782064342; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+H1bYYIaudKWauGtTjgpx1M/CL9xAAASKT54pInnNg=;
        b=bc+o2m6i1GYtjMAAiXD0vpABIuaazNton89I4I7iUVoJYCHLThN0gfEkOoQ0Gp+PER
         kFXeQFi6AQPMEEjk0V4tvNnn07a5iYKLBnpb4BmdUEFwqQV4HkaaJV13WTDBA+FBS7n7
         p5rvAhRV7V2b4rwwmfEABXJsP7YBdiElml6AJBiYYzd2Ya+lOXWGM/y5LVvW5Y8Yn2MH
         6q9XKAd8xb+SJHUpgoYE4XrlLMFz2V0k3FquxgGqgThzovWDzJQrgUjG8q54F9XgayCp
         KwcigyA/p+/f7eypPXbDV2GdU2VHDq9RvIY3u4pxJ5E9UodOqUDgVzNk1ewKAyape7gB
         yzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781459542; x=1782064342;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+H1bYYIaudKWauGtTjgpx1M/CL9xAAASKT54pInnNg=;
        b=ln2Op3v3Y8NWNtN0pG2H5XRTqZTEZneBkxpun4NL9eo+LffiseIr/kwHfPi/q+GXNJ
         DHq2N5Izfg5PPVCUb+4LembJeK4IQB8sRksSkFjkI9RsB5G/lBHfH6iSTBN2ISAXJRRs
         WflTpCP++VY5ICL9eZ3PvgcMVlFpsktYl9eD5Bs58FU7yrt1ZG7yipJXzXSLIx7YHzXM
         d8NQEt1/tE5yN/2nADWVQOs8Qz6YpiC6cdJDCG73N5uuTVtkp9apit6vKuJ1+6Kg6hCP
         7bMzsFBSJjjtoL4dQzMHWGBfJXgj8esUxyciQYh4o/2X0kTSaRnX7SVOZF1I4oHOaBcG
         +Fig==
X-Gm-Message-State: AOJu0Yw+jUF9OnQAzo+ZnClV9t/fXPkHYVWBlrKkIAb+S0tjzb1oCH/m
	Ila9gCzZ7iai3bBmhkTGahzY4CzPZKlaeuQi8Pijks1ShcL0TIDRbSBbcJYrSQ==
X-Gm-Gg: Acq92OHXFlVNul8ODvhgz/niL7oXWspi+I7TCZaMawQnVgK4tmnekGifacRNdD9YZff
	T97TgPnj6fVtyHpZ+ztMz7jNEgFG5oEoLgtIkX78O2GgGtKijOB5LK6EqHG9nrNT/nNbzHBs4j9
	h+peUMgCsCtS9LrRf0t81K8+xu1F57joM+lUU4GYK1HwsQZkjfjX+KAaB4xCwUtdtS5d6Xi9EnC
	ysCoSi08hvflUGzcDfgf5ZWXFmuGUP+T3+/v38jFLPWsFngHPL60U0SiHsiDtwIqvAm74KcHXLW
	fVuQJRpYnwie8G75jR3jVhrsZ93kawZQhf3d83sUcuaW6UUe2tFh1MyVRcGJNPyH6caALt9CQP0
	DmT0uclwcyXYAhGhjOHfpJmrcoR2lk8rZOhXmrGMUlL/+a2MPze5/11a3QLWppCrj9jbfhWdgG0
	Ax1kaYOCyN8bku9+xIwCYfXJqyV5wZ
X-Received: by 2002:a05:693c:3007:b0:304:5a53:7dac with SMTP id 5a478bee46e88-3093d259b86mr3560253eec.25.1781459541565;
        Sun, 14 Jun 2026 10:52:21 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.212.102])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e48e412sm12627081eec.4.2026.06.14.10.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 10:52:20 -0700 (PDT)
Message-Id: <pull.2339.git.git.1781459539.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 14 Jun 2026 17:52:17 +0000
Subject: [PATCH 0/2] Silence po catalog output under "make -s"
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

The gitk and git-gui catalog rules sent msgfmt --statistics output (and a
"Generating catalog" line) to stderr, so it survived "make -s". Emit it only
when "-s" is absent, keeping a quiet build silent and a verbose build
unchanged.

Harald Nordgren (2):
  gitk: silence catalog output under "make -s"
  git-gui: silence statistics under "make -s"

 git-gui/Makefile  |  3 ++-
 gitk-git/Makefile | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2339%2FHaraldNordgren%2Fsilence-catalog-output-under-make-s-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2339/HaraldNordgren/silence-catalog-output-under-make-s-v1
Pull-Request: https://github.com/git/git/pull/2339
-- 
gitgitgadget
