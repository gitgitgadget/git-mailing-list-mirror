Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B31ACEDC
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734529920; cv=none; b=dpTiOTyRL18tjHhk88xJ53IlAo8p1N1611ZgpU4mJwYZtGllYv8L1SZ1FjDDesOFTvPO0rjMIrJEoPFcD1/iUWN78/TQYEG586TuqSN4fl0mVpX4Cl8W+MEL90wd5htRHFC5Lai+1csKUm8AahGPVJ7xjM15KMGINKtIS6xFgxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734529920; c=relaxed/simple;
	bh=GXc4xJShltmzb2n5GcyPBAkov5pAxh/9irfZNFno3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDmq2O9m5dXT3iulkd9tDr7Y2LQrKev2ctDOhs5TO2dZyUm5vdxzNHfN24MBHN15lO7JtMUb7hCLkoxyTogFsrc3LTfvOXT4acGljWxZlF7ExP21bd+RSaWQaP7UARtd/M+7ubPI5RK3e3WaDd/OcHz2E3Vs+4bgumwTdF3uPhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPopEu6W; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPopEu6W"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21644e6140cso61353065ad.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 05:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734529919; x=1735134719; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru0BuGZ0eC7MP9UhfxEfG9I34xC5JzUWt0YqSA/DQgk=;
        b=GPopEu6Wsbq+ro/tvzB2EUoMr4aNvD0Bpw1pNgZVFT7AJNSZ3jqg357t+cpfhDIDKX
         YZojgCI9t0WT59LpG34UFduIU9zBflHlIZMPMHw1lIgcWlUztrgNnksqdz5SAodbTg1N
         olCRrqI1F99rp7dsqNQ+TTij5CfVyZXx1NrRgkTemp976p7m5cFAXxyMv9PLNx+NN9I6
         SPf2WZdlhKaYh4KW3XCFQ/6Ujqy/jBSxdoeTWcWjwoBbxb6ur5Imc0cJZgqHNpfjO293
         Y6jDsFIfgzijZw+4QPUs5M85IHVzLNTUOd4LmeCqsMJdlGueIr2woThLg7hSQiR93Hi5
         5pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734529919; x=1735134719;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru0BuGZ0eC7MP9UhfxEfG9I34xC5JzUWt0YqSA/DQgk=;
        b=J0t2SckYe/e1pXvgLQopv1niYasFT514w+1HXQLT81PfsnCJBTlncxFfzjrfbSQ1Hx
         PJ+B3+gDuyDdXYGmq+2LmPOZuZtXlmyVvxxJRHF6z32r+uV9cyiGgcGN9ZlMj7HdEXbU
         peNRMfndAEM4O2z3DBdIgjx+VY9R9dwZ4Tcre7tEAi8nPFC+xAq12rLGDe+uNkCnbfSK
         nEduLnbX0TJ0jGcFRmNOMZgfqoGWNWeSyaGRKNtp4UAm+i8/54o4g42MlEHw3kvO2/9x
         hL+B8Dp+I4RAEoO7r6qsETEzdf9NnNpEC1cLiDPUDcLYAX6zB2d0AMwuRkhFGIYISMYe
         8h+w==
X-Forwarded-Encrypted: i=1; AJvYcCX9pPg5VrQdiM19YxtxWX/yA+IQW5RAY9VLqYNW5En1Un7tUKY/3aerrDW6Xri01xe+0A4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5grxZQH7wc4Ovm51h2Df8SS8XWmneAIwGz4tUpRIm0kY+mQBs
	cB64R1zt9LxL8kPA9S/4SMbVQhBpeJKDxK+v9G6LoAf6pnp20jme
X-Gm-Gg: ASbGncv71MZv6el6oJC9tyxuPK+ITp47S4KZk83SXhOUHkf0UXOUm4+aiITTUo/ED6W
	IxS7T350zvp8uAwUYuXNMzCriIgO0VJcLJospcrzzAQUNnZ5I42QnzMUm3voF82fnbgYYT8kzsq
	5ccclnOpPzzOV1fx3/G4gezMp9BEgIPCB0P0V+Embn/An6M+XdadSczNTG51/hsQBdXmca8hkcK
	zxddrjnL33JgL5VB9FJvDK5DyQ+qcI9HbRpUuBAWfgCSRJ05FVC
X-Google-Smtp-Source: AGHT+IFBoTL4DFdgEb9MLrLPCoMPovIGrIrK6u5X/uj8VIZPOeFqyrZ7Rcqq14XsD0sNZFf9ShsyMg==
X-Received: by 2002:a17:902:cec4:b0:215:b190:de6 with SMTP id d9443c01a7336-218d6fcd43amr35394205ad.3.1734529918646;
        Wed, 18 Dec 2024 05:51:58 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e648b2sm76784195ad.242.2024.12.18.05.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:51:58 -0800 (PST)
Date: Wed, 18 Dec 2024 21:52:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Wang Bing-hua via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Wang Bing-hua <louiswpf@gmail.com>
Subject: Re: [PATCH] remote: align --verbose output with spaces
Message-ID: <Z2LTp60u03Y9iiUd@ArchLinux>
References: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
 <Z2F7VAsTjfBCVCrG@ArchLinux>
 <xmqqr066ysa6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr066ysa6.fsf@gitster.g>

On Tue, Dec 17, 2024 at 12:21:37PM -0800, Junio C Hamano wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> > On Tue, Dec 17, 2024 at 12:39:36PM +0000, Wang Bing-hua via GitGitGadget wrote:
> >> From: Wang Bing-hua <louiswpf@gmail.com>
> >> 
> >> Remote names exceeding a tab width could cause misalignment.
> 
> If all of them are named with ten ASCII characters, on a terminal
> with fixed-width font, things will still display aligned ;-)
> 
> >> Align --verbose output with spaces instead of a tab.
> >> 
> >
> > Good enhancement.
> 
> With a Devil's advocate hat on, a change like this will completely
> break tools when they are reading the "--verbose" output and
> expecting that the fields are separated with a TAB (in other words,
> the tab is *not* about alignment in the first place for them).
> 

Yes, I agree. Although we may provide convenience for the end user, but
we may break other tools parsing the output. I think I bring confusion
to the Wang. Actually, I have seen that Wang contributes to Git in the
first time, so I just want to courage.

> Now with that hat off.
> 
> For users with that many remotes where the alignment of URLs in the
> interactive "git remote -v" output matter, I am not sure if this
> change is a real improvement enough that it is worth the possible
> risk of breaking existing tools.  With that many remotes defined,
> wouldn't they be doing "git remote -v" piped to "grep '^name<TAB>'"
> or something?  That use case would break with the change, too.
> 
> Thanks.
