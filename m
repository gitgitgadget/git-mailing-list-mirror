Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DBE2D3EDF
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622215; cv=none; b=B6y4VIWTpvDM28m/PB7w5hMNdbo8CHaMybtEMJdHCfnrknezrOU+kbb7Q3s9Vgl/ipI1zoNRJ2w8UNcCWOPZcnYavu5ZVffFucnoG6zBmJ0eIlGPit1GKKFyrrz4WCOpcmBbBwXd42Yoyxo0mcXBDjHOPrYF8oBQTk2B3gwM9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622215; c=relaxed/simple;
	bh=0j6ribL41LxFEX/flMqb7fGYD+3SXjHIY7Qk75M0kss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxbklicqwWHDufJqodBLdRppLp3BznTlT3OLnSMNg6Vn0EtnmCUm57iukLRvs/XswNrmaDU4/dzxOLSSL1acogzO34i6N+y+u7RMiZEszn9xknyGyfWRqiH5REuDRNSotv0mJ1kQ28RgT1j+mqtzLOVLADxU4bAssrvhXmjlTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abjl5fAU; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abjl5fAU"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-94895f6b144so24147139f.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622212; x=1764227012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlSo88VPRLidDgFKo2B90w5pgjJK4BaA+uM42rEH3nM=;
        b=Abjl5fAU5qpDsw1SyNfftrAUseX5WUi5oVJy0GSCT/b6YiSAaBKZSEb5bTAQHfycGU
         ZxUm7xNj5zdxuoa1BMisAaG4fqX+P4lUREsX6FSvmZm9trWjKcC4/w3NrpzY8a7Wiyfw
         QHtSMLlec12uLPBDBAZDF+K2+dCywGRXs8WEnB5UjWM4XfvgZctSlrpg9ZX5163lf5Qo
         dY0eGF5A/L6stcbZma43CeIIUPKE7BepDClAyvlOuxahyrixOQ40g5VqK0+Xv1RJ2QRn
         Pt3Mkx1mCmjHuI2h+o5HZ+w6id7ESFCxJhkgeWrtmi2JP/9qOuP2DhjpFOLw5/4PJFMU
         LyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622212; x=1764227012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlSo88VPRLidDgFKo2B90w5pgjJK4BaA+uM42rEH3nM=;
        b=JRHWjB/2hDHc5DWXecme5IBAA0/8AkvtM1xmPVSzdCLdvsHFPIAXFfXf/F9CPfreck
         MJ9aWSZ2/txKJt+vyZDRH2hJF6l6p79hf8TocZVToPNI5E+vbTjj3HN0Y0/XqLkOtcLV
         Qf0wN5YpgPU1YmF9gY1qD8Bra54tfUQF8D2eWvrrRASyYaHZm+PzPpA+zBHpV0hHtNAu
         ImtTfBgzc7VBStijaC7lhDPpfT6iU6arz33nuwK6a2WZ5oUjV3g8HAzAIpHHcvJJrZio
         4iR9v+utbYEy/awWyiozFlbKRnALPfOfoKfTykmiAUdA0X13O0owMHA+upGkMDh2/D+n
         WY+Q==
X-Gm-Message-State: AOJu0Yymb0w9FBhOs0n5ISquEXh5HmBzE5AOCnH9cjLAAv6JhVLBv062
	xe8R/cl2E9vZ3pxbK/DXRKEp7W3K3PF4qLJo88DgdkagMcOp1mZ5w5yJfFI3G6NMZAJ+9+MAuxu
	/uzd1P3t7NJ3q78Jb/c71VaTkQhe6w6U=
X-Gm-Gg: ASbGncssysS27fdSsSaOStdSlQ3gLiBEJBTzVgUqAw1Yjn896coBHnh9vDXCUJxGvLj
	08Fn/z7Hzcl97vNLmUq208MHQ1sHz8TxP2KIZJcdU5QFhNydJX6WXEQb5JyT8nWJhc5BpE6LhlK
	FKVwD6GN8L3e4IxNB2DuxaOHZYYoyTfJMHUOfqT3yd5ADuOOby59+SfFclJiot/BLX6TlNOVKE/
	FKRsmuWGNF9wBVk3lp+gjwKXDDLekNZH3DlYv7IIYDI3IWgiA4su3ncbs95Sddaevudsw+Xp6gC
	lEnveAZqtIHW1yBu1HCFew/u52eD
X-Google-Smtp-Source: AGHT+IGJmBbApw5o63YDNtWGsGuiFwDab7BQhEFjeafE0+dCM4s7cbpI1uZBjCYvRxyy/MHtVFc1C+6apb8RFwy+8mA=
X-Received: by 2002:a05:6638:a186:b0:5b7:d710:662f with SMTP id
 8926c6da1cb9f-5b95421d5fcmr1928390173.22.1763622212521; Wed, 19 Nov 2025
 23:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-5-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:03:20 -0800
X-Gm-Features: AWmQ_bmNpOG0g3r-p6z0Y3KH2x-b-x8POm0-mVhJSLQvyu88T4Y0ZMthiqDs17A
Message-ID: <CABPp-BEm1QBP+CuSOn5FaE3XJVFg+Qbfzdp560u00ZERbNm6qQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] builtin/history: implement "reword" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip responded in good detail, but I wanted to comment on a few
additional things...

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> +static int collect_commits(struct repository *repo,
> +                          struct commit *old_commit,
> +                          struct commit *new_commit,
> +                          struct strvec *out)
> +{
> +       struct setup_revision_opt revision_opts =3D {
> +               .assume_dashdash =3D 1,
> +       };
> +       struct strvec revisions =3D STRVEC_INIT;
> +       struct commit *child;
> +       struct rev_info rev =3D { 0 };
> +       int ret;
> +
> +       repo_init_revisions(repo, &rev, NULL);
> +       strvec_push(&revisions, "");
> +       strvec_push(&revisions, oid_to_hex(&new_commit->object.oid));
> +       if (old_commit)
> +               strvec_pushf(&revisions, "^%s", oid_to_hex(&old_commit->o=
bject.oid));
> +
> +       setup_revisions_from_strvec(&revisions, &rev, &revision_opts);
> +       if (revisions.nr !=3D 1 || prepare_revision_walk(&rev)) {
> +               ret =3D error(_("revision walk setup failed"));
> +               goto out;
> +       }

Don't we want to restrict the revision walk to descendants of
old_commit (which can be done with `--ancestry-path`)?

> +
> +       while ((child =3D get_revision(&rev))) {
> +               if (old_commit && !child->parents)
> +                       BUG("revision walk did not find child commit");
> +               if (child->parents && child->parents->next) {
> +                       ret =3D error(_("cannot rearrange commit history =
with merges"));
> +                       goto out;
> +               }
> +
> +               strvec_push(out, oid_to_hex(&child->object.oid));
> +
> +               if (child->parents && old_commit &&
> +                   commit_list_contains(old_commit, child->parents))
> +                       break;

Is this last if-check basically a workaround to not providing
--ancestry-path to the revision walk?  And won't it sometimes still
get non-descendants of old_commit before reaching old_commit?  Or, I
guess that's not an issue since you error out when you hit merges, but
once replay supports merges, there's more logic that needs changing
than one expects with the way this is coded.

> +       }
> +
> +       /*
> +        * Revisions are in newest-order-first. We have to reverse the
> +        * array though so that we pick the oldest commits first.
> +        */
> +       for (size_t i =3D 0, j =3D out->nr - 1; i < j; i++, j--)
> +               SWAP(out->v[i], out->v[j]);

Setting rev.reverse would obviate the need for this...

> +
> +       ret =3D 0;
> +
> +out:
> +       strvec_clear(&revisions);
> +       release_revisions(&rev);
> +       reset_revision_walk();
> +       return ret;
> +}

You've pulled out some functions from builtin/replay, but you've
decided to hand re-roll all the revision walking.  Is that because you
first implemented on top of sequencer, and then transliterated to
replay?  If so, I think we could restructure this; I think what you
need is:
  * Create a new commit with an altered commit message.
  * Invoking whatever function(s) would be invoked by "git replay
--onto ${NEW_COMMIT_ID} --ancestry-path ^${OLD_COMMIT_ID} --branches"
(or as a first cut, even shelling out to that subprocess).

The first bullet point would be your fill_commit_message().

The second bullet point would allow you to perhaps drop your
collect_commits(), replace_commits(), and apply_commits(), which feel
like they are just re-implementing replay logic, and replace them with
something like:

void replay_descendants(struct repository *repo,
                        const struct object_id *prev_head,
                        const struct object_id *new_head)
{
        struct strvec args =3D STRVEC_INIT;

        strvec_pushl(&args, "replay", "--onto", NULL);
        strvec_push(&args, oid_to_hex(new_head));
        strvec_push(&args, "--ancestry-path");
        strvec_pushf(&args, "^%s", oid_to_hex(prev_head));
        strvec_push(&args, "--branches");

        reset_revision_walk();
        cmd_replay(args.nr, args.v, NULL, repo);
}

...although maybe it's a little ugly to invoke cmd_replay() this way
and maybe we want to restructure that out.

But, I am really late in providing my review, so if you want to go
forward with your existing three functions and then perhaps we
restructure later, that's fine too.  The command is experimental,
after all.

> +       head =3D lookup_commit_reference_by_name("HEAD");
> +       if (!head) {
> +               ret =3D error(_("could not resolve HEAD to a commit"));
> +               goto out;
> +       }
> +
> +       commit_list_append(original_commit, &from_list);
> +       if (!repo_is_descendant_of(repo, head, from_list)) {
> +               ret =3D error (_("split commit must be reachable from cur=
rent HEAD commit"));
> +               goto out;
> +       }

Why should it be required to be reachable from HEAD?  Shouldn't it be
possible to reword a commit from another branch?

Also, what about when a commit is reachable from both HEAD and other
branches?  I know you started by basing on git-rebase, and git-rebase
restricts things to just one branch, but that was perhaps its biggest
design flaw that couldn't be backward compatibly fixed without
creating a new command.  I'd rather avoid copying that flaw.  (Maybe
the user needs an error by default if more than one branch is
affected, or they need to provide an additional flag to rewrite
multiple branches, but only rewriting one branch when more than one is
affected is just wrong to me unless the user explicitly specifies
that's what they want.)

> +       /* We retain authorship of the original commit. */
> +       original_message =3D repo_logmsg_reencode(repo, original_commit, =
NULL, NULL);
> +       ptr =3D find_commit_header(original_message, "author", &len);
> +       if (ptr)
> +               original_author =3D xmemdupz(ptr, len);
> +       find_commit_subject(original_message, &original_body);
> +
> +       ret =3D fill_commit_message(repo, &parent_tree_oid, &original_com=
mit_tree_oid,
> +                                 original_body, "reworded", &final_messa=
ge);
> +       if (ret < 0)
> +               goto out;
> +
> +       ret =3D commit_tree(final_message.buf, final_message.len, &origin=
al_commit_tree_oid,
> +                         original_commit->parents, &rewritten_commit, or=
iginal_author, NULL);

Does the use of commit_tree() instead of commit_tree_extended() mean
you discard additional headers on the reworded commit, such as
encoding?
