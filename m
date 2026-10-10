Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503832F7F07
	for <git@vger.kernel.org>; Sat, 10 Oct 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791660318; cv=none; b=prwI8QL63dc8wknrwlDkt07NTud9YocFUkkoW5a4v5RJvuWWj67+dt+VINrpzPaexMqZY03u1HaZvR9MGzEg9wYTmzN1iz7HNuSFWcQxSftj1SW9qPfvbXnn5S6bMaFkAPMRF2NeUwzdXhqu2fHKnwuiRFeqELIfsMnmZnk7P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791660318; c=relaxed/simple;
	bh=+JU6fLhJB5DKAD+n5mspnkAvdQiSDQTRHagjQURx/Cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lno57NIl/kJZJW3XpvaXS5J17SncrlhBgRw6AMwxCpd4P+oW+MDM7FzWxKZnkqXzxAO8LMUqwJdYZdkAatrx4/YwHtYQNcEfSHtXImFBjkwiZ7vSnMPs9QPMt/Pf2bHjCYz1q5JIssWpFEmaZOlxKVRfajEd9tw2K47Aaa448P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E5zDQskz; arc=none smtp.client-ip=209.85.221.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5zDQskz"
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7c0d2b0aaso409862e0c.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2026 12:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791660316; x=1792265116; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRpeyJnMpKI+yGzK0CJejS6LnNh7KBK5SP6JUPogJVg=;
        b=E5zDQskzRANMdcN5xheVpomGAqLW0VrBl8UqVm9ZRQRYpwXn9q7LHrl5DnCj/f/Axg
         BrvH/8DtyMASClfEF+1VEIa2l9iiFuSaSvEGPrp6SCZpOK6s45wrok1wEJSvInTi7xTW
         eDLzvNsN42HKfkAecV0+aDLmAte3osdcd9JOiCL4UabyZIJlHRD6qbLCQ87kCmhbIRpe
         49zHh3pXdlTo9EBXoh1z1aqAUXFMVnYb4eLjqRnLzEzeUHiW08sVcpAHY5Ey9zX0abMY
         FYmK93gFgF65aEkpUWzmMtoFwNNRsO8VU1J6AKA9MoYZ5o/pBdRRomf4sNNziW/r4qVp
         UnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791660316; x=1792265116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRpeyJnMpKI+yGzK0CJejS6LnNh7KBK5SP6JUPogJVg=;
        b=E4m5gJQuPWx7DWYw6B/EQj8qHg5yEj4mzQIUcgC+tuJxJtIFbhL9sSGOOwD/vD+kld
         8rhPg3BXIiC+O1rq705zRMqaqzMpWkVB/NvZyRNepEXJRGHOLu+bMSVUJaAzcjJNgp/y
         FnqO/aaVoOTRSPxwCwNfnSgcypFIeV0MQis9Dksg2MSd6OwIQzXEdUaUCzIffjWhsrXF
         RhzQk/1QmrtOqaO82KHpZ3UJAubGjqAUZGomtENHxs4Oeoz/U5vUsJxSKBh+2RGkIqUc
         n3gEIcds0sHa5E/4lXd+SwXhbatx5yaVb9t6fdepg7VuwVvAuRXEoEudrsAy7CU7fWEF
         m02A==
X-Forwarded-Encrypted: i=1; AKwUvBxmtSARbZAjb4S+89AmiFlWjP8iSgEMhwXwmlFRSqTPb7L7qxr7hvd0C8The8Y2k9diDHo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJIfy6/r8hr4+Hrx+BYCQy6QjAD37YVvlQDepOT1AyTuqDfpLvi
	yxxxSVDlw6C7m4sL7yvAT2JP5XNjJZf3K8B/Ep0ZdtL0TIrUlfrXevzOuDG27q9vYfvbFfhGABU
	9rPRJxh9Yhw==
X-Received: from vsbbk13.prod.google.com ([2002:a05:6102:548d:b0:7bf:2eb4:dde4])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:1607:b0:7b3:3b4e:f0
 with SMTP id ada2fe7eead31-7cb365906d3mr1341365137.4.1791660315503; Sat, 10
 Oct 2026 12:25:15 -0700 (PDT)
Date: Sat, 10 Oct 2026 19:25:15 +0000
In-Reply-To: <xmqqjynrwjg0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <2e12486c0d5dd8b94393b08413a85a8d47f86edd.1791493644.git.gitgitgadget@gmail.com>
 <xmqqjynrwjg0.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.g35e303d65b
Message-ID: <20261010192515.212460-1-rmistry@google.com>
Subject: Re: [PATCH v2 1/2] blame: harden ignore-revs parser and tag peeling
From: Ravi Mistry <rmistry@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, git@vger.kernel.org, 
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Maybe I am slow, but I do not immediately see why ignoring
> everything after the first NUL is a problem.  A call to
> strbuf_trim() is ineffective at trimming whitespace that appears
> immediately before such a NUL.  For example, while
>
>     cf9bdb1...f6092d # comment LF
>
> would feed the leading 'cf9bdb1...f6092d' part (after stripping
> whitespace before '#') to parse_oid_hex_algop(), this
>
>     cf9bdb1...f6092d NUL comment LF
>
> would keep the whitespace after '92d' and cause the parsing to
> fail.  I do not see any security implications here.

> > +		if (memchr(sb.buf, '\0', sb.len))
> > +			die("invalid object name: %s", sb.buf);
>
> A file with such an entry is rejected and the entire operation is
> aborted as suspected attack attempt, which feels like striking the
> balance between usability and security at a wrong place.
>
> But a line with broken object name already is rejected with "die()"
> with the existing code, so it may be OK.

Agreed, there is no security implication there. Rejecting
"<oid>\0garbage" (when there is no space before the NUL) was only for
consistency with how other non-comment trailing garbage on a line is
rejected with die(). If we end up rerolling the series, I am happy to
drop the NUL check if you prefer.

Thanks!
