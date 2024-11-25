Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8618E188724
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 22:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572314; cv=none; b=bVQ581pJyC/W+gg3RWN3zPCxhk8pxAmaF1DacpEQg5jaiy3kOGmWuUteRwvG3xIlFeENaDC9oDtxyWg2pmf0wTs+lNRnAWR5GvkJLpaa/0YHuDTjcXTpot2iGMD6vr0Uvf1heaujEoDN2it/jsjflxhlem4NXwoI84P9zerWa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572314; c=relaxed/simple;
	bh=0wc2EB5NdK3kBp8Er7l/kXLvqHLH6ikYzEe5cbmEHrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KC4cZ7oLX+K62xnnA3VwsYidiAEYviogRLtvix+KMPq0pZ+5DzJBx7w8ww0KM7l7x6sS9sKUiDCvmkrsgMtbCc4gcR2l3azoczyAOG+J2ROOpt0siQy1Ah5YSY1/phMBLbOJlY6if+SvOS9u6AYh+3UPSDHncpQpzh8EH1o1kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNlmxReg; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNlmxReg"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3e5f6e44727so2835836b6e.0
        for <git@vger.kernel.org>; Mon, 25 Nov 2024 14:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572311; x=1733177111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzcFtZFnj8ybJPnf/yZ1DYahKA63EurbYxoHrwtm/24=;
        b=HNlmxRegornyalTXwyeZ5OhennXV8xPWxkv5ShMoek4RRuJn114fQkuWolIAg2eer7
         Ou0jje8WrVgkXR0RRxgtXWSqsNQD4VL4U2LJXuu9CN7UXQtVdofbPpVvTXQSsHMhVw42
         grch7mHLCRqLm39BLqmbG34L0FFtWdzF+TgW/677sJvZTFeBX5QVRVm5UKsIhbClLcV0
         k4N4K/P7mgQ1tUXTp2gseW56n3+v2z7VETkUemP5Y4Jx0UR4mQNV69u3a6kcwfKbRfit
         J0HNLX7mjkx7qlhVRg+TVTk/WWHo61SnErR0G5jvsSXeI/AePwZR8Zn2wvQKErTpwFKR
         oGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572311; x=1733177111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzcFtZFnj8ybJPnf/yZ1DYahKA63EurbYxoHrwtm/24=;
        b=U5FEf+DSxGTHJPVY0Ti4GZ21WR5FqzKchh20GZU9pVgsLA+V3Q1YJex0OJ39vDU2TL
         s9FRBypcB0ywxzkJof0TF57ePHlforqYNuQqjCOq6leGK3WzI7iYjA1RmUB/WetXZLxT
         qfzC7/nPwgcoVpDjOUwgzytIYBKvHaCuQKI4VJX+lSPh4opqB+JuFYLstWg+Kh/uXudA
         8eoIiCq0GnNWRlPnWC5+1GPQYVXwzDjTPzRpMrhCWmnqhSBc7lDXK4qXi0RLhDbUDBAy
         Sp6SUmjzF5EHttESljz8Owy1y0kVbl59deycWPmsRK3I5ecCGYWe8ucSpnZ3EkmIchkB
         NSqQ==
X-Gm-Message-State: AOJu0YxTwOvfat+k8PXlyvS/B4Mkpp5R8blUDcMdWV5GER2UQd4XU28d
	CYQ2JVOUuv1nJH5LuudZIOUU+sAzn2bKd8fO/NlK5s7OrEPkskZ+t4zDoIusOH+pVOc/RYjnZ95
	OVcF+D/dz5vRyI0OvqaWA6YnKymw=
X-Gm-Gg: ASbGncs5+bRtsBXfu3hSTtDevlk6cWY286YjZZZp2QKQKpMIMSBi/SrFoz3komkM/mE
	lVdrKPdqYQ9dMNRC8pCFInT4qkGwD
X-Google-Smtp-Source: AGHT+IHGF1R47vqQu+4aek5gGy87AdoI2a/Et2Xbo1Q0lE4twNONg0LeXDDxNxYmzfjw/UQRW0dWDtXumkfNm08UaTo=
X-Received: by 2002:a05:6808:2e99:b0:3e6:61ef:fbf with SMTP id
 5614622812f47-3e9157ab597mr13680691b6e.9.1732572311554; Mon, 25 Nov 2024
 14:05:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbjy5bc6m.fsf@gitster.g>
In-Reply-To: <xmqqbjy5bc6m.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Mon, 25 Nov 2024 14:04:59 -0800
Message-ID: <CA+P7+xoGSHzibDC0-+r-xTNkuWtuUaEqn2wgrty45fomhGDT5A@mail.gmail.com>
Subject: Re: Extending whitespace checks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 6:25=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> We have, via the attributes subsystem, a way to choose from a set of
> predefined whitespace rules so that "git diff" can notice that you
> are adding trailing whitespaces to your newly written lines, or you
> are indenting a newly introduced line in a Python script with a HT.
> This can be used, for example, in pre-commit hook to reject an
> attempt to introduce whitespace-damaging changes to the codebase.
>
> Which is great.
>
> I am wondering what we can do to add a different kind of checks to
> help file types with fixed format by extending the same mechanism,
> or the checks I have in mind are too different from the whitespace
> checks and shoehorning it into the existing mechanism does not make
> sense.  The particular check I have an immediate need for is for a
> filetype with lines, each has exactly 4 fields separated with HT in
> between, so the check would ask "does each line have exactly 3 HT on
> it?"  It would be extended to verify CSV files with fixed number of
> fields (but the validator needs to be aware of the quoting rules for
> comma in a value in fields).
>
> I guess the best I could do (outside Git) is
>
>  - write such a validator that can take one line of input and say
>    "this line comforms to the rule".
>
>  - add, via .gitattribute, my own attribute to allow me to mark
>    the files that these rules apply.  Git does not do anything
>    special for this attribute (remember, I said "outside Git").
>
>  - in pre-commit hook, run "git diff ':(attr:myattr)'" to grab
>    changes in these files with special formats, and have the
>    line-by-line validator (above) check the new lines.
>
> to make sure bad lines would not slip into the history, but it would
> be really nice if I can trigger the check as part of "git diff --check",
> which means it would be more ideal if we can do this "inside" Git.
>
> Perhaps we could introduce a mechansim that allows me to do the
> following:
>
>  - An attribute, like whitespace=3D..., specifies what line-validation
>    function to use to vet each new line introduced to a file with
>    the attribute.
>
>  - A line-validation function can be dynamically loaded/linked
>    (here, we'd need ".gitattribute specifies the logical meaning,
>    while .git/config and friends maps the 'logical meaning' to a
>    specific implementation suitable for the platform" separation,
>    similar to what we use for smudge/clean filters).  Perhaps this
>    would be a good testbed for use of dll, written even in a foreign
>    language like Rust?
>
>  - In the diff machinery, where a '+' line is checked for whitespace
>    anomalies in the existing code, add code to call the dynamically
>    loaded line-validation function when applicable.
>
>  - Profit?
>

I like the idea of an extensible check mechanism with an API. I can
think of a couple of other places where such a check could be useful
to ensure formatting. I do think this is slightly more general than
whitespace checking.. The concept seems reasonable to me tho.

> Hmm?
>
