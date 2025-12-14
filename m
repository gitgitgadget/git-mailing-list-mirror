Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3D117A31C
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.13.153.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765729100; cv=none; b=KAg3MlME9zZo7TpP1E8vX51VRQv4t0Hc/KNT06UwOfnx8YUWGnRVaU541BoRw5cbWpIRJqqI8A0G3Mt7p78H5bPB55a+zd41vIjJ+Bx2a5XNq8Dgw8gGklIz+5mv5VFGoQ0OlqCiEWXN6VfNV0fAaA2gw3TDpmTJ+ZNfd2J+BW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765729100; c=relaxed/simple;
	bh=OEay1GcWRC8L6Gr4gwgnUJJAWHu1WoL3P4m4oIUEwOE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=MgPhAqoRf68kDfiQMqhgRDSp98HssKpPm2apThBPMDo91rDjaMoJJ4roJHWXpO2l/k8lJPM5ZabDXfnjVlp7cUqP0VEvPZKLzt4Y3xh/OCtg1auuSuBDlcCd02CXo2L2n70RiUX/h+q/BRb6eNTfVH0cb1P7Gpla9/4IiRDi8lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de; spf=pass smtp.mailfrom=haller-berlin.de; dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b=Osfpp0RX; arc=none smtp.client-ip=85.13.153.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=haller-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=haller-berlin.de header.i=@haller-berlin.de header.b="Osfpp0RX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
	s=kas202508121029; t=1765728620;
	bh=OEay1GcWRC8L6Gr4gwgnUJJAWHu1WoL3P4m4oIUEwOE=;
	h=Date:To:From:Subject:From;
	b=Osfpp0RXCYLrc20zJZZlSjMQoOsLhvD9e9hblkKNgIL1et7fuET8j2t1Ozx6dIDzS
	 7HzJ99KdE8XrJaPz6l0+UQBhzx14m644PyKHujvp1a7/7izIjgEq/4oeSQz0mKa5yg
	 8TCGwxi6v8DwixiwKi6hhklRKZtufYrUUFQuB+Jur5DTo8dxQ2721cvpvN48WwpNP0
	 EXP82GlOb94Vzm3g4/R0lD6e41KbJQIC3hnM3697fwCcYPeC1sp2UEmSkgKWYj9ohj
	 4gQWti0Sih3gkHFKnowe38FV88rT9qf8Ol56Wadrh2tVKVmSUa94MO/8bKELBArxdS
	 imZOpLpfB0LvQ==
Received: from [192.168.42.53] (i5C74DF58.versanet.de [92.116.223.88])
	by dd36226.kasserver.com (Postfix) with ESMTPSA id 280423CD4B6
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 17:10:20 +0100 (CET)
Message-ID: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
Date: Sun, 14 Dec 2025 17:10:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
To: Git <git@vger.kernel.org>
From: Stefan Haller <lists@haller-berlin.de>
Subject: Would it make sense to add a commit.signOff config?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /

I find it interesting that of all the git commands that take a --signoff
argument, format-patch is the only one that has a corresponding config
to turn it on for all invocations. I would have thought that git commit
needs this even more; I find it reasonable for users to decide that they
want to add a Signed-off-by trailer to all the commits they make.

But then, what about merge, cherry-pick, and revert? Does it make sense
to turn it on globally for those as well?

The background of this question is lazygit, which has a config for
enabling --signoff for all commits made by it. We recently had a feature
request to extend the meaning of that config to revert as well, and the
discussion came up whether that's a good idea, and if so, whether it
should also extend to cherry-pick and merge.

Any opinions about this? Since I work mostly in closed-source contexts I
don't have much experience with the meaning of Signed-off-by trailers.

-Stefan
