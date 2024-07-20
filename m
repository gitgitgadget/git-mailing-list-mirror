Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930110A0C
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721465019; cv=none; b=FPF5tlZ16BHxT9GR3ULzui31KDdkX2XINf7vEcLdbZwn6eAtqCIJb5Y8o/VoQbCCSWpVxhz12yN+DnhhD+hMgOYXiQq5ZpTkzXOehiI+fOLLq9BbuB7wLdA3QmQYcyUCMXLSYN0aZqyGJgkFGARAnRTPXUBe7GI6LhCEQu81ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721465019; c=relaxed/simple;
	bh=7Wzcs67eNINxlvCD9SHk4NCPoC2w2lfN39P8exdk36w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1fekmbIO+hUrBXBv1tStKOTUFOMNK2AwV17N0+vuO9n5mjy125OlWG8zGuOkE3+fR/m50t+HM3xr9YriIg1kYT5ICY9rl0xgA8lRFw9NzvQ+eLgxnCU200M69ybQ0ryyMfK3CJnpqd8pxCT9ackBMGU4vBv6+O527KruLV+9+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ij+21kub; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ij+21kub"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso39751391fa.1
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721465016; x=1722069816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C+HTvn0vBxqdbmFqRBIeFb9FbzJmr1FHDasNazmIE08=;
        b=Ij+21kubGT45DZz4IOPywTPoNHFVZ/dQbP+gbWak7rubHvxk6BDxzBUToGHzkcoJKt
         OQr3GfyeWE1mpbfkUCiw+qqylvHKcpxg2SF3fNp2l5kqidIUpAWq4p6EbOsNFYOYMtKk
         Ba2EMDdjDjW+BDPs7aWgquo8+l3vpsD0Ic4Aba8lA4jqI93B4w947+vk9+Cxu/GSRV51
         Yisorw2flFJfCHhzxAVOVZq7CDCw0FeLF47ZmzA3QvKf7Ljr0oN96KAeFAtMSzOK0f6y
         4tggm9DN+vaFCCxw4AVLuD5AOAXcjBMjW0lYoh/t0meQkvWtzpbDP5qEIaiVpKSqHtFD
         3gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721465016; x=1722069816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+HTvn0vBxqdbmFqRBIeFb9FbzJmr1FHDasNazmIE08=;
        b=AV/JwklAWLA9nmNvLZg1cb0pGnhMyTruYXgbOn6OYRfxDPN+KXuRIviWTnLhnqpUSS
         FyWIiI4hdMMKM5QFNceeRUJjGZwHJpyebXD2v5zJECBOS1FGXn4yJzzlHKURjG2827DN
         ybCoyx+vA8bbUsjvymSXL3m5kK1fudvfXTQ6eVECy3yukS7lSvefzzndZ/xzWT88ntJF
         aC0Ya99xYNE5wYoc/vKBlPaFDhzG5j+DwJWOe/BUBMTotFJGUaw1kAWqIEtgDpE7NRaY
         YjcFboTXmAm7jPaa6O7qaPGKJqpFAuqImdiSKTaU6/J2eWcKwWBjWMjvMi07yPxF8ZJ+
         fCag==
X-Gm-Message-State: AOJu0YwUlY807uptEtshpp2hhBcWxvxmSBuq5c3pDOK+fuHlg7rggsiO
	GDd1nmPWpWPDozDBCoKfJSlSU5G9juVGQG5muqHTROkPUfZSjKNHRmPe45mOdRp9mL7idS+h5Ef
	jPYPmqVMakoppOCqkorJZ6bylhQyOnA==
X-Google-Smtp-Source: AGHT+IGKkLjKhKG1385y/MCCwaykGbn4K6y/iCGnD1bvmg65t/xI7IXdkJGjhuTrh//2UMDm4MUbQVhTDIrSVVCShEY=
X-Received: by 2002:a2e:9617:0:b0:2e1:2169:a5cc with SMTP id
 38308e7fff4ca-2ef167a14c5mr13201251fa.15.1721465015338; Sat, 20 Jul 2024
 01:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFbYOqDVWKz0ic@ArchLinux>
 <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com> <CAH-kW5dAup6aJHbC9HGGg8288+eSMuMub52QXGZkOrHgGRuNOQ@mail.gmail.com>
In-Reply-To: <CAH-kW5dAup6aJHbC9HGGg8288+eSMuMub52QXGZkOrHgGRuNOQ@mail.gmail.com>
From: shejialuo <shejialuo@gmail.com>
Date: Sat, 20 Jul 2024 16:43:37 +0800
Message-ID: <CAH-kW5cdTZJdFa-iZQCwFBZtUBAv_yH_87NbpNHb9yoGhJQkcg@mail.gmail.com>
Subject: Re: [GSoC][PATCH v11 10/10] fsck: add ref content check for files backend
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> The "parse_loose_ref_contents" will return the referent. In this function,
> it will skip the prefix "ref:" to get the pointee. If there are some trailing
> garbage, it will be reported by the "files_fsck_symref_target".
>
> "files_fsck_symref_target" will use "check_refname_format" function
> to check the pointee. For example, if the content is "ref: refs/heads/
> master garbage". The "refs/heads/master garbage" is a bad name.
>
> However, in my design, the trailing spaces or newline will be ignored,
> I thought we may not report this problem. And I use "strbuf_rtrim" here
> to ignore spaces and newlines.
>
> And I think there are some differences between symbolic refs and
> regular refs when parsing. For regular refs, git will ignore any trailing
> garbage, however for symbolic refs, git will only ignore the newlines
> and spaces garbage. And git will not parse "refs/heads/master gar",
> it's an error here. But for regular refs, for example "edaca... garbage",
> git will parse it normally without any warnings.
>
> So question comes here, should we warn the user about the trailing
> newlines or spaces. When using "git symbolic-ref refs/heads/maint
> refs/heads/main", the "refs/heads/maint" will contain the newline
> '\n' here and git also accepts content without newline '\n'. And I
> think we should not warn the user about one newline or no newline.
>
> In my opinion, we should do this. It's not hard to do that. We only
> warn the user for the following two situations:
>
> 1. two or more newlines.
> 2. one or more spaces.
>
> I will improve code in the next version.
>

Well, I have changed my idea here. Sorry for that. If we report this as
warning, what is the difference between the following two cases:

1. "ref: refs/heads/master      garbage     "
2. "ref: refs/heads/master      garbage"

For 1, if we do this, we will first report it has the extra spaces and then
report it's a bad refname. For 2, we will report it's a bad refname. I think
we should not report extra spaces or newlines here even with the error
type "warning".
