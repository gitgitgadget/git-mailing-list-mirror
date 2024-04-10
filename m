Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1279D17BB21
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712773687; cv=none; b=dLtW0Ydt1Ii5DwQPiwEMrO6qAIRReyNkE9BxVJiNftrgeoNVUpumP4CU0RSdpJtK9jx1jyxgm6WIiL07HXq5QbfJNlPGyoCF30edhJMcw7M7F6GTlDdTEEhNZkq2EDbKT5S2x3h4sb42BA5p4EbBA/EfWzp4vbHQQ2DghFhvlrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712773687; c=relaxed/simple;
	bh=5PuIRx8ai7UR/LuMYJSttmf4756dRlVEzElLi29tQdg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=leLZhqEWne4o5sr39lRkBXq7nqHPfdUsOnVmGGeLuig7u0pABcRXgHLxRH4h0Mi/WMw1rEkWROA7dH/zFI3Lzepc6/vzsXjOjMXtWrUeORPF7TOIAspYT1+M0AuR5HB/BcPo3RpZBaSKogSIbbANgtSx0QkMc3sonR+xNAESuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BTY/bFAn; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BTY/bFAn"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 54D5F22AEA;
	Wed, 10 Apr 2024 14:28:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5PuIRx8ai7UR/LuMYJSttmf4756dRlVEzElLi2
	9tQdg=; b=BTY/bFAnXcgozD7MSpn0kS9FXEBpa944lpLWnXPR1OMqnBtsi4RvIo
	pUJe37yBTmb9Qgvk1HsDE3Zn289c6mwlVXIr2PxDtcR5Qqb0y8/op/mKwMsGXdvj
	Pct8bfJ2evAQncKug/Be2v5YNEiYPPFxF6FHWK5iujUVca8oAYohk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CC7922AE9;
	Wed, 10 Apr 2024 14:28:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C97C322AE7;
	Wed, 10 Apr 2024 14:28:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 6/8] fast-import: document C-style escapes for paths
In-Reply-To: <1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:56:03 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev>
Date: Wed, 10 Apr 2024 11:28:00 -0700
Message-ID: <xmqqjzl5t6mn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 105F85E2-F768-11EE-980E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> +an unquoted string. In C-style quoting, the complete filename is
> +surrounded with double quote (`"`) and certain characters must be
> +escaped by preceding them with a backslash: `LF` is written as `\n`,
> +backslash as `\\`, and double quote as `\"`. Some characters may may

"may may"?

> +optionally be written with escape sequences: `\a` for bell, `\b` for
> +backspace, `\f` for form feed, `\n` for line feed, `\r` for carriage
> +return, `\t` for horizontal tab, and `\v` for vertical tab. Any byte can
> +be written with 3-digit octal codes (e.g., `\033`).

Separating the escaped characters into two classes (mandatory LF and
BackSlash, and others) is probably a good idea to clarify the
description.  Nicely done.

>  A `<path>` must use UNIX-style directory separators (forward slash `/`)
>  and must be in canonical form. That is it must not:
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 13f98e6688..5cde8f8d01 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3189,8 +3189,9 @@ test_path_eol_success () {
>  	'
>  }
>  
> -test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello world.c '
> -test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello world.c '
> +test_path_eol_success 'quoted spaces'   '" hello world.c "'  ' hello world.c '
> +test_path_eol_success 'unquoted spaces' ' hello world.c '    ' hello world.c '

It is annoying to see these changes (and the same for the next
hunk).  Would it make a lot of damage to existing lines in this file
if we just say "do not align with extra spaces in between strings"?
If so, that is a good reason to keep doing things this way, but if I
recall correctly, these test_path_eol/space_success are what this
series added to the file, so if we stop such alignment from the get-go,
it may be alright.

> +test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
>  
>  #
>  # Valid paths before a space: filecopy (source) and filerename (source).
> @@ -3256,8 +3257,9 @@ test_path_space_success () {
>  	'
>  }
>  
> -test_path_space_success 'quoted spaces'      '" hello world.c "' ' hello world.c '
> -test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello_world.c'
> +test_path_space_success 'quoted spaces'      '" hello world.c "'  ' hello world.c '
> +test_path_space_success 'no unquoted spaces' 'hello_world.c'      'hello_world.c'
> +test_path_space_success 'octal escapes'      '"\150\151\056\143"' 'hi.c'
>  
>  #
>  # Test a single commit change with an invalid path. Run it with all occurrences
