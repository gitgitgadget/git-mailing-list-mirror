Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD7F39FC3
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KGOwRALQ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-77f3183f012so52593385a.0
        for <git@vger.kernel.org>; Fri, 15 Dec 2023 07:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702654679; x=1703259479; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D47SlVVhvtKR6uSe3fgM5+65R+eX0UMWRos2jjilPek=;
        b=KGOwRALQaC9rwlVL581Zm55ttL2zmnMeef2V6BXn3936fwLmZnJC5D7tb67fViUo2r
         Vh7eeDlJUqvKhEKP2pRcap0FIGUqWCu4qcPohSTv4aNJD1YGrIuq6+uoBBhMFdBCIehM
         Wfiv1U+IPl/4v0ZBjjtppVgR9b7gcMeex4U2CKZdVdno2/USpBoplELHa1RKEKskLvRH
         brh3mdrq7HSWkE1Tpc+lBNt3Otb5z6dG2B3Nt0Nfik6EwRNqIZ2vZ+YVSBw4x/VAJ1Vh
         Zy/xXbXZPfL0ULRZrwubnu4mHACE16SJycWpt5RwP1Huspj2ZH7zX2FCBAetJAVpzv3h
         j5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702654679; x=1703259479;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D47SlVVhvtKR6uSe3fgM5+65R+eX0UMWRos2jjilPek=;
        b=dNzmd6FyFG/vlJSqVIkGTihYYUgGsRozzZYX2gFGTjPxS7lCnzfLhCNCIIOwUOX1Qw
         p5v4Oq/OZPML7/6+YAAsrVDGSkcPxKlrQtp+7OD03qXpap6yIl+QvXjy2d7gSVYLS1xg
         PXLUwiXu/TTCPfSn2vMT9qTGi4v6rokn6MSwm5iMrjpaEPIOSrouVkzE4Fi07S86ofgg
         m33FDDbmIyv1251ZGq36u+URkTy8I8G+e+rolBV7XpyofH8OAoP7cLn8dXzB8oZeaGWY
         d9p7anmnjgTvkZqSdRzfeAJxcJAWDIoUxEaQ6gjxD/o5x35i8/QCOjrXfxM+SWDdRBaj
         mUdA==
X-Gm-Message-State: AOJu0YxcJm+T4dwGFc3yf+77Xh2NwkyhZnD2TwDl5lZkOhM6vpEC9kG1
	nH5MP2zl/4fWOxJcMPGQh4hOcg==
X-Google-Smtp-Source: AGHT+IFhoInLTJafxNzZuEHP2JMMz6Nf1bHiHgCux5pp5I0hK7R5ogSIyXQ+U6i8ApLYoo+0K9gBBA==
X-Received: by 2002:ad4:40c5:0:b0:67f:21a:d4eb with SMTP id x5-20020ad440c5000000b0067f021ad4ebmr4080884qvp.43.1702654679065;
        Fri, 15 Dec 2023 07:37:59 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7-20020a0ce607000000b0067ac431a369sm3034015qvm.17.2023.12.15.07.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:37:58 -0800 (PST)
Date: Fri, 15 Dec 2023 10:37:57 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/24] pack-objects: multi-pack verbatim reuse
Message-ID: <ZXxy1USjjjAbBi++@nand.local>
References: <cover.1701198172.git.me@ttaylorr.com>
 <20231212081238.GD1117953@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231212081238.GD1117953@coredump.intra.peff.net>

On Tue, Dec 12, 2023 at 03:12:38AM -0500, Jeff King wrote:
> So my question is: how much of what you're seeing is from (1) and (2),
> and how much is from (3)? Because there are other ways to trigger (3),
> such as lowering the window size. For example, if you try your same
> packing example with --window=0, how do the CPU and output size compare
> to the results of your series? (I'd also check peak memory usage).

Interesting question! Here are some preliminary numbers on my machine
(which runs Debian unstable with a Intel Xenon W-2255 CPU @ 3.70GHz and
64GB of RAM).

I ran the following hyperfine command on my testing repository, which
has the Git repository broken up into ~75 packs or so:

    $ hyperfine -L v single,multi -L window 0,10 \
      --show-output \
      -n '{v}-pack reuse, pack.window={window}' \
      'git.compile \
        -c pack.allowPackReuse={v} \
        -c pack.window={window} \
        pack-objects --revs --stdout --use-bitmap-index --delta-base-offset <in 2>/dev/null | wc -c'

Which gave the following results for runtime:

    Benchmark 1: single-pack reuse, pack.window=0
    [...]
      Time (mean ± σ):      1.248 s ±  0.004 s    [User: 1.160 s, System: 0.188 s]
      Range (min … max):    1.244 s …  1.259 s    10 runs

    Benchmark 2: multi-pack reuse, pack.window=0
    [...]
      Time (mean ± σ):      1.075 s ±  0.005 s    [User: 0.990 s, System: 0.188 s]
      Range (min … max):    1.071 s …  1.088 s    10 runs

    Benchmark 3: single-pack reuse, pack.window=10
    [...]
      Time (mean ± σ):      6.281 s ±  0.024 s    [User: 43.727 s, System: 0.492 s]
      Range (min … max):    6.252 s …  6.326 s    10 runs

    Benchmark 4: multi-pack reuse, pack.window=10
    [...]
      Time (mean ± σ):      1.028 s ±  0.002 s    [User: 1.150 s, System: 0.184 s]
      Range (min … max):    1.026 s …  1.032 s    10 runs

Here are the average numbers for the resulting "clone" size in each of
the above configurations:

    Benchmark 1: single-pack reuse, pack.window=0
    264.443 MB
    Benchmark 2: multi-pack reuse, pack.window=0
    268.670 MB
    Benchmark 3: single-pack reuse, pack.window=10
    194.355 MB
    Benchmark 4: multi-pack reuse, pack.window=10
    266.473 MB

So it looks like setting pack.window=0 (with both single and multi-pack
reuse) yields a similarly sized pack output as multi-pack reuse with any
window setting.

Running the same benchmark as above again, but this time sending the
pack output to /dev/null and instead capturing the maximum RSS value
from `/usr/bin/time -v` gives us the following (averages, in MB):

    Benchmark 1: single-pack reuse, pack.window=0
    354.224 MB (max RSS)
    Benchmark 2: multi-pack reuse, pack.window=0
    315.730 MB (max RSS)
    Benchmark 3: single-pack reuse, pack.window=10
    470.651 MB (max RSS)
    Benchmark 4: multi-pack reuse, pack.window=10
    328.786 MB (max RSS)

So memory usage is similar between runs except for the single-pack reuse
case with a window size of 10.

It looks like the sweet spot is probably multi-pack reuse with a
small-ish window size, which achieves the best of both worlds (small
pack size, relative to other configurations that reuse large portions of
the pack, and low memory usage).

It's pretty close between multi-pack reuse with a window size of 0 and
a window size of 10. If you want to optimize for pack size, you could
trade a ~4% reduction in pack size for a ~1% increase in peak memory
usage.

Of course, YMMV depending on the repository, packing strategy, and
pack.window configuration (among others) while packing. But this should
give you a general idea of what to expect.

Thanks,
Taylor
