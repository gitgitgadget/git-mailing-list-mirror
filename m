Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F428A2D4
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739472340; cv=none; b=OA5O7Wx6wLktxnucACmqp6peSVE/RUihRS5WOl2oKSN2MAE7AFII7EcU7vNgPMEl4yi2NsZpJ8EpZKpLNy36vuepBd5hqqx6ikYL1bvMR7CjPMgSfA1jiLx0wvLWHQGwJLTSrvXUCTdBR2nCXEoNsmlwNRU53r/eisommVeAiPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739472340; c=relaxed/simple;
	bh=T2vWcFinv2pEg+nxSMssPa0Z7A6hDMM0F6UAJl9WCF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXbRyVFkZSlJdauDMKZE6+R2fPR7TCyqPsRl5VZTtFriNh2zoCQB7E/0B2EfBP+hywnSgNWP2mJXLhkC1xKwFlXGtv/UkuCkNgDj0k1ju0315/a5dBFidCNf7VzAJmRCXOmW6lPR61ecT7HaynppW3qB3ovNdWzs0u4/ACqY3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QatFyfO9; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QatFyfO9"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so9380045ab.0
        for <git@vger.kernel.org>; Thu, 13 Feb 2025 10:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739472338; x=1740077138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYzKAvumf24a4t7HKxVmdIetb18TBLlj1D4zYvPZi9A=;
        b=QatFyfO9meN2e1j1xmmX6c9O28FYyQJO4/0jIQ1/Z3hxRDj3mz3Zamjyxv8cmpfWw0
         mOn7nmLYxWfHAnJLK/vayYUFid3Jn7nHxBtDDPyYKs13osv8JQ1+4c1/EFASi2zNrhnq
         5drLFFlIZewvowxlFzX3uzvN1YFuwDFkaGVxu9GFY3lMgsOEyHkfsGRPf+TjHjgLjWiz
         7NtuM06PV33cD+KPIjd3Bu7cKA76SlaY/FZ8IyytOZ79Qal43abCntCEQ3lcRCAHrc5E
         5cCb852j4ALteHKvBXy4yYqhmVuu+t/j9xrxrce/Ttp2bYJzfe/V0z1Zq0kXYt9x4sHR
         oYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739472338; x=1740077138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYzKAvumf24a4t7HKxVmdIetb18TBLlj1D4zYvPZi9A=;
        b=oPze8njhgXguJpyQ8j91sSi6KB8R3EgA0P2VKtOoC52A5GWQc/ugQauYeFtoFSIX25
         tsxl49IAKtGEMxB4dg/67OqJq6JWoJA5Ig6ZDhS3j5LCQsxPxpz+BpoO2RlsIiXXMZOc
         feWsV42HKTYoRB2R8mDqt2Bkzt/UhJyjkIzE3RWud4rjDkiqb3WJCy3yeogSjf4/YbZN
         yb9p9l8tHY5CjnI5eg7Qj086DHNLnPX5wESWsd2gaTGD1QrXUBcLQ5KXeE78ufAlc7uv
         /2DKyMnmGncgkxmUsV5N0tboyg9vint9sw+I5XHW2lX6x4ZVnvRKIlxCeVLUg24+t7Xx
         WyGg==
X-Forwarded-Encrypted: i=1; AJvYcCV0g2ID27+LE2BBcX8GpJEyvYy3XJnub0axfyn6a0R3uPoSwL3b5654zrJZRul2oxP0Yk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqODmyXPEeT6uIQBb/YtvCo3rlWAwt88q15eBXE8ObTsHs6MuU
	tbSgiRoVxTKGAbpl/kyo1LtWmzC3xxVngFAQkEoF+j/Rat53kjNg5e3kb5Z85GX7fSGM3aKBOy/
	mgWsTBIkyH6idb5hNxqCffdaZER8=
X-Gm-Gg: ASbGncsL7iwUEHG8VdvANLc8ZGKInGega5DrpxeeKMyaTvKAMMVfZyb1cqodF8F9euR
	1rMreYPnOc9QJ3lP4DuJn2JKUMBg21Qc4nVQ7AkjAIXoQlP/Tig8vZxGe7B8z+P+3+UAFAV1YfL
	ZBAw8g+RdYn5igohQ9IBLOBQ9ThWbKVA==
X-Google-Smtp-Source: AGHT+IEPa7e9RWudcnRdP7dQoSyoOxqji2IjFbS+rbtdtlAnGTxXsUTpg7YcPAWvBKzaGaJMoua1O8kgJRRejIcD824=
X-Received: by 2002:a05:6e02:308d:b0:3d0:1932:7695 with SMTP id
 e9e14a558f8ab-3d17d092d3cmr77770155ab.8.1739472337846; Thu, 13 Feb 2025
 10:45:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211194334.20710-1-meetsoni3017@gmail.com>
 <20250213090040.16133-1-meetsoni3017@gmail.com> <20250213090040.16133-3-meetsoni3017@gmail.com>
 <CABPp-BGqihkPq3o4jnqp2aGdqw12F8a8nOModuAB-5N7BQ1t0w@mail.gmail.com> <xmqqwmdtofxh.fsf@gitster.g>
In-Reply-To: <xmqqwmdtofxh.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 13 Feb 2025 10:45:26 -0800
X-Gm-Features: AWEUYZmy-jQzPtkvdOeCNCW3Gqhaaqt7QE17EC52UKJMANoyWP57fCQBQ6ZASB4
Message-ID: <CABPp-BGkWsq9tKk1ytHfP=GP6z90dioqDVgKuDB+N2EzjtWfDA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] merge-recursive: optimize time complexity for get_unmerged
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:30=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > (As a side note, due to the specialized structure of the input, I
> > suspect this code could be modified to run in O(n), i.e. we could skip
> > the string_list_lookup and the string_list_sort and the
> > string_list_remove_duplicates...
>
> Are you talking about the input being already sorted so we can just
> walk the multiple input and merge them into a single stream?  In the

I'm not sure what you mean by "merge them into a single stream".  I
think you have the right idea that we are creating a string list of
information about unmerged entries, and since we're taking information
from the index which is already sorted, we can just either modify the
last entry in the list if it matches or append a new entry to it; no
need to walk, insert, or binary search the list at all.

> cost analysis you did earlier in the message I am responding to,
> being able to go down to O(n) sounds really like a great thing ;-)

Note first that we aren't going from O(n^2) -> O(n), we're only going
from O(n log n) -> O(n).  That's still great, but:

  * n is typically pretty small (number of unmerged files)
  * there's things in merge-recursive that are O(m^2), where typically
m >> n (number of files in repo, or number of lines in big files in
the repo)
  * merge-recursive is used by almost no one
  * we are planning to delete merge-recursive

So, although O(n) is great....

> > But, it'd make the code trickier, so
> > it'd need to be carefully commented, the change would need to be
> > justified, and it'd need to be carefully tested.
>
> ... and measured.

+1

> > Even if we weren't
> > planning to delete this entire file, I suspect it's not possible to
> > find a case justifying such a change without optimizing several other
> > things in merge-recursive first, but optimizing those things probably
> > results in a significant rewrite...which we've already done with
> > merge-ort.)
>
> Sounds like unless the performance issues are shared between the
> two, it may not be worth to spend too much brain cycles only on the
> "recursive" one?

...yep, exactly, and this is not a performance issue shared with the
ort backend; it's unique to the recursive one.
