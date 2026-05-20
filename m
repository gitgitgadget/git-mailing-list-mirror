Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63849204F8B
	for <git@vger.kernel.org>; Wed, 20 May 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779283704; cv=pass; b=efq2z9y9dkn3jMH8D2KF8FzWqc5MwPAOhYe8ttF08i0a3eLhifosaWFhyKwlPgbjzuyfkS9Jrp9LrvS1EXMjMBhOLiaBQ2wDapBzcQS1hxkQ5XK2UyfYUXWOXtDDirXb4sHLT6BW/mYbI0OQC5/Gy6hVrEEfnxUyOHbizQry4xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779283704; c=relaxed/simple;
	bh=Uew5YiNXQTthuc0fVK/inIwl7NGLTxr9RDa3Ia1pmv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLKw6EWy2NRx6zVY0kvICCq/mJ4x/5dK4ZKYIX4UXIKFSB1urP5+dHEoQo0w0kskpKHjYP9xbI7plF7/2IzfteeA+r8BLEvw8781FCI7iMq9pnMn/FezSA8rhbDAFTKQoD81RZjm6Hmv5VKwwYXiHzZcFURkEoW3CXgjQNwBFl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b=kO3VRv60; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=vmiklos@collabora.com header.b="kO3VRv60"
ARC-Seal: i=1; a=rsa-sha256; t=1779283697; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VxiWYVtKB13yoKWSkjZ7lLs4U5ExUOTeg6+5eLckklVSkkPEU5TkoyBRdsZFEniHMTdCgrkJ/h9qH7J5/oDkvTFUeaLVdSKed1LqUqeoPo3vo1Fs7V7fXavT/i2t+1+J0M6yXFq6i/vbLjcTorvn3/zB3lvQAbfl/3ig6cxFx5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779283697; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tWZu9iF6ePPOCkq/Y7nhMDXSfArQRKdOqm/Io1/DyBA=; 
	b=SLFOgspGAfUhAQOOnCwdFIP7vnmggBELGn6yS5HvXIM3R6zzsRh5YLfPIVXhbrf3mKfbvxufGt433vwhkPt6+A1X+/WTMus9lytI9M0o9yAFtmHnSfAhpkDYq/Z8tRlTXY/+/HaxABP3yr65z/22dVp1OJs236sYBbBKEZzimPA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=vmiklos@collabora.com;
	dmarc=pass header.from=<vmiklos@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779283697;
	s=zohomail; d=collabora.com; i=vmiklos@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=tWZu9iF6ePPOCkq/Y7nhMDXSfArQRKdOqm/Io1/DyBA=;
	b=kO3VRv60O3BOnMGVBP5ebcKz8d/9rP3HBLIOlwWcFqLPYoE4UkT1jVXxmSdq4Ztd
	Hiq7zivMGa5waI5Gi3ItiseBMi6iOSiTd80SlNry7uJESWH8mmhE+R2FCVOTdkNHgv0
	GMr9BbfQuBHr/taj4xPajn1tVb2UeYGIw1kvXVak=
Received: by mx.zohomail.com with SMTPS id 1779283695943300.31201207684194;
	Wed, 20 May 2026 06:28:15 -0700 (PDT)
Date: Wed, 20 May 2026 15:28:11 +0200
From: Miklos Vajna <vmiklos@collabora.com>
To: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] log: let --follow follow renames in merge commits
Message-ID: <ag2265RJal-tJLoW@collabora.com>
References: <agLU58gbG1y7KLz-@collabora.com>
 <agwAkHzjrJQPVtCS@collabora.com>
 <xmqqo6ib7vlp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6ib7vlp.fsf@gitster.g>
X-ZohoMailClient: External

Hi Elijah, Jeff,

On Tue, May 19, 2026 at 03:37:54PM +0900, Junio C Hamano <gitster@pobox.com> wrote:
> > :-) Should I just wait more or should I resend this?
> 
> Rather, ask other reviewers

I did a small improvement to how 'git log --follow' works, as in if the
rename happens inside the merge commit itself, then the rename was
detected "vs the first parent", but it wasn't detected "vs other
parents", which is painful with a "subtree" merge commit.

I'm not sure if it adds value, but I can append a one-paragraph summary
of Junio's comment in this thread to the end the commit message, to be
more explicit that the inherent limitation of the current log follow
design (single path, once a rename is detected, we only care about the
new path) is not changed with the patch, this is just a fix patch so
'git log' works better, similar to how 'git blame' already does.

May I ask you to review the patch?

Thanks,

Miklos
