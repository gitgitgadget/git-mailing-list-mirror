Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8041BC433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhKXBfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 20:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKXBfE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:35:04 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E4C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:31:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090a294100b001a6e7ba6b4eso622432pjf.9
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pszeRi4aRHutlpM3Bao7i2q0S86zIxhGH0Bxo/p7F2U=;
        b=ehOP3DwWlvRXhtiSPI7OX6DtU+FppXwZPaQ7HPGOqADGcl63BqUhiGE1j9X8ZCnVaI
         XwZQZs42sk241dwlDkrCsFESNH2sqtLJ+cKX3UyOdmwwsBfEfQPHRQDSTkNowLhOqZWU
         O5fMHKYwZzIu0n/V17w970gdobZBHZfcARMEecPl+bezqnegMO7ls1BhKsJ9rteguBvM
         0au63svNR64VSTJCCj8FFH+FeKmtjGgSOn4GC7gcjeDFq+IpKcHWryBs9BQlBhhxuwur
         QBcjQ7hq2H+VYlStNGp3ZrlM7ZVfAv/+KixEcueLzmtceek+gLDlGTH1PuhrZ7Li7LOG
         2EfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pszeRi4aRHutlpM3Bao7i2q0S86zIxhGH0Bxo/p7F2U=;
        b=2DwDpPAP7QRFsjrC1Lf9nDysCd2FSXJj7ZGhKmElTTsqEOf77GF5v/0G26g1o23St8
         UmZQlaGVK8TOJbDkIh5Jb1GBkpY88JJ8X8+ojrR+jYmyRkp+L9iE1HE5vkCqMirEWBkL
         XRBeOqmwpOpnUzVAvJU41zIlTwR7q/WrTF0s6RXYzHspC6Ci7o52GMBt6+6RFhzhjhyN
         8iyoScfkpnqM+5iW/3FWZcfgM5CUwNOtbcYRq/iQ2Mw+IXDogu2yKcScO5I9IFSYfuxb
         dldEMf3HKHJOhxM7btwlazwYIPtipKUFPMoKlrgyz6id0kP6og5CfKqYlsFJBARaMszl
         4HGA==
X-Gm-Message-State: AOAM530SytFujzt4DULIm+fYYao+3QDIQHBoq4sfTE1lJRrqPP7gtOKl
        M/whekxxbbcRRpDH7z0g+K/cQ3b6ZA+qdQzT4IHQ
X-Google-Smtp-Source: ABdhPJyYI1iWymR792gsxsJe48ARozlE44PfPgClBZV0zJFP4lMz26se3lbcB+jdxAoon/2AWaXWHoldeSUGoybPiKHX
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:88cb:0:b0:49f:ad17:c08 with SMTP
 id k11-20020aa788cb000000b0049fad170c08mr1826245pff.19.1637717515591; Tue, 23
 Nov 2021 17:31:55 -0800 (PST)
Date:   Tue, 23 Nov 2021 17:31:53 -0800
In-Reply-To: <20211122223252.19922-5-chooglen@google.com>
Message-Id: <20211124013153.3619998-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20211122223252.19922-5-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: Re: [PATCH 4/4] branch: add --recurse-submodules option for branch creation
From:   Jonathan Tan <jonathantanmy@google.com>
To:     chooglen@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, steadmon@google.com,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:
> +submodule.propagateBranches::
> +	[EXPERIMENTAL] A boolean that enables branching support with
> +	submodules. This allows certain commands to accept
> +	`--recurse-submodules` (`git branch --recurse-submodules` will
> +	create branches recursively), and certain commands that already
> +	accept `--recurse-submodules` will now consider branches (`git
> +	switch --recurse-submodules` will switch to the correct branch
> +	in all submodules).

After some thought, I think that the way in this patch is the best way
to do it, even if it's unfortunate that a natural-looking "git branch
--recurse-submodules" wouldn't work without
"submodule.propagateBranches" (or whatever we decide to call the
variable).

Right now, as far as I know, "--recurse-submodules" in all Git commands
(and equivalently, the configuration variable "submodule.recurse") does
the same thing but in submodules too. For example, "fetch" fetches in
submodules, "switch" switches in submodules, and so on. It would be
plausible for "branch --recurse-submodules" to also create a branch in
submodules, but if a user just used it as-is, it would be surprising if
subsequent commands like "switch --recurse-submodules" or "-c
submodule.recurse=true switch" didn't use the branches that were just
created.

So OK, this makes sense.

> +static int submodule_create_branch(struct repository *r, const char *name,
> +				   const char *start_oid,
> +				   const char *start_name, int force,
> +				   int reflog, int quiet,
> +				   enum branch_track track, char **err_msg)
> +{
> +	int ret = 0;
> +	struct child_process child = CHILD_PROCESS_INIT;
> +	struct strbuf child_err = STRBUF_INIT;
> +	child.git_cmd = 1;
> +	child.err = -1;
> +
> +	prepare_other_repo_env(&child.env_array, r->gitdir);
> +	strvec_pushl(&child.args, "submodule--helper", "create-branch", NULL);

Before this function is a function that calls "git branch" directly -
couldn't this function do the same? (And then you can make both of them
into one function.) The functionality should be exactly the same except
that one has "--dry-run" and the other doesn't.

> @@ -874,6 +894,12 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			FREE_AND_NULL(unused_full_ref);
>  			return 0;
>  		}
> +		if (recurse_submodules) {
> +			create_submodule_branches(the_repository, branch_name,
> +						  start_name, force, reflog,
> +						  quiet, track);
> +			return 0;
> +		}
>  		create_branch(the_repository, branch_name, start_name, force, 0,
>  			      reflog, quiet, track);
>  	} else

create_submodule_branches() here is a bit misleading since it also
creates branches in the_repository. Might be better to write explicitly
check in submodules -> create in main repository -> create in
submodules. Or, if you want to combine all the submodule code in one
function, (check in submodules -> create in submodules) -> create in
main repository.

> +test_expect_success 'setup superproject and submodule' '
> +	git init super &&
> +	test_commit foo &&
> +	git init sub-upstream &&
> +	test_commit -C sub-upstream foo &&
> +	git -C super submodule add ../sub-upstream sub &&
> +	git -C super commit -m "add submodule" &&
> +	git -C super config submodule.propagateBranches true
> +'

If making each test independent is important (which seems like a good
goal to me, although I know that the Git tests are inconsistent on
that), we could make this into a bash function (with test_when_finished)
that gets called in every test. It doesn't violate the t/README request
to put all test code inside test_expect_success assertions (since the
function is still being run inside an assertion).

In the general case, it will make test code slower to run, but if you're
going to have to cleanup branches, I think it's better to just recreate
the repo. In any case, for the general case, I can start a separate
email thread for this discussion.

> +test_expect_success '--recurse-submodules should be ignored if submodule.propagateBranches is false' '
> +	test_when_finished "cleanup_branches super branch-a" &&
> +	(
> +		cd super &&
> +		git -c submodule.propagateBranches=false branch --recurse-submodules branch-a &&
> +		git rev-parse branch-a &&
> +		test_must_fail git -C sub rev-parse branch-a
> +	)
> +'

This doesn't sound like the right behavior to me - I think it's fine if
it was the config "submodule.recurse" instead of "--recurse-submodules",
but if the argument is given on CLI, it should be a fatal error.

> +test_expect_success 'should create branch when submodule is in .git/modules but not .gitmodules' '
> +	test_when_finished "cleanup_branches super branch-a branch-b branch-c" &&
> +	(
> +		cd super &&
> +		git branch branch-a &&
> +		git checkout -b branch-b &&
> +		git submodule add ../sub-upstream sub2 &&
> +		# branch-b now has a committed submodule not in branch-a
> +		git commit -m "add second submodule" &&
> +		git checkout branch-a &&
> +		git branch --recurse-submodules branch-c branch-b &&
> +		git rev-parse branch-c &&
> +		git -C sub rev-parse branch-c &&
> +		git checkout --recurse-submodules branch-c &&
> +		git -C sub2 rev-parse branch-c
> +	)
> +'

Hmm...how is this submodule in .git/modules but not .gitmodules? It
looks like a normal submodule to me.

> +test_expect_success 'should not create branch when submodule is not in .git/modules' '

The title of this test contradicts the title of the test that I quoted
previously.

> +test_expect_success 'should not fail when unable to set up tracking in submodule' '
> +	test_when_finished "cleanup_branches super-clone branch-b" &&
> +	(
> +		cd super-clone &&
> +		git branch --recurse-submodules branch-b origin/branch-b
> +	)
> +'

Is there a warning printed that we can check?

Also, this patch set doesn't discuss the case in which the branch in a
submodule already exists, but it points to the exact commit that we
want. What is the functionality in that case? I would say that the user
should be able to recursively create the branch in this case, but am
open to other opinions. In any case, that case should be tested.
