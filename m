Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FC358D28
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073389; cv=none; b=ot2pwyDwC8K7quyYFaB7JQF6q8j7ySv8j0KH0lKeW9Jh+dY9KI6WLZ0qZppwfcAQiiD2g9UkBCQuUPtOLjKLqTqUY1e1jJ0IuMAZ1N7VLUfamI+BpUaFLC0gx4BJaP3KcqQyo0oelNrf/Tzqjzt0Vo/RxkWlHdY4Ebj1lC+8D8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073389; c=relaxed/simple;
	bh=33xaeMo33Ep556z3MCI4a5CwexnNJdMX6sbuFiC5xWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFj8bbHal/ZpsTSp/s89XGVuNGXVFIvJ32y6FefE/ZfB+oGBATeCupe5+25UDbG/f0UixtrpXnGCxYK9OHIu7Y6+qsVn86yBpwHRW0PhwvYoa5SUDvYodl3XB3hSmBz7FZyJ8jcVX7pq4zaGaM5jeb/ISGnkuQO4lpp5+bv4D1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L78vQVok; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L78vQVok"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd490be5fso6502874e87.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 15:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770073385; x=1770678185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnJ4B2BU6r8wTkD3gFMBOHKOFK5lG3rjVpf24QT+QJw=;
        b=L78vQVokXynNwWAprsiKC6c3wm5Y6Ejhlk23fJdhzg/8mNLvFYy4bDUkuRUqIsNjpW
         s8mf8Q+4BdxC1DuVyMI/2kNPThh/g0cvSr8/N5Z0iElrjeREsd3AMgYZKK7hGyufXtKT
         S8UKLgnRDLs7rsIvBt48EAyLem7BBKfzM3j3lg2P3skgTdNhj1ZjNfg7mleEZggfG9hz
         6TdJw/V75Ir62cOk2J+05noIdEsvcfAEE/J/qW0HlC9+RCrN8rdvnFzXnHNiYPyPsg8l
         gk88k9MyrFTDpNiAFFXeCYlcNybU8X+MZ7nUA/LyuYFJSHFbxxHmClHp2OgUgVIVIg4m
         +pLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073385; x=1770678185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nnJ4B2BU6r8wTkD3gFMBOHKOFK5lG3rjVpf24QT+QJw=;
        b=ibFg4LFJivInyt/BNGe2guGF/sdN+WBYHU+c2K6owKYDtxc84P7HpQIcWxltCVFo5/
         Pb7OyjGP6umTBDcGHLGz5OsqhCvyPXodX5YNjDQ3AWsZSIwbATnzp7gs/eh2a4Lax3s6
         uTljBm0f4tL2Amogq0EQ8f16hzyQlKjQ6PRgz/9yBYzk/dxEs1luBWDEWqFxbZ80BZBZ
         zPrkv9YokCp1FaT8+k23wHeI4g8qE79+drYzdqTDWqOM6ngijpYanMT8wi2/FePyUhrB
         xP+R4NijTsALg0vkJdhljq6LcWihcXLZLSZlws3gw67UuNrkAoVPlZ2CA/4t2vlOXHdB
         qlmw==
X-Gm-Message-State: AOJu0YyojHOuK8cAdttuJaaHtqo2WXR0QQg430mOCx9rX+PBBy1dnudC
	9cdWOXO+THfqJdo5j/cT3i2qGRqW+0c01coAkWuVku170Tn3Xyf1vjd9
X-Gm-Gg: AZuq6aKzYYiMxROcm5dYelV0wzk42TWyFKfAyr21+p04GnZ5hDj3eCHpsWEo81hmbPj
	2TpWP2BawKvvA6+MrRXfFoNBtbmxAHtsxQf8ucPYXDgBkx04eDNIzL6hAMrBbPvRV8AkM3QMwvj
	q0XUuQvtn38yxVBRUVyXwAgiey57cuNs0RuaubFfI4kZ/vJBWT3VBWIk9YpNb1BAnZUKJj5OY76
	qCS5yoJuEDlLxWUgiuH12WImVdtFg+zF0kjBlVsPmPxoLb6LbChv18vf0ZMjRbA0jPgmvyW+r8s
	H+eGecKj3qlsC9fea0ncak1x7Jnzb63SIAv16otScTxETQ4/FjjCDmi3QDT7s2X6VgXiSh8/TTH
	fcQ/wlGTGxyLjagXt2W5j3oNTztHD7pNLD8R7f7ytyN5HvkczPQkGIJq3WTdKJrUPYAn/pPH54p
	BNgAGBjhA4eZ4rC0IGyWzvclIUlnc24eIZL9QUASOzetBCNr5SPyUiKpK2TcmzMSHEf7Y59+M=
X-Received: by 2002:a05:6512:1582:b0:59d:e7ac:619f with SMTP id 2adb3069b0e04-59e16400ae8mr4227649e87.18.1770073384349;
        Mon, 02 Feb 2026 15:03:04 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074bbf76sm3814134e87.87.2026.02.02.15.03.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 15:03:03 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Tue,  3 Feb 2026 00:03:02 +0100
Message-ID: <20260202230302.13009-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
References: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> That just makes discovering the name of the remote the "interesting" part…

Yeah, this is true! Discovering which is the upstream remote is still
non-trivial. It's aggravated because the GitHub 'gh' tool will rename
'origin' to 'upstream' when forking + creating PR from the CLI.

Which I why I do this becomes necessary

    git remote | rg '^(origin|upstream)$' | tail -n1


Harald
