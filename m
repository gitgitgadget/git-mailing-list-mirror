Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2A82417C3
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313068; cv=none; b=mJ1GUIdUC7AlGmbeF5Nq9KOzxFpiAekEWeLD8nb/2FsEHkFV83efTxrluvs2U6mk9/lQDCrfM8Ib3TMhzyb8xGGeL68QROUDuF7x2a/o1c3sVsP+WR5KVVQQe9ZEhQV16+7HcDEbdTJRmXsAhs/Qo874mJ/rW1tky9GnVw+s9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313068; c=relaxed/simple;
	bh=YBUBdkSk9J1KsL6wY4niy/OqkGzSY8m8zYj8Rl28cyo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liE869RDdUpJu0qflI1pjgmihTnJOjhmLZ6iM6yc737C3ZEOYVObgGknFaisdWdEmMkQCgIE5BL9/9ub92xu+SjL6xtbql095ZpKl55TPO77OC/1xiiF/nA+K3pZ6bCeJTGgreNUYVhoimBECG6bXPS0GoCaX+Rb80PA6qA722c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f3rnCbmi; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3rnCbmi"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5242f137a1eso1834220e0c.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 02:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745313066; x=1745917866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYX3P3xGhLrPCBPFfiH2/1OMvW0TDvujIjJ3JAI4uw=;
        b=f3rnCbmidwBw8M6YqxCEkAcm6xpg1ubhsOnIgcjH358J3vpxhjvenJd2P74kDz3JqA
         XjYE7p9O0aLQ4njoDEpuXQ0FybXivckTPqwZL8SzwWYr4lHCpRxMRRQseMGo8354uWo5
         LZiVDYb9BANXNjP6QxKozr5wYpvwE+cGs6oAh0IaOoJBunJTrtAnY8h1nwT1dOd/OjBh
         xWKXAHnSkNg1Si/rDq4PltHdRoIJ+WGYcBGo/WlMopFaSILCik+0u3XoPsF+jd89PdYZ
         6cHFHMbdLEBdKpSUMYnyIc7/PQIg1H9GkmP8Jd5BslJ/ZtwvFuopblWXmVWMmFQY1ai9
         pKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745313066; x=1745917866;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsYX3P3xGhLrPCBPFfiH2/1OMvW0TDvujIjJ3JAI4uw=;
        b=iMxmxSDV1CrDn8o7AjjycIbK+MA7yzu4GZ+Zd88kKqGgbO2xHJMZqGBUNP4+PyN36e
         lvQmV+/nDVKyRPeoTtHtXvHfN2lF8x8iJupgDI43US4u5FdPpGyVNDUYg4DlUE+cJbhe
         GR3Q2xA8vUSd/YqoDbSZniPWRxwMnCDSHkAMa8oW6Vgs4202cFQStXZ8dwlYdlKqlhHD
         yLqJDKgceQ50d3OYMKLXskYsR96f0zpuG2lWa0QuMwnP8WYxhCBJ4WxYAtOafuehXfUQ
         nDT021KqpDvk0XiA/gVeszKS8pwuAocGgtHsl2elK1TY4TtC+R9obrVr9QV875CfbkNT
         DVbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0A8mZesJSGy78FqfvHcDfFKeVasSkGa40uw8lfK9jw2dJNmwQklbrdmN84Y3Q4WyPxz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwbUG+XZuAhQwMyiSsBRvH+li4bSm55Noyihgncue/aM5OK7z
	RnzeXSXGTBL98xz2MSsTdcmBE0ZuSggsE3d3FmwsSgr+kMnCgBgn7o6Ebfc8AL49KCIbfaZYAUr
	nFvlmGYywa0fYhR27BImnuSg9pt5ePg==
X-Gm-Gg: ASbGncvAQqI7gvVttjHRh8QIBFKewoVhOLb31GiXG8gZ8ab9NsdEY7Q1U3pP/nQ3YlA
	0GKb+z8gvGFGxikAeXGxIsmO7f4S1bKJnhuuBmVFVH3F7jJ9GvVjZfTi0GM0C5H60in+Lx2+8ZB
	kyvUnHtSjjIPJa5sjM+C/8Fkc5phGkwwGrpg9Qv/Y+iobpeOpyNw5sjofK
X-Google-Smtp-Source: AGHT+IGo+NGfj7wy+MIxS0/xXtY6gXGoqsbC+PxEkIWka2fjBP0btNguj6e4QgzlIcp5miYNa7sMas/4DFVNl1596Is=
X-Received: by 2002:a05:6122:2a13:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-529253df487mr11553692e0c.3.1745313065686; Tue, 22 Apr 2025
 02:11:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 05:11:04 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Apr 2025 05:11:04 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqldrt5bto.fsf@gitster.g>
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g> <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
 <xmqq8qnt7c9w.fsf@gitster.g> <CAOLa=ZSa-qQzi3iWPF+M5a4EsvGiQFX=2Ca=vzuqwSLWWXSw+g@mail.gmail.com>
 <xmqqldrt5bto.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Apr 2025 05:11:04 -0400
X-Gm-Features: ATxdqUEEznEzRuhW_iHYGx6NCFTns2CaYL7iYoeAfUREmf8SbRDit7SE4b8zOHY
Message-ID: <CAOLa=ZSSdp4KBHAviudJm=H+bP0aqru=LN2=4hsYsqyM7zLMgw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's hdr-check
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org, toon@iotcl.com, 
	ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000004d869c06335a5d2c"

--0000000000004d869c06335a5d2c
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Step #1, clones the repository, since the `git` executable isn't present
>> at this step, it uses GitHub's REST API to obtain a tar of the
>> repository.
>>
>> Step #2, installs all dependencies, which includes the `git` executable.
>>
>> Step #3, sets up the build, which includes setting up meson in the meson
>> job. At this point the `git` executable is present, so within meson
>> `git.found()` would be true. As such we run 'git ls-files' as part of my
>> patch series, but since the repository doesn't contain the `.git`
>> folder, the command fails.
>>
>> So like Phillip mentioned, we need to ensure that the `git` executable
>> is present before step #1.
>>
>> I hope that makes sense.
>
> Please roll that into the appropriate commit log message for the fix
> you'd send out, so the next person who wonders why this topic broke
> the CI does not have to ask the same question.
>

Yeah, will do!

> Would it make sense to just swap the order, then?

Unfortunately not, this is a chicken-egg problem. The dependencies are
installed by 'ci/install-dependencies.sh', which are not present until
the source is available.

> Our sources are
> meant to be buildable from either release tarballs (which is created
> by "make dist") or a repository (with .git), but from the analysis
> of Phillip and you, it sounds like the CI environment has been
> building and testing from a "git archive HEAD" output extracted as a
> tarball, which is *not* something any real users build from.  Making
> sure that building from release tarballs works is a good thing to
> ensure in CI, because all our developers are testing in their own
> repository (with .git) so we wouldn't easily notice ourselves if we
> broke the build procedure in such a way that it would somehow
> require say "git describe" or "git ls-files" to work.
>

Another additional point is that this also means that the two CIs
(GitLab and GitHub) now run builds differently, while it would be nice
to have a separate job to test building on tarballs. I would say
currently we should fix this to build on a Git repository.

> Thanks.

--0000000000004d869c06335a5d2c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9e6dc1e3a9d952e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nSFhTWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOERuQy85dm1qKzVuWGZJcWoyLzYzZzNFQnAvYzFhMgpTNUtmVXFiMXJn
MTcyS1ltV1ovOHRTeVhwcXBzajd3ZlFNOFFrZWZycEJJUTBCSlU0QlA2OGJOWWowUzZjMGw1CkJZ
ZFM4cUd3d3EwTzZLN1REUzhnS0ZPMEhKaGxQVmpQaHRmdko3WTlLRWVqa1EwVTJuUGtGajgzZFI2
L1RsMkcKWUR5WmNjRUN4eWY0VkttZ3pFWjgrb3pSSk1KSVRFdTlXazFnazUwV0RVZVd2QXJUUFJG
VlFJRk9RM3JmZnE2ZwoyMGM3eWhreEtJV0NzYTZpZmswbXFMUE92N0doeWJPbWZoQitwdS9IMjFx
djh1WEVMeWdTdWhndkdsNVpyQW94ClZlNnE1VUtZRmxWb3JQL01zNjNObGpYZDY1UldnSWJWQXZ0
RzZXYyt6d2czSlZEcVBDQnVneU9JU1dWS1hxaUQKYmdQQUw3TklESXVJOFNPeDlBR2JjN3BwYkxh
ZEtUaGJOMUVLcks2NS9PS3MySC9zci8xZURhSDYwalVEcHdwLwprQkRrOFo0OU5QT1E3RzJvbWVL
WkpNWjBaQy9ZRTFrN001UTRuZHFzVXRIZVhDUzNOcmpFZWFCVXZlQXVuK1VnCkRSVUV5cWR2bDll
dndaeisrR3JpcmxPbTluWVZhN0ZuVEFQVVdQbz0KPVVjeCsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d869c06335a5d2c--
