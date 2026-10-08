Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73563C3F68
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 13:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791467910; cv=pass; b=n2g+sx6M/Bk+u/S8YZuhhE0tij5e8nH7B+Pk24UYXHPU/vw9VZHOXJIdIcNRhsTgB/5zcvZRUMXUBkR5mI7GCSdXJU3ct8/19aGN3R7uMZiZSb04pUHOMNab7JdMDr0r6CI8yQwmlSrdlnMiIMc8fdTPZpo3mALiSFBIV6mIVTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791467910; c=relaxed/simple;
	bh=WJ90n/BtlbZmWDJFBFlI0E38+57EYiontMVwaYAtgfA=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qf4iNXNiJdoWcUMzojT0bJu0iFy1qj+caRONDSPjWnMaEOjQk2F10GrYkakisFt47WMZJi4xWNmgnKqc7T70/vxhqN+eVR/b2tmFkmFmPool+RwYlIEKXJSEzak6qjhdICuO0dH1OQ4X64HHr0cRcTt63yIGrVUk1adXXBpRS5Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=iCqqO40L; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="iCqqO40L"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33e6279a1d7so2371963eec.1
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 06:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791467908; cv=none;
        d=google.com; s=arc-20260327;
        b=S+T9Hiay+cx/apDl3cqLmfAwhqEDF9Kz+sUTX46P8mom0O81sBQaxQMmusJ+G9Nzk8
         Ft6w9c4xHJFSHGFX4TVim3r5NhBFllfB9OfthN+S8A0MoseWTGSIzL5un8L3DBDlnBGU
         jtqUyXsDC6VhTe8xGUf601Akm1PNnxmAPQRz3I9qNQOw+GWHAe6Pn1CSKD7S3fZQiy21
         zm2gKI3zicaTXKH/vI9lWqmvoPBLsPWuCUg5Vgarkj/OOiCdkN+Z+MwGSnZXs55Do+EX
         MfWkNmq4psam6JUefkrIcEXx+/8g/7Pvszud4gFPXyHyRgdY/x7aBL/akJLnX3gM3l8F
         s2ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=WJ90n/BtlbZmWDJFBFlI0E38+57EYiontMVwaYAtgfA=;
        fh=dS7ZYYEQ3xS9uUoit4NbHrS7bRskiJR+qpqNwgt9xSw=;
        b=V+xAKc5AHOp7pxFSWUVbueDPLWBiRzfIj9hPIr2z7HLiRYjCB3t6aDv1d7D0xPE2HW
         sYKp+DQgh1P+y7y15gBvFcy/HYLsrzdp+9khZfcHG2JGkr+dFYopUEieWtWvwcmND4R6
         yUqwWKO3KdxlJOp8mEsgPV//EU1AaOoEJunGHfupSx6hnv9yo8fdgpbQwR5loybAWreV
         paEBMuQVJ6OhLT1ewBjFT3DbkV+QVqCuk7FFqej0MM3KTwzRQh285Di0DNv+iwBtlovG
         BWm4Upq/BGT4+eg78ZTbHIKd/TFEdp8CfeLnyIJmkqZH8P7cFuqFJF3YfXNdHc3/jqNj
         92ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1791467908; x=1792072708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WJ90n/BtlbZmWDJFBFlI0E38+57EYiontMVwaYAtgfA=;
        b=iCqqO40LivNDd6R94KgoqiUbfAUp4kgf0gXqyQY8GWcUsUiiLIy1UKITRHTrK9GFgK
         WYb+Qy/58TX32qCusliGxiPkpYQtcSMJ8OxUBBJGtTXzhuR/uYWuGRlsdEApen/20tI2
         YCE5RQm92IH12MIMInyEpYWVgAcM7uueCgKy/DZp+pk11l/8eQRByWpO0gpUQ2qsUsNo
         woO08iBYx42ZiUaOqQWgbntXer8LShwfpFLgZ/MrBeDTp5haIOH67N0n5YuvBPw0i/Yn
         p/YViMc2Z8KqhgjecZOxHZhH2KrPNQIFx/0Rw7pPOFc24ppQVq5OFPMe+T81POTXpXtN
         u/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791467908; x=1792072708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WJ90n/BtlbZmWDJFBFlI0E38+57EYiontMVwaYAtgfA=;
        b=mYUGu1XJk30qLRnvyZMl4zxlZJCc82U56aDA5Ev+dEBgjmY+cDjZU6q4skQR/Z/wWW
         tZwxv+Ui3XvgAQnJA3WBj60qm2YQH/lyuexXpa6eySeMyS4yMG9r0+yzoCsJd56c+SNf
         IxTKoXCCwhs64HQosE/gEaxBrI2nHrWe3kVQJ3xbCuZ7eRI4oeQjvM8E92LFuS/g9Mt0
         jIYBmknz3xmBAIGYIo3IhrBGgkMv2tizunvpJ6YPP1VEyDJkFI4QBkcEwsC9CMYPb2b7
         gHonaak2g7bE84ELg8VzwGA8SzCwlP5hdMslU+phgHISDgmGwesml1iifvO9V2MyeMbe
         XGIg==
X-Gm-Message-State: AFq9FYK/yU+M4EaGa+t7G2pB7hlPvawvzpZoNbAt7wjAhmV8rYxBE2GK
	L6j+6rkCAYegeHSsuicfM9rhw5mQyzr2FnacA3TrfSeTYg+rAgbkJUMyvXRCZ++0uMMH43n37+/
	sOMIITqisOqxcmNbovsVwZ8yu1BQnpjp7OWG1NqX4Zg==
X-Gm-Gg: AYBFou0nT3aK8WMK3MdpMAMbxZaOtkMxlumekKgKQlzNoTXKKwaubTxFvsgTDaoIdwq
	3bxv+irhC9qf/O+zYwWej8a9Lt0SvakVZyUNQVdLMhd2AxJZE3TtFJNYC69T02jyYuocISq5Ias
	k1gOHdEUGhY/n+EhfpuvJPWZiLQANenj5endfrBfQvMKR/PW+IIy6+Ut5qwEA7f5E9/6IhktaSx
	sIXBie9+GrBU3dZXhix1z8TwaHBlH0lOdny9u1bcabjaobef7u4VZbd1OKXq3fCbvgqE4fnJ4YV
	tHR57QkODwswvri7UrFXVp0/NyzzPDI7c0dGvjxM4+4sNx/hgisDSA==
X-Received: by 2002:a05:693c:41cc:10b0:351:8038:83ad with SMTP id
 5a478bee46e88-35180388663mr1975707eec.24.1791467907712; Thu, 08 Oct 2026
 06:58:27 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 8 Oct 2026 08:58:26 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 8 Oct 2026 08:58:26 -0500
In-Reply-To: <xmqq1pa4ksiw.fsf@gitster.g>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
 <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com> <xmqq1pa4ksiw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Thu, 8 Oct 2026 08:58:26 -0500
X-Gm-Features: AclHuK8W0MwzN0tjhVV3l8NSHk-f5p-U7ICZn22FYzGNQ9HbBkIGxA6jJWmiilo
Message-ID: <CANUHOw3N+_yWnh7=2-5fD+XxgYC9-M9fqL8GEjfEC6kN+CD=gg@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

> Perhaps, but I do not think it is too huge a backward-compatibility
> breakage to forbid giving a message lazily (i.e., all strings in
> argv[] after 'git stash create' gets concatenated and becomes a
> single message) that begins with "-", with an escape hatch that a
> leading "-m" will take the next argv[] element as the message, for
> example.

If the compatibility change for messages beginning with `-` is
acceptable with an `-m` escape hatch like the one you mentioned,
I think a new subcommand is unnecessary.

>> 3. Add something like `--create-only` to `git stash push`.
>
> This also would work and sounds the safest.

I think so too, at least for the immediate change.

But `stash create` is already intended for scripts, and I think we
may want to add more script-oriented options to it in the future.

If we put the create-only interface under `push`, each future option
for that interface would also need a decision about whether it
applies to ordinary `push`, `--create-only`, or both.

That would add another set of option rules inside `push` that future
additions would have to account for.

So I currently think extending `stash create` directly is the better
long-term approach.

Phillip's comments about which options make sense for scripts also
made me reconsider the scope of this patch.

I realized that I had been treating two decisions as one:
whether to introduce option parsing in `stash create`, and how much
of what `do_create_stash()` already supports to expose now.

I think adding option parsing and `-m/--message` now would be useful,
even if we only expose a few options. That is because we should not
need to revisit the basic parsing and message compatibility question
just to add another script-oriented option later.

That makes me think we don't need to expose everything
`do_create_stash()` already supports in this patch. I now think
we don't need to settle the public rules for other options and
their interactions until there is a concrete need.

In particular, I would prioritize leaving out options for which
I haven't found a concrete request and whose interaction rules
might make future additions harder if fixed now.

So my conclusion for this patch is to expose `-m/-q/-u/-a`.
The untracked modes address the original gap, and I think
`-q/--quiet` makes sense for a script-oriented command. It would
use the existing creation helper's quiet behavior without
suppressing the object name returned on success.

For now, I would leave `--patch` and pathspec support out.

I also checked `-k/--keep-index`. It concerns the cleanup and
preservation behavior of `push`, rather than creation of the stash
object itself, so I would leave it out.

I still need to think a little more about `--staged`. It does affect
what goes into the stash object, but its interactions with other
options are less straightforward. For example, `stash push` does not
allow it with `-u/-a` or `--pathspec-from-file`, while patch mode
takes precedence over it.

So far I haven't found a concrete request specifically for
`stash create --staged`, but I'm still checking. Unless I find one,
I would like to leave `--staged` out of this patch rather than
decide those interaction rules now.

Thanks,
Kazumasa Shigeta

On Mon, 05 Oct 2026 09:43:03 -0700, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96 <kazumasa.shigeta@kanamei.com> write=
s:
>
> > Your question made me realize that I had focused too narrowly on the
> > untracked modes. The larger issue is not simply that `do_create_stash()=
`
> > has capabilities that `git stash create` does not expose.
>
> Brilliant. I agree that is the right way to frame the issue.
>
> > Making more of those capabilities available through `create` would
> > therefore mean either changing that contract or designing around it.
> > That is a much larger interface decision than I appreciated when I sent
> > the patch.
>
> Perhaps, but I do not think it is too huge a backward-compatibility
> breakage to forbid giving a message lazily (i.e., all strings in
> argv[] after 'git stash create' gets concatenated and becomes a
> single message) that begins with "-", with an escape hatch that a
> leading "-m" will take the next argv[] element as the message, for
> example.
>
> > 2. Add a new stash subcommand for the creation functionality.
>
> This is essentially how 'git stash save' came about, to give us ways
> to control how a new stash entry is created and how the working tree
> is cleared with command line options. In the beginning, you did not
> even have to say 'save', because 'git stash <message>' was invented
> as a way to say "the boss is here and tells me to work on something
> unrelated. clear the slate with minimum number of keystrokes to
> continue working on what I have been working on later." And that
> later became 'git stash push'.
>
> > 3. Add something like `--create-only` to `git stash push`.
>
> This also would work and sounds the safest.
