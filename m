Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3CFBE8
	for <git@vger.kernel.org>; Sat,  6 Jul 2024 07:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720251513; cv=none; b=nvGWbT9Kj0swDWknUq356wRAbdY4sRyq8eqmP2Z+09TGA+Yq2w8P4AyOfQ8OBpdjQ1pvY6rY8qeyYxKTtcUZT3z23GB54RIQSuNoNnWYVmBUH3dHaH/BS2jtirtkyssiYzRRZXQUPQ7qvXwiTgkUTqarPa5N7kFATO44/c1UvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720251513; c=relaxed/simple;
	bh=uwPeE04Xq5uGqraoRrixJTW3Qfjm1Uo1Y5KDg1WjPtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DDn/mAt0+sI1Hn23W0VFJSqihxaIaE05b3XLOeaMAkmNGfyTVb8zBgEJZzUpbtngJkdg2r7004qpifDk5k4ne0XYtdQSFU6yhZ2oGeBUCQQf3OFZxWi2d3S/BQDVhnwu5rDYfbKlU3O1SkNyUF3P1c7TriiAiRQgT6jiE9HbC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2LY4k6H; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2LY4k6H"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso1174376b3a.3
        for <git@vger.kernel.org>; Sat, 06 Jul 2024 00:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720251510; x=1720856310; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7GeuMyv0hzkjAJRGftvhTIxp5+MDzWhDUAeSHuOWq4=;
        b=L2LY4k6Ho+T8GKjyyBgM/vZ3WSCVmCs88AgpftWBwykFfW1oDQ6NcVZWUKgo5kJAFH
         3fNVZYZrD6mHKY8MXhy1MJxQNOsvwj/NVNUYprnyLv1lBNFSUpUM2kBSfdEjSoBWZ0Dy
         Q1X0fOl+RWjDWxqfO+8fbA5EPqEDu6STHC+JrFe7MGKIcoEixTizhZbiomntHixhdQLN
         gX8VX9DBAY2anoHFTNgnGStXNAKX7QLAn+vfNsZlo5iIbysLpFgfV1oX53mtDKYaFlP0
         NhN2HCqV4mh7nqsrM5/2I/smbELvPCjc5vty8Xpj2bCPpOXlCVGGBYOXOiGhJqHP+ofc
         Mmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720251510; x=1720856310;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s7GeuMyv0hzkjAJRGftvhTIxp5+MDzWhDUAeSHuOWq4=;
        b=aemSKbzscP98XM79LNqX7ZfRE0Fqe4ACfZKWOd53DoFTOyRm2n0Z5KfLQcXvEzZ7Tj
         TqNjINHKnUbHjVomv6LM8F4ZIJWqT2UFD+2iStchvW7cFCFCXqQLPbVteYGadcfU+Ba3
         0QiGV9iT7u6+bYuf2PhbjpaaKifu/aA7ednXqnvUWj8rF18lPFPoQxwDMFui9iJEFKTW
         U/jrk+nGXfD2p5To9u5hlI0kZJQi7ojlHg3t6ZsFCwdhYBbcEAq8ZPNt82TDeIsdH4EI
         1DdX0pWT1yW6ijmshhmQW7rJbLam8VsKZj9lO/GJQIOiQxu/aP99YgQrc3CvNjwhl7d+
         QuSA==
X-Gm-Message-State: AOJu0Yw4mvd5rD8JKLCBU6xsyYBQpiOa0ShItZ9OKEoOoZwlqyLBIEoZ
	Ap6/iRkrBAuYo0kawe/G/9PHvQXT+yFx/qN5TES+MlFO0rUoXozE
X-Google-Smtp-Source: AGHT+IEX76SuALJtfsDAscWTKTvcwdaAAIEAiHg5EF34pzBPdfUh4peJcMt+rlorlPd3qDPu+6u/zQ==
X-Received: by 2002:a05:6a00:2312:b0:705:9fc7:9133 with SMTP id d2e1a72fcca58-70b00ab4f12mr7387811b3a.23.1720251510156;
        Sat, 06 Jul 2024 00:38:30 -0700 (PDT)
Received: from localhost (236.219.125.34.bc.googleusercontent.com. [34.125.219.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708048934fcsm15233675b3a.187.2024.07.06.00.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 00:38:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git diff-tree do not honor diff.orderfile config
In-Reply-To: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
	(Tiago de Bem Natel de Moura's message of "Fri, 5 Jul 2024 11:28:23
	+0100")
References: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
Date: Sat, 06 Jul 2024 00:38:28 -0700
Message-ID: <xmqqsewn2cnf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue)
> The config `diff.orderfile` is not being honored in the `git diff-tree` command
> as stated by the documentation.
>
> What did you expect to happen? (Expected behavior)
> The output ordered by the pattern file.
>
> What happened instead? (Actual behavior)
> Output has normal order.

The diff-files, diff-index, and diff-tree ignore most (if not all)
of the end-user configuration variables in order to give a stable
output, which writers of scripts would expect to see out of these
plumbing commands.

Those who use these plumbing commands should still be able to use
the equivalent command line option to afffect their behaviour.  In
this case, something like

	orderfile=$(git config diff.orderfile)
	git diff-tree ${orderfile:+"-O$orderfile"} ...

would be what script writers would do when the output is not for
machine consumption inside the script, but is to be shown to the
end-user directly and they want to pretend as if they used the 'git
diff' Porcelain command, which pays attention to the configuration
variable".

But when the command is the final output phase (as opposed to a step
in the multi-step logic your script implements, e.g. diff-files
produces a list of changed files to be read by other commands and
processed by your other commands in the downstream on the same
pipeline) and that is why it is a good idea to pay attention to the
configuration, using "git diff" not "diff-tree" may be more natural
thing to do.

Thanks.
