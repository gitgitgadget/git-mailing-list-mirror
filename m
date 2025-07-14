Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6158925C83A
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752509078; cv=none; b=s9EUVclGGp3pgaVjya+exBacXrfYhwRM3DB6Gcb+cJnRU6WAPNj4tucJiittMMeAlx2tICrqwK4SeDv4zJbJyigjyPVXtNyITE780vDvjV13LAD0yZzii0Vmd3MZPXvNP6SEKsc9BCpefdOPWX1Kd+9hUVgg3JJOCer9IKn3uY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752509078; c=relaxed/simple;
	bh=ngaDm1pehSAa4tZ5Jv3IVPR3qKaredS34Q8TVQYaeSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jne22mTfpDBZIqzXMa8lPlWHa70L59uRD7OfSnXeBN+708D66I8yJNEC06jXmA1xlAVXHp5FIHIi6IGR/ky8o9dbVNhvAEDGMQKIW7TEH8HALyrN9zllJK1X2zm71LcXemiMbl2tYuquB4a/v2WyBlq5FveLfZu4WNgqmTZwfaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVDe4grb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVDe4grb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so797872066b.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752509075; x=1753113875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rum/h8kC1JsBlEl+qG4Edlf6OA//i6KmYeCM/8Mvxzo=;
        b=LVDe4grbfq+uwIOlBTZG+VHJpHu2z/hJUx5S0ZTNgJLCxNOl2qhrSd/b+ljkpnlwYZ
         rD9GfpmNsUamvwQy/HBK0QbISy+PN3ybzuA4lpdUCuxvX463syRYz7uXjPLOCkvc0SoA
         iTA7a1WSpAFCE8egC4uNXkYqVYM8b8cy89L87G7SebXnePysm9u0UQoqHFeYjWjw1Gi6
         U9GFfkEXuzhu5/QHrkPcNgs7UiNBxXtx2NBNbJA1RoC7KofPJT+nYEmjad9rc1Y4qKW/
         dXr3sWSx98EMW3TGNH11my18ArLwcjdwk5QduoB7hhpbHSKRcRWlomwW+qLCiB+8QuQO
         htog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752509075; x=1753113875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rum/h8kC1JsBlEl+qG4Edlf6OA//i6KmYeCM/8Mvxzo=;
        b=EDMymZrGBo8JaEb7jj13YNT+h9PIaNDW2LDqoiA9o0hf5fDwvGL9oUbg/aXXD6OxR6
         cAsXfNzhUsUn8+/etgF/ln/EtWcElKCIVTmXDZd3b88APP7XuO6SbPj0EQ4PupAwjDm7
         gPOhPHIQJWDPIl+njNYceJQMNTL/kVd76DEQsG67xYwggBlt8SaV3kSaUyfiiFHdVX8q
         aJmkFrTWbKdlOCFGvpepR+8BemYlVODO+O0K92mFbdapUd67/YPtMJ6fqRVA7QN3I8Tr
         meyEkUY0+XnZDBEnDxsDyCxYSckmqcpF7AOdC/FPS1ypLaHWYisvZzwjx0k/SGY0Zsb6
         xuEQ==
X-Gm-Message-State: AOJu0Yz0SD0zJGsVPHHEuA5jaA5xUg/WzSV7Ya826vDqZT5lO2+oR0rP
	2KdQlUiBiDaoDxeDJ5sJv/hinHxXwsz8ZoSHIFHkwYTWGHWiMtKEUlrSwUw4opOpuMZ6OMoMwro
	cETkCKzCOPthm8pkaOyLfAxLkt2Jj27U=
X-Gm-Gg: ASbGnctzitJYRFnycle9R9rTvEncCtagTgRT8UycRCJLmAGgkjkssT20yR4/5/W64nf
	KgGpNVXAKCsvob5KjDYon85XRZen9jxRGeqxUkNgy+1rFdHliCQXEpIle3HFLVrr1MA1D0ds8IN
	vAAF2VdRuxo/Be2W+fuiLeteZb/CPMR6HAZC3TSHsPXqAAEv7WUYQnnr0XrNSWcBGmPCBccRMHE
	MDREe4OHj2HJWyaBEKYBOheODKqRECSNqI3iA==
X-Google-Smtp-Source: AGHT+IHHUn2MuvZHAAlgLTVzcsI0PPhHcgDeNwUH0pV6POKVzg6XPoj3LD2SWCe/GBC/OBkGpdYjfu9cZfDRyvKBllo=
X-Received: by 2002:a17:906:c115:b0:ad5:2e5b:d16b with SMTP id
 a640c23a62f3a-ae6fbe3d07emr1559010366b.27.1752509073736; Mon, 14 Jul 2025
 09:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
 <20250711-306-git-for-each-ref-pagination-v4-4-ed3303ad5b89@gmail.com>
In-Reply-To: <20250711-306-git-for-each-ref-pagination-v4-4-ed3303ad5b89@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 14 Jul 2025 18:04:21 +0200
X-Gm-Features: Ac12FXwG6cbPlkPMuGdDRiOTwUH_-H50859xZMuDJ7DYRbnRHgU2mCfQY6eEznU
Message-ID: <CAP8UFD1wRxZDCRC76VuuA8_rpNn__TQnL9RnNumCE33wAjSrMQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] for-each-ref: introduce a '--start-after' option
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 6:21=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:

>  /*
>   * This is the same as for_each_fullref_in(), but it tries to iterate
>   * only over the patterns we'll care about. Note that it _doesn't_ do a =
full
> @@ -2692,10 +2710,13 @@ static int for_each_fullref_in_pattern(struct ref=
_filter *filter,
>                                        each_ref_fn cb,
>                                        void *cb_data)
>  {
> +       struct ref_iterator *iter;
> +       int flags =3D 0, ret =3D 0;
> +
>         if (filter->kind & FILTER_REFS_ROOT_REFS) {
>                 /* In this case, we want to print all refs including root=
 refs. */
> -               return refs_for_each_include_root_refs(get_main_ref_store=
(the_repository),
> -                                                      cb, cb_data);
> +               flags |=3D DO_FOR_EACH_INCLUDE_ROOT_REFS;
> +               goto non_prefix_iter;
>         }
>
>         if (!filter->match_as_path) {
> @@ -2704,8 +2725,7 @@ static int for_each_fullref_in_pattern(struct ref_f=
ilter *filter,
>                  * prefixes like "refs/heads/" etc. are stripped off,
>                  * so we have to look at everything:
>                  */
> -               return refs_for_each_fullref_in(get_main_ref_store(the_re=
pository),
> -                                               "", NULL, cb, cb_data);
> +               goto non_prefix_iter;
>         }
>
>         if (filter->ignore_case) {
> @@ -2714,20 +2734,29 @@ static int for_each_fullref_in_pattern(struct ref=
_filter *filter,
>                  * so just return everything and let the caller
>                  * sort it out.
>                  */
> -               return refs_for_each_fullref_in(get_main_ref_store(the_re=
pository),
> -                                               "", NULL, cb, cb_data);
> +               goto non_prefix_iter;
>         }
>
>         if (!filter->name_patterns[0]) {
>                 /* no patterns; we have to look at everything */
> -               return refs_for_each_fullref_in(get_main_ref_store(the_re=
pository),
> -                                                "", filter->exclude.v, c=
b, cb_data);
> +               goto non_prefix_iter;
>         }
>
>         return refs_for_each_fullref_in_prefixes(get_main_ref_store(the_r=
epository),
>                                                  NULL, filter->name_patte=
rns,
>                                                  filter->exclude.v,
>                                                  cb, cb_data);
> +
> +non_prefix_iter:
> +       iter =3D refs_ref_iterator_begin(get_main_ref_store(the_repositor=
y), "",
> +                                      NULL, 0, flags);
> +       if (filter->start_after)
> +               ret =3D start_ref_iterator_after(iter, filter->start_afte=
r);
> +
> +       if (ret)
> +               return ret;
> +
> +       return do_for_each_ref_iterator(iter, cb, cb_data);
>  }

Nit: I wonder if what is under the 'non_prefix_iter' label could be in
a new function and instead of `goto non_prefix_iter` we could return
the result of the new function.

>  /*
> @@ -3197,9 +3226,11 @@ static int do_filter_refs(struct ref_filter *filte=
r, unsigned int type, each_ref
>         init_contains_cache(&filter->internal.no_contains_cache);
>
>         /*  Simple per-ref filtering */
> -       if (!filter->kind)
> +       if (!filter->kind) {
>                 die("filter_refs: invalid type");
> -       else {
> +       } else {

Nit: the `else` could be removed altogether here, but maybe that
should be done in a preparatory patch.

> +               const char *prefix =3D NULL;
> +

[...]

> +test_expect_success 'start after with specific directory and trailing sl=
ash' '
> +       cat >expect <<-\EOF &&
> +       refs/odd/spot
> +       refs/tags/annotated-tag
> +       refs/tags/doubly-annotated-tag
> +       refs/tags/doubly-signed-tag
> +       refs/tags/foo1.10
> +       refs/tags/foo1.3
> +       refs/tags/foo1.6
> +       refs/tags/four
> +       refs/tags/one
> +       refs/tags/signed-tag
> +       refs/tags/three
> +       refs/tags/two
> +       EOF
> +       git for-each-ref --format=3D"%(refname)" --start-after=3Drefs/los=
t >actual &&

I don't see a trailing slash.

> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'start after, just behind a specific directory' '
> +       cat >expect <<-\EOF &&
> +       refs/odd/spot
> +       refs/tags/annotated-tag
> +       refs/tags/doubly-annotated-tag
> +       refs/tags/doubly-signed-tag
> +       refs/tags/foo1.10
> +       refs/tags/foo1.3
> +       refs/tags/foo1.6
> +       refs/tags/four
> +       refs/tags/one
> +       refs/tags/signed-tag
> +       refs/tags/three
> +       refs/tags/two
> +       EOF
> +       git for-each-ref --format=3D"%(refname)" --start-after=3Drefs/odd=
/ >actual &&

Here there is a trailing slash though.

> +       test_cmp expect actual
> +'
