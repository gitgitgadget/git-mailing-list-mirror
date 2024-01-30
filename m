Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69629376F6
	for <git@vger.kernel.org>; Tue, 30 Jan 2024 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706592928; cv=none; b=Zgepf0TSiMilbGGFgDg5xZ0B5Y/UKRhE8P/MtvvE74jgfrwjB/uzft/6GV69RaRCb5fVkpGcLu4f912sPk2gJnKYMdEIOA6DfyOFiv8BHTJeAbsd5yIDEWh/ThmJPZ8+CVNzWEYQQQ9b1ah3U6mwdn6Ux5IdkjVS8uhmlwDJcQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706592928; c=relaxed/simple;
	bh=QyTFa4xZyqHba+l+DNmyNItBflq/KL5DnfKDw0JTxk4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GMt1r6pyzvFeAIb3PU6VtpQGFqcL1AZb7BSAgpKxa39HcxPAPIb3xqIdycKmStzeIG4Z3tl3sbLICnSW3BGFCPDd7cg/cckC7n2JiIY0zickUpwdmeg3Igurk0MZ0A2iDnBORytYGXUcK6Bs0qKLFngt63D6rfpcKShJsZQZDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQaX38kJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQaX38kJ"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d911c9240dso426555ad.2
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706592926; x=1707197726; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH61qgRwdNk/MR/U2TLz5Elfcmj6GgD973eAJEUGZxY=;
        b=mQaX38kJ+gmWPthyMWTUM2v6KSrVU6j33YmEf1IZqeMwAto6Tjia8txvTtpUQNotpA
         AsAi4/gYDxEjAvVllCGNqU+2pFwSb+74Gh1Qv4NOv4bgV69DlwjDl7xnIRojbj52AykR
         SLxQyIReDeAv/+IKNFQY4UjNXj8Or7GiHccb5qIsAO+6yJTjD9IGImHHBeLgxgAQoW1S
         Ldfe7hcqNKeEdHTRXdYd0bxseE5IASlqAzlhpefeHIziAXJPO3QdKklbkCFWmGJ19ZeX
         gXxOlOqeLT9tBEZ2EK/5QLf5jpx2GThkcU/90OhUj65aYQjh+wjfoZTzwn9DpXZ+dMXV
         PPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706592926; x=1707197726;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MH61qgRwdNk/MR/U2TLz5Elfcmj6GgD973eAJEUGZxY=;
        b=QjKtUDsWtg9L0kqrP9Lx6OsGGWkVjyaael3GNQ9x15hqrnb6VnBTKEjSgqHGLXJY2M
         iY88LXMipCSzBPy7NgLM+JA9r9ZIZRSINddv/7QZb3MONmtTvtow/YmFjEZ8ZtsI9fzc
         sa5lJgE5i4idXNHYE7MHm5ZhHi/G3P1CqrAmg5NLkyguT2ulHzLsUqWAHAGUPmc9thHg
         CB1luFCR8sodlS7TFkR7AQ+5V++Mqsw1aQOO8I/3/0KQxDEbtOLes31TKSHqwmuNKH20
         HWiY8SBKgKgkRpo2h4sLXzA/Zpal3kkXdYoMexJ640JPz1OJlimAk2alFn5ea5TDJxH9
         K89g==
X-Gm-Message-State: AOJu0Yx8/7Sa4ZqawK3iEYViZm1ekGE1VL2guu+zQQCJTtho2jsI+soR
	lkw9jhleQVI5R6nE+iKo79R/HDotVCxf12S7lhQdI9Z1PPHF4ihsNTE/8r5CT/E=
X-Google-Smtp-Source: AGHT+IGsUFXmiWU68b3X2oygC1T6sYpckIHuaWwDOP32pH34A0w4bLh7ruxoPqFjUPgAlt7v/2IpTQ==
X-Received: by 2002:a17:903:1245:b0:1d7:48ce:2046 with SMTP id u5-20020a170903124500b001d748ce2046mr6542690plh.29.1706592925312;
        Mon, 29 Jan 2024 21:35:25 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id a19-20020a170902b59300b001d7393f6917sm6265464pls.86.2024.01.29.21.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 21:35:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jan 2024 11:05:21 +0530
Message-Id: <CYRSP93JDLV9.2U9KAZI4XDCFV@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [RFC PATCH 1/2] add-patch: compare object id instead of literal
 string
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <20240128181202.986753-2-shyamthakkar001@gmail.com>
 <20240128181202.986753-3-shyamthakkar001@gmail.com>
 <xmqqmssohu69.fsf@gitster.g>
In-Reply-To: <xmqqmssohu69.fsf@gitster.g>

On Mon Jan 29, 2024 at 11:57 PM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > Add a new function reveq(), which takes repository struct and two revis=
ion
> > strings as arguments and returns 0 if the revisions point to the same
> > object. Passing a rev which does not point to an object is considered
> > undefined behavior as the underlying function memcmp() will be called
> > with NULL hash strings.
>
> I didn't dug into the patch or the codepath it touches, but
> I wonder if it has something (possibly historical) to do with the
> fact that these two behave quite differently:
>
>     $ git checkout HEAD
>     $ git checkout HEAD^0
>
> With the former, you will stay on your current branch, while with
> the latter you detach at the commit at the tip of your current
> branch.  Granted that "git checkout -p" is not about moving HEAD but
> checking out some files to the worktree from a given tree-ish, anytime
> I see code that does strcmp() with a fixed "HEAD" string, that is
> one consideration I'd look for.
>
> > Should the return values of repo_get_oid() be checked in reveq()? As
> > reveq() is not a global function and is only used in run_add_p(), the
> > validity of revisions is already checked beforehand by builtin/checkout=
.c
> > and builtin/reset.c before the call to run_add_p().
>
> If this were to become a public function (even if it somehow turns
> out that it is a bad idea to move away from an explicit comparison
> with "HEAD", introducing such a function might be useful---I dunno),
> it probably makes sense not to burden its potential callers with too
> many assumption.  But doesn't the fact that the immediate callers
> you are introducing already checked the validity of the revisions
> tell us something?  Would it result in us not needing this new
> helper function at all, if we rearranged the code that already
> checks the validity so that the actual object names are collected?
> Then it would become the matter of running oideq() directly on these
> object names, instead of calling a new helper function that
> (re)converts from strings to object names and compares them.
>
> > +// Check if two revisions point to the same object. Passing a rev whic=
h does not
> > +// point to an object is undefined behavior.
>
> Style:
>
>     /*
>      * Our multi-line comments look
>      * like this.
>      */
>
> > +static inline int reveq(struct repository *r, const char *rev1,
> > +			const char *rev2)
> > +{
> > +	struct object_id oid_rev1, oid_rev2;
> > +	repo_get_oid(r, rev1, &oid_rev1);
> > +	repo_get_oid(r, rev2, &oid_rev2);
> > +
> > +	return !oideq(&oid_rev1, &oid_rev2);
>
> Horribly confusing.  If oideq() says "yes, they are the same" by
> returning 0, then any helper function derived from it to ansewr "are
> X and Y the same?" should return 0 when it wants to say "yes, they
> are the same" to help developers keep their sanity.
>
> > +}
> > +
> >  static int parse_range(const char **p,
> >  		       unsigned long *offset, unsigned long *count)
> >  {
> > @@ -1730,28 +1743,25 @@ int run_add_p(struct repository *r, enum add_p_=
mode mode,
> >  		s.mode =3D &patch_mode_stash;
> >  	else if (mode =3D=3D ADD_P_RESET) {
> >  		/*
> > -		 * NEEDSWORK: Instead of comparing to the literal "HEAD",
> > -		 * compare the commit objects instead so that other ways of
> > -		 * saying the same thing (such as "@") are also handled
> > -		 * appropriately.
> > -		 *
> > -		 * This applies to the cases below too.
> > +		 * The literal string comparison to HEAD below is kept
> > +		 * to handle unborn HEAD.
> >  		 */
>
> So, does this change solve the NEEDSWORK comment?  On an unborn
> HEAD, this would still not allow you to say "@".  Only "HEAD" is
> supported.

The reset command does not support naming anything on the unborn HEAD.
Meaning, on an unborn HEAD, using both 'git reset -p @' and 'git reset
-p HEAD' error out. However in case of 'git reset -p' on an unborn
HEAD, it works becuase it skips the validity checks for the revision
string in parse_args() in builtin/reset.c due to the absense of any
arguments. Afterwards the empty revision is replaced by 'HEAD'.
Therefore, the string comparison to HEAD is not for supporting
HEAD, but it is an indication to parse_diff() in add-patch.c, which
replaces that 'HEAD' with empty_tree_oid_hex().

In short, on unborn HEAD, 'git reset -p' passes 'HEAD' as revision
string to be replaced by empty_tree_oid_hex() in parse_diff().
relevant code lines from add-patch.c:

static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
{
    ...
	if (s->revision) {
		struct object_id oid;
		strvec_push(&args,
			    /* could be on an unborn branch */
			    !strcmp("HEAD", s->revision) &&
			    repo_get_oid(the_repository, "HEAD", &oid) ?
			    empty_tree_oid_hex() : s->revision);
	}
	...
}

Perhaps, I should have clarified that in the commit message or comment.

> Not that I necessarily agree with the original "NEEDSWORK" comment
> (I think it is perfectly fine for this or any other codepaths not to
> take "@" as "HEAD"), but if that desire still stands here, should
> the resulting comment still mention it with a NEEDSWORK label?
>
> Besides ...
>
> > diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
> > index 747eb5563e..431f34fa9c 100755
> > --- a/t/t2016-checkout-patch.sh
> > +++ b/t/t2016-checkout-patch.sh
> > @@ -12,6 +12,7 @@ test_expect_success 'setup' '
> >  	git commit -m initial &&
> >  	test_tick &&
> >  	test_commit second dir/foo head &&
> > +	git branch newbranch &&
> >  	set_and_save_state bar bar_work bar_index &&
> >  	save_head
> >  '
> > +# Note: 'newbranch' points to the same commit as HEAD. And it is techn=
ically
> > +# allowed to name a branch '@' as of now, however in below test '@'
> > +# represents the shortcut for HEAD.
> > +for opt in "HEAD" "@" "newbranch"
> > +do
> > +	test_expect_success "git checkout -p $opt with NO staged changes: abo=
rt" '
> > +		set_and_save_state dir/foo work head &&
> > +		test_write_lines n y n | git checkout -p $opt >output &&
> > +		verify_saved_state bar &&
> > +		verify_saved_state dir/foo &&
> > +		test_grep "Discard" output
> > +	'
>
> I think this change in behaviour, especially for "newbranch" that
> used to use the "_nothead" variants of directions and messages, is
> way too confusing.  Users may consider "HEAD" and "@" the same and
> may want them to behave the same way, but the user, when explicitly
> naming "newbranch", means they want to "check contents out of that
> OTHER thing named 'newbranch', not the current branch"; it may or
> may not happen to be pointing at the same commit as HEAD, but if
> the user meant to say "check contents out of the current commit,
> (partially) reverting the local changes I have", the user would have
> said HEAD.  After all, the user may not even be immediately aware
> that "newbranch" happens to point at the same commit as HEAD.
>
> So, after thinking about it a bit more, I do not think I agree with
> the NEEDSWORK comment.  I can buy "@", but not an arbitrary revision
> name that happens to point at the same commit as HEAD.  In other
> words, I may be persuaded to thinking into it is a good idea to add:
>
>     static inline int user_means_HEAD(const char *a)
>     {
> 	return !strcmp(a, "HEAD") || !strcmp(a, "@");
>     }
>
> and replace "!strcmp(rev, "HEAD")" with "user_means_HEAD(rev)", but
> I would not go any further than that.

Yes, however, '@' can also be a branch name. And there is also the case
of '@' being a branch which points to same commit as HEAD, which would
again be confusing as you pointed out above, if "_head" variant is used
in that. For this to work, we would need to check if a branch named '@'
exists and if it does, then '@' should not be treated as a shortcut for
HEAD. (or should it still be treated as a shortcut for HEAD? As 'git
push origin @' pushes HEAD to remote inspite of a branch named '@' existing
locally at a different commit than HEAD).

Thanks.
