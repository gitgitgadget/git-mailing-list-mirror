Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAD1F76BE
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733252989; cv=none; b=fdZflDLxBLkOLhsAJ+q7VQ9TiRnXTRLZBAm3evvrUX/ZZ1PYGUk7ugjGvB0ZEDRVczZ846jCxTgWV3oUx3Lc06ct8A2qeUBj6PCB3uIRsNjFrDPhn+IRdYJFQGqgxL2DSNdA461V8WJXtm0if3rHXlnnCb1hXUk2bWQ8kulqiZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733252989; c=relaxed/simple;
	bh=YWcwsbQk1HtOcfI/iPJ7zOQQhvqYeReS+bk57bDHwpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5ld557gBQE/DzkubjWGzeYNqY0FqOI6sG4gTj/Kevsc/5HFhuGJd9OyecWWSII1eT3rYRlZ65mrLpO+4YMs2PaceH+ce/+OSHM/zDWV7wS9pKzk4xySOSJsz22WhAWT3znL11Hhceknes6Ic1clXxmacAssgWMOlV/Fp59qbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF0Dl2ih; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF0Dl2ih"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6efa5bf5202so22079287b3.3
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 11:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733252987; x=1733857787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHQAvKmYIWCwl0xYCkQ2sl+q6JSfOmYPtUBU+1hjdyg=;
        b=SF0Dl2ih9FY+eTxHIEJV8sbOFRF7+CGXXjRLEfoSoMQw/e+nh3O393wfU4Lbdx0i3n
         YvHCCjgKv5ULekSleJ/rCLEJWiGJ+YiFDM3FR/4iNmB0T4+XzjohcFBXrGdGe8wLVb3I
         JB2YnlFA9h8eLDQ7GHVYvZ4MddNSgqp89YQCJIO50oQ1+TDvyuVFikiylWEcZZbbyWDr
         BCOntDCtkkoL2ZPm3xamAW0qzptLoTd3QL3gy6DlPk2SEaCJWi7h04Gm5smpRLsAlg41
         0jiYTJVl7W7kKtpi/KZXmUFMpEcl9YDGiVoarkIrPE3r/T/6TNCDDMIw5c4EEKrlzCUw
         BQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733252987; x=1733857787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHQAvKmYIWCwl0xYCkQ2sl+q6JSfOmYPtUBU+1hjdyg=;
        b=HJA/SS42wj7b7gD6rBP8UDyjglVHUJ8zOKxa8ErowaNX4SN2J+IWY+x4yfvY7vQsr7
         w60z4LNdsSl3ZnM0RBTeWcZhpugFcS0yiu64DNugMNr5EmYLmuYwiN+DCna5Bi2dv675
         aOkHzMw9FZrvqZq2uvrLDTGf7I7i0VaQxiFlWOdU9gx8Qc++pPt4pTqy1bLU5JsKCLKA
         uCXyXNtmFwd8ijvWoJ8VBkWY3LLzFfGqMaI/Jw9/V56aTEl2r9bIEX+OR+Dpj9AhYeS/
         Cdnmz2bRffMCvDxOkrBtK5d5qYvsNTx/0lUVHLNIBKNsKrb9m26H0xuUA/AbZJkGxtBu
         FIpQ==
X-Gm-Message-State: AOJu0YzykQKMg7ScThV37V7Xm0Y8Ruk4eU65yV/yupNKtW1qkOf3c/zH
	lrQ/MmwPBIai37L01e0a8viucfv5HbS8pHQ0dlmaEqIn591Q74zE97wlps5cbDfb7UAZkepPcQZ
	d1EQQK7K8MhHB0DHsjwodEwih6+Y=
X-Gm-Gg: ASbGncvfHqjIePTFLXoE5O1rJTnOMpdMDjOff34wEhpQlmfldApw+0s6znLbmwGfpJE
	onCnreJ1jenVWrzkru3DTf36O3Yr3FInB
X-Google-Smtp-Source: AGHT+IGUR7UzYf2zu+Z5lmErH+gCzzXrUvZiou/jJA/g766+kQ4m9bkYUtnucYPXGhsOxYNLMGUELz0Yme1SP5BDRNU=
X-Received: by 2002:a05:6902:f89:b0:e30:e39b:9d72 with SMTP id
 3f1490d57ef6-e39d3a2a894mr4239439276.16.1733252986883; Tue, 03 Dec 2024
 11:09:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com> <20241125053616.25170-3-eric.peijian@gmail.com>
 <Z0RIqUAoEob8lGfM@pks.im>
In-Reply-To: <Z0RIqUAoEob8lGfM@pks.im>
From: Peijian Ju <eric.peijian@gmail.com>
Date: Tue, 3 Dec 2024 14:09:36 -0500
Message-ID: <CAN2LT1DLpFdLPAJ+ver5dgxmxpdp1nDYfK+OVTkF2twVLVkeyw@mail.gmail.com>
Subject: Re: [PATCH v7 2/6] fetch-pack: refactor packet writing
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Patrick.

Your comments make perfect sense to me, and I will revise them
accordingly to v8.


On Mon, Nov 25, 2024 at 4:51=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Nov 25, 2024 at 12:36:12AM -0500, Eric Ju wrote:
> > diff --git a/connect.h b/connect.h
> > index 1645126c17..8b56a68b62 100644
> > --- a/connect.h
> > +++ b/connect.h
> > @@ -1,6 +1,7 @@
> >  #ifndef CONNECT_H
> >  #define CONNECT_H
> >
> > +#include "string-list.h"
> >  #include "protocol.h"
> >
> >  #define CONNECT_VERBOSE       (1u << 0)
>
> Instead of including this header, you can add a forward declaration of
> `struct string_list`. This is mostly done to keep compilation times at
> bay by not including too many headers.
>
> > @@ -30,4 +31,11 @@ void check_stateless_delimiter(int stateless_rpc,
> >                              struct packet_reader *reader,
> >                              const char *error);
> >
> > +/**
> > + * write_command_and_capabilities writes a command along with the requ=
ested
>
> Nit: we don't typically use Go-style comments where the comment starts
> with the name of what's being documented.
>
> Patrick
