Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crRl/liI"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01202109
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 10:45:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so22060115ad.0
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701197150; x=1701801950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NMWhnYGandxpl0FOm5NXy43aRrKUhGnL5Gf7f0Fo2E=;
        b=crRl/liIMiBxUDKQ8A24E8NHp7qRAsZ/n4IBGgJEM4dlebNTMZgDQhH56h+CdlhzAG
         nmp+4/c/xmNWI5ZXbazSE/dS3Xi/S4AU85cHpk1Fq+4DHFdGqaTeOtErS0X49F7O2/1x
         upIq7zgXrCUExSGd+u/UKjY5vckfXPZFSUXptHt6U5AP3LzN/VOSPhByEzS7lMnB2ca6
         MmPFDOvJpdHpGsMwpYm+9YD60QQIXrgrMVKYtv44mJ4zmK+PIBkVE2PWeiUoy3irxMAB
         Y6etPjdsMLRk8r6uibZieeYb2qhc2OHemWGNBd6DlQLRmc3OTVJpYKqeVspUZuK4OOEZ
         mbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701197150; x=1701801950;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7NMWhnYGandxpl0FOm5NXy43aRrKUhGnL5Gf7f0Fo2E=;
        b=q4gWQ8fO0abwWs/1UN9ntJc69nyA3t4qo9rU5QEcFmHIBdSQ+Zu0D2n04UHjRfbmaE
         uAUV9AjrkoyyR65Xi2MZ1Zugx9R0gp8865vfEVB6LBkMJbDiT/Rh01IqROF0G6IvpuBZ
         uXIYkK4V0p1nOQG+DIaW6+LSlXkPLKW/NzA6f08fWs0jo3PRg7d6dur16McIE0Idoq1p
         nucn3N2VsFf3HJ+SG8BucaV3IJ2lXxhVvT44hJcR2+9n/Ev31AivFsMEngeu06Ko9eVD
         /dveKmSWjkFBpX/W7cncmz0n5oqmTBEdeZOdGbDuQBDkWJNQXLWqHCMojgEKgoZFCdxv
         G9OQ==
X-Gm-Message-State: AOJu0YwtdbaH57XEjYfZlBbTpGsTerpk9ZqIqxw2EcIeAkuI83/HeLWx
	HeAFM8QgXveYlyqdu+Kc1jjiGEosYxthBGqYt1mYmw==
X-Google-Smtp-Source: AGHT+IGBf08HwD3Byy83tocC09RoetpzX8QvyG3jjTuO0tL5dPjRP9F6eKdUge3FAlTlEHBzJj/gsw==
X-Received: by 2002:a17:902:e750:b0:1cf:c02f:6cea with SMTP id p16-20020a170902e75000b001cfc02f6ceamr8710248plf.69.1701197150250;
        Tue, 28 Nov 2023 10:45:50 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:d2e9:e3fe:4455:513f])
        by smtp.gmail.com with ESMTPSA id jf7-20020a170903268700b001ce6649d088sm10685616plb.195.2023.11.28.10.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 10:45:49 -0800 (PST)
Date: Tue, 28 Nov 2023 10:45:45 -0800
From: Josh Steadmon <steadmon@google.com>
To: Adam Majer <adamm@zombino.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] setup: recognize bare repositories with packed-refs
Message-ID: <ZWY1WSUL11Y6990U@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Adam Majer <adamm@zombino.com>, git@vger.kernel.org
References: <20231117203253.21143-1-adamm@zombino.com>
 <20231128142845.11523-1-adamm@zombino.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128142845.11523-1-adamm@zombino.com>

On 2023.11.28 15:28, Adam Majer wrote:
> In a garbage collected bare git repository, the refs/ subdirectory is
> empty.  In use-cases when such a repository is directly added into
> another repository, it no longer is detected as valid. Git doesn't
> preserve empty paths so refs/ subdirectory is not present. Simply
> creating an empty refs/ subdirectory fixes this problem.
> 
> Looking more carefully, there are two backends to handle various refs in
> git -- the files backend that uses refs/ subdirectory and the
> packed-refs backend that uses packed-refs file. If references are not
> found in refs/ subdirectory (or directory doesn't exist), the
> packed-refs directory will be consulted. Garbage collected repository
> will have all its references in packed-refs file.
> 
> To allow the use-case when packed-refs is the only source of refs and
> refs/ subdirectory is simply not present, augment 'is_git_directory()'
> setup function to look for packed-refs file as an alternative to refs/
> subdirectory.
> 
> Signed-off-by: Adam Majer <adamm@zombino.com>
> ---
>  setup.c       | 10 +++++++---
>  t/t6500-gc.sh |  9 +++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index fc592dc6dd..2a6dda6ae9 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -348,7 +348,7 @@ int get_common_dir_noenv(struct strbuf *sb, const char *gitdir)
>   *
>   *  - either an objects/ directory _or_ the proper
>   *    GIT_OBJECT_DIRECTORY environment variable
> - *  - a refs/ directory
> + *  - a refs/ directory or packed-refs file
>   *  - either a HEAD symlink or a HEAD file that is formatted as
>   *    a proper "ref:", or a regular file HEAD that has a properly
>   *    formatted sha1 object name.
> @@ -384,8 +384,12 @@ int is_git_directory(const char *suspect)
>  
>  	strbuf_setlen(&path, len);
>  	strbuf_addstr(&path, "/refs");
> -	if (access(path.buf, X_OK))
> -		goto done;
> +	if (access(path.buf, X_OK)) {
> +		strbuf_setlen(&path, len);
> +		strbuf_addstr(&path, "/packed-refs");
> +		if (access(path.buf, R_OK))
> +			goto done;
> +	}
>  
>  	ret = 1;
>  done:
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 18fe1c25e6..4ad1690817 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -214,6 +214,15 @@ test_expect_success 'gc.repackFilter launches repack with a filter' '
>  	grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
>  '
>  
> +test_expect_success 'GCed bare repos without empty refs/ still recognized' '
> +	GIT_DIR="$PWD"/bare.git git cat-file -e master &&
> +	test_dir_is_empty bare.git/refs/heads &&
> +	test_dir_is_empty bare.git/refs/tags &&
> +	test_file_not_empty bare.git/packed-refs &&
> +	rm -r bare.git/refs &&
> +	GIT_DIR="$PWD"/bare.git git cat-file -e master
> +'
> +
>  test_expect_success 'gc.repackFilterTo store filtered out objects' '
>  	test_when_finished "rm -rf bare.git filtered.git" &&
>  
> -- 
> 2.43.0.1.g67290e5b65

Thanks for the fixes. This looks good to me. BTW, in the future please
add a version number when you send updated patches (e.g. add "-v 2" to
your command-line if you're using git-format-patch).

Reviewed-by: Josh Steadmon <steadmon@google.com>
