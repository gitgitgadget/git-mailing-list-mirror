Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D511CAA78
	for <git@vger.kernel.org>; Sat, 26 Sep 2026 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439601; cv=none; b=ZveouOEuAt/ip3+emQSi3iXM17dPgwHN3rWcN4Z+WAVGcS7knkWvKXPlkcpRHAlENBlbL2fH75xVRltMWZpae6mlHkM7zdbw8rRMawnvY3PcAQMZUMbS3CX3joNkYERm26QX50UIN9q/crYkRbi09e+Rw4BVFOANZoFKwlN3i4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439601; c=relaxed/simple;
	bh=01+5m16B066m4KWWahStt0PqWmT1cC5bYAOkpWVBFM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uktE1hK95QPQ9rBy7OacgDwyV5JUNvwuKidyRhkFNMW8n/yTT3ufRsXpqTWEP3sp4cwx7PBPGXU2GUGS9uWirnHMLDSRj1taf8B+z75cz1WbJT71jhlzUcNz4thcrDkpRXgyzLIUuIXg75Wq1vqh7y/x083spzlfcyMO5EI5CX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrwZwstc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrwZwstc"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93a40a9a01aso276327785a.0
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 09:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439593; x=1791044393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DjKOw/OmzBL5JDsx9ZtAKcL6PZGap+atVzhchzAWNPU=;
        b=lrwZwstc2AtcaeCRMEe72EVjevWlmC/MVoCepROXTB+Hu2E6A2fYHdAu1r4FPa8Yqc
         gF/ojjg5wOFnXT2gswj5ZN/9aPjHuk6i6/hIlnqoU911DOQS5rBJHmj9oAzyXlvEzV+N
         ueUry073jq33RI28ebaK7eEvVWjO54SBPpIEsi8/5AOtoozwgHsliynOwzUO1+BACZfT
         rfQp5sUA7Fpog/ctbqVvGmotLR3XCTUDGBJQNYQIIPzfXNd+4Xw0suuz9ANHUnv+youI
         u/ieh3Ezme3obCYR1wLga8xcr6Je1JL0jHqTU4Rk4fSXxwNjDzANKAOuWTjxHlfxHIiD
         5KHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439593; x=1791044393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DjKOw/OmzBL5JDsx9ZtAKcL6PZGap+atVzhchzAWNPU=;
        b=mcAt59H5FPYSZ3B5j4gzxGiZIWenbetYChFn0uET2SJjysynTgkE0CriaJouUbkNmO
         ahKgyy+kuhg2BMMXXp2oKhaCatUyYnm5ydiwKTIpmSLS+QA0JwG+wQmPk7lhCtCr/HAx
         IL1j+26EANsPws3W+G779HjW9XmbCge44tP390ylRcTfNnfX0ofgIUN4s2x0Xy3q7hIe
         SQ8AU68OTKah5K2q+5Ic8D8/j3fTtxSG4LEa0uPZvmY3uRiT4jbiEpHbR5FwYlNxF5G1
         mh4jBbicTgXEJdBUJZWs7ItG8fn9YDbGxU6urEGmNn2aJqMY6Abg3xm/pBWkN9N5u0xI
         kvBw==
X-Forwarded-Encrypted: i=1; AKwUvBwDrfizXziNzOfMi0qIYB7Bf0WPqpwQHLNsmPLQxXhGEW0givh4hDJ3vGZjZzU/UsjF3Os=@vger.kernel.org
X-Gm-Message-State: AFuF++kJP2HY+CamLTipcbEfylOaWP1bN9zbbMHwm5gkcf/3IJg7eg5F
	FJtXDNawUZqbinElrVfNyi2SiALXTWg6V4kNUW9VnzXaQ+MqMSb13TT2
X-Gm-Gg: AYBFou21Dr00K1kZ2N/Seo+ipKgKmoNPA1vZAA1yGNLVvZWSwVND85TCJmtNN59meoM
	Ck7X8WDKCr6IKLn7tuzKz6wfoqC0iKzeG5S/x0fMPUkLsFuNZGL+66nWlG+f6p7IQDYDOxFtcnH
	GpLuniDyvEYXAPZHrQzEpSZk4RWSNyWCX7c/hhbSpMlBVk1KcaI0ZGkSM6w8t+MLMIHa/6bDSYq
	3j1QUBb7rYCT7say2EceLFhptX/9NqyAxdYl006bUHDo3zzhaSpX84xB9e6yBc+B98gMMA+IFn4
	L90hlXleitC2uLi+URlKJb2vKlgTHrkSQyNNx7DfEo5A6AHpR2Gy39KzQhZsv6YEfZlM5aByuuW
	Eqx++jiv9/+eAF/4s/I4oshQ2NvmncGjxzKzboXpqW14rcwSmovH9uvieejO23ujFpLj+5He8rf
	9qF+OO1VH2PO+oxEhBlLtio8Bqk1PJm1r4rCkgi7uDhG/3pfCgDGsSCxLWkKWSI/cPHfQVWl3xn
	58mrXpEA0sAsppw4bfNczVdDlV5xIm21yZkcQk2gv1/Qy0N0powx6J8wbCN6v3YWEsZNvsysEDh
	XFi45MhCbZFlVXZFbGphZMsD7YYuJUj1EkgAmJqVKb40obVSfXaX
X-Received: by 2002:a05:620a:2547:b0:93c:290e:9e9c with SMTP id af79cd13be357-93c43d17a10mr1037160285a.16.1790439593221;
        Sat, 26 Sep 2026 09:19:53 -0700 (PDT)
Received: from localhost.localdomain ([2603:7002:a00:5733:58df:3319:3c13:321f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c6a38594esm18053685a.35.2026.09.26.09.19.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:19:52 -0700 (PDT)
From: Andrew Pleeter <andrewpleeter@gmail.com>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	Ben Knoble <ben.knoble@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v8] var: support broken-down idents, signing key, multiple args, and -z
Date: Sat, 26 Sep 2026 12:19:51 -0400
Message-ID: <20260926161951.30531-1-andrewpleeter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <ddfd5232-b832-476c-8614-268f8e4bbe28@gmail.com>
References: <xmqq33va1lcg.fsf@gitster.g> <20260915220228.42819-1-andrewpleeter@gmail.com> <ddfd5232-b832-476c-8614-268f8e4bbe28@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip,

Sorry for the silence. I was replying on the GitGitGadget PR and did not
realise those comments never reach the list. That is also why v6 switched
to get_signing_key() without a word from me about your question.

You were right to keep asking about GIT_SIGNING_KEY. I am dropping it
from the series. get_signing_key() returns a string whose meaning depends
on gpg.format, and the variable gives the caller no way to tell which
kind it got:

  gpg.format=openpgp, user.signingkey unset
    $ git var GIT_SIGNING_KEY
    C O Mitter <committer@example.com>

  gpg.format=openpgp, user.signingkey=DEADBEEF
    $ git var GIT_SIGNING_KEY
    DEADBEEF

  gpg.format=ssh, user.signingkey=/path/to/key.pub
    $ git var GIT_SIGNING_KEY
    /path/to/key.pub

So no, the key alone does not tell a caller whether to use gpg or ssh;
they would have to read gpg.format as well. And in the default case the
value is a committer ident rather than a key, because that is what
get_signing_key() hands to gpg to look up. Better to drop it than ship a
GIT_SIGNING_KEY that sometimes isn't one. I will revisit it when I can
name a caller it serves.

On the exit code, your GIT_CONFIG_NOSYSTEM example convinced me. In v9,
asking for several variables omits the ones with no value and exits 0.
Non-zero is reserved for real errors such as an unknown variable name, so
callers can detect those from the exit code alone. A single variable
still exits 1 when it has no value.

The string_list conversion is split out as you suggested:

  1/4  var: represent multi-valued variables with a string_list
  2/4  var: add "-z" output mode
  3/4  var: accept more than one variable
  4/4  var: add broken-out identity variables

parse_options() sits in 2/4, since "-z" is what requires it.
GIT_CONFIG_GLOBAL is now documented as multi-valued, and the tests use
nul_to_q instead of test_cmp over files containing NUL.

One place I did not follow you: instead of a trailing delimiter for a
multi-valued variable when argc > 1, each value gets its own entry:

  $ git var GIT_AUTHOR_IDENT GIT_CONFIG_GLOBAL
  GIT_AUTHOR_IDENT=A U Thor <author@example.com> 1112912053 -0700
  GIT_CONFIG_GLOBAL=/home/me/.config/git/config
  GIT_CONFIG_GLOBAL=/home/me/.gitconfig

Same shape as "git var -l", so one parser handles both. Happy to switch
if you prefer the trailing delimiter. I should have raised it last time
instead of just changing it.

Thanks,
Andrew
