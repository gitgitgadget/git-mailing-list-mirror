Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887018BFC
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711807220; cv=none; b=PKstQ6D3Q886dGF/0vFQLOPYC4TA+HtNjwOp5fYQyf/npgCwRsdYc52A+nyw9JY1s9GZlLbejaBTRoafwV4ac4NPjsKHoUiUlgpGa+Du7myEzo1JS8CgyzzBToWiH7Ohj40P2d9kIcvbm4Tqzf+9qg/jt3rUf46hhhG4/6DhZTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711807220; c=relaxed/simple;
	bh=GdivqVlsHVBlCjL/z/Fw3t6pjGATiwqj2gsisX7pTZo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=czbsIugvkBGlCJ5sFEQm/2BxvMznHV05gNFXOPNx1iwOrPYLVH4+pXXwAXhL4mV2DZcHJon9FUP4YCEzSB9GOw83t5AB0Opvk4aVFHlv4MN4zdHYM8slzav3ELkOlcZCDQoVgBBPviHJlPwD6etEjiSPrnVZZV96qO3LmfoH6HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyezsZI9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyezsZI9"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-513d717269fso3222763e87.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711807217; x=1712412017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gpcXx2ubRtfD/20Oda7YkTKfNjIl5VnyCEV3q6KHlx4=;
        b=eyezsZI9DEqeCYAzzrwR8t76wqI4CtFyVEleDsHACIM6cQ60HANVTZ5cGNktJtU2gR
         P0IicYCbYpV6nV9ySnfdGS6b8do7s7tYkKDcvAciC47J/c+ixAasFcGrRhp15v+5zdb1
         VdqQML3b0oOfKXVp2UBn0ajVriU4nBgGICzMyTnONKevuOq7LcDoGSl2HRbNCwpg8vl0
         7hSlmeo77JAsBuH0OlLfKA7xpw6vbFjXzIuK9PkDRu70cBwTK3YUeh47ldRi9wd9DEvg
         /FcviCBCjjWqstOwge9qrhTbscw+7KVoj+aNFaiymPI9TZ7D8yCzeGj1In6idsQhSoiD
         P5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711807217; x=1712412017;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gpcXx2ubRtfD/20Oda7YkTKfNjIl5VnyCEV3q6KHlx4=;
        b=VJfA62H9DrewD0Bk/o1F5sIuDGIuVgp9J94KZfi96xjAxnWifD2XawImfFGgn3Flu6
         E6ur7b+idHWniIRQFyQfgeczo5UQLV6n2rV2EpqJ6Iq15WpdezW6AYVvWsMza4LCCtCH
         17tthSY8ynnXcnGSRryyEdLTUPbH6IJyxY6NAClMLjke5qXboxnfkvDRTi4KzcUcVPqQ
         Vc/pNSlBLE6uqgTerQfliTRTBYyPJd8F6kPKI0jKQGCPp7Nu9sG8OvSZiAgOklgIyv6m
         o+WGf9xXj7huLnuGDbsWALqSjbEoMsbkygkEdZzlY3qZVOU/oTVBGpbk2ImqmDXEJI++
         wwKQ==
X-Gm-Message-State: AOJu0YzVMDhLlvGF76xaL6lyeShnHvJahCQ+UrQY6xxqd65xv+wfjuXf
	A0UhZK2oTSPyarZIbgwYdtHKuQWCAB1jqBazW9kEfyPZJ5fJni5N+vrNENwf
X-Google-Smtp-Source: AGHT+IF9fSpO77v2FtwInyqxBT/g0lszvJXIk36Pft9k1OAU0pa2GuKKvY0BbtCGh/r3OensjcLFCA==
X-Received: by 2002:a19:5f5a:0:b0:516:a32e:ab54 with SMTP id a26-20020a195f5a000000b00516a32eab54mr141041lfj.69.1711807216303;
        Sat, 30 Mar 2024 07:00:16 -0700 (PDT)
Received: from gmail.com (40.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.40])
        by smtp.gmail.com with ESMTPSA id d10-20020a05651233ca00b005169eb835e8sm161041lfg.293.2024.03.30.07.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 07:00:15 -0700 (PDT)
Message-ID: <46fba030-d7aa-49d2-88fa-e506850f7b6a@gmail.com>
Date: Sat, 30 Mar 2024 15:00:11 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/3] add: use advise_if_enabled
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>
References: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Language: en-US
In-Reply-To: <06c9b422-b22e-4310-ad5b-1686616ab860@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series is a simple change, in builtin/add.c, from:

	if (advice_enabled(XXX))
		advise(MMM)

to the newer:

	advise_if_enabled(XXX, MMM)

Rubén Justo (3):
  add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
  add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
  add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO

 builtin/add.c              | 18 ++++++---------
 t/t3700-add.sh             | 47 ++++++++++++++++++++++++++++++++++++--
 t/t7400-submodule-basic.sh |  3 +--
 3 files changed, 53 insertions(+), 15 deletions(-)

Range-diff against v1:
1:  c599ff8b98 ! 1:  9462b7045d add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
    @@ Metadata
      ## Commit message ##
         add: use advise_if_enabled for ADVICE_ADD_IGNORED_FILE
     
    -    Use the newer advise_if_enabled() machinery to show the advice.
    +    Since b3b18d1621 (advice: revamp advise API, 2020-03-02), we can use
    +    advise_if_enabled() to display an advice.  This API encapsulates three
    +    actions:
    +            1.- checking the visibility of the advice
    +
    +            2.- displaying the advice when appropriate
    +
    +            3.- displaying instructions on how to disable the advice, when
    +                appropriate
    +
    +    The code we have in builtin/add.c to display the ADVICE_ADD_IGNORED_FILE
    +    advice, is doing these three things.  However, the instructions
    +    displayed on how to disable the hint are not shown in the normalized way
    +    that advise_if_enabled() introduced.  This may cause distraction.
    +
    +    There is no reason not to use the new API here.  On the contrary, by
    +    using it we gain simplicity in the code and avoid possible distractions.
    +
    +    For these reasons, use the newer advise_if_enabled() machinery to show
    +    the ADVICE_ADD_IGNORED_FILE advice, and don't bother checking the
    +    visibility or displaying the instruction on how to disable the advice.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
2:  76550e01e1 ! 2:  f892013059 add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
    @@ Metadata
      ## Commit message ##
         add: use advise_if_enabled for ADVICE_ADD_EMPTY_PATHSPEC
     
    -    Use the newer advise_if_enabled() machinery to show the advice.
    +    Since 93b0d86aaf (git-add: error out when given no arguments.,
    +    2006-12-20) we display a message when no arguments are given to "git
    +    add".
     
    -    We don't have a test for this.  Add one.
    +    Part of that message was converted to advice in bf66db37f1 (add: use
    +    advise function to display hints, 2020-01-07).
    +
    +    Following the same line of reasoning as in the previous commit, it is
    +    sensible to use advise_if_enabled() here.
    +
    +    Therefore, use advise_if_enabled() in builtin/add.c to show the
    +    ADVICE_ADD_EMPTY_PATHSPEC advice, and don't bother checking there the
    +    visibility of the advice or displaying the instruction on how to disable
    +    it.
    +
    +    Also add a test for these messages, in order to detect a possible
    +    change in them.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
3:  3017dd2188 ! 3:  254ece0ee4 add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
    @@ Metadata
      ## Commit message ##
         add: use advise_if_enabled for ADVICE_ADD_EMBEDDED_REPO
     
    -    Use the newer advise_if_enabled() machinery to show the advice.
    +    By following a similar reasoning as in previous commits, there are no
    +    reason why we should not use the advise_if_enabled() API to display the
    +    ADVICE_ADD_EMBEDDED_REPO advice.
     
    -    We don't have a test for this.  Add one.
    +    This advice was introduced in 532139940c (add: warn when adding an
    +    embedded repository, 2017-06-14).  Some tests were included in the
    +    commit, but none is testing this advice.  Which, note, we only want to
    +    display once per run.
     
    +    So, use the advise_if_enabled() machinery to show the
    +    ADVICE_ADD_EMBEDDED_REPO advice and include a test to notice any
    +    possible breakage.
    +
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
      ## builtin/add.c ##
    @@ t/t3700-add.sh: test_expect_success '"git add ." in empty repo' '
      	)
      '
      
    -+test_expect_success '"git add" a nested repository' '
    -+	rm -fr empty &&
    -+	git init empty &&
    ++test_expect_success '"git add" a embedded repository' '
    ++	rm -fr outer && git init outer &&
     +	(
    -+		cd empty &&
    -+		git init empty &&
    -+		(
    -+			cd empty &&
    -+			git commit --allow-empty -m "foo"
    -+		) &&
    -+		git add empty 2>actual &&
    ++		cd outer &&
    ++		for i in 1 2
    ++		do
    ++			name=inner$i &&
    ++			git init $name &&
    ++			git -C $name commit --allow-empty -m $name ||
    ++				return 1
    ++		done &&
    ++		git add . 2>actual &&
     +		cat >expect <<-EOF &&
    -+		warning: adding embedded git repository: empty
    ++		warning: adding embedded git repository: inner1
     +		hint: You${SQ}ve added another git repository inside your current repository.
     +		hint: Clones of the outer repository will not contain the contents of
     +		hint: the embedded repository and will not know how to obtain it.
     +		hint: If you meant to add a submodule, use:
     +		hint:
    -+		hint: 	git submodule add <url> empty
    ++		hint: 	git submodule add <url> inner1
     +		hint:
     +		hint: If you added this path by mistake, you can remove it from the
     +		hint: index with:
     +		hint:
    -+		hint: 	git rm --cached empty
    ++		hint: 	git rm --cached inner1
     +		hint:
     +		hint: See "git help submodule" for more information.
     +		hint: Disable this message with "git config advice.addEmbeddedRepo false"
    ++		warning: adding embedded git repository: inner2
     +		EOF
     +		test_cmp expect actual
     +	)

base-commit: 2d8cf94b28de9da683ddd40961a3a572f2741cf3
-- 
2.44.0.417.g254ece0ee4
