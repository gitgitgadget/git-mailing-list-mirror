Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382C8CA6F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 23:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735947294; cv=none; b=EwftpBJGku6oKRy9S9aAlApxUs8LdOZ5tyA4fmWQ4vQYJWssNxM2iQQ/8DS9YJ+fqqsXxXAT4+SUisQk2RVCuQpInovoBK99zOoZZw2qMtF9h5s1y8p89j93h6DMwrj75fXapptRJXrnOa/+8e95PggS1tnVHZoAj6qcURKgI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735947294; c=relaxed/simple;
	bh=JF2X+uhYunyiOAheEwYg2NyJlvmyxS4vXwqN4vJBng8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MubWbMjlLjOfoGnCetg1OyRGcrFjiyyB+HVDHqGrsunYheE2XysZadiWv/Nru1zTqu8mhh5J5kc3K5lnMpdQ0J37E+kTM3FwrNJ0YiznM0/vzRGX14fOf4KVYm4i3KI0MyjKMMOMvNCMtI0licjnWku0XthSburKdm5qrJJg8uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXNLeQpU; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXNLeQpU"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8442ec2adc7so475184939f.2
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735947292; x=1736552092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgSubB+5C9ODRDjLZrmnCvF5W6nAome2QgtdKbbMxzI=;
        b=hXNLeQpUdsbbYKWCuz24AVKGZIsNRR2J3Qy36HKWImllNxNP18hTtA5/Z+IYph3GhK
         N9kO/klaCOpfEwkkhf3GUmOyypkvJMvbFB1De9/qBmvW0McKeqXty30lm2BKcw1kqjp+
         wXCSlqy+zATFGTE2r8TwpuM5dgI0xKxf58zQoVj/n3KlqQ1FkXlXPKSmm9LDWU/jhowB
         ynPsABHLm9BK99jd03ViZl9XMnWZwGsvwEnTSZYL4c2PN9NOkbkRtBIm2dPNvAxSpHom
         wA9V1l3Fz0idL9CzePUv1x3XNZ3t0iDytIBj/BsMh3sWD+1CplEKi7dNe7Tv21WMJIX6
         Lylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735947292; x=1736552092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgSubB+5C9ODRDjLZrmnCvF5W6nAome2QgtdKbbMxzI=;
        b=I4qrH55E95p4Ih+oXXwGMHUSEL68PJq08l94TZsg/vAydZRgJNLF6BhqsF89P3+zFh
         bUqLu244dM8+UzuxeiruesmUCc3s1NsgptihR8rYj+TF888ZwiZwfM8c4D5mdKALV/qh
         GLlQ5zoNNQT8y2gK6VeKlSv9dfxz3Ehn1hV3aQzflBjtp8JjDN+HEuvDBkdMLob5IjVM
         DvRn4NzDxU+mygurqXuEKXpr/Z39IHZO5OwecNKGSsEBjt0nuGDe3mkuFizNm4+oG8ug
         PdN5dmxSWZDwzRl8rk+ap/7bXpLQYYdVuvosxmRerL0yR2PL8F0Ur8i6O1w0bbzacGyG
         qTyw==
X-Forwarded-Encrypted: i=1; AJvYcCUkS+vp1EK6vI7lFi+itHB21mz+mSEmkfeAICZAi/Gyk9aokyWqYPH3BkXYPYmuddQSycQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9AjDmmlJBPO0ZV7b3dG1mUhlDZDBUE2E8URPE///9WkzlpKry
	3C1M+dm4cZtg6j5l25DViXedYqHjNBmuzsnlJMpMLDap+K2S9Ku0iFcpYoTpH5MmTiQ77xli38u
	zw29Ivd7w1cXlQsb+67FpHwF9/dY=
X-Gm-Gg: ASbGncu+yihuoE8polM4XwVn9OlYqV4KcKl/6YPXdYIYGg83mCoV2VjetZqGkXa9Wya
	Vyfq87MpQxlo0dK7YCwpo0hXxJT3qeZU/uFyqH2aHqdHlS+56oavx
X-Google-Smtp-Source: AGHT+IGNJDWVTT1KovGDY5lv/7cmqXsDzxkVKSFHwjmbR2MkQJiIz06uDyPx09+X3zmnhSyjmiPlD4Gy8OG2skEL97o=
X-Received: by 2002:a05:6602:1503:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-8499e4cf6admr4834255439f.6.1735947292138; Fri, 03 Jan 2025
 15:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1844.git.1735699989371.gitgitgadget@gmail.com> <xmqqpll6wjsk.fsf@gitster.g>
In-Reply-To: <xmqqpll6wjsk.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 3 Jan 2025 15:34:41 -0800
Message-ID: <CABPp-BG47KNt5v3vEzPCCb+qRyz9473qPTfoOcTytb_Eis96SQ@mail.gmail.com>
Subject: Re: [PATCH] object-name: fix resolution of object names containing
 curly braces
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 1, 2025 at 9:01=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Given a branch name of 'foo{bar', commands like
> >
> >     git cat-file -p foo{bar:README.md
> >
> > should succeed (assuming that branch had a README.md file, of course).
> > However, the change in cce91a2caef9 (Change 'master@noon' syntax to
> > 'master@{noon}'., 2006-05-19) presumed that curly braces would always
> > come after an '@' and be paired, causing 'foo{bar:README.md' to
> > entirely miss the ':' and assume there's no object being referenced.
> > In short, git would report:
> >
> >     fatal: Not a valid object name foo{bar:README.md
> >
> > Change the parsing to only make the assumption of paired curly braces
> > immediately after a '@' character appears.
>
> Interesting.  I wonder if this looseness was to ensure that we won't
> mistake a colon inside "master^{/title with : a colon}" as a start
> of a subpath, instead of asking for a commit with a title that
> happens to have a colon in it?

Yeah, good catch, my changes would for example break parsing
  master^{/object-name:}:t/t1006-cat-file.sh

I'll fix that and add a testcase.
