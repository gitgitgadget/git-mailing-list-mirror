Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C221A727D
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751107049; cv=none; b=uoiFdw3O626CLmk4jxPcHTz62aa8bILcYXS+F90ImlRlx4zqMxx8fJOj12kYK461EKlczzf6eohi1YmtEIB6iCPbKmU1SldRRL+VbPNPIALDkkfIDpjF5uvmzrrBqcQRgnlVbesjDRz+uhCFT1hk6b/PZw73G3SsXOATWkwdTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751107049; c=relaxed/simple;
	bh=cCycJUPaiT7/njLItx8ywg5xVKpayc0HsVCZ8yhTeHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGH3kUJBY5sI4dPSL2gqdBOrukR/o17XOpB4jPFgdYDv5uD+dTuJXwj/ud6eNbDqVw5xxiIsD1B654m6TAyGL9BBudUzrieUItFY04LfXGd6jZ8CRBs8RFmSfKay5IrggzZZ7pBkUa4JtTZgbqcaAQL/gms9Xao6jMBm2VZIiKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPyuf33v; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPyuf33v"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311e46d38ddso2430796a91.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751107047; x=1751711847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8WaWMlsa1sDAdqs+R5s75pQ80azN8ooC0N3aYAXRH0=;
        b=ZPyuf33v9D15TIUiZoAMgfn2U04eLftuZ2IBAPmBKrF7NdqPiBEfAcHcdpzBI96Jg5
         wPZ1dkNH09jiTPR+AHY8WprcBrgX56E6dsLMSEppqY8XZR502S3K9qP7cKRM3GGmeDNU
         lMW06nkVrqb13RIKA86sgT8pa5ReKH++0u8RuNsSZlnJnkTWLfUAoBe36XFcHRtz2Ovh
         tzD9bv8GgkwRa88T0bRP+JTiAMD4Z5UjOI+n9b+ZwRNnq0lqSx7QLWfIbtPGtJwlziop
         dj1ipQBD14sEobSV4a2et2Rn8gaPrIIp23X0t7vojHnvfCtO6wWZB6e4BYaX5YlALWub
         tDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751107047; x=1751711847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8WaWMlsa1sDAdqs+R5s75pQ80azN8ooC0N3aYAXRH0=;
        b=hgJkaUqaaZPQigWnhJRmZ1gr6sDse9Sok3HdrQ7rQM3s/HQJLycf2LsGtqhXu+IPjD
         he+O04LgszJjELHITGgGQidRuJshISVqQg0Db5RRBMMzdWnKRoQWyyf/fKVV+ggj5BxW
         C4x5OSBFyD+EhvJUFPCh7HJYcmPIeQJYwqK3UkU23SSQ82TfKZfQedHt+apY3JHQqULf
         hnMYp2XEDcli5N4rwhOoMLPHZ2Sh9GK2qOeEsC+cGYwZajNehqN7iTqPCEt05I8kKng0
         /QYCXA421X5RVMAa3hOOgOMd8mLYKJS3iL3XJkuojppL0+wvHzE2q/1uFFWHqWWGSIUa
         +zFg==
X-Forwarded-Encrypted: i=1; AJvYcCVz3M3sTGi+SS3yN6M3cfc/8Bx5NJGYtxErPbuXLcPGLrVkjzTG1FYhuHJ5xtwUkGjRSOg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8n8Q00+eBfm8eRHqDg+8VOQ35slHPYP1t1Z27S/mEq1geFe0F
	3jtLdW4wH6/tCwoh0yCm5QU90/+PlwZx8/Y9EwwBIF/pffYRY/+5Vo+7BN9DCsZjyVBxoGm08iZ
	ibqRINLF3/D46a9MgV7ps4AZQJKJAdyqBazTVAWsDiQ==
X-Gm-Gg: ASbGncszXHtWRHl20iOnYxCGyc9oi8Go2jt8ZdCvXmJ4ThPl54EQ4TDkIjyGrcQEwN1
	FAK0NxpGAxG2wnSWaNwfauu931jzoQjb4uqOovBmbEbXqcfpRWq1O+qakfJgMe0XQqqIIHGKfUM
	OU+TN/UrNjL2lwAeCI3MdVL07sHEiKQDe1l9Q1wrEhkKPd/cI8BWEvaFsrTk6LiIiqkJu4m8RH9
	T59H0HsHhohBah/
X-Google-Smtp-Source: AGHT+IGSrJpdWFsXt71SVssSqxrtUdd70ElaBWwrKxQpx8PEEHs4BQh/Em8Z62zi8bDwUt96PDwv/Y+sm4AK+QQg5L4=
X-Received: by 2002:a17:90b:2247:b0:311:c93b:3ca2 with SMTP id
 98e67ed59e1d1-318c8eb9988mr9134709a91.6.1751107047299; Sat, 28 Jun 2025
 03:37:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
 <20250626221631.457725-1-ayu.chandekar@gmail.com> <91982162-b138-4bb1-81fd-6f9185801c99@gmail.com>
 <xmqqms9t8cfd.fsf@gitster.g>
In-Reply-To: <xmqqms9t8cfd.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Sat, 28 Jun 2025 16:07:15 +0530
X-Gm-Features: Ac12FXxbeP7dlLwiRCxs__H4sLuxN-zs1cJuKOomO1cRWJdvd3kFr4pXkbWuKwM
Message-ID: <CAE7as+ZBOJ_4LvHQua9bOw7+Y8cMpdo-sf8hThSkFC4rWCEt9g@mail.gmail.com>
Subject: Re: [GSOC PATCH v2] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, christian.couder@gmail.com, 
	git@vger.kernel.org, shyamthakkar001@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 8:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> +    size_t cutoff;
> >> +
> >> +    /* Ignore comment chars in trailing comments (e.g., Conflicts:) *=
/
> >> +    cutoff =3D sb->len - ignored_log_message_bytes(sb->buf, sb->len);
> >
> > This finds the "Conflicts:" line. I was surprised to see that the
> > string it looks for is hard coded and not translated, however the
> > sequencer (also surprisingly) does not translate that message either
> > so it should work.
>
> There is a funny chicken-and-egg problem, though.  It limits the
> search for "Conflicts" by using wt_status_locate_end() based on the
> current value of comment_line_str.  When core.commentstring is set
> to "auto", the code that reads the configuration does not touch the
> comment_line_str variable, which is initialized to '#'.  So
>
>         [core]
>             commentstring =3D '%'
>             commentstring =3D auto
>
> would have '%' in comment_line_str upon entering this codepath, let
> wt_status_locate_end() use '%' as the comment string to find the end
> of the log message, and then looks for "Conflicts:" in the result.
>
> Which may or may not be what you want.
>

This is also being used to append signoff, just before the
`adjust_comment_line_char()` function.
Another thing that could be done is to return the function
(adjust_comment_line_char()) when we find a "Conflicts:" line. Because
I don't think there's sense in adjusting the comment character when
the "Conflicts:" line already has a comment character. But, I would
like to have some views on this.

Thanks.
