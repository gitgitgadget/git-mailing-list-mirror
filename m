Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261F36AFE
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719548479; cv=none; b=e6YUb1z9+K2P20GG3tW5cuf8m3slzOuSjdy+sn6pZ7z7PqA8Z5YXyOWxV6RDHmwwUxF79JbVal0df6aYgnMXeurBu7sUKoHStpp3LAt6Qc2tne8aJg8SYfN1PZC6pW0LsbkoWC1qP4fhZjAOEiSzz8NVEkREVYTy3NxKkis+sjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719548479; c=relaxed/simple;
	bh=yN2v5yTdxEMfsrl4kwZzGzlrrudNhwMDVootTJqQ87I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=k20A/14kGu+MWTY6eiGaoCA6Rh+4QJEdRDrjFnLKjK7WFdSbML/4+SCLH0tUsdjpfljWu9gpCsa+8ug7C3lsW68BC7+aEsUuaRk5ehiWfoZsWD6oP+tKnXSZnzrVXd5VT0D0JvKlEahdhfpxo5d9EJi41wtWh14XmnQJ0dZeiFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfQxKA5B; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfQxKA5B"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so161053a12.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 21:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719548476; x=1720153276; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yN2v5yTdxEMfsrl4kwZzGzlrrudNhwMDVootTJqQ87I=;
        b=GfQxKA5BpcHYozXoTCapdmjHTUav6DqnuhizKdL2PUnQqwjykGvDPDSAHYgByuyYCY
         l5xQCjCiijWLgC2/aNpq+ukYG+KXIte5CZZTE6LyaxWMFbeazdS2hismA8agmuaMBrnc
         T/qIcvnRZDBaZUDPfDAqJ/JD35vYd8ePW6r+irVmHJFA0x5Yj/tLFi6FBJMtlJ7qLINh
         aZgL+z4MiKPe/gvknPuiCcjEa+VjbhfzKxK1GwcV04hJP4WNr7GWVgNldzSiM0Tj/ncz
         IBvWLZOuDgPJbIZdTtGy6nez1ugKabCeRd0ehSPgcvWttzB37VcoyKTruvH+8nAt1QmI
         Lvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719548476; x=1720153276;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yN2v5yTdxEMfsrl4kwZzGzlrrudNhwMDVootTJqQ87I=;
        b=skOKudSXRLYPkk3B6Vzp2m2/O8xjY6B+RQpbGZG8r8USjAKEWcL/7Av1tZf7ashhGE
         /7upy7PmzrZ8mPTFc50PTUoUmglDDTxMKLmUdYtOTqm6fqJ8NdGErqp/Fc5YtDX8ORCW
         L1o9GZDZ5jRm61pP+S7rzjXmtHv35CdLaVXBSQw7f8AQgs6XdqKvnOLKgffv+dar6Rnd
         7hquRvAXNUXJPZz/l5xsiDnPmlEfU+YstZc/vnOzfdk/489ZJaeAai/smDNKMgLxx6K5
         3oRA1pRW3zkYN70DCnmemTN4uP3y25+fOOeb89TRMea91+qYQFOY45jBZiqVks01Hf7S
         2N4g==
X-Gm-Message-State: AOJu0YyYtedvvrAp+hzGhl5zoZf9I9EjYE82nGSJjjFgexZtIHAO2z5Q
	KdIWVwRFqdqOCRt9bg/2nGWLGwmo/FUhYXeGdk78iJ7DffSmM/96dhi7OL7yqw3UvD9yDQRDxhR
	A9gSXYuOzKasBcfFfWoZd8rR7fHWj532ViNs=
X-Google-Smtp-Source: AGHT+IHETbbxSnNhDJPQXfXNlAlnndIAbrVhuX2aqEkAvhsLpE/qxR/tmV6M1XQN04pq0jQmLEergATJJbbkCOfp/oE=
X-Received: by 2002:a17:906:6d16:b0:a6f:5a48:7b90 with SMTP id
 a640c23a62f3a-a7242cb7253mr919243366b.38.1719548475877; Thu, 27 Jun 2024
 21:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ajith Sakharia <ajithk.sakharia@gmail.com>
Date: Fri, 28 Jun 2024 09:51:04 +0530
Message-ID: <CA+8M_AZTtqSU7ugZ-w8yyOKeP+opambD08DSOGko8akL_CXQqQ@mail.gmail.com>
Subject: Usage of `-u` flag in `git status` cli
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
I have recently been working on some performance initiatives on git
status cli and its usages. As a result I found something confusing and
wanted a confirmation on the expected behaviour.
Based on documentation the status cli has a `-u/--untracked-files flag
with 3 potential values `no` `normal` and `all`. The `true`is expected
to be treated as `normal`. But from my experiments it looks like there
is a difference in `git status --untracked-files` vs `git status
--untracked-files=true` (notice the existence of `true` being
explicitly mentioned), where the `git status --untracked-files` gets
treated as `git status --untracked-files=all` as suppose to `normal`.
Additionally, `--untracked-files=all` doesn't seem to use the benefits
of `fsmonitor` and `untracked cache`. From some additional
investigations the impact seems to also scale to git plugins across
tooling like vscode, warp etc that use the `-u` flag as part of their
syncing logic.
Could you please help me understand if this is expected ?
Regards,
Ajith K S
