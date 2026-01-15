Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34222D948A
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501880; cv=none; b=eXGdxwfVTsy7OJxDoLPb7mL0Ph/h0GQsRcFCh81lO7wIG77WL8mZfWDP4+RO2CsOImlN3qeAJ5flgNLU3jRTyJcWvOy2xpzOYQSCMvOSbiwB1+wjxg9ShdnGklszrpoRUsYYPP45MxPRwl/1kRdycacmFPCsyJSN57fVgFboU0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501880; c=relaxed/simple;
	bh=VMP02oYd2XP4EfhDsDmo2wI8uib8JWQe4ibhCMFfBjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJU04DDbZxGB4RyuJQCllO3XQv+hPdY6XsWCbgjz/npJoov4yDuTb8oqb5NEC8tncqsckQCrARJsMsYD0+YYXHyDsuRqHe1n/m8TsetbaMQxVaHHwCM1lJsgVmDRCvtO0bmwXnxz0qiGQsiBmVD8d22HLG7lP04SujmoBjzeHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ca42QiYq; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca42QiYq"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7cfd53a8c31so744916a34.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 10:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501877; x=1769106677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bce2E5bF1eGDUf0XtTCEAv3zUjH6REtJQDv+uweZFuA=;
        b=Ca42QiYq7MeK1nJiaLh0h3IHo7nYgqByw/qGLIO/zpcTOllk7bWIxCYNbbIMfy0qCH
         HDalk73FirjaRHB03sDa4hz/SVQej+Xi4aasepGCS77XbupM6wdIusG6A9Na8xwWq8P5
         IpOyYOSOX+HIZabtPURo9UYqqJRe/GOZST66tqxvEeOF4uworX5tyS7j2T17AyXmKCih
         ZArwmUdQckCqF9xad48+hkqvx+FeSf2ePwcLl7rBttqALUhkaJ8WcflnhSNac7j77gXP
         4L3gC0wMjm4tFIEUiFvjgPm3K7NosbU14E3yW4byadtHXx2Xto3tWJWSF126Du4V2c+W
         n5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501877; x=1769106677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bce2E5bF1eGDUf0XtTCEAv3zUjH6REtJQDv+uweZFuA=;
        b=EHHOtycMCMIFOkaL+dAs+PB7r0z/W6xFT0/f2iGGwN33rpEOeGQ235Sn1XB7ohwqNs
         /X7QLEKrHWZvXlsZTx8XBBc/Qoklr6nFAxoVRzqvRvMgt9ztuQ21zO1z/xoPz2TdBkSK
         epL3xMXsOWXxGhEg6xuMYdNsEy4Jb+jizZ3bWdaysS/Dhqna0OXDYGheFPYL8yjLJZhZ
         KLROiFAj+cRHUAUO7+gnSbIAoUJJDRpHOAq4nlEFe5RtCQqwsRfNYWcHvaXKvOo02zJq
         6oQluF2xWSLWGSITy3dsc8VsgGINh0+GTcdWJMQWUw1A7jpAi5t5xjy3bihFywh9UQva
         WjBg==
X-Gm-Message-State: AOJu0YyhmzF2WAw29sdJ/bnt323ffhc6TNfy71yqGfAdu7Yq1VTqbQmV
	WAxBzxIpozRv+nPG+XdjUNIvG8GkKX0jgmJIoTcgj+k41fj7gJS2imLqE/Bgkw==
X-Gm-Gg: AY/fxX4UPmrelpWZiyHYrc5N3vcLOz0FaJyxa915paKDibmWPuhKCBJkY16QXrn0XWU
	/DSZNJBOqr0fpy/UN1H/t+tlnSE1zM44tr6LMKViY6tjn4hd1s5rtO3xZy9WThKDVXbORJP7HZT
	e8sVD/Y+qcLaQhb4fQPJez3Bxxn08UK6Vofwro3oCQAN6LnXGDSHu3ztCgK89Lsi/drAEHO08zE
	84PZ/gy2n/vT4irkoomOqlUyVWmGH+dlXFOw5GLLji5ywRb7N766S9hg3OGa3rtScgs3Ft118O0
	yFIP2lxPg2ruz/Aq+x8SdIpK2JV3wtoBvcGFkaHi2dCOBjMpj+uq6eNKjfoyqYRlU3piGE8DCki
	D1OUiLDaBpT+GiyjVZIbbx4MTaM2gy+eWi8UUy0T+xJ00lPj+feQx53h5+u/P9LGeo4Ny7lJKWT
	C1OLr2
X-Received: by 2002:a05:6808:2f19:b0:45a:58af:fee1 with SMTP id 5614622812f47-45c9c88d521mr204565b6e.16.1768501877240;
        Thu, 15 Jan 2026 10:31:17 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9df08545sm23781b6e.8.2026.01.15.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 10:31:16 -0800 (PST)
Date: Thu, 15 Jan 2026 12:31:13 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/14] object-file: extract function to read object info
 from path
Message-ID: <aWkvucfZy7e2Rd6t@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-3-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> Extract a new function that allows us to read object info for a specific
> loose object via a user-supplied path. This function will be used in a
> subsequent commit.

Ok, I assume that the new function we are talking about here is
read_object_info_from_path(). This new function does the same thing as
the previous version of odb_source_loose_read_object_info(), but now
requires the path to be provided.

> Note that this also allows us to drop `stat_loose_object()`, which is
> a simple wrapper around `odb_loose_path()` plus lstat(3p).
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 39 ++++++++++++++++-----------------------
>  1 file changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/object-file.c b/object-file.c
> index 8fa461dd59..a651129426 100644
> --- a/object-file.c
> +++ b/object-file.c
[snip]
> @@ -455,7 +438,7 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  		goto out;
>  	}
>  
> -	fd = open_loose_object(source->loose, oid, &path);
> +	fd = git_open(path);

Here we already have the path, so there is no need to invoke
odb_loose_path() again via open_loose_object(). We can instead call
git_open() directly. Looks good.

If I understand correctly, even before this change the path was already
available so using open_loose_object() here was already redundant.

>  	if (fd < 0) {
>  		if (errno != ENOENT)
>  			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
> @@ -534,6 +517,16 @@ int odb_source_loose_read_object_info(struct odb_source *source,
>  	return ret;
>  }
>  
> +int odb_source_loose_read_object_info(struct odb_source *source,
> +				      const struct object_id *oid,
> +				      struct object_info *oi,
> +				      unsigned flags)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +	odb_loose_path(source, &buf, oid);
> +	return read_object_info_from_path(source, buf.buf, oid, oi, flags);

Looks good.

-Justin
