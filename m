Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C726F156C6A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096106; cv=none; b=hpVFnlirUGpz46x2nm3Ep9Kqau09VlFRfxxcCcSrQY6Xm+MOkRwdPwvsB5ZmQGRGztRvXthFrnBERb4b/TXzkmvLc9ESyrBmZgD3S79dgetB4uqwJwyk5efESi9E5JtCNaob/WcYpTk8vD+61MJk0bJqgm90NufTyvWMODh6s48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096106; c=relaxed/simple;
	bh=AWJkrHo2srivaMspCwiqlY7/BK1/tIDiJgA97pq1+Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJapUGqlHcwMsvEZ6fMfPSj3Eu2j300d4qixBGQI5moFb2y4aeas1JjxDS3zf3x2O0rolATYoCDGB6YsHbjKZCVwjoHePQDLLwCYzR8a86tgyoWgCd+2RJi7lT6BEOYOOJMM8kWnQYb98NralKe87+irVo6sY78bsNd5YXi0CuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=CBcD5YSK; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="CBcD5YSK"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so5161514a12.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1761096104; x=1761700904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krgpOqfhb7WGrCWrjXvaRLBe02mJxiv6EKYRlpB7GHs=;
        b=CBcD5YSKNlAWVSgiW0FLgAdATEP6UHTJiSwiuiE5gd24nZZ1u32pYUXr2fmK4+CLnZ
         61kcVFwoZbipH1YYqCwn5VlDT7SLld2/it2C0wbOlKOSF8yVTmh7Ywg6RANKPW6/eJYd
         6W6WLoVv002eASNwqn+arg/tL+Ds6fg3ScN9c1WABfbuzusthIO6mttnBwaxLjDB2zR9
         6cT381IUem5E5xMNaFPzOQ32d8oqhgqgPIsAWfjJPEpMmABotVYG+WWzphHGdy+GDbxc
         lV5Uvbn9NSoceA1c0uap6bTs9+gVtJkuoSpeBrIESYB1Ij01M42YGYrzOYHB0sy+QAF6
         4ocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761096104; x=1761700904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krgpOqfhb7WGrCWrjXvaRLBe02mJxiv6EKYRlpB7GHs=;
        b=ts941qtb2uQLWKKkq5zt+GqPGmT+iWrCiJftdmA0dC/vkFj6euHN7AlSj8woZpzqI2
         zXW7bLbbg5oTvbNnM4qY1vpKH6ygc+GA7pRKUg2AH4eP4ANEZdOHZAxZYRjsU6CdgkPH
         d0CN330XSieTr2bGAxKoAXlrc5/X3YgBSTXGDY6j0sq/nr6C5hXggzonA1mWjedwS32Y
         YVWvq/Vy5y/q3yPKjgFlwhGNpkm+sWwzeyfEMT16HjdJjQqRzhvV4rtGLhYa2+25ddnN
         v0le2UUBOGSoSzIyIu9ckEUKUMd9PvLMV4pEZ6OYhFjjar7k8iSFtOhjmjN27/f+P1Q0
         kqbA==
X-Forwarded-Encrypted: i=1; AJvYcCWew5Yf479aLYn5uTLBF8O+vWqd/mtAOESvKheeUSh+2TShcD4h9F5oyuSTmxDcDZ4r2ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeLJB0BfOetWbFqZBsBZG9kZFVI1D9VHY2qHM+L13QYWnncL2
	llcVJTSrIzX5PrLLXWnWbwadJLj7BNSowJFzvHyqDGyB5dy7SWYpcSF597Z1ry0t6xciFrn1Wn1
	7cuTjVz8EXglw6Fvmvictqvbil57fSlzDlXWB8pDzl435Tmpy3eWCTLBPbgXNCzDNw17Un6QALI
	JjXvt8VNybbfgwzOrvUaD385JkMmL1ZM2qETUD7p5XjYBQXbZWKTQsVXulq8YyT+ukOdLo6E2oh
	1QV93/lzPzsjGgJ5GeA5VQkT03SExI2UB59fU1ibXYfEFLA1od/nzsGIz5930LzNssYGG+t09Ah
	yK1owdnRXb5cmyw=
X-Gm-Gg: ASbGncuyowt8CJXYBn7T6ehWxaKhxe9OmO9nEOGwmdpDEiksZzvsbLj7Uio1KLKYflJ
	3Pd4xpDGboOzLVoAe/TRRV8/8UZr33HdkFRWkwPy9jmAm5HCAW57KzGaIzDP7+U4v1+yZGYgx0M
	i9tR/DNL6olm/HU1szBhFil+cZkqdHoSn8cwByDfSWfPwXJaoR5uNrgCRrz91Pz8YLwX2Gegpx1
	sQcUQAnVd2piqEBLTeGfF3TpPgZGqXQEZM68VpKUEINl8lve/qFwChWGflQpgNShHo6REj+w2LZ
	njOKAWw=
X-Google-Smtp-Source: AGHT+IHcZb5Ccvw83JagVmEXp1ce2J7nwdoNkFEfJGsi6fJqi5r2f/eVXgq4GK/cXgaz5mo1OtRnLG852T3vfiMiPQg=
X-Received: by 2002:a17:902:ced0:b0:256:9c51:d752 with SMTP id
 d9443c01a7336-290cb65f0e5mr267952125ad.56.1761096103924; Tue, 21 Oct 2025
 18:21:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1993.git.1760999702581.gitgitgadget@gmail.com> <20251021080625.GD259661@coredump.intra.peff.net>
In-Reply-To: <20251021080625.GD259661@coredump.intra.peff.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Wed, 22 Oct 2025 10:21:32 +0900
X-Gm-Features: AS18NWATFqWhi--iBwv-UfQzcWQQWp2HSnVd9zPnbIpp3KyqltQeuYRodYMHy8Y
Message-ID: <CAOTNsDxoSFTBwaO0Eqr+r0NQOwdA2Fge3CN7JQtnAWEt2PnDew@mail.gmail.com>
Subject: Re: [PATCH] macOS: queue for munmap operations
To: Jeff King <peff@peff.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for pointing out many unusual mmap calls and other details. As
discussed below, the root cause was simply my ~/.gitconfig. This patch
may be useful in some rare/edge cases but a somewhat unusual hack, so
I'm withdrawing it.

On Tue, Oct 21, 2025 at 5:07=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Mon, Oct 20, 2025 at 10:35:02PM +0000, Koji Nakamaru via GitGitGadget =
wrote:
>
> > From: Koji Nakamaru <koji.nakamaru@gree.net>
> >
> > Executing many mmap/munmap calls alternately can cause a huge load on
> > macOS. In order to reduce it, we should temporarily store munmap
> > operations in a queue and process them all at once when the queue is
> > filled. When the program terminates, we can discard any remaining munma=
p
> > operations as corresponding mmaped regions are automatically reclaimed.
> >
> > Add a queue for munmap operations to perform them all at once.
> >
> > Here are some example timings. On the Linux kernel repository that
> > requires about 1700 mmap/munmap calls:
> >
> >   time git ls-tree -r -l --full-tree 211ddde > /dev/null
>
> Why is it doing so many mmap calls? Do you have a ton of loose objects?
> We have to mmap loose objects individually (because they're all in
> separate files), but each pack only gets a single map (well, there's a
> window parameter, but it's 1GB on 64-bit systems, so you should get a
> handful of maps at most).
>
> If you run "git gc", how does the resulting ls-tree perform? I have only
> 27 mmap() calls on my system.
>
> I know that running "git gc" is relatively expensive, but it is also
> bringing other optimizations (like the fact that we don't have to open()
> and map each of those files in the first place!).
>
> > On a private repository that requires about 943000 mmap/munmap calls:
> >
> >   time git ls-tree -r -l --full-tree xxxxxxx > /dev/null
>
> Ditto here. I'd be curious how well packed the repo is, and how it does
> after a repack. If it has a very large packfile, you might also try:
>
>   git config core.packedGitWindowSize 4G
>
> or similar (though for just an ls-tree, we should only be looking at
> tree objects, which in general I'd expect to be in a confined area of
> the packfile; so the 1GB window is probably plenty).

Following your suggestion, I investigated the number of mmap calls in
other environments and found much smaller counts. I tracked how
xmmap_gently() was called in packfile.c and found
settings->packed_git_window_size was different between environments. My
~/.gitconfig defined "packedGitLimit =3D 128m" and this caused many calls.

> > +int git_munmap(void *start, size_t length)
> > +{
> > +     static pthread_mutex_t mutex;
> > +     static struct munmap_queue *queue;
> > +     static int count;
> > +     int i;
> > +
> > +     pthread_mutex_lock(&mutex);
> > +     if (!queue)
> > +             queue =3D xmalloc(COUNT_MAX * sizeof(struct munmap_queue)=
);
> > +     queue[count].start =3D start;
> > +     queue[count].length =3D length;
> > +     if (++count =3D=3D COUNT_MAX) {
> > +             for (i =3D 0; i < COUNT_MAX; i++)
> > +                     munmap(queue[i].start, queue[i].length);
> > +             count =3D 0;
> > +     }
> > +     pthread_mutex_unlock(&mutex);
> > +     return 0;
> > +}
>
> Does batching those unmaps actually make them faster? Or is it just that
> the commands you showed did not fill the queue, so we essentially just
> leaked all of those maps until the program exited?
>
> If the latter, then I'd wonder:
>
>   1. Does this increase memory pressure, since the OS has no idea we're
>      not actually interested in those maps anymore? Some of them can be
>      quite large, if the command is looking at blobs.
>
>   2. How does it perform on a command that actually fills the queue? I
>      guess something like "git log --raw" might do it (though if my
>      guesses above are right, you'd need on the order of 64,000 loose
>      trees).

In my extreme cases, this batching makes them faster. Queue flushing has
occurred several times for the private repository case and not occurred
for the Linux kernel case. Though I haven't investigated in detail,
memory pressure doesn't seem to be critical (and it could also be
possible to adopt smarter thresholds).

I tested git log --raw for the Linux kernel repository. For reference,
the results are shown below:

  without "packedGitLimit =3D 128m":

        mmap    9

        # without batching
        real    1m3.970s
        user    1m2.232s
        sys     0m1.725s

        # with batching
        real    1m5.991s
        user    0m58.637s
        sys     0m4.315s

  with "packedGitLimit =3D 128m":

        mmap    3072538

        # without batching
        (It took too long so I stopped the execution)
        real    518m6.928s
        user    0m41.126s
        sys     517m24.072s

        # with batching
        real    2m26.276s
        user    1m8.495s
        sys     1m3.230s
