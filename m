Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FFB2DF130
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412400; cv=none; b=ZJEKxTfHkkS8J1VzLQXmazUOLq330zlB/DkY24ZfVi7+DfbPxYF6fK+mN4kWdWwBLeleexET9SnBetRPN9KhAikzre35v0AArD6utOSpIbRugnmVdvyASMtZ9OyzfEUZfUmXfGZwPdYI2XD6aV+S77oGoEcKleIt5wOMp1J164Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412400; c=relaxed/simple;
	bh=a9Sw22MgLHcJNaXFUqmcahiolU0oFj8l+7VCliHxBbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq3BuLl1ByQCXdrnoIzUwgGTtJryFUoP0Cf/7krahbggTnBNfyzcwqin3nHaF1B612tYhu0PXQJqlCfYWc2tCn4dRNcLHZDHE3/kIVAj65hhDUwXCVmE83ltK4EFu6rRMC73QOdeDIqlzf5Yk8y4OQmjUrj+S9nARh1cnst1hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzzaoSAZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzzaoSAZ"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6c13b68dso1081708e87.0
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 09:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768412397; x=1769017197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9Sw22MgLHcJNaXFUqmcahiolU0oFj8l+7VCliHxBbg=;
        b=bzzaoSAZgINJ90xr+ZbyVwRBLBCEfzWOkF+qOX0iL1mUjl5nJNEDAc+hX8qbSgA2pe
         KCLpLK5ULrSsNSbtQ82qR4zvps2akVK8yKukxo0BnaJ1r05LqyzRaQqW4zIOo+ISHizk
         +GCyOuLqGKbCLma90viuosISNCtgBimAQbwe8bhjOERVZ8s2ny899IzV9DGkYFK6g7jq
         twBBSepbARTLyQqPdA51CVLMHGqWs4LriBwz3rxgbbaMrRaYYYkWMrYNvfbFkxc7X6JZ
         Lwju7wGPnzoPiil7SKgyuJUUoOC2bhWLJEVsKtDFZ0ImMdSbW8YUZVlbUcj7FbtHl6Fe
         s+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768412397; x=1769017197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a9Sw22MgLHcJNaXFUqmcahiolU0oFj8l+7VCliHxBbg=;
        b=t4S1Ndkb1agoyHSyduO7XGQkYOJaOpVMuHbOGQXBJ/TXP04fBx9ykGlIPkdcWimIju
         wKCXtQiNAEEGeVyUGthdF+ifR2oXTnZLIoHZyS903QFBOUvLa/2ZQXxvvY8gFHT21YV8
         KhKgSo2KVp/yNe0uPmvXvwN7t5EEqF/cKPjZ4/fU8fQ9iNgfCXt9+t+JAEWsB9oVN/ph
         tB5fm6KrBdzV5RFFiUIsxyIUB5VO9aVMz3i0LgsCet2KXKkGG9HZBVE29T4vLBtA7aHT
         EqZv1TpQFW88HErvCjrmXU7ZyTyZ1KCKgtzLFJacHvsuWhdABE1hOTUlJtjpsnyK2r61
         l9iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7XumlEY6pZFnYvO+i+SJV425kWfiIrfUBXybGJNDdBpeTaZv/mYuqORuwqwi89W0+kAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWQExTGvpDNfkp0pXdO+bLEwn+W8V2A1UQdzZq+e0N8ZQTqA2p
	PRg/zJFyvb8S5Vagekam/nIJUNkT5ZGu3AfB86grRgl+gnPkPeuw6vOUVq45jrPRSp3HfDKU/aP
	4AENMXGB7KmIoamZAA+dd+BAhtefP9SA=
X-Gm-Gg: AY/fxX7LeGa7YCjLoOfBbtGrtCAUx+tWX72fN0h0SzAw4qLBelPeI5c0aUlpc34NC7y
	l9BLBslwvp0YbxoC3yjMEPkQCabl2c61kEPIB5HZ5JDrJlPizXuD6+H1TNpLvCOzJuLzQEeOK9J
	iD2E2cxgGqKguoxFdspOfl7clvX+6cAHvqWByGtCQ+jTkPyND1QVeExbUkYS9ueveBB1h4zf7K4
	i3Ha8tE6ZhFMWk+s5P6Kq+L8ncprP8C+F1mPmPWbJGZaYUuGYRZV7LRKBmG8oGhleYEN2fkHdEZ
	127pEN45Bu4=
X-Received: by 2002:a05:6512:3b8e:b0:59b:6d18:d777 with SMTP id
 2adb3069b0e04-59ba71a1e2dmr60125e87.22.1768412396948; Wed, 14 Jan 2026
 09:39:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGe2LO0nxXuNNRYS0fk0JuPBDa3UCT8EDJ6G1u4GNW1d9rzRgA@mail.gmail.com>
 <CAOLa=ZT4fQdHqG+1AeviYuLUR5VG33voJk_DU1y0MzhUKBQvvw@mail.gmail.com> <xmqqh5sof61i.fsf@gitster.g>
In-Reply-To: <xmqqh5sof61i.fsf@gitster.g>
From: Rajiv Sharma <rajiv.tilakraj.sharma@gmail.com>
Date: Wed, 14 Jan 2026 17:39:43 +0000
X-Gm-Features: AZwV_QgdUImglaTrkPcmwcOJmCQU8lVs5Ys6JiJCxxwAUM1v30LrPrZtNb_yctU
Message-ID: <CAGe2LO3t3B1g1ARH-LQ9V0UoGmToO-Z9XYpeMOTKkaSQvCpaRA@mail.gmail.com>
Subject: Re: [BUG] Git push sends too much data unnecessarily
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the great explanation! You are right, it's not really a bug
(because there is no correctness problem here) but it surely is
suboptimal behavior.

> This boils down to how Git negotiates between the client <> server

I think that's the crux of the problem here. I don't think git
negotiates in the push path the way it does in the read path, i.e.
there is no process of client-server communication that involves
gradually arriving at the common base (in this case it would be C3).
The read path does this quite well (using something akin to a skiplist
IIRC?) and the common base is found in a couple iterations in most
cases. I am unaware of the historical context behind this difference
but I assume the server sending unnecessary extra data during the read
path would be much more expensive than the client doing it hence the
push protocol is kept simpler.

This kind of negotiation _could_ be added to the push path but it
would be a breaking change. I read somewhere that there were plans for
Push Protocol V2 (in the same vein as Read Protocol V2) so it would be
great to see this improvement making its way there!

Thanks
Rajiv Sharma

On Wed, Jan 14, 2026 at 5:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > So it sends all objects required to create the reference, in our case 4
> > objects, in your case GBs of data.
>
> "push.negotiate"?
