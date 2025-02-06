Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA72288D0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738843517; cv=none; b=t0pkOA2c9P5cFiTQ6tcvwYidz8fyA5B7JtHkQRSUex3u9/8toRCMiuAYbqjHoIBWDpbStO/vmVx+jwobtiF31dFbU9HbAZpZoR2m9Ba5aI3Qfmi5IneYZuljH+k5PP4c8Fr0S8s6U1hrq8Xkma3T5yggW4FaGPUoXcy9FgOqAX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738843517; c=relaxed/simple;
	bh=Mvmu1ner0mz0WXG/MpxwQId8RvH1VgGQ2GFkXPwEk7Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=f8fvKf1mCpVgTJDZF69DvGubQXFP+aekHSVHplzUdSz+0B7LUpZZS4YFTBeILetqBJ5V9nXKs1mFvXBthbCJgkkO1E27AJxjMhX0apeZMj7Vl/FZOeJNZ7X4fgkP/gcy6GhMH88g2rITMiS4/LUFAoQ+3q4rZWf9jnh+9D5yTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWbkP466; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWbkP466"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51f2a8fd0e6so44057e0c.0
        for <git@vger.kernel.org>; Thu, 06 Feb 2025 04:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738843514; x=1739448314; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=409E27dZKpbN8frRhUh0OcHnWOl1cfCCC8Kt9pIObnQ=;
        b=OWbkP466bigYPcwB6jK8iu7fXiUo323ikIiXjiNxKDEON5HszsHRbztow0U+mBrKO3
         7S1Rv0L7DVKnr74ViaY311babEPZx66pgCU83AgMYgR8p2bnPUkPIWzDP7wqTwbKNKEp
         Px7BNHI28yQ6lzua+sLme+bvav0+o9TDBI/FoQtgk0DwvovtnTGgQkF6eG1cMw76Z3HN
         M0wi4JhzWNPI4aPE9enLB4A6eNHVq1lRDzpE9kWu3EHxyqHyVN09raUvIUbiWt/KBTym
         x6qYfb3gFy5Jiq5G1XJwHDhYAD2W/09fQbpsGgNNHyYGERdzv0x5M5WoRihHRqoSeHmw
         MLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738843514; x=1739448314;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=409E27dZKpbN8frRhUh0OcHnWOl1cfCCC8Kt9pIObnQ=;
        b=bm0CYE6VM6Wr5igpqGS7N1H5X303vqE4KDDwJxsuTwdX4YYw2vqGDApE7N7x7Rbej+
         1mU8tJkcRQ8Yw1iHlGEiOZfzborWeO789G+xqiEuZq/9fE/z1n6G9EaxYgL2X/Wkn2Oc
         0Ll3CZiRXJC+yUle8JjFn8HxzRkhuGFmskP5XSwoYjxDw2R0ilLn7+VbL1WWtwHNFM8Z
         XuSik2SIRCIbrUVOK58Q7kv6Aoea3U5fxJ0kIrIzW9eZvmPURpbCUmk+tawUadL6UgRQ
         pgIDoFjwuQwyfG5aj7UTD39on2+PzSuasVG15Leq4TNjH59Alc6A6dSoN8GpwvK+1BHC
         1rxw==
X-Forwarded-Encrypted: i=1; AJvYcCWlZRCa2n7zlI6JZm6s3X9AUSwOirMkCJavbtGHv2NlYlxaVK1utHnQqbegSZdP4r07Mvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytw2e3njoGnqUmYloGQ0AdYs02jdkF6EwKkn0Q0M2Zse/j2Dfw
	vQKNmu/TMCgAswEQrwgmYrhRr+qv5ig8b5lCdy0mHlIuUQuyCmC9yNRTehAZWSKKI4Tk87sfjbd
	bmyYJrc4It5o6MIhPxtt5uLN7ryIP/+Qs
X-Gm-Gg: ASbGncsbwy4JSwJjv0CEZRLTAdqYhILTnBWG51JYODLBwOzkWtEoZ9N3Ie4B6UKO7Wg
	zmz29ppmwTIp5R2A2rthdLqDNneDbUw0QcbKnpKsnwHvWGKMG/UedrcU0fDMUjdgTpd98tW16iD
	aTZmmWNgLV+9XsEEex80D+qAe8Bmy67VY=
X-Google-Smtp-Source: AGHT+IFpWG5aHUgvrViIzj43Ae1RDrLCxSnu52ToADa3Bf4G4GS57fy04/EOq8ol4zHWTHLVkhlEl226AuQML/NXd9M=
X-Received: by 2002:a05:6122:190b:b0:517:4fca:86e2 with SMTP id
 71dfb90a1353d-51f0c528362mr3573925e0c.10.1738843514108; Thu, 06 Feb 2025
 04:05:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Feb 2025 04:05:13 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
 <20250206-b4-pks-path-drop-the-repository-v1-5-4e77f0313206@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Feb 2025 04:05:13 -0800
X-Gm-Features: AWEUYZlw6wD3Jx1H9cOGeMwwa7BoAywb-XnhUm_Cyg2_yrOgWSC6JHvgPzuwAqM
Message-ID: <CAOLa=ZTJ7ef9rP3fQfNwSCD54zeVPL1Rd_hQfzDpEpFiStx_PQ@mail.gmail.com>
Subject: Re: [PATCH 05/16] path: refactor `repo_submodule_path()` family of functions
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fa9eff062d780de6"

--000000000000fa9eff062d780de6
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/path.c b/path.c
> index d918d0409e..d721507be8 100644
> --- a/path.c
> +++ b/path.c
> @@ -560,14 +560,15 @@ const char *repo_worktree_path_replace(const struct repository *repo,
>  }
>
>  /* Returns 0 on success, negative on failure. */
> -static int do_submodule_path(struct strbuf *buf, const char *path,
> +static int do_submodule_path(struct repository *repo,
> +			     struct strbuf *buf, const char *path,
>  			     const char *fmt, va_list args)
>  {
>  	struct strbuf git_submodule_common_dir = STRBUF_INIT;
>  	struct strbuf git_submodule_dir = STRBUF_INIT;
>  	int ret;
>
> -	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
> +	ret = submodule_to_gitdir(repo, &git_submodule_dir, path);
>  	if (ret)
>  		goto cleanup;
>
> @@ -586,13 +587,14 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
>  	return ret;
>  }
>
> -char *git_pathdup_submodule(const char *path, const char *fmt, ...)
> +char *repo_submodule_path(struct repository *repo,

To stay consistent with the other repo_* functions, should we change
`struct repository *repo` to `const struct repository *repo`?

> +			  const char *path, const char *fmt, ...)
>  {
>  	int err;
>  	va_list args;
>  	struct strbuf buf = STRBUF_INIT;
>  	va_start(args, fmt);
> -	err = do_submodule_path(&buf, path, fmt, args);
> +	err = do_submodule_path(repo, &buf, path, fmt, args);
>  	va_end(args);
>  	if (err) {
>  		strbuf_release(&buf);
> @@ -601,16 +603,35 @@ char *git_pathdup_submodule(const char *path, const char *fmt, ...)
>  	return strbuf_detach(&buf, NULL);
>  }
>
> -int strbuf_git_path_submodule(struct strbuf *buf, const char *path,
> -			      const char *fmt, ...)
> +const char *repo_submodule_path_append(struct repository *repo,
> +				       struct strbuf *buf,
> +				       const char *path,
> +				       const char *fmt, ...)
>  {
>  	int err;
>  	va_list args;
>  	va_start(args, fmt);
> -	err = do_submodule_path(buf, path, fmt, args);
> +	err = do_submodule_path(repo, buf, path, fmt, args);
>  	va_end(args);
> +	if (err)
> +		return NULL;
> +	return buf->buf;
> +}
>
> -	return err;
> +const char *repo_submodule_path_replace(struct repository *repo,
> +					struct strbuf *buf,
> +					const char *path,
> +					const char *fmt, ...)
> +{
> +	int err;
> +	va_list args;
> +	strbuf_reset(buf);
> +	va_start(args, fmt);
> +	err = do_submodule_path(repo, buf, path, fmt, args);
> +	va_end(args);
> +	if (err)
> +		return NULL;
> +	return buf->buf;
>  }
>
>  void repo_common_pathv(const struct repository *repo,

[snip]

--000000000000fa9eff062d780de6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e21b5ba019f7530a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1la3BYWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMnh5Qy85QnNPZ0QxNzlaVzZXbXdrOWM2ZGUxWnp2YwpZalR2bnVkRDBs
WGNLckFJOVVXTGx4K3M4bWRackdpU2YyaUs5bFNhZEFQejFPNi9rWmxseGNrNGc4ZzdQTU9QCm5w
eStpdUZpbmMyVTN1SlI2NnJ5RllWT3lkN2NDUjN6WnBsa0xsY2FnRjlxRkV4QU9XWHg5VlNzK0t1
S3hDQ0gKRmdjZVgrU1pFa21ESVlJQzNFd1JlRWp1bDZOQ0xzamZ4Skh0NDdhQzZ1aHFNQzBGaUU2
YU9USmY1Um8yWmF3Tgp2RDlhaTJMWURWcUxtRm9UbzVkQTN6L2lFZVJZaW1adk9GK3ZVTGNSUitz
TFJmRkdLRnZMOXA3ZEN3NE1hak04CjlQWDlaWnNtWTMrclR0Y0xlQUQ1SWE4cmx1ZGMrZ0hNM0Na
N1RRZ24rSTV5TTAzZWFMZ3JBcEJjNWdSZTZieU8KL0JudzJ2NVB4QzhEY0pWazVwKzBqMW9XMmRz
TVQxZXh1bHlUVzJNcnRhZjFSczdZNlUvSWFXV2FmeE16cG1xcwo2TE14R0l6U0NScHNOVlpPc1ht
dVpJYlhkNytiWVAyKzR6RStvaU9rUHNrRVZWdlpramtvSWs0bUdPcGZTallsCk9BT3RDR0lVZ0pl
aHdlczA0RFcxaXFjSTRxRkVQdWtBSXo2UDFSaz0KPVJNQmoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fa9eff062d780de6--
