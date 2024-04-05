Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200B2173336
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347322; cv=none; b=Q0/6SkVjylLgrY72bPnW+1LwCzzF8AWdOP2MdWJOHQ7B3c1mAC0TyRsYQd/NiohUvbSfFQ1UuYog+5qwKV3PTYvc275gqHe2RU5/UCtsaU1W1bNoq46T6cjcCJs53uzmql8UENod20J/gIz0842vf+Hbod+84N7oD0TEExuRwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347322; c=relaxed/simple;
	bh=LqCLYNvt2ztrfiVNReqLGw720htc4w8PvvyOvkxbXKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co80sIYTmUWlmcMhgqY7sbzaJUNSALXpPyhFbfPKzvJ+MFXPGyYW+uPSbgUcibZ/7kopYkUZyO0IqzQnU1T13SN95TPnQknxBLehm7IusUarMNzT5jL3tKtMA4CYfxoMnYVkFEgH1gFCCrSdDkJqXiXq3lwalBB3MnnZS4VeyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sRgGD3eE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sRgGD3eE"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so2258558b3a.3
        for <git@vger.kernel.org>; Fri, 05 Apr 2024 13:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712347320; x=1712952120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKhrafAfEPDRNJCkCvwOHhZwA6cZE4v1lYdWL8BBZJg=;
        b=sRgGD3eE4k4nrTrItoNU5u/iaQvLLSz5gjLq7hDgrHmE9naygAmr9Y6+cW16618HJz
         p4gnkz+RlAgRE5wbHKj47foepXuGyUd7w5V92rYcmLt/SkyVZAxsXVdDGe4thmStalSS
         3WU4yS8eOfCHtAk8HdpQoOwTPsxvCfgex1FjCn2L4PNmG9NPvQVisf8kDDHS0IaRBFWg
         IKZV/VXVhVZfekn+aR5tiLe0HGB8+gWPrZ0aOFthcxILHDN2l3glSUTA0DDryssgLcC0
         cQi7mPGVamslz+sFeOZ7hT/w0TV3pFA5y7g5WS3zDZQuYVO/jTLzbm6KDaa4+s2VMwlL
         Sb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712347320; x=1712952120;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oKhrafAfEPDRNJCkCvwOHhZwA6cZE4v1lYdWL8BBZJg=;
        b=JKHuEJ1UTA6lEExX2ZoLst1oVE2f7srhqv6MT43ZlKqg4PAsr72QWwmNcWTrgtiuDi
         zGRH16/trrFE6Ep/rKIoGxmwJReC/WVzvM+LxaHD4gCG7IbmCYwsZxtQG5JdGtNQCeLw
         XtAJREDHo3D72AdxAP4gxe5BVcZSemcY/I2ooO5m5BAqt/8vaFVMIhI4N3kTwrLIqi3D
         CLJ+UVlbMW96/uek6mWdqP7+p4FkkjaQhmvLUqTorbbp0S75c68lfvdFq5XRCVyzWE1y
         lYLNFOFlPNJTwxQ7NGl+Lz/dmIWHWlW9Uh1a43gXIqNqbj+cOOsnbxuRS7k9Z+hejeix
         kxzA==
X-Gm-Message-State: AOJu0YxIW6T8lXkbaOOYY3KSas5M/sKuUHB60Mjpng2puUJubMFTArao
	CdPmZlvislnmKwB3aJHSv/6oRK8mb/PyAdhMXLIRIAhqm2JzfR61GtLeCwOVoQ==
X-Google-Smtp-Source: AGHT+IGEQdLuJZ3QhDaHXm55kaMPfBskDih+DpEN9Rl/7a95PVPHJup3rLKXcMUVUrfCESkXX1rIeg==
X-Received: by 2002:a05:6a20:d49a:b0:1a7:42cd:b207 with SMTP id im26-20020a056a20d49a00b001a742cdb207mr2718290pzb.19.1712347320149;
        Fri, 05 Apr 2024 13:02:00 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:3cd2:bed3:a312:d0b9])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a00214900b006ead1509847sm1878221pfk.216.2024.04.05.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 13:01:58 -0700 (PDT)
Date: Fri, 5 Apr 2024 13:01:52 -0700
From: Josh Steadmon <steadmon@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
Subject: Re: [PATCH 08/12] ci: make Perforce binaries executable for all users
Message-ID: <ZhBX7REqotKKHpWg@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	JGit Developers list <jgit-dev@eclipse.org>
References: <cover.1712235356.git.ps@pks.im>
 <22f86f8ccb9f3fb7f98ff57ddd09724fc9e44628.1712235356.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22f86f8ccb9f3fb7f98ff57ddd09724fc9e44628.1712235356.git.ps@pks.im>

On 2024.04.04 15:25, Patrick Steinhardt wrote:
> The Perforce binaries are only made executable for the current user. On
> GitLab CI though we execute tests as a different user than "root", and
> thus these binaries may not be executable by that test user.
> 
> Fix the setup so that we set the executable bits for all users.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index f4eb125fd2..068c478025 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -47,7 +47,7 @@ ubuntu-*)
>  	mkdir --parents "$CUSTOM_PATH"
>  	wget --quiet --directory-prefix="$CUSTOM_PATH" \
>  		"$P4WHENCE/bin.linux26x86_64/p4d" "$P4WHENCE/bin.linux26x86_64/p4"
> -	chmod u+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
> +	chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
>  
>  	wget --quiet "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
>  	tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" -C "$CUSTOM_PATH" --strip-components=1 "git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
> -- 
> 2.44.GIT
> 

Do we break CI in patch 6 and 7 until we get this fix? Perhaps we should
just squash this into patch 6?
