Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00BA12E63
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079984; cv=none; b=o83ieU+Gku0GOrWH8SwYL8ihMTdKw149oy6agoFSxUABsAktubMKijp9KN0LoA2VH7m5UsfCYh2fDGrTvxW3PT62uTFTNglT7UQp+vNWm9PC/jTD2s5fpsaGhzzI9qbSh4VKrXd+83+MG8f8JdtgBMlHLBPPtOsbeGKkjqdfn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079984; c=relaxed/simple;
	bh=qkEjDqbDlqQtFKFK8oBcxJBV4GDMKC5fJ/vtFmX7D/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f3ziW/1oApyAWpMbtlPoXFYzDCuhE78FbRFpmO1ZTqgB6xph7TZIR01JQ14NV34h0vVbu9A0T8x3WiQA2uqvsB2MnFUGQzFEjXbPZFJwJ4AXW31eUwacQk8teSXbNbeHGSRNjgvVq1y/BY9iPH5Q04yMuSVn9AC//+0DbT2ArHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAUaFKOD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAUaFKOD"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso3697671fa.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 23:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706079980; x=1706684780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4U/STmp7HDG7HYSjE85bhCiI1nHwgXCUibBEaA4miw=;
        b=DAUaFKOD12K7gmXIQwcg9GPcbvVuYAQNdC002m12vgJidlBIhoEQKML7o+z6ARutqa
         twxH988dYHJ+2sDaNDyMCSnFI8aoSrzRbnhi06iyBurKq88feK+7WOSJSvh6hDWAYJ8W
         0hCwH2dwdoIIak5AFNiLxvZa9lzx2hJW0RY5ZUeYkk4SYkXilcZfO+zYJVewJgKFpuIj
         GcxmpEzffJWju4TeKEF+CkK+ehCe2BxW83AEWFl4pizK6pl6SUqZQMU9kXSIgimQ+x24
         HNdyLMHgRCcj9Nm6ao8HvsSN4zwdSgHjlCPYNY5RZnIpn+O1CGOqCzHt+1knSkYid0QO
         JtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079980; x=1706684780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4U/STmp7HDG7HYSjE85bhCiI1nHwgXCUibBEaA4miw=;
        b=JdqDcdXhwmDBIBW3JVdCFE+NZ4C+1o02GD06bpsUKhz08er9A3gsIHp3HFgbS+SPlN
         QYoRw44YGxREypXmDVCGNyBw4QgVn6zge5HZhIfIwz1smABzrgS7zi8fe8iz6wErBCmW
         ZlZ4IWNKbwmR3vVM1L4g1ERbXmngenmDh0r6g9iNUb2TTI1zf5aBFvv1ZybXf4F8BbwV
         f4pxqohpnrwau0I6ZgGXrf6RWR0xBUhBVYvmnxozpKahRZmgfGgGQl5piezsKxo6huCW
         UdBuwdjjY4C9zv5rOblyG3NVB/vpTJpDHoXf4e977BWwLJUDqNuSn12gBTItQzzQFBhv
         t1kA==
X-Gm-Message-State: AOJu0YyYKKwndCnI8peMIDmT/YlWR46rqzPHEtnLfY/tRIra6SiDJ5iq
	ureEDFa5G9GmHzMx0uTbPSa8dECgGqEBYx2RG8+8y09lOWzhVSK1GHFZrd2Ln50T33yQ/w/wK2k
	fuL3h+w7zmIbVpbmUU1X8U5XI8D0=
X-Google-Smtp-Source: AGHT+IF20Nppc/4syDD2nzoLOc36li8cJuj7h4uE6vfatOndA3Cdtl2vy4yCCnwFOfkIDzUhhfMNiPwBOmljJ4P4SG4=
X-Received: by 2002:a2e:860a:0:b0:2cd:936:8b68 with SMTP id
 a10-20020a2e860a000000b002cd09368b68mr556757lji.56.1706079980355; Tue, 23 Jan
 2024 23:06:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzfxa9usx.fsf@gitster.g> <20240117081405.14012-1-mi.al.lohmann@gmail.com>
 <20240117081405.14012-2-mi.al.lohmann@gmail.com>
In-Reply-To: <20240117081405.14012-2-mi.al.lohmann@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 23 Jan 2024 23:06:08 -0800
Message-ID: <CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for rebase/cherry_pick/revert
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org, phillip.wood123@gmail.com, 
	Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:14=E2=80=AFAM Michael Lohmann
<mi.al.lohmann@gmail.com> wrote:
>
> Co-authored-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>
> On 12. Jan 2024, at 21:18, Junio C Hamano <gitster@pobox.com> wrote:
> > I like the way your other_merge_candidate() loops over an array of
> > possible candidates, which makes it a lot easier to extend, though,
> > admittedly the "die()" message needs auto-generating if we really
> > wanted to make it maintenance free ;-)
>
> I would certainly like that but I did not find an easy way of achieving
> this in C. Help wanted.
>
> Changes with respect to v2:
> - use read_ref_full instead of refs_resolve_ref_unsafe
> - check for symbolic ref
> - extract "other_name" in this patch, instead of patch 1
>
>  revision.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index aa4c4dc778..c778413c7d 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1961,11 +1961,31 @@ static void add_pending_commit_list(struct rev_in=
fo *revs,
>         }
>  }
>
> +static const char *lookup_other_head(struct object_id *oid)
> +{
> +       int i;
> +       static const char *const other_head[] =3D {
> +               "MERGE_HEAD", "REBASE_HEAD", "CHERRY_PICK_HEAD", "REVERT_=
HEAD"
> +       };
> +
> +       for (i =3D 0; i < ARRAY_SIZE(other_head); i++)
> +               if (!read_ref_full(other_head[i],
> +                               RESOLVE_REF_READING | RESOLVE_REF_NO_RECU=
RSE,
> +                               oid, NULL)) {
> +                       if (is_null_oid(oid))
> +                               die("%s is a symbolic ref???", other_head=
[i]);
> +                       return other_head[i];
> +               }
> +
> +       die("--merge without MERGE_HEAD, REBASE_HEAD, CHERRY_PICK_HEAD or=
 REVERT_HEAD?");
> +}
> +
>  static void prepare_show_merge(struct rev_info *revs)
>  {
>         struct commit_list *bases;
>         struct commit *head, *other;
>         struct object_id oid;
> +       const char *other_name;
>         const char **prune =3D NULL;
>         int i, prune_num =3D 1; /* counting terminating NULL */
>         struct index_state *istate =3D revs->repo->index;
> @@ -1973,15 +1993,10 @@ static void prepare_show_merge(struct rev_info *r=
evs)
>         if (repo_get_oid(the_repository, "HEAD", &oid))
>                 die("--merge without HEAD?");
>         head =3D lookup_commit_or_die(&oid, "HEAD");
> -       if (read_ref_full("MERGE_HEAD",
> -                       RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> -                       &oid, NULL))
> -               die("--merge without MERGE_HEAD?");
> -       if (is_null_oid(&oid))
> -               die("MERGE_HEAD is a symbolic ref???");
> -       other =3D lookup_commit_or_die(&oid, "MERGE_HEAD");
> +       other_name =3D lookup_other_head(&oid);
> +       other =3D lookup_commit_or_die(&oid, other_name);
>         add_pending_object(revs, &head->object, "HEAD");
> -       add_pending_object(revs, &other->object, "MERGE_HEAD");
> +       add_pending_object(revs, &other->object, other_name);
>         bases =3D repo_get_merge_bases(the_repository, head, other);
>         add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTI=
NG | BOTTOM);
>         add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
> --
> 2.39.3 (Apple Git-145)

I had to go look up previous versions to see the discussion of why
this was useful for things other than merge.  I agree with Phillip
from https://lore.kernel.org/git/648774b5-5208-42d3-95c7-e0cba4d6a159@gmail=
.com/,
that the commit message _needs_ to explain this, likely using some of
Junio's explanation.

Also, what about cases where users do a cherry-pick in the middle of a
rebase, so that both REBASE_HEAD and CHERRY_PICK_HEAD exist?  What
then?
