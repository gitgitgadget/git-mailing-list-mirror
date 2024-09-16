Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98B05258
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726517635; cv=none; b=srNDW3tdmp1rruvPaCkbhMN+9MAuaKy/DVCaFI0+69aF0/NkUSfnSenX3pcJiCXgfQyy2F/Zy7jnPb7PETHqGwAaT+0KsjJwfkHVQ85KE+ksL06gTsTXpFWF4j7rrZAix/ZnVaHNoLFJa6Pb0f4ylaW6saok+6is9BBm8MdmKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726517635; c=relaxed/simple;
	bh=0Wkack4ehVGl3qskWXYC5yAe65QHG00sZ2TJq7Hwr7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mfRmjNcYO3YeaxJS/IbpQZp+vIx031XaHP8SjDWon+n6nKsOx7k3mKqtnyH7iPIHMupFj1QONiG7o6zqOo3+IdDFAjS/DS82cq8koyMiT3JZeb5kvVxTTlW59FLAk8LuzD5dWlX8CPwXLLDBEzHSJH7tVmxikuy3QJayrjmWx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DyGPvjZV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyGPvjZV"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3780c8d689aso3676740f8f.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726517632; x=1727122432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=du2BZO1iurEXLWlGlOeOrFU8E2xYCdMA6vwuK2FX600=;
        b=DyGPvjZVFtmTY0S7BO+urpVPHCjcfN47pMvDHhv457JKALkyWMl9F5spoq/aYhraeB
         zY2KwzKOtdajTH9wIjZZmixLGu1C3iuwZNMQocWAR6DAiINjA5zUwz7BOp/uvCK+GpOv
         xKUwm5PmBv2b5H7BVDAsh5MEG+MCUqDghaAlqYsp2MFWYyOSUpzRvTeBBe5t0j/cTnRc
         uvMwbsnV2WJ1DrLMdz+adHib7qwJWGiZRiDOiDQUXjHtldLoAklljItN5AQ3D5yNUZqS
         gODKfn4u0KkgZ/9zagbgwUkmzVuK1na5OYNnwgwfaTuB8kaNU7c8GsSOcA8Grzlnlc2e
         ifpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726517632; x=1727122432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=du2BZO1iurEXLWlGlOeOrFU8E2xYCdMA6vwuK2FX600=;
        b=jhSGU/wKQ7hF2Xv2Lns1Lms3QwUY67/Q6XyC2ACZBgcMBPOEkQaiBK7Dx5+CcXinCV
         t6TdHUEmkwS/Lj8uLV0e3W9XYlKVP1qiQashNirglJAgo82ZvsuJSenftsCfxSqo9Zeh
         dFPI88pZ0v3M/RnxX9Dkr5tUsGUzcuQn1V6k1LBtGYA5RBAhgKEuY+gKKLBXTPBbToFW
         C931KRzXUcHNxkhhpcIboY0NkYBKK/e0e30jTIEL4aYKioCt+xH/2MVHlt4VJJvM4ZGf
         2X13boppTxM0HPY/gCT1yrvCaJlKvIGePWdgdN47ytbchLWlv4ShgJAzBagoQlNYrfV7
         XjPg==
X-Gm-Message-State: AOJu0YygmK9qUA+z2pdYMI5mpxKbgF8B26WpQUwZtgKK00MAW+gk705s
	sKzU3ejXhW7QdTFeoHGysqaf49WH+w3Y2qoUXl9BiFgaAePq0URQZPShpVSc7Wmhu+3wxEXcPWI
	VRy3tPvi3sf0QlkawOSo5GuumFLCK3Q==
X-Google-Smtp-Source: AGHT+IElw022aKyDj0cBo0oe+0mHBVYIzHx9Roq3xZU6wOGKF3txcrRUrNB4YZ5B04Rg3xm5n940Sq+ZEw1TkVPTHaM=
X-Received: by 2002:a05:6000:1247:b0:374:c29f:8ddc with SMTP id
 ffacd0b85a97d-378c2d638bemr10432506f8f.40.1726517631188; Mon, 16 Sep 2024
 13:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240915111119.GA2017770@coredump.intra.peff.net> <20240915111846.GA2017851@coredump.intra.peff.net>
In-Reply-To: <20240915111846.GA2017851@coredump.intra.peff.net>
From: =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date: Mon, 16 Sep 2024 22:13:39 +0200
Message-ID: <CAN0heSrQiV6WOP4C5mFPh1AMgX9yy3CcHx2RPraKMFtmNJ2fPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-jump: always specify column 1 for diff entries
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 15 Sept 2024 at 13:18, Jeff King <peff@peff.net> wrote:
>
> When we generate a quickfix entry for a diff hunk, we provide just the
> filename and line number along with the content, like:
>
>   file:1: contents of the line
>
> This can be a problem if the line itself looks like a quickfix header.
> For example (and this is adapted from a real-world case that bit me):
>
>   echo 'static_lease 10:11:12:13:14:15:16 10.0.0.1' >file
>   git add file
>   echo change >file
>
> produces:
>
>   file:1: static_lease 10:11:12:13:14:15:16 10.0.0.1
>
> which is ambiguous. It could be line 1 of "file", or line 11 of the file
> "file:1: static_lease 10", and so on. In the case of vim's default
> config, it seems to prefer the latter (you can configure "errorformat"
> with a variety of patterns, but out of the box it matches some common
> ones).

I've never hit this, but it doesn't look too crazy. A couple of digits
and a colon and things begin to match. Ok.

> One easy way to fix this is to provide a column number, like:
>
>   file:1:1: static_lease 10:11:12:13:14:15:16 10.0.0.1
>
> which causes vim to prefer line 1 of "file" again (due to the preference
> order of the various patterns in the default errorformat).

Makes sense.

> There are other options. For example, at least in my version of vim,
> wrapping the file in quotation marks like:
>
>   "file":1: static_lease 10:11:12:13:14:15:16 10.0.0.1
>
> also works. That perhaps would the right thing even if you had the silly
> file name "file:1:1: foo 10". But it's not clear what would happen if
> you had a filename with quotes in it.

Right. Looking around, I can find someone asking the Internet how to
escape the filename and not getting any response.

> This feature is inherently scraping text, and there's bound to be some
> ambiguities. I don't think it's worth worrying too much about unlikely
> filenames, as its the file content that is more likely to introduce
> unexpected characters.

Agreed. (s/its/it's/)

> So let's just go with the extra ":1" column specifier. We know this is
> supported everywhere, as git-jump's "grep" mode already uses it (and
> thus doesn't exhibit the same problem).
>
> The "merge" mode is mostly immune to this, as it only matches "<<<<<<<"
> conflict marker lines. It's possible of course to have a marker that
> says "foo 10:11" later in the line, but in practice these will only have
> branches and perhaps file names, so it's probably not worth worrying
> about (and fixing it would involve passing --column to the system grep,
> which may not be portable).

I suppose we could use `git grep --no-index` instead of `grep` for `git
jump merge`. Anyway, that's out of scope here.

> I also gave some thought as to whether we could put something more
> useful than "1" in the column field for diffs. In theory we could find

Heh. Yes, in theory everything is possible. Your approach makes sense.

> -               print "$file:$line: $1\n";
> +               print "$file:$line:1: $1\n";

Looks good to me and from my testing, this fixes the problem as
described.

Martin
