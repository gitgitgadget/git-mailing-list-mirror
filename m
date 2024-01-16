Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD7200CB
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705440191; cv=none; b=X3z2p364xBdxdz8Ln3x6857BjNMQ3N2TAQVRcUSwxVOEuFRA5sU8W1o+jNDe0edvR+sY36jGRoY5A4/2BGM7PCQhThHE4g9NfS1SQBHcI4K48i10okb6xQKN22ewqaLgSe8gPpi54ECXuyST7pIAXjAVo1r7qRjnAID/l0Zk5sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705440191; c=relaxed/simple;
	bh=rUTpVi3zSApjNPXbux2SKXJdHaI9L/JjLbC1gp1ankk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=p+OK8p/u9UnIiWUhxoraH9xMses2c/1+hWOlOPzq/s46kt84Ydmd6RNurucsgCd8wB5U9wH5YdLNxyHES6jgwDEjvA7DrEkjLtn4/qEY0fewT51Suq0pbtsnf//O6jUM2bvdwjIj829Opo8Y9BuNS2Pk8VVrrTaalG8KqTCRBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6K3uOba; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6K3uOba"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7ce6bffb9easo1750129241.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2024 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705440189; x=1706044989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGZRCrcUOCTeEnE2oLJXdhUZq4C7WXkCBhNPwnMnmmA=;
        b=e6K3uObaQlntAiKEOiDW/NFgPQc8rDAqiY5USyowycPXTSP/I/mB1c4r2FXHsG5+I1
         sNw7HBTf79fg+EyGqK24I5ZW0h7PDKKtWIAspPTJg7fYhT+rNQWw5J85RwoO6+/X+7nZ
         Uk00tuesjQpd8J1Os0sCrYuh/ngcT9VoGcfqbX1VMuyFPy682EK7fcfrhVZtUaogH+37
         cHHtbizjL6sQnBpHQhtb7hEWzLY8ykFebuyd7WXxpzg+AE8ARvZUL6iRUSsnBJLYolU6
         rzqbzucFT5rmeJByRJj0NMZf5OioxaOxk4XhceJdTfTPvH0mraXyrdcHY792HQB+YAQr
         FrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705440189; x=1706044989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGZRCrcUOCTeEnE2oLJXdhUZq4C7WXkCBhNPwnMnmmA=;
        b=E2D1rFkCUVOwqWb6nk5y/t4OIR8KgNRbQZrtRaZ8q2OPSf176mmzZz13X87xkRouoR
         J3ePZyAf3x1xodb4zFV0727GxnfvWLzs2RuToCZBKvdWq3uzy8xo7NCYK1coNHyedVk+
         HSJOOuRtgc7EOcsy3NFGLd+QTxTs1zfk8+OkrkLzw6WrMbkktMQC+cd4AuGGzeJQ18yM
         D7PtHaxKPnxiMJyPP2Jwc8fJPS0ndAm88GAbw0yBRCLGe1M0+vWpGjRd2EZbnPxru4YO
         qgjBSrJlifEv4jepyihA7oY0DBHCu/xEvF9oTXa9CM2cgamv4ZTP1e9Cy9bzIc50HYmC
         1dIg==
X-Gm-Message-State: AOJu0Ywfido26SVwj1puEDgSE8/7nDa4/XOIzgylfHBOmY0pEMhxQcZ0
	dRHW1RrmiSd9BEFZNdzCXYaZFug3lc/ISBP6fqP+1jxQ8pE3RFEOADsOiYQUHSMU
X-Google-Smtp-Source: AGHT+IFDG3IZBEaZoSHXy9fixx5XXcBMAzB4xV72R2IwI6k6sQBRKAqZQABm4d4Ft2mRNgIz9pD+2mrsPEm5UjfqX3Q=
X-Received: by 2002:a05:6122:d9e:b0:4b6:c299:4a8f with SMTP id
 bc30-20020a0561220d9e00b004b6c2994a8fmr2884654vkb.5.1705440188862; Tue, 16
 Jan 2024 13:23:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHQZ30Ad6+YM9qnCOeNNy8e2k-AbYR_bBXTups-7z6=ioyqS5Q@mail.gmail.com>
 <xmqqply68c87.fsf@gitster.g>
In-Reply-To: <xmqqply68c87.fsf@gitster.g>
From: Raul Rangel <rrangel@google.com>
Date: Tue, 16 Jan 2024 14:22:57 -0700
Message-ID: <CAHQZ30DmMYgTkKhWzK+H-TJN0dj2B-1Fhutu_=eRQd7vJCdjZQ@mail.gmail.com>
Subject: Re: Make git ls-files omit deleted files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 2:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Raul Rangel <rrangel@google.com> writes:
>
> > I'm trying to copy my current git worktree to a new directory, while
> > including all modified and untracked files, but excluding any ignored
> > files.
>
> Curiously missing from the above is "unmodified".  You only talked
> about modified, untracked, and ignored, but what do you want to do
> with them?
>
> As you are grabbing the files from the working tree, I suspect that
> you do not want to base your decision on what is in the index, which
> means that ls-files might be a wrong tool for the job.

Thanks for this insight. I ended up using `git ls-files` and
`--ignored` to print out all the files that I want to ignore, and I
converted that into a `find` exclusion list.

Here is the final command:
$ git ls-files --others --ignored --exclude-standard --directory |
(printf "%s\n" \( -path ./.git; sed -e 's/^/.\//' -e 's/\/$//' -e
's/^/-o\n-path\n/'; printf "%s\n" \) -prune -o ! -type d -print0 ) |
xargs --exit find . | xargs -0 --max-procs 0 cp --parents
--no-dereference  -t /tmp/clone

This is actually a lot faster than I would have expected.
Parallelizing the `cp` cuts the time down dramatically.

Thanks again!

p.s., Sorry for the resend. I forgot to send a plain text to the mailing li=
st.
