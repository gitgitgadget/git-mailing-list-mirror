Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6222338
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298841; cv=none; b=FgfqF15xjB6kogkr5QJGZGPSZIMR1XxQk2tBoedt6uicaem7UiKzyHdqHZRoScVaxGCPWvvcdeuOP2bHyzTrfuu5IEBcv2UXDXCcadjpLf7Jq+nN4R+vRTTp1NfcSqgTqmoEVOf8CCQejqofbXU2a2eqT2UHlQX0jyUm59cgYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298841; c=relaxed/simple;
	bh=mHb7hNCKTYZh2OGSwLr2Qq+DfGiTle5D6gR2SsIx75g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Gpdag9OzfW8DId8Z5c306Wh0wsEknUzVpVVzLscVJXnoAiBOrLrTIpvs4CmXCqEqaseJfC6hF57FPwFL0xD5e8YfToUYoX1agZVhDDX5cgKlBvhO6U74NaUx4DL9dpByjEy60UT9MP6Oedyqu7zCuHS/L6FHTkms0QMf2k7HICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eei/E//5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eei/E//5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6da57e2d2b9so536200b3a.2
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707298838; x=1707903638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+9gTKUQUWFIDOd97O1wBWLpvULV9pEulZ+VGblftE=;
        b=Eei/E//5JDJeMs0MvjQKqszSB7triWCc6m4k2D5tZqCyd2Xf9syYKbJO4rJ0+4VC6n
         /zQsZKbdvxAYvAY+19AmTS+Q0TqKDpDPDIfvYMpjcXuxv6eTxB3GseVX1xQKU6c0shkq
         9JpURpQRNMdXTuLfAa4PZXbVHUVBz/yMdP3WybUflDTcB3iNfAZfvEyXNvOhxGZh+qeV
         F+xbvJ0v9JoRlbwnee9aApXbStEMu37HCE00hM0Dk1D10V8pscuQ94NGvdn+viabWUHD
         SQEF66bSbTnNLr3Npf029d88pyPp+jYxLOxepYZbgMiIKT7GD/TTxuHoBnbr1ptFKeEe
         i6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298838; x=1707903638;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW+9gTKUQUWFIDOd97O1wBWLpvULV9pEulZ+VGblftE=;
        b=ZZd16/DkjRAAnOYxBa9TrsCUPJQgCP3AyH83mQJiIUF1m2bA9MVPqaUbYTxqtOjWfZ
         D+J3y4tb196orgEAG9nRJ8beb5RD9GGnPXKfjO3D1aGHxc6ko4rcMQHNq8brA59AaAnP
         LmS9D6jgETCC/csS57rkdBb6RkkI4UDmUsvmqbf9u9KLQEuvD7jXL6Lz0mGNQjR5RSkL
         RP5+dbKPfzKZ/r3l9yClr4r1R7ZfjfJoB2hcQVsMQ9S+pQDqW/vTlzdFvEa5k+N2K7ES
         tX8U4/EkfcDwI9zQbJWAxZJLQo6zDuL+WxiH5EfYU5OCsBsePnx5tonPbhe6rVOHi5dG
         H8gg==
X-Gm-Message-State: AOJu0YztuUjgfSgtEglPtnR+QNq/bu2n+TrE630Adi/8q7wKQ3QWCuJ3
	fvjGa7UIHYdX7IWzLASBSzJG/RiYP1pzyS8w3uAysBUloIymSrbsS/yF7ueN+D//SHjCSocxW7W
	+7w==
X-Google-Smtp-Source: AGHT+IHb8KKbAv2bll4GF0j8uXhVjxGV4rhBTnh9DMDlTGnVxq2/mh5+NM/NROAP0PNoE/mKOgN6EDJgSno=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:93a6:b0:6de:3790:9795 with SMTP id
 ka38-20020a056a0093a600b006de37909795mr85302pfb.6.1707298838520; Wed, 07 Feb
 2024 01:40:38 -0800 (PST)
Date: Wed, 07 Feb 2024 01:40:36 -0800
In-Reply-To: <20240201115809.1177064-4-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201115809.1177064-1-christian.couder@gmail.com> <20240201115809.1177064-4-christian.couder@gmail.com>
Message-ID: <owlywmrgmx2j.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with --missing=...
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, John Cai <johncai86@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"


Christian Couder <christian.couder@gmail.com> writes:

> In 9830926c7d (rev-list: add commit object support in `--missing`
> option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
> so that it now works with commits too.
>
> Unfortunately, such a command would still fail with a "fatal: bad
> object <oid>" if it is passed a missing commit, blob or tree as an
> argument.

Hmm, but according to the manpage for rev-list, it only accepts commits
as arguments. Conflict...?

Also it took me a second to realize that you are talking about
missing objects passed in at the command line to `git rev-list` and not
the objects that this command encounters during the normal rev walking
process. It would have been a touch nicer to say something more
explicit, like

    In 9830926c7d (rev-list: add commit object support in `--missing`
    option, 2023-10-27) we fixed the `--missing` option in `git rev-list`
    so that it works with missing commits, not just blobs/trees.
    
    Unfortunately, it would still fail with a "fatal: bad
    object <oid>" if it is passed a missing commit as an
    argument (before the rev walking even begins).

> When such a command is used to find the dependencies of some objects,
> for example the dependencies of quarantined objects, it would be
> better if the command would instead consider such missing objects,
> especially commits, in the same way as other missing objects.

Could you define what quarantined objects are (it's not in the manpage
for rev-list)? But also, I'm not sure how much additional value this
paragraph is adding on top of what you already said in the first two
paragraphs.

> If, for example `--missing=print` is used, it would be nice for some
> use cases if the missing tips passed as arguments were reported in
> the same way as other missing objects instead of the command just
> failing.
>
> Let's introduce a new `--allow-missing-tips` option to make it work
> like this.

I assume "tips" means "the starting commits which are passed into this
command from which it begins the rev walk". Might be worth including in
the commit message.

But also, it's curious that you chose the word "allow" when we already
have "--ignore-missing". I assume this is because you still want the
missing tips to still be displayed in the output, and not ignored
(omitted from processing altogether). Perhaps "--report-missing-tips"
is more explicit?

> @@ -753,9 +765,19 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  
>  	if (arg_print_omitted)
>  		oidset_init(&omitted_objects, DEFAULT_OIDSET_SIZE);
> -	if (arg_missing_action == MA_PRINT)
> +	if (arg_missing_action == MA_PRINT) {
> +		struct oidset_iter iter;
> +		struct object_id *oid;
> +
>  		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
>  
> +		/* Already add missing commits */

Did you mean "Add already-missing commits"? Perhaps even more explicit
would be "Add missing tips"?

> +		oidset_iter_init(&revs.missing_commits, &iter);
> +		while ((oid = oidset_iter_next(&iter)))
> +			oidset_insert(&missing_objects, oid);
> +		oidset_clear(&revs.missing_commits);
> +	}

Aside: I am surprised that there is no helper function already that
simply copies things in one oidset into another oidset.

>  	traverse_commit_list_filtered(
>  		&revs, show_commit, show_object, &info,
>  		(arg_print_omitted ? &omitted_objects : NULL));
> diff --git a/revision.c b/revision.c
> index 4c5cd7c3ce..9f25faa249 100644
> --- a/revision.c
> +++ b/revision.c
> 
> [...]
> 
> @@ -2184,7 +2189,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
>  		verify_non_filename(revs->prefix, arg);
>  	object = get_reference(revs, arg, &oid, flags ^ local_flags);
>  	if (!object)
> -		return revs->ignore_missing ? 0 : -1;
> +		return (revs->ignore_missing || revs->do_not_die_on_missing_tips) ? 0 : -1;
>  	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
>  	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
>  	free(oc.path);

With a few more context lines, the diff looks like

--8<---------------cut here---------------start------------->8---
        if (get_oid_with_context(revs->repo, arg, get_sha1_flags, &oid, &oc))
                return revs->ignore_missing ? 0 : -1;
        if (!cant_be_filename)
                verify_non_filename(revs->prefix, arg);
        object = get_reference(revs, arg, &oid, flags ^ local_flags);
        if (!object)
-               return revs->ignore_missing ? 0 : -1;
+               return (revs->ignore_missing || revs->do_not_die_on_missing_tips) ? 0 : -1;
        add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
        add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
        free(oc.path);
        return 0;
--8<---------------cut here---------------end--------------->8---

and it's not obvious to me why you only touched the "if (!object)" case
but not the "if (get_oid_with_context(...))" case. Are there any
subtleties here that would not be obvious to reviewers?

> @@ -3830,8 +3835,6 @@ int prepare_revision_walk(struct rev_info *revs)
>  				       FOR_EACH_OBJECT_PROMISOR_ONLY);
>  	}
>  
> -	oidset_init(&revs->missing_commits, 0);
> -
>  	if (!revs->reflog_info)
>  		prepare_to_use_bloom_filter(revs);
>  	if (!revs->unsorted_input)
> diff --git a/revision.h b/revision.h
> index 94c43138bc..67435a5d8a 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -227,6 +227,14 @@ struct rev_info {
>  			 */
>  			do_not_die_on_missing_objects:1,
>  
> +			/*
> +			 * When the do_not_die_on_missing_objects flag above is set,
> +			 * a rev walk could still die with "fatal: bad object <oid>"
> +			 * if one of the tips it is passed is missing. With this flag
> +			 * such a tip will be reported as missing too.
> +			 */
> +			 do_not_die_on_missing_tips:1,
> +
>  			/* for internal use only */
>  			exclude_promisor_objects:1;

IIUC, we won't get to even do the rev walk though if all tips are
missing. So perhaps a more precise comment would be

    /*
     * When the do_not_die_on_missing_objects flag above is set,
     * we could prematurely die with "fatal: bad object <oid>"
     * if one of the tips it is passed is missing before even getting to
     * the rev walk. With this flag such a tip will be reported as
     * missing in the output after the rev walk completes.
     */
  
> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 527aa94f07..283e8fc2c2 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -77,4 +77,55 @@ do
>  	done
>  done
>  
> +for obj in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +do
> +	for tip in "" "HEAD"

So far from the patch diff it was not obvious that you wanted to check
for the empty string as a "tip".

> +	do
> +		for action in "allow-any" "print"
> +		do
> +			test_expect_success "--missing=$action --allow-missing-tips with tip '$obj' missing and tip '$tip'" '

If I run this test without the new --allow-missing-tips flag, I get 

    fatal: bad object 82335b23aa7234320d6f8055243c852e4b6a5ca3
    not ok 11 - --missing=allow-any --allow-missing-tips with tip 'HEAD~1' missing and tip ''

and I think the last "tip ''" part is misleading because IIUC it's not
actually passed in as a tip (see my comment below about shell quoting).

> +				oid="$(git rev-parse $obj)" &&
> +				path=".git/objects/$(test_oid_to_path $oid)" &&
> +
> +				# Before the object is made missing, we use rev-list to
> +				# get the expected oids.
> +				if [ "$tip" = "HEAD" ]; then
> +					git rev-list --objects --no-object-names \
> +						HEAD ^$obj >expect.raw
> +				else
> +					>expect.raw
> +				fi &&

OK so you are using this empty string to clear the expect.raw file. If
that's true then what stops us from doing this at the start of every
iteration?

> +				# Blobs are shared by all commits, so even though a commit/tree
> +				# might be skipped, its blob must be accounted for.
> +				if [ "$tip" = "HEAD" ] && [ $obj != "HEAD:1.t" ]; then
> +					echo $(git rev-parse HEAD:1.t) >>expect.raw &&
> +					echo $(git rev-parse HEAD:2.t) >>expect.raw
> +				fi &&
> +
> +				mv "$path" "$path.hidden" &&
> +				test_when_finished "mv $path.hidden $path" &&
> +
> +				git rev-list --missing=$action --allow-missing-tips \
> +				     --objects --no-object-names $oid $tip >actual.raw &&

The fact that $tip is not quoted here means that this is equivalent to

    --objects --no-object-names $oid >actual.raw &&

and not

    --objects --no-object-names $oid "" >actual.raw &&

for the case where tip is the empty string. I wonder if we could avoid
being nuanced here with subtle shell quoting rules, especially because
these are tests (where making everything as explicit as possible is
desirable).

> +				# When the action is to print, we should also add the missing
> +				# oid to the expect list.
> +				case $action in
> +				allow-any)
> +					;;
> +				print)
> +					grep ?$oid actual.raw &&
> +					echo ?$oid >>expect.raw
> +					;;
> +				esac &&
> +
> +				sort actual.raw >actual &&
> +				sort expect.raw >expect &&
> +				test_cmp expect actual
> +			'
> +		done
> +	done
> +done
> +

Wait, but where are we actually making the $tip commit's object
_missing_? Hmm...

Ah, actually the tips are just the $obj variables. So it seems like you
could have done

    for tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"

in the beginning to make it more obvious.

Also, given how most of this is identical from the loop already in t6022
just above it, it would help to add a comment at the top of this one
explaining how it's different than the one above it.

Thanks.

>  test_done
> -- 
> 2.43.0.496.gd667eb0d7d.dirty
