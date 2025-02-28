Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20131C1F05
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740721916; cv=none; b=QHtKmHGCVb5ZYbmWVqHHQ+tlX7dShmLN6FwiTgm30fTuQMO0DUp/EH5npPgxSuWucJQSuWw+AmuGNJi4oTmoE0PfxdGTfxncr9dq9t4JSBARzUXQnctL3oyIhN/iB63s4SErXeH2RBy4+Y9yoUIUE5TdqU3wuJUzr+O6ljCGzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740721916; c=relaxed/simple;
	bh=L+AgeyfwzqSfPqRZF2NJe95bCK96veJfUiXNO6jZLGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s8FSaHR2NuCii7a68LtKJ+f+AFb4ftaVUb6KWdUbwgFzcXEdBD+jW/K1Fx95j2P3Lx4qWlxEJUYApryFmWgiZdqc3/t0T53sGJmOWQqH74QePjcNnsjmp4X/jqV502PT1Fas95LaSVSBavKrlpezNVqMD5bkU1oouVZrsjyando=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from [192.168.10.88] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 849213F003;
	Fri, 28 Feb 2025 06:46:09 +0100 (CET)
Message-ID: <fc549e53-c3b1-4aaa-b027-19d8dae2f3a6@hogyros.de>
Date: Fri, 28 Feb 2025 14:46:04 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: gitweb.js build mistake
To: Thorsten Glaser <tg@debian.org>, git@vger.kernel.org
References: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <070641d0-730c-7d92-af4a-9157dc1edd3d@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/28/25 14:34, Thorsten Glaser wrote:

> This is because (rightfully) the output got a new dependency…
>> $(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
> … but the rule uses $^ to append sources.

> Possible fix attached.

Would an order-only dependency also work?

     $(MAK_DIR_GITWEB)static/gitweb.js: | 
$(MAK_DIR_GITWEB)generate-gitweb-js.sh

    Simon
