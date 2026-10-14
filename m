Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387240963A
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958615; cv=pass; b=udxGrkFWY40Us43LYKjGfQnUxrf/OQTBratYnt85Qt8YC/aakeD+ZXiw2Ho0ggmn4wPVXVmAZEG3RnHg3l46TviJf+MS7hWM83ReknoZD3Y8yEdEAkKDMqeFkNkz7Of5omzy4/hgjxY2O3tENbJhow7a22NyKObglxoeWS3xPnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958615; c=relaxed/simple;
	bh=oqvQ5WqS8s2U256lz2g+p5E5VmHtcoxY5HpVQODAfg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA7z8i9Bm35JtTXQ08tIz84CP4ziOcG1B7+Rh7nYRDSxsq+eEdMPT7efz+qfEspgSxtd7BsydXca3dmQd3RZBB/70E0B/7pGQYfDxF9tjUoYqOej1cpJ3xtCS0I81CwdLamjazEeQDkBPMZ8XM30kpTT4Sa/IK0fE0jVZYelIVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=CBADP0P9; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="CBADP0P9"
ARC-Seal: i=1; a=rsa-sha256; t=1791958608; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XX8fvDLdzVFfnsgj13lKbZXg67xQwYImDoovRhyojw5FdSsEK0Y4V47aZNCHciXMqrTAcxCU4GNOtomaKXtA852aJpjLW4TJp82IV6eGjT1IicKRn6LwlgtpNWcGRNXzgbEwwAh5Hnmus2ngxFacgyCYSmBzWbjGyHJJabew78Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791958608; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=oqvQ5WqS8s2U256lz2g+p5E5VmHtcoxY5HpVQODAfg4=; 
	b=N3np5tUir6L14D6cAdJ93ou2unIcxbdM4/N7KYBu7/2qeHJeB0jNDfMdE6fF1xBRw1duTJmdhXj0OnKU2tQ5vRUCI7wTDlCzUB5BYtSAPWN8vM4uahe5gj5gqYV8UWgx1TmI00HoqbJIYvlW0jaU1uBgD0w+elRfTNPeT3emiPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791958608;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=oqvQ5WqS8s2U256lz2g+p5E5VmHtcoxY5HpVQODAfg4=;
	b=CBADP0P9B06mPTZ2c4SpJJRWHzsI+zFgfDOmUEM+TG6Ijns4JX72ttSbK0POVc63
	nd0OiYxc+pPEaLfNfzc6ofaS01qJyfC8Fs8kFcvltUV6CmP2VMyHPw26BM+Hxjt05yZ
	5C38yvqzKin/PTZplK44ZJDLwteOQ5XxFauilMVs=
Received: by smtp.zohomail.com with SMTPS id 1791958607116568.022292679643;
	Tue, 13 Oct 2026 23:16:47 -0700 (PDT)
Date: Wed, 14 Oct 2026 08:16:43 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: Performance regression in `git log --follow`
Message-ID: <as8eS9VyMMTo1pa3@collabora.com>
References: <as44NVKZA9C9S5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <as44NVKZA9C9S5ae@pks.im>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.951.53
X-ZohoMailClient: External

Hi Patrick,

On Tue, Oct 13, 2026 at 03:55:01PM +0200, Patrick Steinhardt <ps@pks.im> wrote:
> I've bisected the regression to 304812ed33 (log: improve --follow
> following renames for non-linear history, 2026-06-22). I don't have time
> right now to debug any further, so I decided to just forward the report
> to the mailing list. I've also Cc'd the original author of the above
> commit.

Thanks for the report.

To some extent, this is expected: previously log --follow had a design
issue, as described at
<https://lore.kernel.org/git/xmqqjysz7r41.fsf@gitster.g/>. Now log
--follow finds more commits has it traverses non-linear history, which
takes more time.

Let's see if we can find some creative solution that keeps the new
design (storing / restoring the path to follow as you traverse
non-linear history) and at the same time improves performance for your
use-case. Quite possibly my patch is/was naive and we can avoid some not
needed work while still correctly following a path across renames.

I see Gabor already commented in the thread and same some ideas, but I
haven't read those yet.

Regards,

Miklos
