Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144FC2D1
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 01:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751851850; cv=none; b=IOFOl571o6XgZ8ceGmhn7g2Jj0un27MWFCDIj5Y6lOXq9l+FO6ASP/rel1m1UHkIK25PcLRHsX0KI+foQrnvfsBZhAWswCI52SDdJAmgweTM7YgAzvHDKJtBNaqKoROthVhkN/PVjOq0mcCg6ac38sL+5G3wPQvHWzoZRqzXz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751851850; c=relaxed/simple;
	bh=HTfQf2lhEjNd0Bwc+CIilgNZ+VLi1F02xPNrL+SvSEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V/g0WLl/kxVxAAv0ScfCScqGRwO0iqpxYI6Ku+vLTdpsb75KuGl8mtWpjZC7Pus7c8Qhu13b8sI9HCbqfV4GdjbP+bAGIUoCpKCXLokgEdyjNNYBDr4wMT5Zr3c1+RRO98ogmnCxDqw///VMyZpRl/QQkUe3DsxtNTYYWu0vORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPwracHi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPwracHi"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso1555994a91.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 18:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751851848; x=1752456648; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYWtfbI0s5se/Rk3rypUx/+XCbdTbnOUni/j+YbgA0I=;
        b=GPwracHiZSx1WVQBfPBy7jkacuDkFgMmp8UvMva4tbTTCP7uwxbzO/up7T2xhmwtgh
         w0KrFDgk5uzRchQTC7e2uZqvThWacl4wjU0KU2cRmoGvAA9CWP3jeiInvN//aFuSz3Sh
         ABceZZ0qYamdET1bYuLuuvDrtDPGxg7CsRVJyayQwJESWmm0xSg3jAESeJEO+JEiAjIf
         A3xRQpxxV5m0VipxlNivUZUY819IjLZCTCtqs0GSn8CQ7265wjnE0eBHHYIto2OCKNYr
         lhQuOM453xdOm0+amupdI5MfEoWRTMDx2IAUuJM/XwvjRK4rP+K8W+Jc934fImypC55g
         xT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751851848; x=1752456648;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYWtfbI0s5se/Rk3rypUx/+XCbdTbnOUni/j+YbgA0I=;
        b=q29xphyWfkdqJrgjEpn589ykJ3OdgjliBBzcOWsMigz4M2bqdsx0XftXqD8qnU5Exf
         d2mjqkLcInr8n/sv297WFnDjXbj7G+mlVJxb0uzvut+rY9BBubhvVHwSpO0IIqiFvRLp
         kaTbjLkVo1PFvl9f/hTyltHmbIFpttVokapHO/GC8q8W80fMMU5MumelFZ3k5t759SRh
         WNJ19nbRdB2CUhajfhOzIEuVwxzj0On/zDRLUpgVp8ySJEjwip15n2olBu/kZ/NxI6OO
         NvfurxiAxt3aNtETLu7Zs1ZCpb736it8nT3X6N8zU8fbMNQkKw0WkJiFivXZEDEqRDXf
         sP6g==
X-Forwarded-Encrypted: i=1; AJvYcCV3CSXdPhy9kqVhJwdy+Eg5A6WbuHQPFhM0yfS7I14Kpl1/5FfrU0z0VgmBAMtmNrKzedM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdVIiEw/R8yFumGj2bmPfijowMwwSRdcy0PW5/zVveANiC0gxq
	ozBKmRss8lq3v4hnSQyuL4p4mokaYmTotq+F8Z+83bMik+3XyxlmZZPv
X-Gm-Gg: ASbGncu3+MFQmr7zy3EhfJpf3WUbIstWROhk9Cdb8/XNKnXNSv5GGe1GZ6b1jsYwQTI
	XpJmph8bH55T5CK73fAw5dxiLAHQsoYVbIaAxP3OFEOp13y1RRZzsoJPmepIIOlpT4IhnDBzEYC
	JZiroLrcRDYvxjszFPFHhrrzAqo5UAFeuFXGJXUDExP9UtvZ6xbe12mKlRnf8QD2gbLx3FiLBzj
	eGzZJk0w1eCBPNCT3rUciZwDSWxItjVfWv5yw7r5/bjIqMjBm0Ys06i6iwtzDWyLMvODMm4p6VZ
	8ArbTbrbUYiy9MLvLNt7w1hayDSZB3KhUupmPDv3SWtFvzeuY1iFoLJrRxx4HROl0fbOPAwmYOS
	oXN6yicwq4Vn9PAioEjTzRp99mpk=
X-Google-Smtp-Source: AGHT+IF3u25UUvmohmWU1cv4BLGumbPT/iT3G7gQSkQTRP2qsPKPHqXNErwxQED2k+0cfNcUpmErEQ==
X-Received: by 2002:a17:90b:2ec7:b0:313:5d2f:54fc with SMTP id 98e67ed59e1d1-31aba84750fmr10820621a91.10.1751851846894;
        Sun, 06 Jul 2025 18:30:46 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31aaaf6f8b4sm7897830a91.46.2025.07.06.18.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 18:30:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Drew DeVault" <drew@ddevault.org>
Cc: "Aditya Garg" <gargaditya08@live.com>,  <git@vger.kernel.org>,  "Martin
 von Zweigbergk" <martinvonz@google.com>,  "Patrick Steinhardt"
 <ps@pks.im>,  "Andy Koppe" <andy.koppe@gmail.com>,  "Remo Senekowitsch"
 <remo@buenzli.dev>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
In-Reply-To: <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> (Drew DeVault's message
	of "Sun, 06 Jul 2025 12:41:50 +0200")
References: <20250703113505.11889-1-drew@ddevault.org>
	<PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org>
Date: Sun, 06 Jul 2025 18:30:45 -0700
Message-ID: <xmqqfrf8ait6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Drew DeVault" <drew@ddevault.org> writes:

> Trailers and headers are different. The main point of the change-id
> discussion earlier on this list was to avoid adding trailers.

It sounds like this "avoiding trailers" is the root cause of the
problem.  If change-id is something not precious as you earlier
said, having various operations lose it by design or by accident
may not hurt a lot, but then doesn't it make it harder to notice
by hiding it in a non-standard commit header field?  There is no
easy way to tell "git log --format" to show such a custom header,
you'd need to tell amend, rebase, cherry-pick, etc. to carry the
custom header forward (or not---have all the change-id loving
communities agreed on when to propagate and when not to?).

Keeping it as one of the trailer fields will always make it
available [*], propagate existing one by default with any existing
tool, and because it is in the same place as log message, the user
can easily remove it if it is not appropriate to keep it.

    Side note: [*] Unless you are doing "log --oneline", that is,
    but I'd say at that point you are hiding it deliberately.

> I also suspect that if we added this as an "inbody header" that older
> git implementations would ingest the X-Change-ID header into the commit
> message, which is not a desirable behavior.

Of course not.  If the thing is a trailer, you do not even have to
worry about such sillyness caused by adding it as a new in-body
header.

> IMO the right way forward is to use a mail header.

No.  In the change-id case, trailer is the right way to go.

Having said all that, you may sense that I am not all that impressed
by the previous rounds of dicsussions arguing for recording
change-id as an extra non-standard commit header.  We should think
twice or more before making anything that structurally does not
cause Git to behave differently taking advantage of the information
recorded there an extra commit header field.

But after thinking thrice, we may find a set of good pieces of
information that should be added as new commit header that are
structurally more meaningful, and there will be times when we need
to convey them over e-mailed workflow to allow patch recipient not
to lose such information.

In such a case, I fully agree that embedding in an e-mail header
would be the way to go.

I would suggest a lot more generic implementation to solve it once
and for all.  How about doing it more like this:

   "git format-patch --extra-headers" grabs all extra headers
   (i.e. those that are not the bog-standard "tree", "parent",
   "author", "committer") and emit these

    X-git-extra-commit-header: encoding=iso8859-1
    X-git-extra-commit-header: frotz=nitfol

   next to "Subject:", etc.

