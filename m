Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9133F9F46
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457388; cv=none; b=XSwy6N8nEhkthV7a3ucTIUqG4Qf0SqACoAoOkr/2ZAudam8ISiyfI60p5uXZvRjKFp1kJPrik6KUWaA6UGvIk1uhg12fekbO+UlmeJKjiT4kJsStAs2BB7jyLonsYSCp6ejsQiq13lWeXLXFApaMd1hSmTyUYQZiaKSXUSGGJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457388; c=relaxed/simple;
	bh=muw369yXVLSodHe1rJfgyVe9dK7xKGr+EHUXuO5R88o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tAQB43Wb2kZsnKy8Cb2yk3+uP/nO4BudSqfVnRfy+pKg7vud5lnp5rGC6Xi7nEFJuWG3SvTGtN7XHW+60vwRfeyiu+BZF51++oeRz/i80jb1cW+JX8AJ+n7+weYhloEaadpfOA2DoAJ1lyhC39XH74/XV9aJwNvELJ/Xt9inrdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=iOv3cRi7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="iOv3cRi7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774457382; x=1775062182;
	i=johannes.schindelin@gmx.de;
	bh=7kqUo0qW+tRN0+0HI8fa7Lhv0fputg66bukd5Gbk/nw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=iOv3cRi7bk3xOOol2P/CNhd4seqKWqY/5JPe9UPo/VFYg92o5L8vtSuwaekGhNHl
	 kq1kvUdREIZ4nXXP2ApZY1Olx3RBFPYRa9CZweysTebzm969OyjuiCJphT5q5moax
	 i3ZNESjpQGwkbdI40UztEiAvQZkAvAEeANh7xwLx6ya+zdBsWHxjwCUF4s35JEzlM
	 MG3bUZNHvTVviGEbLD6aeOrqxhxEJCgcZYmnmrVla3w0laQcwFEyoX7RQvzPtubn5
	 OEOEB6NkBMnMsZpd5bC+g72dIdnuelAw9AfNTpS0BlQrRzUF0XoYQlYSdYso1Mg3R
	 80vcFfF64Uo8VgWnVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1wAN6q2flS-002ucy; Wed, 25
 Mar 2026 17:49:42 +0100
Date: Wed, 25 Mar 2026 17:49:40 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Luiz Campos <luizedc1@gmail.com>
cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
In-Reply-To: <20260325075055.354709-2-luizedc1@gmail.com>
Message-ID: <a4305ef7-50ff-4a68-ab42-fe2fa73e8f37@gmx.de>
References: <20260325075055.354709-1-luizedc1@gmail.com> <20260325075055.354709-2-luizedc1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/tR/u7p5N+VkY5JScJx7WU1j92Z+6UeNMfXCI+V8lGdUVdc6v50
 BWcoA05UyptQjta8mMX6QL0hfVI9IGKp+DKbTACx3oRpWXgCRr332+q8SbEitpLhkW/0apr
 aIbnOkBFX6jyPVnMOmcGQr/XWvhTukJJOyLMBvwgVOZxqMtnC7ra9uFJPffc7WWmrar8REw
 1k133JsXLTBj77RpvugQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3bPlqL17/S8=;PJL2mdBgVat8MrZ1BhfCMSPXeB3
 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
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, 25 Mar 2026, Luiz Campos wrote:

> When using `git add -p`, users can stage or skip hunks,
> but cannot discard unwanted changes from the working tree.
>=20
> Introduce a new 'x' action to discard the current hunk by
> reverse-applying it.
>=20
> This idea was suggested in a previous mailing list discussion:
> https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net=
/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0

Sounds good!

Just two minor comments (not really actionable, I think):

> @@ -1026,25 +1046,26 @@ static void reassemble_patch(struct add_p_state =
*s,
>  		struct hunk merged =3D { 0 };
> =20
>  		hunk =3D file_diff->hunk + i;
> -		if (!use_all && hunk->use !=3D USE_HUNK)
> +		if (!should_merge_hunk(file_diff, i, use_all, merge_for_discard)) {
>  			delta +=3D hunk->header.old_count
>  				- hunk->header.new_count;
> -		else {
> -			/* merge overlapping hunks into a temporary hunk */
> -			if (merge_hunks(s, file_diff, &i, use_all, &merged))
> -				hunk =3D &merged;
> +			continue;
> +		}
> =20
> -			render_hunk(s, hunk, delta, 0, out);
> +		if (merge_hunks(s, file_diff, &i, use_all, &merged,
> +				merge_for_discard))
> +			hunk =3D &merged;
> =20
> -			/*
> -			 * In case `merge_hunks()` used `plain` as a scratch
> -			 * pad (this happens when an edited hunk had to be
> -			 * coalesced with another hunk).
> -			 */
> -			strbuf_setlen(&s->plain, save_len);
> +		render_hunk(s, hunk, delta, 0, out);
> =20
> -			delta +=3D hunk->delta;
> -		}
> +		/*
> +		 * In case `merge_hunks()` used `plain` as a scratch
> +		 * pad (this happens when an edited hunk had to be
> +		 * coalesced with another hunk).
> +		 */
> +		strbuf_setlen(&s->plain, save_len);
> +
> +		delta +=3D hunk->delta;

This hunk is quite hard to read because of the `if ... else ...` -> `if {
... continue; } ...` change that de-indents a large chunk of code.

After pouring over the diff for a bit, I was able to convince myself that
the diff is correct.

> @@ -1547,21 +1570,57 @@ N_("j - go to the next undecided hunk, roll over=
 at the bottom\n"
>     "? - print help\n"
>     "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
> =20
> +static int apply_discard_hunks(struct add_p_state *s,
> +			       struct file_diff *file_diff)
> +{
> +	struct child_process check_cp =3D CHILD_PROCESS_INIT;
> +	struct child_process apply_cp =3D CHILD_PROCESS_INIT;
> +
> +	strbuf_reset(&s->buf);
> +	reassemble_patch(s, file_diff, 0, REASSEMBLE_DISCARD, &s->buf);

If you detect an empty patch here and indicate this via an early return
value, then...

> +
> +	discard_index(s->index);
> +
> +	setup_child_process(s, &check_cp, "apply", "-R", "--check", NULL);
> +	if (pipe_command(&check_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))=
 {
> +		error(_("'git apply -R --check' failed"));
> +		return -1;
> +	}
> +
> +	setup_child_process(s, &apply_cp, "apply", "-R", NULL);
> +	if (pipe_command(&apply_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0))=
 {
> +		error(_("'git apply -R' failed"));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static void apply_patch(struct add_p_state *s, struct file_diff *file_d=
iff)
>  {
>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>  	size_t j;
> +	int needs_refresh =3D 0;
> +
> +	if (s->mode =3D=3D &patch_mode_add) {
> +		for (j =3D 0; j < file_diff->hunk_nr; j++) {
> +			if (file_diff->hunk[j].use =3D=3D DISCARD_HUNK)
> +				break;
> +		}
> +		if (j < file_diff->hunk_nr && apply_discard_hunks(s, file_diff))
> +			return;
> +		if (j < file_diff->hunk_nr)
> +			needs_refresh =3D 1;
> +	}

... then this loop is no longer necessary.

Other than that, looks good to me!

Ciao,
Johannes
