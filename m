Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8DB211A24
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744821641; cv=none; b=Hmyf6f9Mb3A2umSjl4uL7wf8z/J8YXYGz5w1tR2OKjVLaknlALNSQMTcPHy7P+slOlFufVjX+HXpZLV3ZBBo6iwa/ccpAGGrjU8oVsLtF25dtdNsqcmnUKdDBpaJqBDL4WduuUgsO3iQcLrRUxHokc5TUrr7B3aYQz6pdyPg92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744821641; c=relaxed/simple;
	bh=2+Il/dHTKHUyrupJuM/FK7DufXPJixIVDXb5wx9gS7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYBRAPQFtG8kCOyoV6qrj0oGJpY7LI2Si4cPHtW6rvGlnjSiKEO9Q9tXdT+sm3W6raUv/StWAXkj1k4QPEZnYoz3TBoORzWYgFtXPoWUlc4Y1SdT6m1CR38smJDme7IzTJL7IBGhF6SLukVl/BJyBNVOUjuM9jcKqhurnX4TeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1ah1eT6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ah1eT6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0e135e953so723988285a.2
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 09:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744821639; x=1745426439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fuw0NCI68S65OVbWCDyAyPWZZeTzpDrwyqPUdCjn7uQ=;
        b=Q1ah1eT61iTVcTnUuu28gIyf1lIzNJcEH1/fWejwlNOaWt8pjtXgkKkQruWh+/edIx
         NddwRqChIETxVPbdQlueE6M6d+pKMTZL+d14Sdxi+y7wedgtw9qp2Cd1CEYpEoGLPGZV
         oz7rUXD8HwG1icOJBqEyIogSCqufB7umapDXNzy2H78zDocImjIhr3DDgLDvBaokEgtT
         dYJb2h8Uy0bxSWK+gWqybeFUisWAuxPgCn5taiTXYdDJ7MZcCB8t2kT0BJuiPz3dItLQ
         td6OTLAulCHNcL14n7PSsU3zWqXBCXi7Y9HNZlMvX6U/+o3qfPWl+SEUmm61/7Y3l/32
         0moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744821639; x=1745426439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fuw0NCI68S65OVbWCDyAyPWZZeTzpDrwyqPUdCjn7uQ=;
        b=uTeff5fmI1gZz8+idSelY1Ct2XG8qpCpKCtnqUy2wb1I+r10ARK4vHyU/PB1tG7yXH
         uZ+psFuy8nqchiajHNCRi/p0voy+sBFhl9FdgudYLWSJDkdT2sW88pz7UWabrAxZeYFa
         ReyLB7sOE1lnyy86rcBARrSWbVLXgcVZX/POzSKAG5NhoS1BiHh7M5N2OfW6PSTGjQUF
         +ZOKBovD71Vw/829QmYGvhglCMANmeyKWKjoAIRYEQmFf5TKIrLVKnpCznXn70KMaiOe
         vnjbYRH2xmh6UKOy6FTF7NO1wOjFbeeI47yBcSlGhFp1PE3UMw7GKIVL12jB8G+aVn0s
         GAnA==
X-Forwarded-Encrypted: i=1; AJvYcCWDBClB9BMlVwVATIbEbh68XEi+zcfNTpNk9aLS1qnTtTmgEfQZuURGoKZfzX4DhnMeYjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqx+qNZDC91y3is6ihp+ogF8LFEhE5fMJ8nsQYckw+e8vxHe/
	9+HoYUKVNcElj9Eb71fq+4rffKRF52fcR7VIQGJvP4v0oAvUw6e4c8gx42TKp2U0iCfTiHNE11Y
	pUyPWXth46/BCy7R526avQs/KNa0=
X-Gm-Gg: ASbGncuJkbOkXVx02zlj+Qk8Ob8x6+U5VigqeBGj9UxIUmQQ1C3FnsrS/Eb/DnZJ0Qw
	/eegb11quHQT3uZ7A5lfBqAxPq3yNOLpaIFrD64PnkTilHZ7jkKms+59D/P6yXE71+hadtGFBpq
	ZZdboPHYKUsJ43TIqRMkqECQkav4yB9xfAvMCu08oUF4FBd2Az9tgdvzk=
X-Google-Smtp-Source: AGHT+IElXWGU6BwtHV07Jj/zZ2Q6vkxkEosBatN8UtTa5EhPsgVMe1N5y4/+dafSHt6ax48Vlgy0+36hSjC4t1T9Cd4=
X-Received: by 2002:a05:620a:1926:b0:7c5:a29e:3477 with SMTP id
 af79cd13be357-7c919084009mr387917985a.53.1744821638933; Wed, 16 Apr 2025
 09:40:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412094607.236382-2-jayatheerthkulkarni2005@gmail.com>
 <20250412174051.780148-1-jayatheerthkulkarni2005@gmail.com>
 <Z_7ekhsBzXK6LKuV@tapette.crustytoothpaste.net> <CA+rGoLfAidyuomeNym5WX8Bo7-jPcfHx35wDeZ7W2aorAN-B7g@mail.gmail.com>
 <xmqqa58gjlnk.fsf@gitster.g> <CA+rGoLesZ3nSjruJ8_XRWVsFpMu8mo_4cCOdB-GFHU_qXkXDCQ@mail.gmail.com>
 <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com>
In-Reply-To: <717161C8-497D-42C7-8C10-AC112238EEFD@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Wed, 16 Apr 2025 22:10:27 +0530
X-Gm-Features: ATxdqUFcFFWH6n-z80LNJmSRH5HuDEmKdu3GQkj4KgfZWNcS1q5ZUrGZVl9vcmg
Message-ID: <CA+rGoLeUojJ4BAUDy2kBsMjRCEFTP=so7sDgy1BX6d7RoBusEA@mail.gmail.com>
Subject: Re: [PATCH] t3706: Add test for wildcard vs literal pathspec
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	peff@peff.net, piotrsiupa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 9:20=E2=80=AFPM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
>
> > Yes ls-files is also a great example, I will add them in the test.
>
>
> I was going to suggest you to use `git ls-files -o 'f**'` in your test,
>  which would eliminate the need of `git add` and `git reset`. However, I
> just found that the bug doesn't happen here:
>
> ```
> git init
> touch foo 'f*' 'f**' f bar
> git ls-files -o 'f*'
> ```
>
> Here (I'm using the current `next`, currently at `fd585f7`),
> `git ls-files -o 'f*'` list the files correctly:
>
> ```
> f
> f*
> f**
> foo
> ```
>
> I also tried with `git grep`:
>
> ```
> git init
> touch foo 'f*' 'f**' f bar
> for f in *; do echo 123 > "$f"; done
> git add -A
> git grep 123 -- 'f*'
>
> and somehow it worked:
>
> ```
> f:1:123
> f*:1:123
> f**:1:123
> foo:1:123
> ```
>
> So, if I'm not doing anything wrong, it looks that it is not solely
> related to pathspecs, but related to pathspecs when used with some other
> commands. hmmm...
>
> > I think for the pathspec and glob specific commands almost all the comm=
ands
> > share the same code, so it should work the same for all.
>
>
> I also though the same, but somehow it behaves differently at least with
> `ls-files` and `grep`. Perhaps it will need further investigation on how
> some commands behave correctly and some don't. I would start by
> inspecting other commands that uses pathspecs (some that I remember:
> checkout, log, show, stash, status, ls-files, grep) and see if they work
> correctly or not, then compare the two groups and see what differs
> between them under the hook.


That is interesting
given that this part of code
<prune function in add.c>
while (--i >=3D 0) {
struct dir_entry *entry =3D *src++;
if (dir_path_match(repo->index, entry, pathspec, prefix, seen))
*dst++ =3D entry;
}

takes part in dir_path_match
Which traces to *Exact Match* problem that was found

and from ls files

if (!index_name_is_other(istate, ent->name, ent->len))
continue;
show_dir_entry(istate, tag_other, ent);

Where show_dir_entry calls
static void show_dir_entry(struct index_state *istate,
const char *tag, struct dir_entry *ent)
{
    int len =3D max_prefix_len;

    if (len > ent->len)
        die("git ls-files: internal error - directory entry not
superset of prefix");

    /* If ps_matches is non-NULL, figure out which pathspec(s) match. */
    if (ps_matched)
        dir_path_match(istate, ent, &pathspec, len, ps_matched);


Something like this
So I think the argument values are making the difference but I'm still unsu=
re.
