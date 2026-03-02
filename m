Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A305E42315D
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772471106; cv=pass; b=JiX8rrz86SevmicfS/el9lv8Kptdu1BbR0T/fsOoIMzH2eTAq8gLoQIxPbP8Ce/YAKFZhln0tsy90+JpmT6Vh8KBrrwFtf4uoj6mF22m4z/L3me3rBFHkZcllqTUTJa4xdg+cAxF+MtUvxxux5DWdcubRsBO1zh9hKnhhTvXSO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772471106; c=relaxed/simple;
	bh=l7O7y5KCLgmU6xemrqnFugMcjb9F5Tb/Gasmk1GmEl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uSI57LhgWYJYs8QOFwp6lmvP7CkNOyfpGf97HAK/JXJEnBqL4eblldS1dAmw1V0tE1Fu+m1oTcg2zeTuuNnJD+AjvzEhrl1m4SSHEPy4qfeTBxwsUoiHSfe0GycjI1GJSYY6nEmWSaz+YDEX22wqodJMd/GYs3TCVy0vulbkKSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=PKVZo2Ft; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="PKVZo2Ft"
ARC-Seal: i=1; a=rsa-sha256; t=1772471085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HdDSp+fLYFlG22QWlI86/g3DmVJQFbNmi7+gmqpOXGmY35bVMF1iAeWLAYhY3oZg+n2tpW4ApcUlWt71OAVhLtqmQzZ7VigZviCErnuR+QfmR2k1tW1cZdXFxxYaKJ8GNEihcGYmGNzu+Vf65arQ5f3EIoHuKUJIDCDdKz48R7A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772471085; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1LWX92Ei21e9tznXvultuAh+rxozsHdnpNlB4Py4XBs=; 
	b=XJCl8lrx4Y0ifkdFvPbce6NfRvlibUXMircLLCS6Juq49Vi5x+OvYXWBAbihB+PdOIgjaw6+APl3BeTk0wRoky3nUacQHrhDqiDJVAYIbivel/ZYiBVF/O7Wa1Y+p3mEpAeM6x2U4m22FnO921+17252beCAHeHzyw0AUjxezzY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772471085;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=1LWX92Ei21e9tznXvultuAh+rxozsHdnpNlB4Py4XBs=;
	b=PKVZo2FtF39tuR+8Rs8KYB8Ecx5ReOwfmS2+lgu+J/05Eleu7P9XvwrX5VqytJnJ
	2iUljcpd2Raf0+OsFuxyXqREHYpBjvytuS51kBV7qV4FEZsqmzElCRhVlbTBgCxfBdf
	cCPEMW3UQvy99x2HTumLfFyUe5YhBEiC58839B9k=
Received: by mx.zohomail.com with SMTPS id 1772471083242390.58813342433007;
	Mon, 2 Mar 2026 09:04:43 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/12][next] Specify hooks via configs
In-Reply-To: <xmqqy0ka2n53.fsf@gitster.g>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
 <xmqqy0ka2n53.fsf@gitster.g>
Date: Mon, 02 Mar 2026 19:04:36 +0200
Message-ID: <87zf4q5fiz.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Mon, 02 Mar 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Hello everyone,
>>
>> v3 addresses all feedback received in v2 (details below, including range-diff).
>>
>> This series adds a new feature: the ability to specify commands to run
>> for hook events via config entries (including shell commands).
>>
>> So instead of dropping a shell script or a custom program in .git/hooks
>> you can now tell git via config files to run a program or shell script
>> (can be specified directly in the config) when you run hook "foo".
>>
>> This also means you can setup global hooks to run in multiple repos via
>> global configs and there's an option to disable them if necessary.
>>
>> For simplicity, because this series is becoming rather big, hooks are
>> still executed sequentially (.jobs == 1). Parallel execution is added
>> in another follow-up patch series.
>>
>> This is based on the latest next branch because it depends on some
>> commits which haven't yet landed in master.
>
> Please don't depend a series on 'next'.  That will make your topic
> taken hostage by _every_ topic there.
>
> Besides, the ar/config-hooks topic has been in 'next' for the last
> few days already, and it is time to go incremental updates.

Understood. I don't think there is anything breaking in the config topic
v2 as it landed, so I'll create incremental patches on top of it to
address the feedback I've addressed in v3 here.

Thanks!
