Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4776E4414
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767741575; cv=none; b=UN5juy+Zn4Ias2eA1Au3BF0Ccg7P2PGLrVdJl/O89OnLIK6MX/NDW407BZhlx4iPQBHx3+w9+h+/rh1naUEtufDOk2zUWYcXQO/CpaPT+s0lEL6ybOIwD4n26W9kk4zZG7ygsZwQwr6vcbv9OgZ8WXXlhpbtb4clajWeA69nfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767741575; c=relaxed/simple;
	bh=r/EcZzXNVlRsTK0JRXiVMv6rSoII3ElSBTGDkCwp8Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICO2oS/1J7cHJMesvbVFGQmNGY9xENnkfk8ckoqF+ZxZDrAH3+PW5EmVXdfK4VFL0Jg2FjH/9mUG7TUkkcYvj35x/W/Dmq4D62s11PXR0cvFT8rQ6eST/vuk65f0sXAeSNPzQz4SN/rDQ6V2dvsiUrMt247GMfq52ljrR814L9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE509Nuz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE509Nuz"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6575e760f06so539368eaf.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 15:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767741573; x=1768346373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCZvlfPvrOb8K53Z8Uxbu4Eq1pY/hcqfAJnXszbYQso=;
        b=DE509NuzlbmulkcwU6G8Vo2lVz8Pm5qY2B/mmDT+DQJRV1LRXbi6L4DwwdO6O84//N
         qcylCmrylX5S6bkxmKER1+zLxyUhLqsIv64QTzpsNcRMAk5VCD5z6wNiOiJDwgD1YnzK
         wwES6tLBIDTlwu1/onDn4p+sODIiCjJMWlT0N2PizI9rbi1IcZhvAbBhVwn651j9Zdxx
         tP3Bgo7Cb2RrkzA7JrN/vpTnSrBbLjRp+3KNjVBZ20Y0+YZbpS5dbUnghd2D7Qysh2Yi
         SDxHjesovjrQXXIsRLu3jbfKLfhPpKQamPO8S5Db4W3scVIgf1cflSFJCFVFhwnPhVL7
         AqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767741573; x=1768346373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCZvlfPvrOb8K53Z8Uxbu4Eq1pY/hcqfAJnXszbYQso=;
        b=FzNofknypeYwn9GmG/TkGpq3iXCjSMLwAyjw13mkUaEQ0Fsq85FGfSv+uPlhwcsKQH
         PqabdhNn/XJbE6vqn40X5D38wEllXz888WbQTEj+lrm5/I9pkSXaYeInPniit6DEjEb0
         pfxeDluFl0ah4QUXnb1WSL6CiyKzTDav+YnLK0G3BQB2hTQldUs5A0YlGrRwgnH0IS3k
         ZQAwB6KJMKeQDemSl8XugOVhenWLk9fHjqU0Ym6+MfOoMDvj30mnjKqdyL1Jv3Hd1Uuf
         p/3Z/bi1+f/hsfrH8Y/xFhg6CyxsA0QR8jyfFA1NhTOhHMiV88OvWMFQMrwY9kWX34ND
         mV3A==
X-Forwarded-Encrypted: i=1; AJvYcCUWI7FxumeMAxb4x0WI4kYDTRrmq2e+v7rGB2+o+rzZZ3Fu/OMjUvqvEIObGFyCIjMGYY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5F5848KzRIqttBKEhsCe/VR0p2IHgD++osUl4iaY5M2DrOol
	zfSRzYfzFv3OILX5bxQS/g3/UsojKeMYc5c8wXbGo86vPxUOQpTOfglyjybveY7kYqYvqtKKaIZ
	6Zx/+s23JPm9cw/wjgIr2azqoouMm+vjdng==
X-Gm-Gg: AY/fxX7t7nLqXV7dPdoDbCbxjJ+jOGy7CmyyAUrzPyLix/08cH0ew5ECw0cQ3Svwcjq
	IRH7/s6f2TmbbM5GMM8xx8bo5bE6mlkNlky6nMcxKKOoKd8wiHtk4f+0rYlEqSuZkZNJXRRY1v+
	VLGKMu94SNO9m6rwx9azNDnFycsjZXpStBi+WoR+az3DXR0f9Vzq3L1ugQ6WAIsVxT3OnV1D67D
	p9Lnm947Fr2KKipr1PMzpYri1v3AN9jAzgdTTiW85lGIb9eyTD3CAbokN6+jZbVyz+803pYxS+o
	v8sGceWRCbVi3Sq46w0eR4wVZrck
X-Google-Smtp-Source: AGHT+IFexAK+PhlmCaCAbnM3Z5ajQrVUckmgaBkfpkAHCUXDdqidDf5CzobWaFKy6KWwKi9LK9h3pWiVjp/VD7nlzzw=
X-Received: by 2002:a05:6820:f02d:b0:65d:140:8e1 with SMTP id
 006d021491bc7-65f54ed12b4mr190079eaf.13.1767741573061; Tue, 06 Jan 2026
 15:19:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com> <xmqq344siypm.fsf@gitster.g>
In-Reply-To: <xmqq344siypm.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 6 Jan 2026 15:19:22 -0800
X-Gm-Features: AQt7F2oDXMz0PdlcnoaHuNFHOJaFJ6ef7zeLjOHfP82-pLVfBeXbMXhvDk50Cro
Message-ID: <CABPp-BGQK5cup9j1nm1fb+2iuaoQnWEzBvGnmUeoCDv0iEH6_g@mail.gmail.com>
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Matthew John Cheetham <mjcheetham@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 4:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This problem doesn't occur when refs are specified on the command line
> > for us to check, since we use those specified refs for both walking and
> > checking.  Using the same refs for walking and checking seems to just
> > make sense, so modify the existing code to do the same when refs aren't
> > specified.
>
> Excellent analysis and good approach.
>
> > Snapshot the refs at the beginning, and also ignore all
> > reflog entries since the time of our snapshot (while this technically
> > means we could ignore a reflog entry created before the fsck process
> > if the local clock is weird, since reflogs are local-only there are not
> > concerns about differences between clocks on different machines).
>
> Repository on a network filesystem being accessed by hosts with
> broken clock?

Oh, indeed.

> I do not think our reflog API has (1) give me some token to mark
> your current state (2) here is the token you gave me earlier, now
> iterate and yield entries but ignore entries added after you gave me
> that token, so going by the reflog timestamp is probably the best we
> could do.  Any approach may get confused when the user tries to be
> cute and issues "reflog delete" or "reflog expire" in the middle
> anyway, I suspect ;-)
>
> > While worries about live updates while running fsck is likely of most
> > interest for forge operators, it will likely also benefit those with
> > automated jobs (such as git maintenance) or even casual users who want
> > to do other work in their clone while fsck is running.
>
> Great.  Will queue.  Thanks.
>
> > @@ -509,6 +510,9 @@ static int fsck_handle_reflog_ent(const char *refna=
me,
> >                                 timestamp_t timestamp, int tz UNUSED,
> >                                 const char *message UNUSED, void *cb_da=
ta UNUSED)
> >  {
> > +     if (now && timestamp > now)
> > +             return 0;
> > +
> >       if (verbose)
> >               fprintf_ln(stderr, _("Checking reflog %s->%s"),
> >                          oid_to_hex(ooid), oid_to_hex(noid));
> > @@ -567,14 +571,53 @@ static int fsck_head_link(const char *head_ref_na=
me,
> >                         const char **head_points_at,
> >                         struct object_id *head_oid);
> >
> > -static void get_default_heads(void)
> > +struct ref_snapshot {
> > +     size_t nr;
> > +     size_t name_alloc;
> > +     size_t oid_alloc;
> > +     char **refname;
> > +     struct object_id *oid;
> > +};
>
> This data structure is somewhat unexpected.  Instead of a struct
> that holds two arrays, I would have rather expected an array of
> "struct { refname, oid }", with the possiblity to add a "token to
> mark the latest reflog entry" to the mix I alluded to earlier when
> such an API function materializes.

Yeah, that makes sense.  It'll mean that there won't be anything left
of Matthew's original patch that I was trying to upstream (especially
with the further changes Peff highlighted elsewhere in this thread),
but I can just take the authorship and note Matthew's contribution in
a trailer.

> [Footnote]
>
> We could call refs_for_each_reflog_ent_reverse(), grab the
> parameters that each_reflog_ent_fn receives as that "token" for the
> latest reflog entry and stop.  That way, we will learn the value of
> <old,new,committer,timestamp,tz,msg>, which should be a robust
> enough unique key.
>
> After that when iterating over the reflog, we know we should stop
> after processing the reflog entry that holds the recorded value.

Interesting.  The global timestamp for reflogs seems good enough for
me (network filesystems with a broken clock feel niche to me), but I
can leave a TODO in the code for those that want to pursue improving
the reflog handling further.
