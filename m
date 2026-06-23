Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36822772D
	for <git@vger.kernel.org>; Tue, 23 Jun 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214250; cv=pass; b=UnlIeuegx83JBYumxLhz9InxNM1t9VXIbh15ObUDKxMjd+9gxmpchPgYRuRhR5nqseiOLceKl5KfZYo3tAW3yUHBjVNktS7foyM53FmyYUnP5zRFqEpDv9eES7vt67t/e67RXUstaYa2jGcsIx/KEHuqT2DF6j3tlAPbtwPxaMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214250; c=relaxed/simple;
	bh=WA434A3yBYyHnUB5Q50HSmvzLeAZbuPXMpGgYodO9H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swJUC0QzOkS2OFpOitPZhgnHHJnX/+c/htBPRJJj067oE6R5pf2IvJDbNb97xZflel5w6Rgl/WIvujsmCDmyoVB0u/fJ5Y4WJ1b0BGMGegUD9//X+r2D2X7kwjuNtUd6FgvGhmRTXPovGEUEap7lB6gFcOBqCn06jkNoCVlzw4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=S8mu7QT1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="S8mu7QT1"
ARC-Seal: i=1; a=rsa-sha256; t=1782214240; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=m9D6UOMuHKXI4VecZwV7Dleck84kmBEbqFY84RVx5iGYIZ74i5ZcH01vDO5AWK4aIm29q2qLWPgTDSHZlEFZPU9GlsUsLpoDlqKfkQmAs2ALT3FuHe2+blyVldEoe+TeKcIvYQIOzDLqa5D3aekhvaCkEz4CGU3+pxqht1fYelI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1782214240; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WA434A3yBYyHnUB5Q50HSmvzLeAZbuPXMpGgYodO9H4=; 
	b=auRU2fxKxn5qrkIAexALk7yuA6CFRmlIXvkZn/wl0ZyBJE+qgulr1boIC4zNthDzBV9DxQ8+0K3S5PvdrLTflpLqnkmZeQDK4J2up+ON0f9N1ATB9BKt55pU1eOCaOPS7HUFAQvtFH4ekJQdTsHmY6lSSN/wiWshJOftVy7AUlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782214240;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=WA434A3yBYyHnUB5Q50HSmvzLeAZbuPXMpGgYodO9H4=;
	b=S8mu7QT1opp6liwf0m0MptyAQi7SPYPMohkUZyJo89OzsvxcoK+t02pDIccpbAVp
	6v3Q1WpIiv0zAWye6Mb4RvubZz+lK3xksbNTg+Zi4HQ8Dm6ikVeCfRV3J27rGcoFfSE
	ExOw+DBP1R/nIdm7iK/YEFB2PNRh7zZpjhTZw5KY=
Received: by mx.zohomail.com with SMTPS id 1782214237733399.5010691260343;
	Tue, 23 Jun 2026 04:30:37 -0700 (PDT)
Date: Tue, 23 Jun 2026 13:30:33 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v4] log: improve --follow following renames for
 non-linear history
Message-ID: <ajpuWSUiQ6CRV2Kv@collabora.com>
References: <xmqqo6hglncl.fsf@gitster.g>
 <ai-aE83w02xPRlPr@collabora.com>
 <ajjU4w2B0NlZffw1@collabora.com>
 <xmqq1pdy4udg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1pdy4udg.fsf@gitster.g>
X-ZohoMailClient: External

Hi Junio,

On Mon, Jun 22, 2026 at 05:44:43AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> went on in this patch would count), but as long as the resolution
> that is in my tree (as a part of 'seen') exactly matches what your
> update contains (meaning: rerere will do the same correct resolution
> when the topic gets merged to 'master' anyway) and the conflict is
> trivial to resolve by hand for others

I see, I'll keep that in mind for the future.

Thanks,

Miklos
