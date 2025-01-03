Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5580318EFCC
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735887045; cv=none; b=Z3oVWCucNM3TjT6I2+y7mLj3bAvV5U8BDdrAGGy7XM+451kxX4al7XuFonbQIrfHmhokFYORx6rchWb3NYl3rQ9fBAmVVSL6ezxxLLLmXAk/COP2p6ZKU5eOFpNyEEmyvb72EsCODY5VR6Dj6actiu87vf13zagld6jF8clNTwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735887045; c=relaxed/simple;
	bh=IjMQWvFSrhb4cX1IDpMm+PHfspjMql8oqHKizUbxTLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9CaTmlSrxPgTmRGSIpYVE3VxMwYIGiT19crbO7Zq53NGybBnkzL23kq1Mf9uWgxhOkzeHedvy4EEBY6WmWyjDbh2ZkMRK6yP2IjHQYk77n78g/Rv9SxV+XGSx+6R0mBV5LkR9cNgwASqsP4BBFpg4zz8nGRpReWQROMRagVmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4AUVg9W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4AUVg9W"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21628b3fe7dso161393255ad.3
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735887044; x=1736491844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/xDsfK91VRJVmaLtn3UEztmnvHAxxCRqM6va9Nj7iE=;
        b=R4AUVg9WKFq0oSgGSSbtziPt/FOzkxp/+5rnh4pRcRsT5asb/pfqqHbaBjIKNhyWIe
         /eqQWY/z32i6YGiSyW7Zbx3J1NwRDKkD4OC5vjYkgn8iY8wYCe09qQij6VUuZBKkA5yB
         xITT0xDJ+BOvlVf54MECVzCMlflpZXsCs1fjnoLj+LuXBqHYrLECDSo/THkjpZThTK+O
         KflPcvTK7+ACg7nTs41uIIDc0MLos9O4t1rd0+64sbd9Rxa0mlvY76UTHhG65bTeJiAp
         +SfsMrWlz8XCondRIl1Q8OEnVY7QdmwrvDFd99Hm9jKkC4ApYopNPo4LIwcvyoqkiSy2
         cD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735887044; x=1736491844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/xDsfK91VRJVmaLtn3UEztmnvHAxxCRqM6va9Nj7iE=;
        b=IgDAmiE3dLBwJaMlrV5cdjZwCrMGQ3u/gpJfef72jOzKMvmEX7H+LnQ6Ps/Dsyfpmi
         MOylYyrH83INZ3vfHzI8m72AzWcd3tElmavnv+GF2vg3TQMpS51oHXermkZxZ9ACQBeI
         FEygPSaZb/QUWUj2YXKPfM5uFUhdX6XXtB8JsrhaKLiTWh8yS1ZLrSfPJg6snb6+mYbd
         +DxTKEAeF6CUOnqOmfkBjIWwypmXMPnJKZoPj8grK6SGcU0c61Jmnvo1gDo4I8EHUyL5
         eo61co3KuBAJV3yuLNmUFLab3OhrKsKevzRF68dUoZVjRf6t0B+rNMle2xTcspBUD1if
         3sTg==
X-Forwarded-Encrypted: i=1; AJvYcCWVhY6M37ftxnFyF+qAbHjnkq5w3yUL1Yxcxx7WX8SIdf8kJe9UTuPp1CY9/hGdl/m+V7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1pdscovvYCRGc/riEbXPg0wWC1flDSnpp19QpGFQQ8F1xqY6
	W0kHX3pVL0DGyHS0jUUpV5/BSNA+zsQ7XArECQBVytuQxFnogaZeRonXurMr/OPDWvdA/jqlfQv
	EPP3MSRdTBG31NusDEXROY+B4j8M=
X-Gm-Gg: ASbGncvE00cR8Rz0MLg2x/G79QVk2yWDWio4lisOB4KBA2/WCgWvnXOojP0Q/fZPCdr
	ioEude7kq0sfZw8kFe+BO9bQCtkZLmB81hKKLG5FWAThWzMQeMoonTg==
X-Google-Smtp-Source: AGHT+IG7BnMSp8T5aFe5Mp0G7jaiGd+59tM1h499rNG2z3gaaJ1Mb0UwGkOtk1V7xNo1wkVPbLFBqEAgDIHvqKjkOo4=
X-Received: by 2002:a05:6a20:7288:b0:1e1:aa24:2e5c with SMTP id
 adf61e73a8af0-1e5e083f156mr68492462637.38.1735887043465; Thu, 02 Jan 2025
 22:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
 <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com> <Z3JIpDQTDrQuoEN2@pks.im>
 <xmqqh66l1d1n.fsf@gitster.g>
In-Reply-To: <xmqqh66l1d1n.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Fri, 3 Jan 2025 12:20:07 +0530
Message-ID: <CAG=Um+0fC3DcHB19du9YF19CdzCXkt9AYA1ndBJ5pbGAAMYREQ@mail.gmail.com>
Subject: Re: [PATCH v2] maintenance: add prune-remote-refs task
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 7:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > On Sat, Dec 28, 2024 at 10:07:41AM +0000, Shubham Kanodia via GitGitGad=
get wrote:
> >> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-mai=
ntenance.txt
> >> index 6e6651309d3..8b3e496c8ef 100644
> >> --- a/Documentation/git-maintenance.txt
> >> +++ b/Documentation/git-maintenance.txt
> >> @@ -158,6 +158,26 @@ pack-refs::
> >>      need to iterate across many references. See linkgit:git-pack-refs=
[1]
> >>      for more information.
> >>
> >> +prune-remote-refs::
> >> +    The `prune-remote-refs` task runs `git remote prune` on each remo=
te
> >> +    repository registered in the local repository. This task helps cl=
ean
> >> +    up deleted remote branches, improving the performance of operatio=
ns
> >> +    that iterate through the refs. See linkgit:git-remote[1] for more
> >> +    information. This task is disabled by default.
> >> ++
> >> +NOTE: This task is opt-in to prevent unexpected removal of remote ref=
s
> >> +for users of git-maintenance. For most users, configuring `fetch.prun=
e=3Dtrue`
> >
> > Do we want to make this linkgit:git-maintenance[1] even though this is
> > self-referential?
>
> That certainly is a thought---the rule could be "whenever we refer
> to a Git command, we refer to it in a uniform way".  An alternative
> would be "of git-maintenance" -> "of this command" to weaken it.
>
> This refers to those users who want to use the command for other
> reasons (you use the scheduled tasks driven by 'git maintenance'
> only because you wanted the 'gc' and 'pack-refs' tasks to run, you
> do not necessarily want to run a new kind of task the new version of
> Git started supporting, especially when the task is destructive,
> like this one).  We might want to stress that point, perhaps?  If a
> reader reads this part of the documentation, finds this task useful
> and decides to use 'git maintenance', the note would sound somewhat
> nonsensical to them---"I thought about the ramifications, I decided
> I wanted to use the command, why would it be opt-in?" is a plausible
> confusion.
>
> >> +is a acceptable solution, as it will automatically clean up stale rem=
ote-tracking
> >> +branches during normal fetch operations. However, this task can be us=
eful in
> >> +specific scenarios:
> >> ++
> >> +--
> >> +* When using selective fetching (e.g., `git fetch origin +foo:refs/re=
motes/origin/foo`)
> >> +  where `fetch.prune` would only affect refs that are explicitly fetc=
hed.
> >> +* When third-party tools might perform unexpected full fetches, and y=
ou want
> >> +  periodic cleanup independently of fetch operations.
> >> +--
> >
> > Nicely explained. I wish we had more such documentation that is taking
> > the user by their hand and explains why they may or may not want to hav=
e
> > a specific thing.
>
> Yes, a configuration or an option that are not for everybody and for
> every situation need such a guidance, and this one is done nicely.
>
> >> +static int maintenance_task_prune_remote(struct maintenance_run_opts =
*opts,
> >> +                                     struct gc_config *cfg UNUSED)
> >> +{
> >> +    if (for_each_remote(prune_remote, opts)) {
> >> +            error(_("failed to prune remotes"));
> >> +            return 1;
> >
> > I wonder whether we should adapt the loop to be eager. Erroring out on
> > the first failed remote would potentially mean that none of the other
> > remotes may get pruned. So if you had a now-unreachable remote as first
> > remote then none of your remotes would be pruned.
>
> I think the structure, hence the behaviour, is shared with an
> existing prefetch task.  I think the current way is OK-ish, but
> given that we are not in a hurry, we may want to correct the
> semantics for both of them before unleashing this new task to the
> world.
>
> For that, we need the callback functions given to for_each_remote
> (i.e., fetch_remote and prune_remote) to always return "success" in
> the sense to tell "I am done with this remote" to allow the loop to
> continue to the next remote, and convey the failure from the
> subcommand via some other means (like flipping a bit in the cbdata).
>
> Thanks.

Curious =E2=80=94 I submitted my patches through GGG, but Junio was kind
enough to apply a few other fixes to it.
Is there a place I can now get the whole diff (with the range diff
patched in) so I can pull that into GGG?

Thanks,
Shubham
