Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C102EB10
	for <git@vger.kernel.org>; Sun, 14 Dec 2025 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765730668; cv=none; b=YjlVF+sZRiv0V6bcD4tvukcvNtWYJZ675IJ5/L07S0RbzV1BrdI6fALPtMMj69QpntqZKg2/TFXCOkntzbYjAaMutNRgc1WUbKmXijDakqwhR8eA4deLHSgjKaJ/I9gNSBMVIY89W4QXl8DXCbssrbYPtJYIOH5A6LULekm3Lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765730668; c=relaxed/simple;
	bh=uK9qKwlrX2wNlgS1SNxw7FRbi0klY/McXs/eJ68D8v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvW4JxaVXQsbKCWUm2xiM2627D5D4KTyTTip0AO24h/y0PzAWfASdNloI+ia0cN5DcWO/KdMChJFZ7unGIUkZvEMD32QjrOhQifr9hXQ+CSo1d65YyNakjwSC8h7dTIS+ftpaWo7PxY5P0i0NTC1f0oLh3VHguV/hA2OipemrsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ3uGUzL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ3uGUzL"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-bde0f62468cso2830337a12.2
        for <git@vger.kernel.org>; Sun, 14 Dec 2025 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765730666; x=1766335466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nf8Npjobc3aD4OTQjH82QrDtN0kPxpsQptc4sJ0D1k0=;
        b=GZ3uGUzLoyjSYHR/XD3JqlhrNUj4slzU95vDamcUm86W6R9cd5SniAdpG09W2C24+c
         A8ucfWIH7IrpBcrj6Yqidi5dB99bqyFb6HlJVijFl5ZRLEl6xBKKt7fGx+ncLNOK0sOR
         2/xQqwMbvfvCU79V0/B6493pm49DmcToHDKjIFCR3kq+VwCE1+8cyEx4Z1RSFPOfRZs+
         4PqHvrXeD/QtYx83sajdLNqiLSUuS6XlF29lzwQ5QZ3ZL3YaJoriopuQOloTUrSfXpWp
         wVkxXII7Tnsejs7fpXeykzEWQYxcy24bwxGnTArTYpXShitqB3Ir5saVo4wcH6cqNeCN
         Ozrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765730666; x=1766335466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nf8Npjobc3aD4OTQjH82QrDtN0kPxpsQptc4sJ0D1k0=;
        b=A9MbrX7mSAzXw7xD9dOr57kOFTl5crELTis7wrspKAE1ZyKaAdovu+hyuG4W3kR8Dc
         wmD4BWvzfMcvkVFI1RpT+V+w/gRgI3INIZz9MVhqKcjNUbzFrdbw79yuMsX0P4dhTDBD
         6TBdkL5estUZDmMM1/JLlCm6JAFoYi0k9kVPghC6qmapumT8w3JytFCAgb+rEMuE7yFP
         GlCioJO5QH0ORC2HWweKLGuwQ9Rb11n8f8Asbcbr/ll7wC8H5EEVQ5JnzwLR9V5ClhfA
         OjKzKo2EXTZ9mmAfpPMZmkuEAxknWlMxXq6bcPs9kRKnFJsoMARkOX4/tScMyAlZCXis
         GhXg==
X-Gm-Message-State: AOJu0YxtBvDfnX312Vvc3VzGYsAZcWru4tMhmWBOLA7grct214iS1cJl
	H00+3FfwH8RvLehBCKIRrqym9lQyqH6DX8EeShMGVq0GRXaMQH/rfqzkCkBaqg==
X-Gm-Gg: AY/fxX7a1cwZW0JWjMChvixTdNZjyAIjJFLAY1wXOOxiLQqOOYe0qA3RnSCdQJOg29q
	5k1nQBf1tYYPA5EtPQU2X5/fzzVI9pm6J3VaovNDPM5QFaul4BQUNEXZxXM5sTBIFBTyITexiOG
	RdzBfG3USnbm0wj8qysiWYQdj7q9V5pZOYIXqiMa+yODjwRzN4KrLrLriYcV37i6+6480aVYOvq
	fyHZ1UQzAuM+LgrS4DM7LLGJAAOUTPgINb6SpEgdRPtgoPFNbe9n6LCu7gMvNDff+wYmx1WEHKj
	o3SKcO6fMvm8e1hvZuQXsV5NwHvXHVc02IStXmjfOXx4aNUbjZLZcfbrIM+t56whIouHbKqUDdF
	w9HAHLb3hoTuA/HP74pXowPBDnO2waLGjsKXmvNz/sb/C5sY2nPnb6G23Td65R0qR7+ceRWkmCG
	XWMCornRTMhNLR8LWbj0Fj7wHR6dtfgifnobPLQgeaQlf05qXFzNK2dnK3JuH+v/iMCDxlDnE3d
	56hDiruaJ7DBaNCXAxYdH2I6S7or9MWkxbObo9/ymMCXq7IGg==
X-Google-Smtp-Source: AGHT+IHllo4NV4wtN0UE4pI5U9vSsd2f4lD7EjLyov9l/9lgEwJ+TF8LpJv5FPlD2P+s9QcDaBd4qQ==
X-Received: by 2002:a05:693c:8087:b0:2a4:3592:cf62 with SMTP id 5a478bee46e88-2ac3018c3b8mr6503046eec.6.1765730666124;
        Sun, 14 Dec 2025 08:44:26 -0800 (PST)
Received: from Carlos-MacBook-Air.local ([2601:640:8e80:3680:5c57:222d:3cce:68cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190acd01sm29298098eec.1.2025.12.14.08.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 08:44:25 -0800 (PST)
Date: Sun, 14 Dec 2025 08:44:24 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Git <git@vger.kernel.org>
Subject: Re: Would it make sense to add a commit.signOff config?
Message-ID: <aT7lkXl65-TBIsRS@Carlos-MacBook-Air.local>
References: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86c5d40d-5a06-4a69-90d8-a737685b0536@haller-berlin.de>

On Sun, Dec 14, 2025 at 05:10:19PM -0800, Stefan Haller wrote:
> I find it interesting that of all the git commands that take a --signoff
> argument, format-patch is the only one that has a corresponding config
> to turn it on for all invocations. I would have thought that git commit
> needs this even more; I find it reasonable for users to decide that they
> want to add a Signed-off-by trailer to all the commits they make.
> 
> But then, what about merge, cherry-pick, and revert? Does it make sense
> to turn it on globally for those as well?
> 
> The background of this question is lazygit, which has a config for
> enabling --signoff for all commits made by it. We recently had a feature
> request to extend the meaning of that config to revert as well, and the
> discussion came up whether that's a good idea, and if so, whether it
> should also extend to cherry-pick and merge.
> 
> Any opinions about this?

this was discussed recently[0] and the point that was made is that SOA are
meant to be relevant mainly in open source contexts and should be explicitly
given.

Carlo

[0] https://lore.kernel.org/git/xmqq4iwvfx8s.fsf@gitster.g/
