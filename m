Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810B1DFE32
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212924; cv=none; b=krlaW393BfMNC2/zzxnBty5iVBFqDYEd6lp6GfgOZbKPsPHvDUqX1y6jOYfm/6P9hde3v/6uTgjfIconaI3sw6FnCyuoo8vR0wTdE6mJWDlbEmpGGk1jP0ZpjvyR3TiNPx08xaMTJIKMPkbcf/cAcwPm8WBXkjKgJAVEF9jN2Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212924; c=relaxed/simple;
	bh=MbFqK8TvU0psUktBRhIJRJuvPiorbzw8cO9YUwcXdWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXFzYm705132zUU/ahy16/59dO8zXpivJ8bk6OyCfrNyiNjzQGYPW7t4ASND143Qn5uzRt8FfHdDbVKk5lWODCDbUJBocVcB5AqQSLj3zhjIYi/YrHrGMwn22t59fdq9y0uvxj/gwttxOR3e2O0fb4J2eS128F7FSrOe9vOFSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnQPq0kj; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnQPq0kj"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-84386a6669bso210676939f.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 00:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733212922; x=1733817722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7s6ed8eIsZsvRDrPUbcpEJCVdwUO1yQ8ECmKB011sSU=;
        b=EnQPq0kjSAOCUPkX6S3VdX/1XCUtFcWVz6vsx47kk6CxGmpzbqCtBe6X6kt2NQOCvo
         HcPoHEdRv3IcNGj0+rq5oiBVAn6b895jAFrvq+oYyLGxY02CUBqfSQyQMPRnCJwzYaBt
         xURUGZqHb+NZ32hW5Q5RX6XdU/9s7EQp15Di+E4fERfx8BuRqBk2Qztu7rXiw1FhOXzR
         zREzkVdCXc/OFiF4i8LYEE6uJcyzJg+LVrWPngEmXtfZpHNBsfU9jwibkjlH7yrOTxeL
         LjGagMb+9Cw0FXqkWRrnJpNQOL/PevHAs6Hyqn/XQMdHxeLzj1npxojKs1EfAFgGj93t
         SzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212922; x=1733817722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7s6ed8eIsZsvRDrPUbcpEJCVdwUO1yQ8ECmKB011sSU=;
        b=nvcy7nxPNdg4w6WCUFOp6d8SgCf0g+HdMTzdIdqOaQIlo7auPFDHR/ll/38OVwBJVS
         oytBtSfTelzRp4AEWMJjayz+f9ql7SdCSCNCvA6g/RoKbPWfRrhRg8LYbzZbjzBABGpV
         rTlkZz1cy3t2OM0JsEQr+A8PtMM0wzoqPkRMwZCRrwD6i9fRJaCBxARiG5msyw6DEV/J
         g25O5ODPSEsOa1xxugFl071NCYMbdAEpVvLactTOJbjrRHeeLS4W1d/ztUAC8ASE2zrN
         hn8y0K3umi8DhHVGKs9Cjvq2vHcVMoUrIlIyzDYUQhjEfWrTTnVmfUAHSJl8htjFQrjl
         EScw==
X-Forwarded-Encrypted: i=1; AJvYcCWLKc+CKw2Jc6CvBZipSjBFWfzHb9Ps1g7OWFdGCqY51yGooJwhU0inWNpcPk2PL+eHo4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRVktqeSz50DsFpdmqY2GgmoglGolS50efLpU5ql0SLtj19SM
	9xLeqJpd5V0YRzmNcsQsQP0Smqox2m0Ygh3qrgwh6IBSgjKqYyJpAa7t6qFdporIOtZlQyFsZF6
	/QwvRoew3r9m+qXzNpMEgt74Qgt6Tjg==
X-Gm-Gg: ASbGncv2WVWZnMee+O0TaEbIceejJ8n7DOwkcCnoYsnBjECYdSGlxRWuaVUCJJpBPs4
	ZbjfcOyA7Ua13v+sFGfyxuW03g1iAIyqlH4TNa5UyEIRDzsYusBwJz857IHKEOy/B
X-Google-Smtp-Source: AGHT+IHZBb8jD0NvE6wdwxUslohya/2RZVeJTAjVPlTZoXbTSWCHfKf0sYYH34gIlu0aVbl5TIxANpZKBCh/zPPAROU=
X-Received: by 2002:a05:6602:14c2:b0:835:3ffe:fe31 with SMTP id
 ca18e2360f4ac-8445b5744aemr194453439f.8.1733212922592; Tue, 03 Dec 2024
 00:02:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1832.git.1732740464398.gitgitgadget@gmail.com>
 <pull.1832.v2.git.1732928970059.gitgitgadget@gmail.com> <20241201214014.GC145938@coredump.intra.peff.net>
In-Reply-To: <20241201214014.GC145938@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 3 Dec 2024 00:01:51 -0800
Message-ID: <CABPp-BGP8zrSzxcacTzLY-EuYAQW5EwyDGNAMh196udGN18fmg@mail.gmail.com>
Subject: Re: [PATCH v2] fast-import: disallow more path components
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 1, 2024 at 1:40=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 30, 2024 at 01:09:29AM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> >     Changes since v1:
> >
> >      * Moved the check to a higher level, as suggested by Peff.
>
> Thanks, the code change looks good. Is it worth tweaking one of the
> tests to do "R innocent-path .git/evil"? Otherwise I don't think there's
> any coverage of the file_change_cr() call at all.
>
> -Peff

I would say yes, but since this patch too has made it to next and is
marked for master, I'm kinda tempted to just leave it as-is...
