Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460412DE6F3
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892186; cv=none; b=dOLRHXfifztum7yD5VC9ofP5rP0Q4yN81jRrDljFm6FCcJODAan9WNTGFjDgjCkgkRjWCGiU2jr0DVMBGxgKUPFqPp2S4JfQaQPgvtsWwMNeDrMU4gPMnR7iQnlMi506+n43aYpEb4vrlHqfo3QfF3rum5WtK4OSmj4hFrzNJRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892186; c=relaxed/simple;
	bh=CgrvpHQ/2PansNy+UCHxCrWi3bbm2HAsr0ZnPQKpiIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr/ZNTfwjkYX4CqM8uI4n59z/1+fqLSvi7h4h+JyM2pznQuL9bIBSJYkAuxu2zFPHfJbCOrOhZVkIQqIl82jYEC/9DfRF3Ot5JVZS6d4+fEmOwmh8XNbUXLdYQ/6BKGJGDqw6TCsDCDglzPiYCo/7+XH/2To9Uor57R10RmbAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhGsHk73; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhGsHk73"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so116468555e9.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770892184; x=1771496984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GCXpP23eAcRec+1RyiZApYEsFEV7LSckZSY7pYNJ3Zg=;
        b=lhGsHk73P+TqM38hZuy66XVyDABa9BFnFbMeYVlRIG+E/H+4FUGpMeYsIJ8ueDvaDB
         PM86QRTdq/sGllPsYjwsd2rSzM4Z9JNfw9NCSH/+N3dhx76pjmrkAOZ8R0jTEs+HMKd5
         FOBK/HSUecpMlj5y3BKDIPGoZPswVqEf1fhvQEB32RKn+ba1Lkd3wXLlytkv2b2UU0uD
         1TxexGb4TVqr4QewK7vzWnDlYud8mrgLfbGEtU4QhSeIUiJ5RMeOYjDNFiWhvec6Ou88
         IsBSST+pdp/cJYvo5MKGCHQcqTSLTiHHJGoJwPfxaQOxg6cjsqh58OYwcDeCYT8XFblI
         Wmfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770892184; x=1771496984;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCXpP23eAcRec+1RyiZApYEsFEV7LSckZSY7pYNJ3Zg=;
        b=wfiCj7cNnEgyFVRLV+vgygrCOcaZoExC+d0NZpddyn9qWnuJccwzy/sq67r/fC2cDH
         dyhFh6ywkinRH+ZxdDHaCFviYge935UdkSNM0moKtQrEI+5vWhAFa/GPVbwN3iSFuRuh
         WCSFsaIwforbLGbmBiLcHHff/hcF+qPXBr+Lnt5z8DHBFomGHdu+YDJTVFL1cZrwNM3b
         g5QDSyhSUKogPxGWkteScHnONRUJHA6gfP3n0kXcbubhTHHdSqHjrxZrQoOg3/ooR/pw
         HX8jyDYQR8RBceiMckmQDFi+euQsGzfPLahxsJQoZ8qY5qoJLelO+o/jsVDikJRwbjj9
         MkEg==
X-Forwarded-Encrypted: i=1; AJvYcCU7rPSQYfrQ9G/x4u084QnhZVaUPe1P+IDlN35KkajgKn+ZaETWgcVb/+fJIr4NqVxDP6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHmyK6ckuvGXco/vVUt+0KZMak1uYY9Bj+tIvmPiF10aKQRlh
	z7+SvEYLglOuusSmKUYmawcp131MZbpIlQEnFE5TPUrKMLXXlEGSLH3F
X-Gm-Gg: AZuq6aJmnNGjfZbuJR1y3sySBLyZlxRdkvhMZcruGk13VMtULt/3tz/68imIVtm2HJZ
	iXt2R6B79OynyeqleKV17RdA+9AiL3KIaA/G/6pP/AhaLEixkaSfnlGsy/38pLYRsCS2ovQ8910
	G4gQWC0+yVwYpmnawE4aXPB3ZPWXwucew+I2mmyxiwu7zL9D0gBiVLsIuf2qBRRtPgW0H3XGgOp
	w2N3YDP5Q9RN/ASJK7sx8TpRNFzPm1tCiAejWed0zFUFeIBixIGtdET6//6jucdl1WkBSeo8nCL
	exRZalsbAPy4xvrpr5+LKIEXcG6aqPdx+jMPTJUHgkXDWljQ1PCgNSnUe4N7nXtRbq+sIzx2iB1
	3vU2KP9aTURbOJthNnkN+pemhKIGNlRIfnU7PnuJx0ovx7nY7rt6EaMJVv6Lf2LoBSl5qj5B8/c
	SQTdd7OCutZ3+DhI99i8x5kvIuXh44k5s7nrQwncIhJy+wj5PnsGcWDZE2SpC84SCj202/yX/7O
	eWjcg==
X-Received: by 2002:a05:600c:1e8c:b0:480:4b59:932e with SMTP id 5b1f17b1804b1-483656c0a5dmr30166345e9.11.1770892183380;
        Thu, 12 Feb 2026 02:29:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a64cf1asm40197605e9.5.2026.02.12.02.29.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 02:29:42 -0800 (PST)
Message-ID: <19d86fb2-cbbe-4753-831c-a6ed49722103@gmail.com>
Date: Thu, 12 Feb 2026 10:29:39 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] meson: regenerate config-list.h when Documentation
 changes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Evan Martin <evan.martin@gmail.com>
References: <c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>
 <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 11/02/2026 23:51, D. Ben Knoble wrote:
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
> for globbing like Make.

It would be useful to mention that we assume that if a user adds a new 
file under Documentation/config then they will also edit one of the 
existing files to include that new file and that will trigger a rebuild.

> Helped-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Changes from v2 (<c9ae171eed6bd5b0fa6671b10a5ad0da024f36d0.1770649805.git.ben.knoble+github@gmail.com>):
>      
>      • Pick up (and tweak) Patrick's depfile proposal
>      • Include the script itself as a dependency
>      • Escape output paths (spaces, octothorpes, and backslashes) for Ninja
>      
>      I'm not 100% sure I've actually done the escaping correctly, though,
>      since Ninja's source says that a space preceded by 2N backslashes
>      represents 2N backslashes at the end of a filename, and
>      
>          λ printf '%s\n' 'foo\' | sed 's/[# \\]/\\&/g' | xxd
>          00000000: 666f 6f5c 5c0a                           foo\\.
>      
>      So would they interpret that as the filename 'foo\\' instead of 'foo\' ?
>      (Or, no because the 2N slashes aren't followed by a SP, but a NL?)

Having re-read the ninja source I agree with Patrick that we should not 
be escaping backslashes

> +if test -n "$DEPFILE"
> +then
> +	printf "$OUTPUT: %s\n" "$0" "$SOURCE_DIR"/Documentation/*config.adoc \
> +	    "$SOURCE_DIR"/Documentation/config/*.adoc |
> +	    sed 's/[# \\]/\\&/g' >"$DEPFILE"

This will escape the space after "$OUTPUT:" which is not what we want.

	printf '%s\n' ... | sed "s/[# ]/\\&/g; s|^|$OUTPUT|" >"$DEPFILE"

should work so long as $OUTPUT does not contain any '|' characters.

Thanks

Phillip

> +fi
> diff --git a/meson.build b/meson.build
> index 3a1d12caa4..fb5d7367f5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,13 @@ endif
>   
>   builtin_sources += custom_target(
>     output: 'config-list.h',
> +  depfile: 'config-list.h.d',
>     command: [
>       shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>       meson.current_source_dir(),
>       '@OUTPUT@',
> +    '@DEPFILE@',
>     ],
>     env: script_environment,
>   )
> 
> base-commit: 19a08e0c02faf1c5b4efd1add85598cf8390ff7e
> prerequisite-patch-id: 364ba1899740b93be5957262d3583348d030e8fa

