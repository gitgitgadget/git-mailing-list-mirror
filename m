Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68527FD76
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320029; cv=none; b=q74f9hlyxtOSXN5/xyG/utCT6wEgSdu0Dyw5nd4emU5aQZij8/Gtt8+dIocjSDfrFEuCt36ofIpGUvKLiGtPsuUcrn+ZxJg4DikTtCUDhvddg37DOuv/bHI2yewRS39poxQhzQWDQLvy6MIfOD3PtReGzo5+37DWzmFNJuYbfjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320029; c=relaxed/simple;
	bh=bhMjUKpMiCRJnCaFO0CReYtI89tfwt6BvBQleqwWbDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDDy0NBnfFvdeT/Irw5qyBotjUpy7wH8hc6FjDnVwMHpVVSL9S049s06jAOdsj/dWgg6No3m/RM6ZwGjD8tlWliH3iDs8y+wtZsc5aHkuoEqIK2qbXOJS6LYMmz4iiTQeeuGBRs6as03NUxMYUFTHFM4z6p1Bc95f8pD75chTcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1k55HmG; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1k55HmG"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4376de3f128so2670722f8f.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320026; x=1771924826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SheIlw3agZ5IIOevCFmBBXjNhiI8cn0Nzj++tD/dGs0=;
        b=F1k55HmGElmKTMVi1g2hiZJ+IGDuO0smkFNIgtW7FuexY6fmHmlkqr2qKcwV4e+Luq
         2g+rtTJG1XA88zRLa3qZJ3kIDxscWVzqh4NbEHa5LL1tlddXIrr+3krhF/OK79AW6khX
         qCTOUYAtZ4UboMm6WXKc3IuPXWYGQezxtFPdxCjIXLNsHrFb8Xkt8A7OTPOsckXm+Onv
         ZPiD2OfsTbbXTMIFLVL9YCOx6QVwg3UOCFh7jAitQ2c/I9EyAD7ucJ696M8HxqUOYpdP
         KBl9QLEOK3rZNLgIFtSYcqAzn9tA2RH+c5d2lJZHDZOfbpOmvH4DKOMdOgW5+Cb5/Edp
         dBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320026; x=1771924826;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SheIlw3agZ5IIOevCFmBBXjNhiI8cn0Nzj++tD/dGs0=;
        b=cOT2xz1wGgpNBOKS/l5RCjhNv8imvnxqprjduwNolTHuaJz9BzZ60XxAikpfNyHt65
         7dM1D+U1MprhX3CwwOXIC2VN5RI9YtBKWd3cMWMk5F5FLObh2yvD/AoHFap4TV/VDND6
         6ivNPmHDozGBQNEWlqVb0QJT0+PrX76CzkCgADKpaHdHSUjNx7i5yXMDc/7UXTu7OjzN
         3LrGipCv6oWS/4ZxpS1cCalq86nR8z5eOPBz3bytakZaBM40mbfpYaQ0rgfvAqtluqVE
         xkqEFw7DPOIyRps1SR7yValg87EvNLbmIHzgCjZP4hHlr31EMlFnpA1sWNwMok77IKQY
         +Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCUmGGDAkHyjnTJJ3Y6jlRVwbIixVGjHEgf7h8cZD09e8ja5+8v3naQs6Py7biVYZeUQQXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGEPVNX/7z8JlgwEMVKNmM8EMpUp10wdWblps0kU5oLtFF2KJs
	smtndSkOgWx3Od0goXvA5Nm8WBdGoPv4GJIW1cgrU4RZRePhkxNtDYjO
X-Gm-Gg: AZuq6aIZGhjGXG7FDtHZoDB0q1R0qDTU5poVlw4oEcJh5nP04fP84CsB6OxMZRgrRb9
	ElT46HVA+iyNG/iogc1DSYJdocyRRYEN6dHEmmzH3f8jnt6aL0ej40EnVd8M7ezsMq4VU7tl3ic
	H4YQU9WWCKK6o0hI7zABfi4TYAp7ey/XNkTKkpd4VGzNna5HIqBT4EkbeQo/m7IFg06kPGmMxt4
	3MqxYDjXaERiCAG4vTyOjjlKRZrSeK7VkPHnhV87IdGfkY/OKa1t/LGHheWfO4uZ0k6ZInrQA+F
	snyoJsXgH4re9oTTHj6t0LXGoSvAosgqAO9yaLTnHQw5ftM29dJATIzWXL92mc4U4yIJzvlZN/F
	D+tE6zBTJIsT0+bzukeL41bEWVD1dztkWVdq4GsYpdCLwca+0ik09vu4jubuEfRCds9PtUOlrWW
	NAiV2IMYTf4g2qd13q4DPDmhlCYaE6XqtEXtnwezfyF+qbysrt+p+PQJFRm/+QRoVqpVFSLr+N2
	tNanA==
X-Received: by 2002:a05:6000:2303:b0:437:7010:1d09 with SMTP id ffacd0b85a97d-4379db732c7mr18785330f8f.27.1771320026224;
        Tue, 17 Feb 2026 01:20:26 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8d46sm34003285f8f.32.2026.02.17.01.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:20:25 -0800 (PST)
Message-ID: <833b54f7-bb6b-4bb7-a5ec-fc0fa679abf8@gmail.com>
Date: Tue, 17 Feb 2026 09:20:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] meson: regenerate config-list.h when Documentation
 changes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Evan Martin <evan.martin@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
 <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/02/2026 22:28, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list
> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make. We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild.
> 
> Also mark the generator script as a dependency.
> 
> Combining the following commands helps debug dependencies:
> 
>      ninja -C <builddir> -t deps config-list.h
>      ninja -C <builddir> -t browse config-list.h
> 
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>

Thanks for the nicely written commit message.

> +if test -n "$DEPFILE"
> +then
> +	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc
> +	do
> +		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"\\

This forks two processes for every file which is a bit inefficient and 
will be especially slow on windows. If we quote $OUTPUT first we should 
be able to use a single sed process for all the files

	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT"| sed 's|[/\]|\\&|g')"
	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
		"$SOURCE_DIR"/Documentation/config/*.adoc |
	sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"

Thanks

Phillip

