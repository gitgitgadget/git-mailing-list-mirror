Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55633D1
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734873774; cv=none; b=I969Qq1xslDKm0BLOtaYbgxT67wSw1sw6b0Ec9PkGnEsVUvqYYG2S1HzsiCqCMGMZIsWpH1K5jnC5eBIr3vRqCmljKaV+6ldlnHpXB5x2FKOwxwbSun6Fjx+rTkKU9ePphjKi+0tNAsmpFBCVaAHASvFBnFKXwkmwHGmqSi3eXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734873774; c=relaxed/simple;
	bh=4zT8sk+OCvqM7hPfwdVonAlOJHAyC93Rl49zs1bBW/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMrFzI0LMkC10fhfgueknCuWpd+kEHb4dRpvW9G1X95sHd0w7lijSSD+76n5msY3751S+grY66mj9NFa3A9oWrmKTgFgXjoZxl+YHZzHyyiMj5Wnvu8LSK5vOizH5MxplopLGFap7xktF5wLSJh1C+UOws4lxizN4zQ0sq4SSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYbVV5zl; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYbVV5zl"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3c8ae3a3b2so2459223276.0
        for <git@vger.kernel.org>; Sun, 22 Dec 2024 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734873772; x=1735478572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4zT8sk+OCvqM7hPfwdVonAlOJHAyC93Rl49zs1bBW/s=;
        b=EYbVV5zlOJyC4tC9+t+K/KxwzArt/Y6SEz+mFz5Lvv5wIOc7+5Dn4FVn0hd4f0+RP+
         44MrDoeMal5/btH6cV870BP2LXYVp2O09+a9zqnXwCZ0ra27MKaGLfAaDvsA1Mu2QAIB
         Rqg2YGVP9LQPe6f8y3k3jqoK73Z6+D8xASPtdo4kXeywcQ8+67cxg9cCMH+MCpEPmWsE
         +f+6yqFYbdQtW5hSuWCaiu9ICIVRbZ31FGqAUU0CGTJyuatfaJuCseGgdqeTUxJ42xje
         NA4lWvEY3VPlrKx96NVz6cJGRkEQZ3VWY9RIK4qOPBBqcjRGeziHk1yqqQ/bLYY23yZC
         jiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734873772; x=1735478572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4zT8sk+OCvqM7hPfwdVonAlOJHAyC93Rl49zs1bBW/s=;
        b=tT2rUvbTiAflrN16XRy7oGS6160MJ3v1RX29AHD+KTi4IQyIpXogV6VSCm7om/RhQQ
         qWICsGAOTukq8DadzuEjFmDNso10WgDa7aXHZCfc52FluxY4d+y7k+fY59VdGB4DsFhu
         pDhl+GiJCOjBKA+rtEHtmWP96TCByFlix51DjgI5prJkuD8OMSpRv4HShPncHaAJstaT
         q+4QTjKzJioa1ie8nYNKnkAADXkDE9oOtYAwkaH9dWk0yiEASZdVbyJNJ1gcr9zU1udF
         T9xb12PWgIe5vvDdIdF/wjoMPr2wIjm3or1Nr+TI1sRwsCz61RfHXDBJHdcd1U7AwGm5
         w6NQ==
X-Gm-Message-State: AOJu0YygtrnwS4WPnzWd+brsv6klD2V9y2xlsnDPUYKebB0fQVpB4/sc
	T3Oj7GE64fYUNrjm6gj8BYgtgAHrooJQ8wVSwXBWbATtUH3LpffEPxWkKVYGmN70KI46CM/CAJ0
	1N1x03wnq3uyYG5OEwiEFkzqrA878LlaZMd38yQ==
X-Gm-Gg: ASbGncvINTLimoF3J1xPlm6sNTJcOcTcVeVtPqG2tsU9XeOUXA1CW9X+5PYpCOBjq9+
	GC2PYzkUvXoNlGPCIYRy2vcKddwEKbUqH/l3/3A==
X-Google-Smtp-Source: AGHT+IHfS/7R5vzO3v48NXNH6krNpVFzQbJfjJFj8u6g+bJ4SR/7xuKBmBTfSBRntP88tC+oLxK2dr3j5eCCZz6PYAo=
X-Received: by 2002:a05:6902:230c:b0:e39:7a90:eeb7 with SMTP id
 3f1490d57ef6-e538c26f65dmr6949727276.22.1734873771762; Sun, 22 Dec 2024
 05:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGedMtcSSkmQ2u9yYvKMiWnprWR2VZrbuoT9EX+U6nuxOWiEHw@mail.gmail.com>
 <CAGedMtd9F3tZXC-z-5=csELdPakzFS=QU-e35So3Og_ak0mq3g@mail.gmail.com> <Z2e-T0NZzrMwEvmd@pks.im>
In-Reply-To: <Z2e-T0NZzrMwEvmd@pks.im>
From: Seyi Chamber <kuforiji98@gmail.com>
Date: Sun, 22 Dec 2024 14:22:38 +0100
Message-ID: <CAGedMtfDMj5P0T6x3soe3OUhRbpSw_-m1Vcm+rhDat1vvReK9w@mail.gmail.com>
Subject: Re: [Outreachy] Blog: Introducing myself as an intern working to
 convert unit test to use clar
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Dec 2024 at 08:23, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Fri, Dec 20, 2024 at 11:37:23AM +0100, Seyi Chamber wrote:
> > Hello everyone,
> >
> > I just published a new blog post on unit test scripts I've selected
> > and prioritized for initial conversion to clar. I would love for you
> > to check it out and share your opinion!
> >
> > Find the link here:
> > https://seyi-kuforiji-902b48.gitlab.io/posts/week-2-prioritizing-test-scripts
>
> Thanks for the blog post! The initial selection looks reasonable to me.
> I was wondering whether it would make sense to evict "t-reftable-tree.c"
> out of the first batch and then handle all reftable-related tests in a
> single patch series. But we've got 9 of those, some of which are quite
> complex, so that patch series would become quite large overall. So I
> guess it's sensible to distribute the conversion of the reftable tests
> across different patch series.
>
> Patrick

I suppose I could still make that work if that's your recommendation.
I could divide the reftable-related tests into two sets and then treat
them together. What do you think?

Thanks
Seyi
