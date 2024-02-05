Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E13136648
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165506; cv=none; b=URL/8Y8SsTcNBl8X1AYIVdu8Oa138dIEgSnz0Cs6t2w0bqjvjRvGMDZLld6LN3j3/fmWgpZmYtZ0G0qtyUGRwWAG7pt1Kv/fcsV3pYwMgSt4aRQh1qY8wbubJjXAito5wV5TRKps5C1MGdt5zZVpb1MOWgk34ELsO2SdXfCMe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165506; c=relaxed/simple;
	bh=fpzjoIWadlW9dIZTbStcdHDb8WkLXwAbGwcRVK/5JoE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=b/xLoPc4RzuQeQ1sdvgj4wcjUnDfuLhuzRwIQIPlqQu9cBomvKEhErqmSmSILq1m6T3SF9iWmZuz69nC2fz6Ie4JLzzyE5SpQsj0SXC6UN8KQYpgRNx/s6Jez+/QS8SQCUalhKI3XmTbD7Zj5T+7NzGayIlKT3WrWWcWHc1qDyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It+YJCpk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It+YJCpk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7858a469aso35567845ad.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707165504; x=1707770304; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i34B6S4EpUV2gW12KwQ5gPY4uYgzaBeWOfNUc5geN7Q=;
        b=It+YJCpkHr2ufmNcX2hX+8Ywdytmg6Plg/7dbZtCuw1nyuoKOvwS1f2NO1ZifNsPRW
         Ls/jFQxo6TnUPao3E/EHBpejV/PJxzcY0DOeIBmjIZRVvvRbB2Faw9r/2mMlhQNwsf0M
         edca6cjtl7ZeyscjQqhWIkYR/Kq8HVrVAuZ3zvwkbSdQi2inkX91V2qcbL/83bRLc/JX
         ggb3gtpWmfxLO3DDN/ac7B8ENZeSj+tXoCyDKoQSlgu6EE/a1XH4MWHYDffaQKD/U/7M
         V6HPgq7svCo8ojiteTjInd9rmHI0DDDmRpVNQ3hwVWGTXjj2Sbw7T4NtqmbVwvqJIJKk
         rWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165504; x=1707770304;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i34B6S4EpUV2gW12KwQ5gPY4uYgzaBeWOfNUc5geN7Q=;
        b=PIfavepcFMT6CqUDS3ZPtT5dc5Qf6fLI3Js8P5nW6WGck5NnD2s9CrrJQz3CC4/Ek9
         kUhLhNyj5QxACp3tqB6/Z4T2lZuvodqsAky7ERh/g6MjMfzFN7iSmI5EHUPQ0+SbUbwy
         dd+Cq1WN3VvCpGxWogZA416zMmDfIREXBGj0sxndLwCdbxuWtgs96mW8EXaYiH4HyDbO
         t1sgqCTvVNht/gYR0gJEUxs5AQg6WamvqQxdGnt/Yforss6wRvXBnB7QHSRdKpAqlKcw
         4RVZrVNtvfCEhEH9rTg/9BrkY4X+a+RXL95zCdfe/3kL8WnxpYB5JYPnQ0uoghfZPqD5
         xUxQ==
X-Gm-Message-State: AOJu0YzPXJMF12KgbHXGF7LWGLUArUveF0fCsS8Zy6uWK8oe/Nj9wKza
	j6CV8AY93rOHROGPYhXire1MS0C9z1jFt8Z0f4ZjuTzPdELuw+Pm
X-Google-Smtp-Source: AGHT+IFDPOAA22toJ4bsaF3xNuZ731+wgJ5JfHUQQjCWOr0DpW0PO0h0puKlIuEyOi2eVsxu3YPVPg==
X-Received: by 2002:a17:903:1248:b0:1d9:66df:f7b3 with SMTP id u8-20020a170903124800b001d966dff7b3mr237741plh.45.1707165504030;
        Mon, 05 Feb 2024 12:38:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWmihDiAy8J15G0SIee8Zk/nuL5BvE438NpFDeJyFSgjk7vGydkloZQ2nnDXZpzjAFFBEwU0DVPIdDyCh/z0nT38/s9TTbbu4dAPUZ0kjA=
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id jw19-20020a170903279300b001d911dd145esm289024plb.219.2024.02.05.12.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 12:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Feb 2024 02:08:18 +0530
Message-Id: <CYXFNV97P2SC.1ABUMGOIR1GQ0@gmail.com>
Cc: <gitster@pobox.com>, <ps@pks.im>
Subject: Re: [PATCH v3 2/2] add-patch: classify '@' as a synonym for 'HEAD'
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20240202150434.11256-1-shyamthakkar001@gmail.com>
 <20240203112619.979239-6-shyamthakkar001@gmail.com>
 <9f9f26f1-5460-468e-a893-5caf7fbea981@gmail.com>
In-Reply-To: <9f9f26f1-5460-468e-a893-5caf7fbea981@gmail.com>

On Mon Feb 5, 2024 at 10:07 PM IST, Phillip Wood wrote:
> On 03/02/2024 11:25, Ghanshyam Thakkar wrote:
> > diff --git a/add-patch.c b/add-patch.c
> > index 68f525b35c..7d565dcb33 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -378,6 +378,11 @@ static int parse_hunk_header(struct add_p_state *s=
, struct hunk *hunk)
> >   	return 0;
> >   }
> >  =20
> > +static inline int user_meant_head(const char *rev)
> > +{
> > +	return !strcmp(rev, "HEAD") || !strcmp(rev, "@");
> > +}
> > +
>
> As well as the places you have converted we also have an explicit test=20
> for "HEAD" in parse_diff() which looks like
>
> 	if (s->revision) {
> 		struct object_id oid;
> 		strvec_push(&args,
> 			    /* could be on an unborn branch */
> 			    !strcmp("HEAD", s->revision) &&
> 			    repo_get_oid(the_repository, "HEAD", &oid) ?
> 			    empty_tree_oid_hex() : s->revision);
> 	}
>
> I suspect we need to update that code as well to accept "@" as a synonym=
=20
> for "HEAD" on an unborn branch.
I had already considered that. Updating here will not have any effect,
because on unborn branch, we do not allow naming HEAD or @. This case is
for when we run without naming any revision (i.e. git reset -p) on
unborn branch. In such cases, we pass 'HEAD' as a default value.
>
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index a6e30931b5..79e208ee6d 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -539,12 +539,13 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
> >   		 * recognized by diff-index), we will always replace the name
> >   		 * with the hex of the commit (whether it's in `...` form or
> >   		 * not) for the run_add_interactive() machinery to work
> > -		 * properly. However, there is special logic for the HEAD case
> > -		 * so we mustn't replace that.  Also, when we were given a
> > -		 * tree-object, new_branch_info->commit would be NULL, but we
> > -		 * do not have to do any replacement, either.
> > +		 * properly. However, there is special logic for the 'HEAD' and
> > +		 * '@' case so we mustn't replace that.  Also, when we were
> > +		 * given a tree-object, new_branch_info->commit would be NULL,
> > +		 * but we do not have to do any replacement, either.
> >   		 */
> > -		if (rev && new_branch_info->commit && strcmp(rev, "HEAD"))
> > +		if (rev && new_branch_info->commit && strcmp(rev, "HEAD") &&
> > +		    strcmp(rev, "@"))
> >   			rev =3D oid_to_hex_r(rev_oid, &new_branch_info->commit->object.oid=
);
>
> I agree with Junio's suggestion to use the user_meant_head() here.=20
> Looking at this made me wonder why builtin/reset.c does not need=20
> updating. The answer seems to be that reset passes in the revision as=20
> given on the commandline after checking it refers to a valid tree=20
> whereas for checkout the revision for on the commandline might contain=20
> "..." which run_add_p() cannot handle.
I was not able to run reset with '...'. I ran,
'git reset main...$ANOTHERBRANCH'
but it gave me "fatal: ambiguous argument 'main...$ANOTHERBRANCH'"
error, with or without -p. While,
'git restore --source=3Dmain...$ANOTHERBRANCH .' and=20
'git checkout main...$ANOTHERBRANCH' works fine, with or without -p.

> > diff --git a/t/t2071-restore-patch.sh b/t/t2071-restore-patch.sh
> > index b5c5c0ff7e..3dc9184b4a 100755
> > --- a/t/t2071-restore-patch.sh
> > +++ b/t/t2071-restore-patch.sh
> > @@ -44,13 +44,17 @@ test_expect_success PERL 'git restore -p with stage=
d changes' '
>
> It is a pre-existing problem but all these "PERL" prerequisites are=20
> no-longer required as we've removed the perl implementation of "add -p"
I can send a separate patch to clean up this script, removing PERL
pre-req from all tests.

> >   	verify_state dir/foo index index
> >   '
> >  =20
> > -test_expect_success PERL 'git restore -p --source=3DHEAD' '
> > -	set_state dir/foo work index &&
> > -	# the third n is to get out in case it mistakenly does not apply
> > -	test_write_lines n y n | git restore -p --source=3DHEAD &&
> > -	verify_saved_state bar &&
> > -	verify_state dir/foo head index
> > -'
> > +for opt in "HEAD" "@"
> > +do
> > +	test_expect_success PERL "git restore -p --source=3D$opt" '
> > +		set_state dir/foo work index &&
> > +		# the third n is to get out in case it mistakenly does not apply
> > +		test_write_lines n y n | git restore -p --source=3D$opt >output &&
> > +		verify_saved_state bar &&
> > +		verify_state dir/foo head index &&
> > +		test_grep "Discard" output
>
> It is good to see that we're now testing for a reversed patch here.
>
> Best Wishes
>
> Phillip

Thanks for the review.

