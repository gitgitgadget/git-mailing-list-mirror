Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA51853
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128216; cv=none; b=d8A4fJOIaKIbTVG8ym1Q4sTwMr3YV5wR+C7eQvbnnTEl4ULyR8n9XvuS7+cvWJMzlnbAB+Qx0wiKy4CzPzbVcpod3N1BNdl2dtFcKyUAUUU/nojDVaS8tDKXb7YgT0jxXaDDB0xkSQjUtwpgMbgE5zUMkhcRz/wGMpi1cbLVNWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128216; c=relaxed/simple;
	bh=jeMx0zi4G+Qhhxte9lKVHc17yxiJzhcq+bPoC9V+2Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpaKabZ8kjxSmD5v+u7H9zgA3qyqbS4Og24KHWARVbwsi95WkbnfmKhMjYNKv0rE5HVJK8SwdpndISHMeBUPLmz0HoKKZGxOOtadJU7wFdlJk7PpwXQbt1S722XJpfR5caF9+hDGhRnUm/Hx5zB3m1HaVpb936CbRq8LImc+kUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpIWhOjz; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpIWhOjz"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-70e75bf727fso10486967b3.0
        for <git@vger.kernel.org>; Thu, 05 Jun 2025 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749128214; x=1749733014; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C/30t13nkCraH4vhi4eTeJbZ15kbxrghou36/Fi8ngw=;
        b=EpIWhOjzKV9RQjD6j+VP/++zd85pqsXinnG1e7nwcH2Axb02QQ3dT4uYF9uFTXV7CY
         1YV+lVSj3+busBV2dtrzkrMHWbqOJjPs8i6fPmt0/eyRQzaLR84a9ucT6MxKcI5G7vlt
         guio72No5J0LUEVCg4muouuJLeQ9cISDeaNWW059sdtmjiVTmYMeysSSjx0ir7MWMIwB
         mfqsrTCEtSaYNENIiw97Nioyw5OTDd56hl2RZHlSg9saa+cqjTGnXtxOSsEDkbhlaDGk
         ppIRqlh1yBqM/cOgNCrCyLpPipCsIEii803SMCCcM1oLWIAUzEbGMQ8k2ystuFbJnQpd
         sPQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128214; x=1749733014;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/30t13nkCraH4vhi4eTeJbZ15kbxrghou36/Fi8ngw=;
        b=Tsrtfjz3W8NTfCkKSep4uzz0XbXOEkSZAECjiMEz012zSNJ70Uh1KMdNsCiLZA8UKd
         qx3PW9iSv+B0fv3+9TarxWUFQS2KcD84Fa0zQQNlqLkdDRbjWtOFnDJhPZcEZGqBjyML
         zCieAzz0vsvTG/d7zRfDnJbSo9QxWGwmgmO5+6X3DmaeVJbhq+sARZy4njvRE/5pBWRX
         HfufqnqlI1KR4zvJ7/yBhNJwk9JWzCEwsDgsSxVP19vqMwX/DmV0/swVlTpOc0qwr1n7
         SZ05nHxBxXYmsa+kr+UDGVrYL/HZmY3PdsnNKZwH4UuwnCUZaas4K7FgSNECAJt109G5
         pOuA==
X-Gm-Message-State: AOJu0YybsQA6YiFSnAPQJrANFHI+4hNW7HVflxspx2HMANShMSjfuRR/
	R2nbykcNF5LJAJZnubAKQCF/oSQVJoF9tsvjMqKsjZUnqKxRWOEPiAmInrOEnCjzGIOr2hO7Lbn
	3764XnFN8V/9WjUCWcLwrVxP6xdaETaM=
X-Gm-Gg: ASbGncvNX9gE4spxioem69FcO9LP9yaxFgbPm5llEe++3iORp9hOlJCsqk76kw20UhN
	8OPk83wrjsID3yzrB2HANSS2nWdBXEqtzNh8VqVqVcZgkKfYwkrhDawTyLkyvZDbFrgwMyQxodh
	b2fUhmm/TpdDan7D88H/f8GJfQz1LfHzlzNsnytTUE275X
X-Google-Smtp-Source: AGHT+IFR+JabMa6dBbsrlms19Max4lGCBYcEVf7v7gH3lpC0SwhcXi/6fj6ZpErUEt4THGKpKv/uup9qB8L4Nu6wbD8=
X-Received: by 2002:a05:690c:4b81:b0:70d:ffaf:48e1 with SMTP id
 00721157ae682-710da192d88mr87134187b3.9.1749128214100; Thu, 05 Jun 2025
 05:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602122559.208780-1-kuforiji98@gmail.com> <20250602122559.208780-11-kuforiji98@gmail.com>
 <aD793WJpsHm3d3Q8@pks.im>
In-Reply-To: <aD793WJpsHm3d3Q8@pks.im>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Thu, 5 Jun 2025 13:56:43 +0100
X-Gm-Features: AX0GCFsp2B4vl0fh8TsIbVW6EAEXiYCRAeMrOWrzeHV_nB-FCR2DDaQMvrkyXPo
Message-ID: <CAGedMtdaDR1E9YWXQOQKKtKj7rgjmRy6cLMC+A+7B39r=u5Amg@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] t/unit-tests: finalize migration of
 reftable-related tests
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 14:51, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Mon, Jun 02, 2025 at 01:25:58PM +0100, Seyi Kuforiji wrote:
> > diff --git a/Makefile b/Makefile
> > index 8ed8f234f4..8d8f2d574d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1380,13 +1380,11 @@ CLAR_TEST_SUITES += u-urlmatch-normalization
> >  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
> >  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
> >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> > -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> >  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-oid.o
> > -CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable-clar.o
> > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/lib-reftable.o
> > +CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
> >
> > -UNIT_TEST_PROGS = $(patsubst %,$(UNIT_TEST_BIN)/%$X,$(UNIT_TEST_PROGRAMS))
> >  UNIT_TEST_OBJS += $(UNIT_TEST_DIR)/test-lib.o
>
> Can't "test-lib.c" also be deleted now?
>
> Patrick

I don't think we can just yet, as `t/helper/test-example-tap` imports
the `test-lib.h.h` header file. Fixing that would be beyond the scope
of this patch series, don't you think?
