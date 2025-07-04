Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78B2EA46F
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751647150; cv=none; b=YOBTWXdOF+o3SBoEberNVNglANE6aEjSVauBP/6tBNLLawriQdKImR4R/e7tOuhnVSsDeQ9fLP//m8ssQul2I1MlOt8TNZ3fbf3GY0FD8yYmbMKkPu+Uo6Q9GXBVA8ty774Tgo5na5OC7p9iAxXcvYqaFwFDJdyieZ47O56iNvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751647150; c=relaxed/simple;
	bh=P+lIP6NkpuGTpVPKQR+FM78vwqYJ8G1c2BbC383hKc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dsJpG3MahhG0SfO12IEKUEI52ZvWvJ45m40RbfQdR6rxfOJzrEYPFkUB0Bo6fmCmI+u9G6OltNJLRcWAVi3mRoFBOVrKHVMpmH0m4lomaoQF4wNL95Iw2HuBi+y5zIJP8L1hEkhD8vMS6B6rmVr8lEnjUXI8x/iPHLnXv6kQ8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKa6Gb3v; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKa6Gb3v"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31befde0a0so711045a12.0
        for <git@vger.kernel.org>; Fri, 04 Jul 2025 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751647148; x=1752251948; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6WdXk2OEO+xdsURluIrrFbHNp8y7DznccociXsiPKQ=;
        b=bKa6Gb3vkzEffl17p4Fifhl5k+Jv5TQWZOlA3qXSiHDo2wxXnKzjW0xLBw86qucePg
         ENgS40QpqTE1ZtoYmC7zcSImorLN/O0EoBAPQgMqSj55mXuw277P8ZMnodeZynElbg/n
         Tawc7STNhilxbX7LCbk69aQvTK6y1XeeyKtZmObzOlYa46qRngaCd7Q77jwN8XjsTBkK
         jfmPLsVpYz/hF1CjToTf74mtH3wHpgLz6WqcZ90TY3q3DfxpLzjbrvQsaWt3s/xhN5tM
         rXGsFygUpWSNPFT4snQq0BebgzqhR4wWcWa6rk2EMijS+kdcYdAatD/cLJZ4NzKWX/P5
         +bJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751647148; x=1752251948;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b6WdXk2OEO+xdsURluIrrFbHNp8y7DznccociXsiPKQ=;
        b=IMiSnCBsZCEri+BlLox+8RPD8KlNjqqJvfJLv40E+K+mrtbab4T/ou1CQaYhlG5H2C
         /6Ew4pyHO+lBXaHVD6GcRUSjFjce9IDNZDuB3cyjrPqVxqsL8c5NLYGpjkPCNasOoSE6
         hM2Eja/s2sBOVjWUh68vX2bUbNRjbvUBWOOYXb5UcmFopv3+mLN/4zvnLkmGKFmQUnH5
         SMXvGxdS9ReZlF7loJjWYuJ2/+fsH580pabo+15G+fOKL0wOJMljKbxD0HOGMkKiQ8Ve
         A0h5Ls3IxKo488obXfy41mlmBAqfH5dWnuZgxT/AQloE5U31EIuzjhvSkEs2H5M2jWKT
         +C/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXorH0i67H2xwhqPrdK91d+puD77me01wkXgs0vpn9pwiWDbDFy2Z2pnKUpCWJjwyHjdYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdg2iqQ2e/Kk9IKvvaPzfY1Nk0rNqT74rogJ89qpuFqt6vA+iv
	BkIKTfY2tQ14s4lHBSZ11VYlC/AoJowg360lZhDK55Y90Wtirji+i4eZ
X-Gm-Gg: ASbGncuQtTeNYdLI/oHqnLMtrx0U1Dy17LgwrrOPDde1uI1MMdMr5PtSQn2P9ulwxlw
	0dzX0kLVEKev33anr1aCPJxB9QXYpCn0pCkY5m5n43ZUCpGpvfscMUEfnoZL4KUiTtFFPI5WUm2
	Sl61rkpAXNxIPB6m7VfAgAuj7FUfFK/9cz19pTpQSYR0QuIjRi8PE/uJUwK8JwZ39fO9bmRf98p
	iOXzEPsPF6sqs0yltKD/YVeElJdUsyCBcZGvploRZeZHMRGAwDtLM7wD3l/GLgZRdAZ1IwcOZE1
	NB4eqlsmC87cxIG79CGnmJGV+Ongt9g66o5wcvhQ9xK3klqUhuB2EPKUZfm81T9rFn3c3+s5StH
	12HL7P+fYgw7vPoJqvOlk4jjwY2c=
X-Google-Smtp-Source: AGHT+IFYCCXqSfXXKXyR7g1AlziLn6ocOmN2owCy70bVuglmdmuNRWZhX4e6kxSbMDmsrWPVG32WIA==
X-Received: by 2002:a05:6a20:549d:b0:1ee:a914:1d67 with SMTP id adf61e73a8af0-22608fbba8amr4824085637.2.1751647147804;
        Fri, 04 Jul 2025 09:39:07 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b38ee450db7sm2423167a12.4.2025.07.04.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 09:39:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/4] for-each-ref: introduce seeking functionality
 via '--skip-until'
In-Reply-To: <CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 4 Jul 2025 09:02:17 -0500")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250704-306-git-for-each-ref-pagination-v2-0-bcde14acdd81@gmail.com>
	<87ms9kcbtq.fsf@igel.home>
	<CAOLa=ZS0uP+5xso_SEG2GJZHeac-0F2_wMJKtvbFj_wROKbBkw@mail.gmail.com>
Date: Fri, 04 Jul 2025 09:39:06 -0700
Message-ID: <xmqqa55jc3md.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> I think I was a bit against '--start-from' and '--start-at', because
> they imply that the reference provided must exist.

It also implies that if the reference does exist, that would be the
first one that is shown.  But I do not think you want that, as ...

> Consider the example
>
>   $ git for-each-ref
>   refs/heads/bar
>   refs/heads/foo
>   refs/heads/main


... after a paging application starts from the beginning and showed
a single page of some items, it knows the "last" one it showed.
That last entry may have been refs/heads/bar.  The application may
not have seen the next entry (i.e. refs/heads/foo).  So if it has to
use '--start-at=refs/heads/bar', the first entry it gets from such a
request may be for refs/heads/bar again.  The application needs to
remember the "last" one it showed and skip that, which is a bit
awkward, isn't it?

>   $ git for-each-ref --seek=refs/heads/cat
>   refs/heads/foo
>   refs/heads/main
>
> You can see that the reference doesn't have to exist. So implying that
> it should can be a bit confusing.

For that reason, whatever verb you pick from seek or start or skip,
it would be great if the option name also made it explicit that the
named one, if exists, is not shown.  Conceptually, it is "skip
everything that sorts before the named item, including the named
item itself" that such a paging application would want, wouldn't it?

Thanks.

