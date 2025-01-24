Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4197C23B0
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 04:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691584; cv=none; b=dAlSgwTtSY/HLZRYf41AzFsHzCeBR/CyQt0K7WPu2E8+FjYg42gAVeVYd4aGz2qPlkH6o6NFPnP49qYbck0OrwXEHjI/O7MA0yEkB8RiOYCNLm0YMpzy1rGhSPnz9+xpIxp2PMkeA9cQMjd18VFMqkHgLKg8GbRoGjf1wxWJc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691584; c=relaxed/simple;
	bh=Pohz9HkRY51+ov82fFcAPSw7fkOUFj0A9ds6Jfd63ms=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwFm1pVq64sQ19RpEtAsZ3e8Bkq08BDWSFT4PTevA7uF7lcgwF46Eu5C2zxTk9eXSEekcJG7mBmRSng0SYbnWK7iWhnWZMouP7+7c9mV8cgrtL1k7mebnoMuduyuioaPQp64CoeuHjsX9ZFz91Vc2wowUMgqFVCqRnrHOhHnrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm/TgE2O; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm/TgE2O"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51c7b5f3b8bso547290e0c.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 20:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691582; x=1738296382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLdXIqGlEHqhKKQNt2c6qos64S84aKsxcayO4XoNneI=;
        b=lm/TgE2Ov/oMqR0gwK3GVdl4/rtRVRb1lE+nKoKTwD7YL2JBDJB9W1Zl45a2QHtRWl
         J6Ixye3regweFgu4iEy3gQS/mbqIjGrCkrFn6OiC5AJw1ySLk3THksmeG0VJrordno/8
         P2nDFhkT/Qdrn9jdf8kqGMLcphJLKg5rworUJp8TWu/AC0qKw56K1TOVP5xv8kpvslDZ
         CwC3Y7U7SV9i50s/jUffn0WlagJQJW7CyOvB8ZlhBspduOd2Yi9hUZH3cJ/HU4HAXoX+
         R7/v5IicMgqXfrQMAU/v9LjunzSSqiNMKtmMBw9lP9nSIynNf0TyLo0zAJE+twtLg0fX
         V+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691582; x=1738296382;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLdXIqGlEHqhKKQNt2c6qos64S84aKsxcayO4XoNneI=;
        b=BOxfyCiEc4CYUhU783SgzkS7YmE8GCesPvUoMIjazjkWHvP27VVCyFTAFWRdp1DeCx
         c9GiWEkkBhcmpVTjtS/TN9qxLsxzXOBx2BsHD2QQOb8Y3tZcTP+DmaECO/FnsCSumFQY
         wFEPSf7O6yke6STlkYSGpHSdebHO1C0MMIACNUOpwz0eTMiu3b8t8RHPuqwPbbsIgE6p
         vfSOicqCOjdKTyWw/hIqFCz88qRkzYIKpU4r6MKxu0eFNFpKwYwnpvaV7E1Q2dMpmwlc
         CPuDWfi6ki+coGqfuPNKQtBG+QdPRiMnLuIDS74ny1qwmicbKbfmybCziKTiEbgX3RsB
         KTlg==
X-Gm-Message-State: AOJu0YxLrySgT3g8mMZ8X9sk8HVlISXZm3u8PeKzFqImNirMql0X5Mu9
	ox1E4DRLpwMC6Xkzq8T/4OxbtrFIQ/vS9LZKeLUNXC263SoRUmRXeF3W9Uxs1nIje+hg0CS/u9A
	8l2YwVfPHAEboS1jVL/kHz2r5NI0=
X-Gm-Gg: ASbGncv0cTJhZDeFkStp7PLhnbw3EJ1qF/RTGtY2kHb78rfuAi3pZBf61xRmReQdJrR
	8tdy4sWj0b9ERGE7vtSTqkNydAlbZg5Bj/d+kavRZelgDEf0NaNe907UHEo3R8Gc=
X-Google-Smtp-Source: AGHT+IHv9EPcFTvnSTmvnHxcYwkZxXoGPevqYf3xNWmysgI5kfxvkpmgl0+vuvt9MZZ5bzk/l/QvpipI71HlAv7xzIA=
X-Received: by 2002:a05:6122:6610:b0:51c:aa1a:2b5b with SMTP id
 71dfb90a1353d-51d5b2641e4mr26712956e0c.4.1737691581915; Thu, 23 Jan 2025
 20:06:21 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Jan 2025 20:06:21 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqbjvxs8me.fsf@gitster.g>
References: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
 <20250123135613.748916-1-karthik.188@gmail.com> <xmqqbjvxs8me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 23 Jan 2025 20:06:21 -0800
X-Gm-Features: AWEUYZlxGgBicVnXleglSsWn7EDo2G3AA3vfT5wCzq1fPJj5anJax30uCE-vA1M
Message-ID: <CAOLa=ZSisRwmUyLHAP0e=8U0QjfFbDfXwd2mJXKjVywcmM56Tg@mail.gmail.com>
Subject: Re: [PATCH v2] reftable: write correct max_update_index to header
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, sandals@crustytoothpaste.net, 
	Johannes.Schindelin@gmx.de
Content-Type: multipart/mixed; boundary="000000000000784197062c6bd96e"

--000000000000784197062c6bd96e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> While this patch was merged to next, Dscho reported that it was flaky
>> on macos pipeline. On further investigation I found this was easily
>> reproducible when the leak sanitizer was turned on and the reftable
>> tests were run. The fix was simply to add the missing 0 initialization.
>
> If it is already _in_ 'next', please turn it into a relative patch
> on top of it, instead of replacing it.
>
> That will give you an opportunity to describe the breakage in the
> original version, which everybody missed until it hit 'next'.  And
> you can also credit the folks who reported the breakage, and
> describe the fix.
>
> The reason we do not revert out of 'next' lightly is because the
> changes we merge to 'next' are supposed to be reviewed well enough,
> which means that any bug we discover later is likely to have been
> caused by mistakes any of us may repeat in the future, and it is
> worth documenting in our history.
>
> It is quite a different review philosophy if you compare the rules
> we use for patches that haven't hit 'next'.  These uncooked patches
> may have mistrakes that reviewers can easily spot and get corrected,
> and these easy ones are not worth documenting as much.
>

Thanks Junio, I understand your reasoning here and it makes sense to me.
Do you think it is worthwhile to also add something like this to our
Documentation? I couldn't find anything there. I'll add a small patch to
the bottom of this mail.

>> The patch is based on Maint f93ff170b9 (Git 2.48.1, 2025-01-13).
>
> Thanks.

-- >8 --

Subject: [PATCH] doc: add guideline to tackle bugs in `next`

When fixing a bug in a topic already merged into `next`, there are no
strict guidelines to follow. While topics in `seen` can be reverted,
topics in `next` have undergone thorough review. Documenting fixes for
such topics is valuable, as it helps to clarify the issue and
contributes to preventing similar problems in the future.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/SubmittingPatches | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 958e3cc3d5..72454acf21 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -115,6 +115,13 @@ latest HEAD commit of `maint` or `master` based
on the following cases:
   new API features on the cutting edge that recently appeared in
   `master` but were not available in the released version).

+* If you're fixing a bug in a topic that's already been merged into
+  `next`, it's preferable to create a patch relative to that topic.
+  This approach allows you to describe the issue in the original version
+  that went unnoticed until it reached next. Additionally, it provides
+  an opportunity to credit those who reported the issue and document
+  the details of the fix.
+
 * Otherwise (such as if you are adding new features) use `master`.


-- 
2.47.0

--000000000000784197062c6bd96e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: aca9e8c4313962fc_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lVEVic1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOURNQy85NDcxZThNekF6Y0dZT3pNRVdMTk1UTk9xNgpJd2lBcW5JdEgx
WFhLSTFBNlRpUTRvam9XUE8zMUFrK3lWanA5OGlFK2g5UUFBWE96cWdQTkVuVWVKTytTcXpsClVJ
bVI5MllteEpxaDVWYmVEaXRkWGt4WllaVGFHSDhZMHdkV1pOakNyZndTWkhPa0F3NlRYQTVUVUlE
NVlGNE4KeVY5Z0RDWGpaTFNLeVpDT1NqOC9yemx2ZWtBcnI4cXFueUJxYktsSEs4RWVobGFZeWpj
aXFJYzZCWVhvc0R6ZgpXYTBqald1djBCNG12VGlYcWlIKzhRT015aUxodEsyZjU4VDlIQzd6a0tk
cWZvWG5NSzZ4ZWlTaDVJRzI2bTRUCmQxeEVPaHNQT0ROcmtLSldLV2FOK1ZwYjZGUnJ6Umd4T1FN
blUzVEZTQVpxaGp4aGtnSGQzRFFLNWxBUGk4TTQKL0YxQnJmUXZmWkw2d2RNcHpxY0dLSHlGTEVm
SzVCYkpHK0YycVB4eC93dHhFNnN3YkVpeUx6dTZYUGFkU0J6ZgpZZElreGRPWHVsVWEwK3BnbEpu
ZEhpMzU2bVZpRTFVYXA0cnZxNUZrd3hlWkVrQnNZQUtNZDZtNG54dFdLTGN5ClVKbkpYMm83bVNs
eVpVa29ad3JQai9VNk05dFo2RjRCbmJuRVFBbz0KPTRXajgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000784197062c6bd96e--
