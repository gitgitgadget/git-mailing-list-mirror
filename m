Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D0143C4D
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663876; cv=none; b=AxIhJUFX3lWYVa/XixJSJn+FS1lsyfB2pxA1j9w1MI/8au8YwjCAK3L1tmoZzE7LpbRNSFaWUebprbDHG5V1nwzG2IL0PIpnPCu3PrdUyENRhvtnspCB9c52I6l5B7ejZs1FnKXezvII+tNX8S0vIM4S2TZmF6pWDNoxxtFoDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663876; c=relaxed/simple;
	bh=nGhpnF08Q/9nojf97g6MnqhyaPBfJyzHAV05xPDHp2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFluIy4d3Y1Sg9PHqrB0ybwHK5aWFowxgr/bumo35dPoKdexT/I2/iBzDjOAXsgfdm7Hgqy+Ku8o8W71fZduv2sLnmW2Tmf+nWFARNjcVXJkI0b3DaK32/K8BraO0bYdSIcruob8q7cc7Cz9BWjqNJWAWQnmsynJIRGbefYpRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqXi4Vks; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqXi4Vks"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52b94ad88cbso1029293e87.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717663873; x=1718268673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nGhpnF08Q/9nojf97g6MnqhyaPBfJyzHAV05xPDHp2s=;
        b=TqXi4VksQd3fwySMM9uwXA4+5EGHfm5swNi67O9mX0C3OjBIm+nWPdS+VOpmvj0wS0
         bcl/PrQ0A4n/WrUYGLHF2k82tptCBmVNocwWNTfTPRNcx/2HZx3qxmDWUnNcZ7Y4Q8NW
         CcHMZbDf/Apwi/DF6rbcLjotYF3mpS+jCfkA2zwcfw7ElkerfsjnXM7g14WO87GeSP/5
         pgDqLPaz5Jbwc5FEwE+n1+dfkyTn8lMUmc/88N3auA5ORP+yYE3oYqBHeR08c08KMw2r
         GyZl8W1IqfDdgafZVb1AZFaTMW4DO/WCPDZ2C6zIWeeoOzv7YgFO4tGpEgzg7MB0vwor
         wKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717663873; x=1718268673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGhpnF08Q/9nojf97g6MnqhyaPBfJyzHAV05xPDHp2s=;
        b=vO4dZTovgUfK3Kn5KkWWt3ts2akCiFmrSjF0qq8Z1oMfn5t8z5zcoSD5u2lohfaEe8
         dsF+njAfq1yKoH3UPCphohttPxYQ0QjQNEe11MRFP6Ip+iIKm1tyD+zYrsNGiT9bl+hS
         KzKzeBslbB2eFuBXfumnP6mk2gnu7gZ3qcRn2h6N1XzDlPbJ9LVXd88PHpRpe8EJ1Sv2
         fxDj0Gi0c3NbtYfbaexiBIDFV0GCs16BGvQswX0X2YI+o9oCB9cLDgt+dDxjC4f5gPG/
         i5H0glSwq6hEIb8RJV9lPOPKOTuWoYYsyy9M4uKTsTnWWyvXtyl+K4/ly9HdJGZfgp/9
         S35A==
X-Gm-Message-State: AOJu0Yxry38aQiVGrdLX8k0p77jh31o4HntO4VJRMy0XelN0CR5uQsO+
	+xEKquPQUsVEVsrrTN1z4kbtkDMi0Bj4PcEeuiOO+Tnn84nNCIPuXnRl2Q+o62IT16uzT/E9Lf+
	9i/552KeUjdwJM9ybJMfwQgTHIJbVxwYQ
X-Google-Smtp-Source: AGHT+IG+aBfZ5wQ16yKRMZN/t7dP8c4npvBzkYOILqO+geCTqyYoxP0gkZjAoHV/H5QUg2RllqGlJzVMUziN4PGYgzI=
X-Received: by 2002:a05:6512:3e1e:b0:521:cc8a:46dd with SMTP id
 2adb3069b0e04-52bab4ca688mr4066900e87.11.1717663872673; Thu, 06 Jun 2024
 01:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606075601.6989-1-chandrapratap3519@gmail.com> <20240606075601.6989-2-chandrapratap3519@gmail.com>
In-Reply-To: <20240606075601.6989-2-chandrapratap3519@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 6 Jun 2024 10:51:00 +0200
Message-ID: <CAP8UFD3SZ6z35QOqDpVowtBKiH53GR_0Ok3Jq=6dvaxaDv444A@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/6] reftable: clean up reftable/pq.c
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 9:57=E2=80=AFAM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> According to Documentation/CodingGuidelines, control-flow statements
> with a single line as their body must omit curly braces. Make
> reftable/pq.c conform to this guideline. Besides that, remove
> unnecessary newlines and variable assignment.

A commit subject like "reftable/pq: remove unnecessary curly braces"
might be a bit more specific.
