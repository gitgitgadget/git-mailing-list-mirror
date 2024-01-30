Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7D3838F
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596762; cv=none; b=iuAhE4DP4crJ48ie3pCbs8cD2bCgsiGYuKOlxGJQM24io15bcQ+yCE1YjGo/WORMwCHGYr/N/Wr/hHwmxLdJz7tdz1jHiUKa0gw1xtgBW/rwnwyKg8Vg5Qa5wAfyvMzB/h25gHBv+oKBZeTSuv559D/FMv7Lt+IOfi+i57GhWCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596762; c=relaxed/simple;
	bh=IVZiEdvEi5Tkon5zffsxNQZNVkUegusuWb5uqDn+HF8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=tQZgb/zECNWjM2pIqeY98giYrQHhf4x9VFoUx8XKb+BSiGKmf25slUs/UV8CtIEuuhqW0FHJ6lgcBYdTWRMSkt9IGTM4N7FWsiNQIQbmLvXHOxEjIa1r2hqBbveoDeGQVCYI1HqYw1JDQtVfa+/IHq0PD/LsNl3AHj3zCYSfH8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm4XT8cG; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm4XT8cG"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso2993566a91.0
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 22:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706596760; x=1707201560; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLNYfNKOwOfitxp6FzfqOl1fN2d7hXGaHRklBGLBApQ=;
        b=nm4XT8cGKo8F1cG0/3yAZSqrbLscK85RSzCvsxX9mV9lpWsc5veDMgJak2O5GiH1YW
         PnENQzAtynchShDtA2vjxfReZrqUuJIUPDhE35Ct/WkceIdmaeDGWE6qv3amt1MEZNSm
         Klag6JQmEatbyRQ+tuMW2OfyEqYJKmhMZ3iBeF2AJjWDpocDM0JxKPVHeihsgO0z4r63
         pjcLAZOVbhyE4IXmtVu8TSJTIVCfRnjYkivberWW8TGmAAc0rBxU0l1iNMQaHLh1qF4Y
         vM5DgOcYTVZHVVXSB2Id6NAyxJsI2wqykv9BK1bU8nv3hDfyyxjjXjLUQ/byhk/VFA7s
         Q8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706596760; x=1707201560;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jLNYfNKOwOfitxp6FzfqOl1fN2d7hXGaHRklBGLBApQ=;
        b=BxEJSf36CXnE8NB4600fMW6s6yrZIFNcSK2kT38LCMi4YCxn64sBpAMVKRvg6CnsDC
         h/9EgdXZG2/7SpKe6IiiFKa6396rsC8k4k48l5ICvRB2qDfolxTLTZJF1PKxrILEpQBS
         5xh0BYhj5FPSMEPzlwac+Z662pVktI9Vj+jGwgVBx7OsDOrz/c838tMMV4sNKXMTP21Q
         7c8NfzNLNh0Vev3UZSPhDCaVIJ5LDnBWqd3eVbVG2Pn1wiThEqDIGY77TONjQxBJq/W/
         2MPbRnZMFcBhmNJ4hqB7OcqT4YwlMC+KdyPg3+PZa871NsF5xae6A7YDfbDICuGJfRL/
         5AJg==
X-Gm-Message-State: AOJu0Yzd3TUoQ+209WaxvBnV7YTM2ZkO1VHMD8g20YfXHy19Ut5Mvhvy
	UG5FURLv8hvqInoYK9u9paQChG7Zyv/Gtpl/YH7fU8pJqhfQM9CpqPtOlce9TFs=
X-Google-Smtp-Source: AGHT+IGKTEoFVo377cRYqKVUdV6qUQehZuiwqvVqVSV3SItJl3Znti50AA5jD6ZxcLa5oMhZNZ+LTA==
X-Received: by 2002:a17:90a:bd90:b0:293:b540:5a8 with SMTP id z16-20020a17090abd9000b00293b54005a8mr5183728pjr.8.1706596759905;
        Mon, 29 Jan 2024 22:39:19 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id pw18-20020a17090b279200b00295bbbf1029sm299906pjb.2.2024.01.29.22.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 22:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 12:09:15 +0530
Message-Id: <CYRU26F9KCDF.2XI7VRT7N04OC@gmail.com>
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
X-Mailer: aerc 0.15.2
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240128181202.986753-3-shyamthakkar001@gmail.com>
 <ZbeQmv_KcChtrPqJ@tanuki>
In-Reply-To: <ZbeQmv_KcChtrPqJ@tanuki>

On Mon Jan 29, 2024 at 5:18 PM IST, Patrick Steinhardt wrote:
> On Sun, Jan 28, 2024 at 11:41:22PM +0530, Ghanshyam Thakkar wrote:
>
> We typically start commit messages with an explanation of what the
> actual problem is that the commit is trying to solve. This helps to set
> the stage for any reviewers so that they know why you're doing changes
> in the first place.

I will keep that in mind for future patches.

> > Add a new function reveq(), which takes repository struct and two revis=
ion
> > strings as arguments and returns 0 if the revisions point to the same
> > object. Passing a rev which does not point to an object is considered
> > undefined behavior as the underlying function memcmp() will be called
> > with NULL hash strings.
> >=20
> > Subsequently, replace literal string comparison to HEAD in run_add_p()
> > with reveq() to handle more ways of saying HEAD (such as '@' or '$branc=
h'
> > where $branch points to same commit as HEAD). This addresses the
> > NEEDSWORK comment in run_add_p().
> >=20
> > However, in ADD_P_RESET mode keep string comparison in logical OR with
> > reveq() to handle unborn HEAD.
> >=20
> > As for the behavior change, with this patch applied if the given
> > revision points to the same object as HEAD, the patch mode will be set =
to
> > patch_mode_(reset,checkout,worktree)_head instead of
> > patch_mode_(...)_nothead. That is equivalent of not setting -R flag in
> > diff-index, which would have been otherwise set before this patch.
> > However, when given same set of inputs, the actual outcome is same as
> > before this patch. Therefore, this does not affect any automated script=
s.
>
> So this is the closest to an actual description of what your goal is.
> But it doesn't say why that is a good idea, it only explains the change
> in behaviour.
>
> I think the best thing to do would be to give a sequence of Git commands
> that demonstrate the problem that you are trying to solve. This would
> help the reader gain a high-level understanding of what you propose to
> change.

Yeah, my original motive was to support '@' as a shorthand for HEAD.
But, since '@' can also be used as branch name, I thought of comparing
object ids instead of string comparison in accordance with the
NEEDSWORK comment. However, as Junio pointed out, treating a branch
name revision that points to same commit as HEAD, as HEAD would just
cause confusion.

> > Also, add testcases to check the similarity of result between different
> > ways of saying HEAD.
> >=20
> > Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> > ---
> > Should the return values of repo_get_oid() be checked in reveq()? As
> > reveq() is not a global function and is only used in run_add_p(), the
> > validity of revisions is already checked beforehand by builtin/checkout=
.c
> > and builtin/reset.c before the call to run_add_p().
> >=20
> >  add-patch.c               | 28 +++++++++++++++-------
> >  t/t2016-checkout-patch.sh | 50 +++++++++++++++++++++++----------------
> >  t/t2071-restore-patch.sh  | 21 ++++++++++------
> >  t/t7105-reset-patch.sh    | 14 +++++++++++
> >  4 files changed, 77 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/add-patch.c b/add-patch.c
> > index 79eda168eb..01eb71d90e 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -14,6 +14,7 @@
> >  #include "color.h"
> >  #include "compat/terminal.h"
> >  #include "prompt.h"
> > +#include "hash.h"
> > =20
> >  enum prompt_mode_type {
> >  	PROMPT_MODE_CHANGE =3D 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HU=
NK,
> > @@ -316,6 +317,18 @@ static void setup_child_process(struct add_p_state=
 *s,
> >  		     INDEX_ENVIRONMENT "=3D%s", s->s.r->index_file);
> >  }
> > =20
> > +// Check if two revisions point to the same object. Passing a rev whic=
h does not
> > +// point to an object is undefined behavior.
>
> We only use `/* */`-style comments in the Git codebase.
>
> > +static inline int reveq(struct repository *r, const char *rev1,
> > +			const char *rev2)
> > +{
> > +	struct object_id oid_rev1, oid_rev2;
> > +	repo_get_oid(r, rev1, &oid_rev1);
> > +	repo_get_oid(r, rev2, &oid_rev2);
> > +
> > +	return !oideq(&oid_rev1, &oid_rev2);
> > +}
>
> I don't think it's a good idea to allow for undefined behaviour here.
> While more tedious for the caller, I think it's preferable to handle the
> case correctly where revisions don't resolve, e.g. by returning `-1` in
> case either of the revisions does not resolve.

Will update it.=20

Thanks.

