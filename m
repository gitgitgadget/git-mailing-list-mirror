Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A5712D1EE
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709676593; cv=none; b=Sdfy0h8HVTeke0O04AeHExT1Ad+vYwK7wkOcl2pCfsiiF4ZfxRl9xZIjTdeNg9uZV8WNK5w3dBDeHp0h8RRpp+ii8Tc08E3GWo37gKrnEeZULYpwW2KVnbXzuwDM89LQGHN8uqrbrToN0F/r92dlekVtPBClbXIYQADAMu8nXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709676593; c=relaxed/simple;
	bh=k3wMGfD+kUHmd/vfUCr2Xttr4GM06ue0c5GxqDJMNG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5ivIJDOnQsoguMqof8/M4mnSg+NxrzFGKg+nmSbn2GvX54qpJltSEznc0VwQI9U4U1Aql1YgV+WJWcgO3KihhHCNET/P49mjPpjUOhVA2G1r/yrdHDzoCEe2KH40eWePxYh2vHlOIv7xUdhSXUfrw+XQRxvew1fRtwlLVY5pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrzfA0GY; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrzfA0GY"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1a7d51fb5so4522591b6e.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709676590; x=1710281390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8TsgC5I6FgVhlDz03soeijtW5526zIWpVK4xJ6r6Ro=;
        b=ZrzfA0GY3Jd2Pl8Y4o3LzA7nnw/xMjwgGxM7V0EXJ+J7v6f2d11KBfJgQlFtOzasq4
         xSOjDm8Fs9LDziCKXP3Fx2coj0LrS4zcZWmc97oWZFRQmiwDoQmBAZXZDd+bqdIM6MtA
         dL9e2kaocRqsVVqVIEDgEn92oIDrgttQTgbovo3trWuTWtlBcj/KEYSth2DeBARn015X
         0bDG7bJoNA8uRBhse1/Ku8KxRrdfQpWNwZrw8j2X1IVQvjq1pZ08QnRovAsbb2FKlv9G
         trXHS90RgQ9TsuL9sLzpJc7YVJbLEjLDlCCSLXAOXDAt9eb6TO6OCBU+UZzQtwhqxeVY
         dWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709676590; x=1710281390;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8TsgC5I6FgVhlDz03soeijtW5526zIWpVK4xJ6r6Ro=;
        b=QqFL4A9dbjaeo8+ERE9UXq5zIN6Z6S2Xs9J7L1aAJiJMwi8b/9zg/a9x7ANhCSOot/
         QEVaXEiP3D2NAjlFNmobEXUKjlR2opjZYRg7YTMnVIS3BdHf5PH/ZqX3nF1Qk9yRo5TS
         RTzkAlFrHHrzdPbOx6Pd08EDgQP56r7lW7lA84vlpDPcxDuiSL/CjjRthuOM4GLkKscH
         IKutxtmh2evHqPP5GXryGp5/AL87WakOpBS+7mhtfqES7DOoWxo2KKE5fpOgOMs7govU
         1m6uqF6rTfNXOOQAWFsX0SIOu+1i9vmEtOliD+5JDrZNiYwAz6G78dHZgVRz2QGs9zyI
         P6kA==
X-Gm-Message-State: AOJu0Ywu2wJlQtgbPFUkSswX/EwxtC/IG6zBWST7kkzSwXA7c/wRwXd+
	tQLgWwm+eczQzhUWuDcWBJ6JHVlpKQxNzXWQfD/yAZ0y8Iqb2DHGAmyBvNW3
X-Google-Smtp-Source: AGHT+IGFq920qPU/unPUmcvXnOGAMeWT8JCdCQHWx7cjg0v0ElNoJD7cQmhpaZJIxr0XCnOLXudUjg==
X-Received: by 2002:a05:6808:1294:b0:3c1:b35a:dc43 with SMTP id a20-20020a056808129400b003c1b35adc43mr3820710oiw.24.1709676590378;
        Tue, 05 Mar 2024 14:09:50 -0800 (PST)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id b16-20020a056808011000b003c216560341sm150807oie.56.2024.03.05.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 14:09:50 -0800 (PST)
Date: Tue, 5 Mar 2024 16:09:07 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] lockfile: report when rollback fails
Message-ID: <lyarkcrkcb7ww542lc6y7t534yxnpahvrwephottvcbhr5dkn2@wwd5wk5bzlw7>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1709549619.git.ps@pks.im>
 <1acaa9ca1a53e3d8e875fed7ce961d0b5426688f.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1acaa9ca1a53e3d8e875fed7ce961d0b5426688f.1709549619.git.ps@pks.im>

On 24/03/04 12:10PM, Patrick Steinhardt wrote:
> We do not report to the caller when rolling back a lockfile fails, which
> will be needed by the reftable compaction logic in a subsequent commit.
> It also cannot really report on all errors because the function calls
> `delete_tempfile()`, which doesn't return an error either.
> 
> Refactor the code so that both `delete_tempfile()` and
> `rollback_lock_file()` return an error code.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  lockfile.h |  4 ++--
>  tempfile.c | 21 +++++++++++++--------
>  tempfile.h |  2 +-
>  3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/lockfile.h b/lockfile.h
> index 90af4e66b2..4ed570d3f7 100644
> --- a/lockfile.h
> +++ b/lockfile.h
> @@ -323,9 +323,9 @@ static inline int commit_lock_file_to(struct lock_file *lk, const char *path)
>   * for a `lock_file` object that has already been committed or rolled
>   * back.
>   */
> -static inline void rollback_lock_file(struct lock_file *lk)
> +static inline int rollback_lock_file(struct lock_file *lk)
>  {
> -	delete_tempfile(&lk->tempfile);
> +	return delete_tempfile(&lk->tempfile);
>  }

question: For a lockfile that is already committed or rolled back, is
the underlying tempfile still active? I'm trying to figure out if it
possible for an error to be returned in this scenerio. If not, it might
be nice to clarify in the comment above that, in addition to being a
NOOP, no error is returned.

-Justin
