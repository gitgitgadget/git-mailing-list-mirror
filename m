Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4AEC433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350214AbiA1Qhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:37:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:60899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350219AbiA1Qhh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643387852;
        bh=CR2/9ILTydR5JNf0UsvENziE+nl8DtRB4JYbC7iQ6uU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TtthnI9qiKgaXaXOfVfVFwu3X4kXlSRW0++VwCEjvb5wi3gLVih78Xp6Zld22D4T6
         UCoCUHKQnrRBgKbbVgHcMiGjdQLvFQwz0j5PYmAQOon2lwlHX+82hm7EfWWApnQWQj
         39FKuZRdZZh1X1fOVqCZE/RTR5qZz1RqsssvtF6c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1mzl181ppO-00EsAI; Fri, 28
 Jan 2022 17:37:32 +0100
Date:   Fri, 28 Jan 2022 17:37:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 07/12] merge-tree: support including merge messages in
 output
In-Reply-To: <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281731240.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <2f296aeeefbf8340cfb8b7fa4fef5ad49c8b4aa1.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:maB07k3TeHnksYvVqfL3Ma8OR9s1/QQl/++/jtUjOyWqLBv8smu
 KV650mUjBSD7WUfMWCijzbSg1lWSjNZDPpFg4dYnEVcC/BOOROvYeKq2PE4wkarTh3IyTSL
 DC1wWw0NrzF01uhD4+E7Nszg/84sNfwV6HSu1+i5ICKFwonvypLjj3UP5UZzRM4M/bpZRBI
 4bXq0vYtiWhig7HTA9y+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dbu970ME5U=:we5y6mX+uUWxTqHHCg6hnK
 JUZPXb5nllr9X08IW/KAYmc8zEHblq2jRRgOcjxAr4CqvIoY1z6hm7dLNUoLt51vrj1+kW+LF
 RZ2Go+p8LLvEYmuoHYx7DSdmEBabCUxtiD35XKcikaAzK274tSRlPjmpLdhCivOtmC5LtpXlJ
 nGhn+h7mrq597nBsrdZpDHSDAZ4eq5eW+nzcbJBu5Tr5CxqO3eeuYOYOe8E2XnZwRiknaVyEa
 bRx/f4N5LrDISz8Gayf8Y++J+L6ruWws76eN6BF1i/qBrhOwnnof/2hXeq6AInyswpQHr3HFC
 aNB858E73SvAAGsxIi/lPrQ2CFs9DxcfSIm7hVAw++29uQfSCSXxX/vfg89HaTfgLCAg/u6/C
 JMdJfkr2qLqhrhqHVOPvGLVVEim2vfDAweWoeb+E3GLRMgJyOJZ+nhCRLGMzOJg714P08K0Nj
 5rY3iE0ZirJUk575+O8a2EdPRg1uBhSxmfpkUKd6wlPqKoadYKmJ1O5VYz8ABncTBuHlkfxOL
 oCkkwFw9+qxB2Kl+IAfmvc4P0pPxjBGg14qHbxy9guiZIOctesOy4dzIdJVI266M812wQvoW3
 /WY2sE0eoaqeiFY/eH0dWNa7VtDFDKsfut38MpRcUJyjH/y5/22goIBOIhOd1gZkn5f9huvpe
 g5RFVnzBLTBJwlVk4trYtprHIZl1Gyjie57XEbE58jtQS30pzp9gs+TdnFbhOAPJIy3ctDUdP
 BT7Ap/vIG1pWhT7Kaal2m1DeOUjfsWQMJ87cyT+vGLus5VkVVeCddT7a1RGqMr/mLhaQkUlx1
 kS2Hbyg4tjuUe5lJUQ/OF3qBVR3ru0AttI2SykjKu3W7ByK9BksrpWWy4zgID1xr2PAj9xXU/
 dXt6sN38DXPaaOih3Uafkzyb7liYRwHfEa6oW6E4T2iaFmPDhyEmT6Tw32AcLgHIBh4sXsh9U
 rjwBXMzBHhwVQg3KXDeHtyArCd9a76W+SUJzA1vfufLUK/HFQD9x14PmmtK844bOR0BiAqAUF
 To48lbWoHq0YsBWPtK7NdUAuWI9n8zVxqCoi8R+W4CHO0b/yEve2wRdZPOYzf12IpRiOwRwyl
 838kilfhT5K1fE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> When running `git merge-tree --write-tree`, we previously would only
> return an exit status reflecting the cleanness of a merge, and print out
> the toplevel tree of the resulting merge.  Merges also have
> informational messages, ("Auto-merging <PATH>", "CONFLICT (content):
> ...", "CONFLICT (file/directory)", etc.)  In fact, when non-content
> conflicts occur (such as file/directory, modify/delete, add/add with
> differing modes, rename/rename (1to2), etc.), these informational
> messages are often the only notification since these conflicts are not
> representable in the contents of the file.
>
> Add a --[no-]messages option so that callers can request these messages
> be included at the end of the output.  Include such messages by default
> when there are conflicts, and omit them by default when the merge is
> clean.

Makes sense.

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0c19639594d..560640ad911 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -440,22 +441,30 @@ static int real_merge(struct merge_tree_options *o=
,
>  		commit_list_insert(j->item, &merge_bases);
>
>  	merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
> -	printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +
>  	if (result.clean < 0)
>  		die(_("failure to merge"));
> -	else if (!result.clean)
> -		printf(_("Conflicts!\n"));
> +
> +	if (o->show_messages =3D=3D -1)
> +		o->show_messages =3D !result.clean;
> +
> +	printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +	if (o->show_messages) {
> +		printf("\n");
> +		merge_display_update_messages(&opt, &result, stdout);
> +	}

Excellent.

>  	merge_finalize(&opt, &result);
>  	return !result.clean; /* result.clean < 0 handled above */
>  }
>
>  int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>  {
> -	struct merge_tree_options o =3D { 0 };
> +	struct merge_tree_options o =3D { .show_messages =3D -1 };
>  	int expected_remaining_argc;
> +	int original_argc;
>
>  	const char * const merge_tree_usage[] =3D {
> -		N_("git merge-tree [--write-tree] <branch1> <branch2>"),
> +		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
>  		N_("git merge-tree [--trivial-merge] <base-tree> <branch1> <branch2>"=
),
>  		NULL
>  	};
> @@ -464,6 +473,8 @@ int cmd_merge_tree(int argc, const char **argv, cons=
t char *prefix)
>  			 N_("do a real merge instead of a trivial merge")),
>  		OPT_BOOL(0, "trivial-merge", &o.trivial,
>  			 N_("do a trivial merge only")),
> +		OPT_BOOL(0, "messages", &o.show_messages,
> +			 N_("also show informational/conflict messages")),
>  		OPT_END()
>  	};
>
> @@ -472,10 +483,13 @@ int cmd_merge_tree(int argc, const char **argv, co=
nst char *prefix)
>  		usage_with_options(merge_tree_usage, mt_options);
>
>  	/* Parse arguments */
> +	original_argc =3D argc;
>  	argc =3D parse_options(argc, argv, prefix, mt_options,
>  			     merge_tree_usage, 0);
>  	if (o.real && o.trivial)
>  		die(_("--write-tree and --trivial-merge are incompatible"));
> +	if (!o.real && original_argc < argc)
> +		die(_("--write-tree must be specified if any other options are"));

Hmm. Well. Hmm.


I'd rather keep `--write-tree` neat and optional. What's wrong with
allowing

	git merge-tree --no-messages HEAD MERGE_HEAD

?

To be clear, I think we need this instead:

	if (o.trivial && o.show_messages >=3D 0)
		die(_("--trivial-merge is incompatible with additional options"));

I like the rest of the patch very much!

Thank you,
Dscho

>  	if (o.real || o.trivial) {
>  		expected_remaining_argc =3D (o.real ? 2 : 3);
>  		if (argc !=3D expected_remaining_argc)
> diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> index e03688515c5..c34f8e6c1ed 100755
> --- a/t/t4301-merge-tree-real.sh
> +++ b/t/t4301-merge-tree-real.sh
> @@ -84,4 +84,25 @@ test_expect_success 'Barf on too many arguments' '
>  	grep "^usage: git merge-tree" expect
>  '
>
> +test_expect_success 'test conflict notices and such' '
> +	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
> +	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
> +
> +	# Expected results:
> +	#   "greeting" should merge with conflicts
> +	#   "numbers" should merge cleanly
> +	#   "whatever" has *both* a modify/delete and a file/directory conflic=
t
> +	cat <<-EOF >expect &&
> +	HASH
> +
> +	Auto-merging greeting
> +	CONFLICT (content): Merge conflict in greeting
> +	Auto-merging numbers
> +	CONFLICT (file/directory): directory in the way of whatever from side1=
; moving it to whatever~side1 instead.
> +	CONFLICT (modify/delete): whatever~side1 deleted in side2 and modified=
 in side1.  Version side1 of whatever~side1 left in tree.
> +	EOF
> +
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> gitgitgadget
>
>
