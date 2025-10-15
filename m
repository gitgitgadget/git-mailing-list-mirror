Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08333086
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565922; cv=none; b=SVj8XqtaBsyWqWpiRlOrEyLj+THicrHOcl1BjQ/cK0rLr7lZSAdQt126WMprHZIcoBwEk62wuA7C9uDM5WR0vWpVphmWn3ktqmbQCJClSWiQ8TUfSDD+oASgrOb59diSsYLOPQZr/4dYM3ywxgC8Ygvn3R3OReSGEXl3Cj9qRLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565922; c=relaxed/simple;
	bh=1awZfYnEhuJeXn900xprW2cQQ5vSvkNtjpSGpUfYg30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2iB1lL525Cq0gA2trEg72uFrSIOMtzpjjNs8sMpCjOGnoNHPiokklK1rT4IT9V8sFV0yHq5FpR8mc3c1TA5mJ58LWHIFIh/06z26wiRZ9+BnjRjJiXdbreWtEBGm7FxDXw4qUXJUco/xkiYElCMEPlbPOyE3MY+ivwapL1bYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsD6lvDj; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsD6lvDj"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b593def09e3so7343a12.2
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760565920; x=1761170720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1awZfYnEhuJeXn900xprW2cQQ5vSvkNtjpSGpUfYg30=;
        b=gsD6lvDj9u2egX88qssXqe1RBW3eATgTIK/LnCEZrrWtLD7sTeixUu2LEzl4moz17F
         bGSFYuSAyvqXVdg4nDkEHWT22vbRPdKgmpxGirExckAEiTVmGbX/M1qUq58zCm+hRZkx
         cN/BNoIZwmYZlFPfSLKVlB2xBirJaWJGC4Jn6OagB2RmrZ0bSz419AWy69z/johKfNWq
         HxXbakANcE3vGQQhwIEBeWXRMSSn1XtvwGVMNMtGLuN6rkRYPhSIzURlrYRaXSR+5WYw
         fYKV26b5GecklP9brKJmeWPJm3oTgYJPd8jJOZs9D3VV4WQKFSkX4HfqzhijRpdh68ba
         +bng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565920; x=1761170720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1awZfYnEhuJeXn900xprW2cQQ5vSvkNtjpSGpUfYg30=;
        b=ksz06Ew0JCjgNHpSmTGZ9o0Y/Z2k0X6jqDJk+wiSZN70gvnt/l3StKgmVOB4yN8Zi3
         LVzOzAJPUF7BdHlLpLdo83EfB0CYnc8LxHaT4UQeA0cBJhXQ6q59+pQhQOoBeifXUygg
         Ib2RZNfAJUynDXP88f2UoLQ+09d8j47v/DYKM3iMjKPvHZjzqN338hgtHzv4ylW0ttyH
         EB0xMemOqO2FOlhUK0YKCPSJb9okzk/xp3WYdajqHkWCEmGzDzmIAaTObSw3ZhqZxBjf
         +q+k7g9GPsao6vVHmZpht9epBZw3cvOTx9SizOinyPnQ/MIKM6yOiWtAFtLNSnS5acmo
         BKFw==
X-Gm-Message-State: AOJu0Yy5Yr/zmu+QC0Y/OZxa/O+YZWuZSmjFHTFTUpjn4cmr9J4fGdX6
	XsMAPKcsguHgwE0IYROV0mBAVOpF0TMbmPFWg+351f75IdZ/nYRS+2v6/WkoSH3ygZq/j1Y01po
	Ojov9hWBwo8lYHG/V6jzoZuTLGPyxedI=
X-Gm-Gg: ASbGncvjSXVnVR37E3/D+DeN9KJ8gEaSqE8c6fR6sr0kt8Uf/aqIqZIC4tv4kAnmk67
	iOfp6hdAz6it8QzjB58Jy11/7cqT6m0SWYupmPvL1zgoH4dy2KPPqBrHEDQyTlKxohGeL0qemPG
	ZXnzDbuQv10U2Ofhphpsli1x/dwrXjRy4LyF0V83gsqwyW15p/O5sgy7ixCNIhp2Bv123uGRhC7
	K9WPn++zj8A5Pa957pvIg8Chc0nNhgZSGv2bJoIoqY788M/TGvx2zKLxo/kTFX8yXNwGMsV5Ng=
X-Google-Smtp-Source: AGHT+IH/QRIGEQGVlCpXwjFe+RrJXV8PqBEw5LGraAPovmdUuVRINGqxEoCIPrunAIHdVgh2iH5nOXJAV5bYd+vmn2M=
X-Received: by 2002:a17:902:f650:b0:28e:7fd3:57f2 with SMTP id
 d9443c01a7336-290273868bamr405700025ad.49.1760565919845; Wed, 15 Oct 2025
 15:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760490943.git.belkid98@gmail.com> <CAP8UFD1paGeMQZ6oOHau4YBiSC8U3csWHFdOx+ro-8xOO+0wTA@mail.gmail.com>
In-Reply-To: <CAP8UFD1paGeMQZ6oOHau4YBiSC8U3csWHFdOx+ro-8xOO+0wTA@mail.gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 15 Oct 2025 23:05:20 +0100
X-Gm-Features: AS18NWBfp5AluYzj1UD79faq74X1WkN_4PRiZNcKTFgBLJQgSQp58kTrMXoCGQw
Message-ID: <CAD=f0L-QmCA1EEXAWMQhsdXhQkwLkBi2VOZ53OE6wwNKpW57=A@mail.gmail.com>
Subject: Re: [PATCH 0/2] [Outreachy] gpg-interface.c: use string_list_split
 instead of strbuf_split_max
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 16:40, Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Wed, Oct 15, 2025 at 4:19=E2=80=AFAM Olamide Caleb Bello <belkid98@gma=
il.com> wrote:
> >
> > The array of strbufs that calls to strbuf_split_max provides are merely
> > used to store the list of tokens gotten from the split and no edit are
> > done on these resulting splits making the strbuf_split_max unideal
> > for this usecase.
> >
> > This patchset replaces these instances with the modern string_list_spli=
t
>
> A cover letter like this should be used to provide broad context for
> the changes. So if there are there patch series or merged commits that
> started doing something similar, it would be a good idea to mention
> them or give a link. (To properly mention a commit, you can use
> something like: `git show -s --pretty=3D"tformat:%h (%s, %ad)"
> --date=3Dshort <commit>`.) If there are mailing list discussions were
> the topic was discussed, it could be interesting to mention and link
> them too.
>
> Thanks.

Okay this is noted too.
Thank you very much for the feedback.

Bello
