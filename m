Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647425779
	for <git@vger.kernel.org>; Fri, 10 May 2024 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366444; cv=none; b=QuYhuMyKMvBHko1R7WaYkzVMJLHDOWg9NNzbL+UNCqXZQdLkeCUUl8PNr57k8oLdh02/TaZOCXez04PAI/wbadM6EwP8CioWoRWj5LO4QRgJnq71b++XemgKnxYU+bn78xAbmVXRm+fF5wYYjO29Uk85e9G8/2MbIeobYwq+Jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366444; c=relaxed/simple;
	bh=W/kf+icVu5/P3HSXLItKYoz1nypfZnwiutYuLo12+aI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL5IaUKC1dVTKoyTrxAkY3Ae0WYQvtpZe0wpxETtt6wnm3kkogp+p5Zy2SON3topTp6S+yNtJekDnhnNhkbHC/mMsFhtDtCOWd6du8F3Gd9N5YcLPqO/TuhGUkjQk6AQ8HR1UPPM6+d8JVrRm/1BbOf0ll+W9hyyQ9W4uqMJYIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3GK/81r; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3GK/81r"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-23f59d71d10so1462172fac.2
        for <git@vger.kernel.org>; Fri, 10 May 2024 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715366442; x=1715971242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XowPRDfSrqfxwXqpQc1MeXmmKc+mXBcytaUsenVm+RM=;
        b=M3GK/81rb4ZyGXXOP0SDlhStbQdeEuSX1kVckIFhFMuHRHmXZOnsBoJLhXPRRTBN6f
         amJcOu7hSCsnKhJomfpEr8VDzLar0yc/r4yw0F0LU1GIrW7157rG7IcirVioJRl9GcaA
         kn4jzKW4gr+1iBN7H5Nyr98f+dSfijSnBMFp7Ej5+IxclEzJAHdP5ZVgc9dito5FBfoE
         cQNNXU7MNdTzUlIiyAta+WsX0vGJLTWN52B7GBKuUxyBqUfgdHmefRD4RYjjukmEp0Ko
         Y9FgzMH/pQFzo9c6czo+ZYbuz4OkgA7D8AE/FGvycRkKzBmdhYas2e4wy2VN7gxs66pP
         ENEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715366442; x=1715971242;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XowPRDfSrqfxwXqpQc1MeXmmKc+mXBcytaUsenVm+RM=;
        b=LssDDw4iamdlDZBZnNtnOyaMqVo0qEhGlBBOx/ZHizGoMlcc6E458mJto2l3yFiEvP
         ZOuInIHHSZQePQPl8Jn1iKDRcUHEa4ssJFPe8VjOSIs7r7dREaUKvvTGZBVsrVLIWUwb
         u8GpDgVmsVpD+KdDo8PM1KqvPr7AoUN3AS778WtUsL1LSL5I+jEKA5EqJ2SYl9kLzuCC
         9Kx2WN49n8dxk/sXdP+ggYi2a3BtcsRnzE8dmkXFYjNDMZ/dSH8EoGcWqC7ifUh84Sn5
         xxNWcoep2waqxZAKwSf24ooic+H4MxI28+QRTVmsp2Z3hV42GuDipywabLhslRwahRW7
         pGug==
X-Forwarded-Encrypted: i=1; AJvYcCWjGSH3mA1tFsJniomfg9l09UF+pibRvdJ2JfqWP3v7zVKlaKZUvohfwvnqsiDqJXHyo2m88/cWTEvCA04uEQ+k+2Pb
X-Gm-Message-State: AOJu0YxX+YASdNnUKPEAD56Ao/DudAF1KaZhI210LKX2Q0p6fIIqbDdS
	h6EZdaPQ68hpA5citasoSB/JNJ/m0Gg7l+LlmCa/sOqpb5aIQhV6
X-Google-Smtp-Source: AGHT+IFyMGuMVDJK2SAGAm6z3XsyMEHte3I7rvcZftXMofXUMlp+ESmDON7U7XYNO5i7bcFEUb/LPA==
X-Received: by 2002:a05:6870:9724:b0:23c:7b1b:ba3a with SMTP id 586e51a60fabf-24172f71327mr4505229fac.42.1715366442208;
        Fri, 10 May 2024 11:40:42 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2412acd6656sm952934fac.51.2024.05.10.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:40:41 -0700 (PDT)
Date: Fri, 10 May 2024 13:39:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #04; Thu, 9)
Message-ID: <262znkm7vg77nzp5fadhfuqkcs6wapsuzd5dtvffoopszzoyia@uohyfeerbncl>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqfruqsjb6.fsf@gitster.g>
 <Zj3SsbHLp-gH_Jey@tanuki>
 <xmqq5xvl7k97.fsf@gitster.g>
 <Zj5I9J-l24Pk-10q@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj5I9J-l24Pk-10q@framework>

On 24/05/10 06:19PM, Patrick Steinhardt wrote:
> On Fri, May 10, 2024 at 08:35:16AM -0700, Junio C Hamano wrote:

> > "I read it and have no comments" is somewhere between "an invitation
> > to miss" and "it does not highlight anything, either positive or
> > negative.  Was the topic that uninteresting and uninspiring without
> > anything noteworthy?".
> 
> I figured that this might've been it.
> 
> > There were mentions of a new document for reviewers, similar to
> > SubmittingPatches is for contributors, and it would make a good
> > section to document recommended ways for reviewers to demonstrate
> > that they understand (1) the area, (2) the goal of the patches, and
> > (3) the implementation presented, better.
> 
> Right, that's good feedback indeed. Ask questions, reexplain what
> happens with your own words to both double check your understanding and
> demonstrate it to others, ask for alternative ways to implement
> something. These are all ways to ACK a patch series that otherwise looks
> good to you already.

Noted. Thanks both for the feedback! :)

-Justin
