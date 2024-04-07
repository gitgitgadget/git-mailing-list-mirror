Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540817F0
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712473470; cv=none; b=KDg0yp/BJoT/y9LBorgXfrCRJIRSEso5qgRbCfkO1gjIcOucA0blxwV0S//9HID6YvbMsHbXNgnIq7hbl/h7n99JvCfadD/DhPrxzud1oJ3et58xSWN/8lSLBBFmie1PDA6RjQZ0oGmca0sJs/T4IVGS8zF+JPaCX7jxurTZClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712473470; c=relaxed/simple;
	bh=okrhiWnzOTEN+QdAUDC9lY03mhc0bswqi3q+OEtPgzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULUA+Sz7Pw0znaYe05kUdFvhPv91VwomzJWaTexuhU3y95Y2r5XiKeWnaSlz3hWDh+wUq6WWAp7+Xhv560wMmW84CzOWOgcQapQ6sEiVvK88+pDunYvBa6/1V8a6ekKcYQjllP3TKNEoqiDWM8b9udY9x+3CLMQr7/DEq7spzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB8J6dRX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB8J6dRX"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3442f4e098bso446565f8f.1
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 00:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712473467; x=1713078267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTLC4heAiLqwMK3Vh0WmmMB+gBG/s4q88tiSR2fbuRE=;
        b=bB8J6dRX5EUDHRKAx1dmoNBXSMDwXedOIn9pNmV2kOkZvx6kY6agE2V4t/FemOkEjV
         6HnKjST4ib6jTj9teD/cO/zRrlSlzfh4IxS5pWFeAU1Y0LO2mzwjCwzPg1zHvzY3W2zE
         VrK3+ohvGf1hbxFLSlNw+ELBa28ZdFv5/KVCPr25FfNZ3Sp5XeFr0cCkG7WnH5EaADUs
         LU4ZU73r3xI2zRUa+i3Q0azrx3++wHop596I0J3NwwvYT00robw0Il0rPmPjPWLp6mpO
         hv+VK4SVj56kCpwhh2HEy0mebUP9Es3t3JrmvGzudl7aTfYgNzLDJZsJr+KnU1yMzy6f
         G/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712473467; x=1713078267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wTLC4heAiLqwMK3Vh0WmmMB+gBG/s4q88tiSR2fbuRE=;
        b=rSL1Tqz+/azF1PGVVl65z2255nu0NvMjSGoVggTV1ysR6ACfNV2lVzreq7Lufa9x+v
         6qQYJdI45/hXkup8RpFhkg+eTMxE5hq+Y/DcQob1GgreLID+Ap+4ckYD+2KrpVLtEHY2
         jKXTZ8I80rOlj1LtXd4MXn8AdFn5xEVkf8Jacr9mALVlrVFbErmti70uIt25IgJTxcYm
         Fd5EIzh7Y2jwi7RwGD2vbqBYRbsgJ7z+BLCIY2YWhK6h2ydh5aPHxcBEWTQxNynpcDTk
         2ep8qazzpn99bw3lAtZ0HNEYwYFSbrV3QgHogCoDBQRCgmTGTzMFLrofHLAK09imTEvg
         IFrw==
X-Gm-Message-State: AOJu0YwVSkF+Vh6ABsYYI44mmOUvSsq7QxtgtJnyh+Sq195moAfZxA40
	QZ0Sg5h2rbeAeapPUvXvhb0/zfH2K11k16ZLqXIfXR2NYU/q1TTKm1kXlS5jtkgU8N3EBHvJ7/m
	Og2kVFaSkA9nDUyjl83A5Mq2lDmQ=
X-Google-Smtp-Source: AGHT+IHgCT9pDlTlv7phpVNTVCaoPo5S9v/Vm2tdKQQsbqPsNb8l86bvzoiWMnEGgMdSJ+XVPSpYWBEdcqyqctV38Ws=
X-Received: by 2002:a05:6000:4594:b0:343:44cd:7d1e with SMTP id
 gb20-20020a056000459400b0034344cd7d1emr4864384wrb.17.1712473467206; Sun, 07
 Apr 2024 00:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <20240407051031.6018-2-leduyquang753@gmail.com> <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
In-Reply-To: <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
From: =?UTF-8?Q?Quang_L=C3=AA_Duy?= <leduyquang753@gmail.com>
Date: Sun, 7 Apr 2024 14:03:50 +0700
Message-ID: <CACXAH50jwngEQLF612FMyZ36yB5Nd7vVHS98KMWYjXqcNzvpwg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 12:47=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> > diff --git a/graph.c b/graph.c
> > @@ -729,9 +742,9 @@ static int graph_num_expansion_rows(struc
t git_graph *graph)
> >  static int graph_needs_pre_commit_line(struct git_graph *graph)
> >  {
> > -       return graph->num_parents >=3D 3 &&
> > +       return graph->connected_region_state =3D=3D CONNECTED_REGION_NE=
W_REGION || (graph->num_parents >=3D 3 &&
>
> Style: This line is overly long and should be wrapped; we aim (as much
> as possible) to fit within an 80-column limit.
>
> >                graph->commit_index < (graph->num_columns - 1) &&
> > -              graph->expansion_row < graph_num_expansion_rows(graph);
> > +              graph->expansion_row < graph_num_expansion_rows(graph));
> >  void graph_update(struct git_graph *graph, struct commit *commit)
> > @@ -760,6 +773,12 @@ void graph_update(struct git_graph *graph, struct =
commit *commit)
> > +
> > +       /*
> > +        * Determine whether this commit belongs to a new connected reg=
ion.
> > +        */
> > +       graph->connected_region_state =3D (graph->connected_region_stat=
e !=3D CONNECTED_REGION_FIRST_COMMIT &&
> > +               graph->num_new_columns =3D=3D 0) ? CONNECTED_REGION_NEW=
_REGION : CONNECTED_REGION_USE_CURRENT;
>
> Style: overly long lines

May I ask how am I expected to place the line breaks? The Linux kernel styl=
e
guide I consulted
(https://www.kernel.org/doc/html/v4.10/process/coding-style.html) doesn't s=
eem
to go into too much detail on this.

> > +static void graph_output_separator_line(struct git_graph *graph, struc=
t graph_line *line)
> > +{
> > +       /*
> > +        * This function adds a row that separates two disconnected gra=
phs,
> > +        * as the appearance of multiple separate commits on top of eac=
h other
> > +        * may cause a misunderstanding that they belong to a timeline.
> > +        */
>
> This comment seems to explain the purpose of the function itself. As
> such, it should precede the function definition rather than being
> embedded within it.

I just followed what the surrounding code did (particularly in the original
`graph_output_pre_commit_line` function), but on second look that functiona=
lity
comment seems to only serve as context for the sentence below that so OK.

> > +       assert(graph->connected_region_state =3D=3D CONNECTED_REGION_NE=
W_REGION);
>
> We tend to use BUG() rather than assert():

Same thing, I just followed that `graph_output_pre_commit_line` did. So I s=
hould
forgo the consistency here? Or is that usage of `assert` in the existing co=
de
also to be updated?

>     if (graph->connected_region_state !=3D CONNECTED_REGION_NEW_REGION)
>         BUG("explain the failure here");
>
> > +       /*
> > +        * Output the row.
> > +        */
> > +       graph_line_addstr(line, "---");
>
> The code itself is obvious enough without the comment, so the comment
> is mere noise, thus should be dropped.

Also same thing that I followed for consistency.

> > +       /*
> > +        * Immediately move to GRAPH_COMMIT state as there for sure are=
n't going to be
> > +        * any more pre-commit lines.
> > +        */
> > +       graph_update_state(graph, GRAPH_COMMIT);
> > +}
> > diff --git a/t/t4218-log-graph-connected-regions.sh b/t/t4218-log-graph=
-connected-regions.sh
> > new file mode 100755
>
> We typically try to avoid creating new test scripts if an existing
> script would be a logical place to house the new tests. I haven't
> personally checked if such a script already exists, but if so, it
> would be good to add new tests to it. If not, then creating a new
> script, as you do here, may be fine.

I tried looking and didn't see a script that these tests would fit nicely i=
nto.
I would really appreciate having a second set of eyes.

> Modern test style is to perform all actions inside the
> test_expect_success body itself, so:
>
>     test_expect_success 'all commits' '
>         cat >expect <<-\EOF
>         ...
>         EOF
>         test_cmp_graph a b c d e
>     '
>
> Note the use of <<- to allow you to indent the here-doc body.

This is also because I followed what `t4202-log.sh` did, but if that repres=
ents
outdated practice then I'll change.

(My apologies, the email client doesn't automatically add CC to the mailing=
 list
in the reply and I forgot to do it myself, so I have to resend this message=
.)
