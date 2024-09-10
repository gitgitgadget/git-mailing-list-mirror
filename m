Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456391A4B99
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726006792; cv=none; b=uZ950YHS7IcKOWm9Y604k2OsDREpyqWvEpbKxfOs8zO4rQzfovTx7PDFH4oi+rMpYytqTfx174ViXIPFD3hAIl674H5JdWTBPgbpocJQBFyMbS+fTr71eeKtCwYbnwquIy1A4AlmYmYas/iu/9s57S6JW7EHM9AewDb1prtpv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726006792; c=relaxed/simple;
	bh=R7BJw2XcxCC9j4A85S4kJF5VuBMXC9/1M8fKvsCAhAQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQYKCK9xNg5/k4MqbUJX/t8Bd+RxfFB5QCUAdRDg26wjKAxjFfIqz6Rj4uImmBe8hzDNeH8bzmz9IdCqu8evaJxD8q60StdQR5pAe6Czyq/VSGor4xuwsaoXVg7JAGU5nOYJB1oGypWM3tUYKLIfLHK+UntJ6RVs2k2St5nufpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS3du2Bs; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS3du2Bs"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e1ba0adcb0so629465eaf.0
        for <git@vger.kernel.org>; Tue, 10 Sep 2024 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726006790; x=1726611590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MVodsncM3dUds14+R7jgKy9c91Gft0quxnxu9OwqxG4=;
        b=kS3du2Bsb71Hyp1tGyHMGxthCNryTihKUohXypKnNcpVd2RQxWaMtFN7bxq3viE9Vo
         R9rYPXu/ZjHW5RKXWeOO18Vj/oBTGD6xcJ9yckR5hXO7UgvyP3kbVyld2Bmo94/j6Gki
         JJMuJvP3ABco/RqOp5KldSJLGyKNfLCT82AEPrMnMqj+shiSGYAn+0A4CQxvMMm7RFNp
         Bua9UgNuw9cDbavOka7eVbXTYOa0Jszz9B32jSJQcIh71KRg3t5Hd2DBjKrUMZSRg6Bu
         wmQtlXS5gdvvBCePm9u4piN+J/6qQR1aRVE9RDgFiD08TtjcEzCWewP3u7bxXpewiCuZ
         aNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726006790; x=1726611590;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVodsncM3dUds14+R7jgKy9c91Gft0quxnxu9OwqxG4=;
        b=FsoWLdgd4nAelj1tlskNBaTQyBYfow0bTjhlETzg+25AvC8NlaVkIZu3pW8jb1DFON
         hp85WuMLIQ9bkDOoLPc43P4r19/WxcHX4Jg0vfDlynPpKEw+c8G/s58DPT0mQfH5eEUi
         tSWU2XgzE6i8/uBTYTD74XsUkNppqA/XiAS6X9OPlKxmnFmLjTfGjq6VK3q3kNqz6YJc
         X+tui7sty6G0/kPPeH5LFevSoIV2RBGVSEZpfWvm4WCQ3MiKEozreRcGpS1A1sY7fDMe
         PP6ifUrUcEnr15m6pFRJNqimo9FIT4H+MBmsrq6PA4pZu4WjY9cHopxQzRVKeF30XMMI
         Gjdw==
X-Forwarded-Encrypted: i=1; AJvYcCUvhMgu2vQ8mltAwSZdg83s/5kNb6ILG2p3pW7fhfqVk7mjMiSuFnjvrC5KLWIwXyhLAfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCChXlR7Z6XduUBtJbVOWAhdjKwkCXTq07Jq6ZM3ujEyKi8cO
	kiLbDG/nAPmlyxjV42BkgLqgD0XAnTZy68WTj/LI2fStSzt7h9eCOJrP+6XCqMsKFF6dmF7kNYI
	B01D6b8yqyK+2Qo7EyA4uQtFZwHs=
X-Google-Smtp-Source: AGHT+IGYuInVfS1f2nLpBBFe8OLGl1u/ZRgi8sTiRCa9XPUgiW60HtwnATLHDlSxr6QHins9DTgVEXSaftJ3/N4rzVA=
X-Received: by 2002:a05:6830:6b07:b0:710:f693:51c9 with SMTP id
 46e09a7af769-710fe75fe93mr1234246a34.20.1726006790135; Tue, 10 Sep 2024
 15:19:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Sep 2024 15:19:49 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Ztb_JuMjaoAbIZXq@ArchLinux>
References: <Ztb-mgl50cwGVO8A@ArchLinux> <Ztb_JuMjaoAbIZXq@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 15:19:49 -0700
Message-ID: <CAOLa=ZS2TsRAeAHJ6B9h82-H2tSG-vZMRBSpspQ3hOW5GBdciw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ref: add symref content check for files backend
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000009b4a840621cb4509"

--0000000000009b4a840621cb4509
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> And we will remember the untrimmed length of the "referent" and call
> "strbuf_rtrim()" on "referent". Then, we will call "check_refname_format"
> to chceck whether the trimmed referent format is valid. If not, we will

s/chceck/check

> report to the user that the symref points to referent which has invalid
> format. If it is valid, we will compare the untrimmed length and trimmed
> length, if they are not the same, we need to warn the user there is some
> trailing garbage in the symref content.
>
> At last, we need to check whether the referent is the directory. We

s/is the/is a/

> cannot distinguish whether the "refs/heads/a" is a directory or not by

It would be a little clearer if we say

   We cannot distinguish whether a given reference like 'refs/heads/a'
   is a file or a directory.

> using "check_refname_format". We have already checked bad file type when
> iterating the "refs/" directory but we ignore the directory. Thus, we
> need to explicitly add check here.
>

[snip]

> +/*
> + * Check the symref "referent" and "referent_path". For textual symref,
> + * "referent" would be the content after "refs:".
> + */
> +static int files_fsck_symref_target(struct fsck_options *o,
> +				    struct fsck_ref_report *report,
> +				    struct strbuf *referent,
> +				    struct strbuf *referent_path)
> +{
> +	size_t len = referent->len - 1;
> +	const char *p = NULL;
> +	struct stat st;
> +	int ret = 0;
> +
> +	if (!skip_prefix(referent->buf, "refs/", &p)) {
> +
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_TARGET,
> +				      "points to ref outside the refs directory");
> +		goto out;
> +	}
> +
> +	if (referent->buf[referent->len - 1] != '\n') {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_REF_MISSING_NEWLINE,
> +				      "missing newline");
> +		len++;
> +	}
> +
> +	strbuf_rtrim(referent);
> +	if (check_refname_format(referent->buf, 0)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_TARGET,
> +				      "points to refname with invalid format");
> +		goto out;
> +	}
> +
> +	if (len != referent->len) {

Would this work with a symref containing:

    ref: refs/heads/feature\ngarbage\n

Since we check last character and rtrim, wouldn't this bypass our
checks? Isn't it better to find the first `\n` and check if the index <
referent->len?

> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_TRAILING_REF_CONTENT,
> +				      "trailing garbage in ref");
> +	}
> +
> +	/*
> +	 * Missing target should not be treated as any error worthy event and
> +	 * not even warn. It is a common case that a symbolic ref points to a
> +	 * ref that does not exist yet. If the target ref does not exist, just
> +	 * skip the check for the file type.
> +	 */

I think the common terminology for this is 'dangling symref'. Perhaps we
could shorten this to simply say:

    Dangling symrefs are common and so we don't report them.

> +	if (lstat(referent_path->buf, &st))
> +		goto out;
> +
> +	/*
> +	 * We cannot distinguish whether "refs/heads/a" is directory or nots by

s/is/is a/
s/nots/not/

> +	 * using "check_refname_format(referent->buf, 0)". Instead, we need to
> +	 * check the file type of the target.
> +	 */
> +	if (S_ISDIR(st.st_mode)) {
> +		ret = fsck_report_ref(o, report,
> +				      FSCK_MSG_BAD_SYMREF_TARGET,
> +				      "points to the directory");
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +

[snip]

--0000000000009b4a840621cb4509
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: eb8561dd566ea949_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iZ3hnRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHhXREFDa0l0cXhTbXorYU1ZTU5pVENhdUxJdmMrNQpzaHRZZk9GT09I
S2NYdGJKOFROZm5PMUdVZlhCYU1XOVQyTE85TWpOZ1N3ZzFWQXh1Wm9MTDFMMzRjWG52MFhmCmtz
SFNEQW82YlZGQVNhYzNhSk8vZ2xOTmlWblh6K0RGWjN2MDhkV0FBbFBEV2pDZXNVR1M0ZVAwVEtk
QW5sL00KTnQrdGVwckpmd0w4YmJJMjdFSkI4bWpLRjJxdVpRcHZJWlh2dGVjckVUdkhmcGVPMnR0
c0JyRXhMWmtSMjBzbgppOGl2Y05TZm0zZzBnTjNSQlBaNW9iUXVqdjJhUzEyK25KenB5T1JVcHZv
TEt2MHI2ZFV5L1pOU1FGeWMwTDJtClFvNmNzaitwb3Y5a2tZOTdWdnVCS3QxanNZeWljWDBITE9j
TGxoeEU1cFJBRTBxYXNvUk11R2Q1UUU0TEdpSHQKNlQrTVRlMTdMQlJRRmwrZlBtRFJQcXEvSlNj
SnJOazRsOUFqYjdpK2kxdlpWQk9RZFZjRGgwaVlqL2NxeXYwbwpUUExENUpZQWJzWjNWQk9XVlRm
c1dQT1VwNzBjVWxxNExLNC9IUS8wSTVFTHZUMDZ4TU5CT1NiQzhkSWFnakIyCnhkSXA1VWRIK3Iy
WU01b1RVYkpPV2M0VDBwdHNZQVQ5NUJ3dTB4bz0KPUltU1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009b4a840621cb4509--
