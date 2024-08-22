Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E0F42A83
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 21:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724361889; cv=none; b=SKFfYP+ZkQKRr7eR48hSv0FVzpMAc9lqwCd6ELdgRkeSjTyRaS3PNj1Ec1jSJLqdsw5HIm54zcLFHQBoj35HyNAT1GRkz+1Eqs5e6IDCywxN0lCbC5TUDWE5M+SPtrvcelFkb3zuaduV09CuoeMh6qxOksduwDOfaxmpUdl1rpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724361889; c=relaxed/simple;
	bh=BIBTbRONGF64sKusbrshIVsi3pmiFzfgKVkYfDB7GNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8pEWcF1HDkLeqooNRmIjsXJiryFqWH2lNwuFVXNZxRl7rsMGSbK93Egr1wyhohD+Q5K5zjnbaVvu/s5KwdHc4ShVAuLUpgALLI+zNGdZvup3fods+C67J5rPfHlY9lyptswxk47319J2JTrsc8PhZlPxY2OazWKxSmRQQi3fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TT/4A/+p; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT/4A/+p"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6aab656687cso10971617b3.1
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 14:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724361885; x=1724966685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVkQG6xgTniLt2umgW9eW6tsgwtGc1qdh/IiZ9nWgL4=;
        b=TT/4A/+psRQvvCoEZZwmCPIQ9jHbJlPIPNIEaXis2b3vP8XUqrIt0O4aS0Ptgq+Xr+
         o2hMAptDifQH7X5A4Oz8+K3kt0ai2SwzeeAxnXJk5GjuMDt+CgCJHEA1pTwLHoEOzXxs
         3iUn3y9+mn9MfQtSxqZvPnDRKW/3uOUSKspQ8JfYPeU8Bmuqk52lsvAbY6sV1GDM5Eu7
         RjLZFn9D0GcZqmTye7Tc5NO9MflMxKw49uHHTyLxOKC9Y1DzA2DnTIINJsgQp8Ka7nFj
         3JisaxqV6HauXzYBl4EX43npSspHkk8cXoZygblYG8wz1U2uQ91iBml4693DB2L2wcDn
         hh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724361885; x=1724966685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVkQG6xgTniLt2umgW9eW6tsgwtGc1qdh/IiZ9nWgL4=;
        b=ImOjLI2nN70w/2P7R444d1cBXAREE/dqmbE8bo1Lm0nqgYy7C+41dTW1SR4TU3zkTT
         I3jAjXhMEyo1HoCx92r2aLCkBulPjq/WbP9qVEZvlvwfzx2h8a6AQMjefDDT7LkpHzeb
         hC8B1bBNRMVzzoPxDqyDCP8DNzBtGpcA89Ue5k8d0mPMxtn7vPTLBMNP2Jglx//LbWFL
         fDi8H8FafnrOIGFcmH4CY6iSKn0jxw1V0dqnI28cxFVayihmsZNpKdgZsd41lTKTt4Ap
         q9FziJKoNEUs8dNtxE7DlyXM12lkepmhu26kG3qyxiy2jHCYI/RTS3kysq4i/6d4h2xF
         Hviw==
X-Gm-Message-State: AOJu0YyIrEWC1IcEIeeXrhkgy1zjaxCAfXLSVhyIECMPGKGl/+W3mxto
	LtcG4MLLf+2gqsF1qvdcOx/CcAxhr1CV3nZP+CLLG857CYqzaC1yXEIb/eZuvjGH62e8BPRaqEh
	8UVBsg1TC4HWnGDAZzDeXZvteotukoziks4r1cg==
X-Google-Smtp-Source: AGHT+IFBVFLKBgTWMtwMf/hgYbKBK9UPer4lSAC6ggNcKTzVqBksPAZT/nisH19sPpJMXOT0X3wuSTytstxlxBEySAU=
X-Received: by 2002:a05:690c:688f:b0:652:e900:550a with SMTP id
 00721157ae682-6c602a1a4eamr4627897b3.19.1724361885401; Thu, 22 Aug 2024
 14:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
In-Reply-To: <20240628190503.67389-1-eric.peijian@gmail.com>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Thu, 22 Aug 2024 17:24:34 -0400
Message-ID: <CAN2LT1A7W+qp5H0R4Q1TfFJqSM5jKAz3NPEA9jxU0A00kgO3Ow@mail.gmail.com>
Subject: Re: [PATCH 0/6] cat-file: add remote-object-info to batch-command
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, John Cai <johncai86@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, Toon claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Reviewers,

Thank you for your thorough review of v1. I have addressed all the
issues identified in that version and have now prepared v2.

Could you please take another look and provide your acknowledgment?

Thank you very much for your time and effort.

Best regards,
Peijian

On Fri, Jun 28, 2024 at 3:05=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wr=
ote:
>
> This is a continuation of Calvin Wan's (calvinwan@google.com)
> patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-i=
nfo command at [1].
>
> Sometimes it is useful to get information about an object without having =
to download
> it completely. The server logic for retrieving size has already been impl=
emented and merged in
> "a2ba162cda (object-info: support for retrieving object info, 2021-04-20)=
"[2].
> This patch series implement the client option for it.
>
> This patch series add the `remote-object-info` command to `cat-file --bat=
ch-command`. This command
> allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not have
> object-info capability, the entire object is fetched and the
> relevant object info is returned.
>
> A few questions open for discussions please:
>
> 1. In the current implementation, if a user puts `remote-object-info` in =
protocol v1,
>    `cat-file --batch-command` will die. Which way do we prefer? "error an=
d exit (i.e. die)"
>    or "warn and wait for new command".
>
> 2. Right now, only the size is supported. If the batch command format
>    contains objectsize:disk or deltabase, it will die. The question
>    is about objecttype. In the current implementation, it will die too.
>    But dying on objecttype breaks the default format. We have changed the
>    default format to %(objectname) %(objectsize) when remote-object-info =
is used.
>    Any suggestions on this approach?
>
>
> [1] https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google=
.com/#t
> [2] https://git.kernel.org/pub/scm/git/git.git/commit/?id=3Da2ba162cda2ac=
c171c3e36acbbc854792b093cb7
>
>
> Calvin Wan (5):
>   fetch-pack: refactor packet writing
>   fetch-pack: move fetch initialization
>   serve: advertise object-info feature
>   transport: add client support for object-info
>   cat-file: add remote-object-info to batch-command
>
> Eric Ju (1):
>   cat-file: add declaration of variable i inside its for loop
>
>  Documentation/git-cat-file.txt         |  22 +-
>  builtin/cat-file.c                     | 240 ++++++++++----
>  fetch-pack.c                           |  48 ++-
>  fetch-pack.h                           |  10 +
>  object-file.c                          |  11 +
>  object-store-ll.h                      |   3 +
>  serve.c                                |   4 +-
>  t/t1017-cat-file-remote-object-info.sh | 412 +++++++++++++++++++++++++
>  transport-helper.c                     |   8 +-
>  transport.c                            | 102 +++++-
>  transport.h                            |  11 +
>  11 files changed, 785 insertions(+), 86 deletions(-)
>  create mode 100755 t/t1017-cat-file-remote-object-info.sh
>
> --
> 2.45.2
>
