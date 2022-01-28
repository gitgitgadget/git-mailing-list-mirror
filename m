Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19196C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350054AbiA1Q5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:57:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:37297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245611AbiA1Q5I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643389023;
        bh=J7rQ13yn7q7+z+tiYmrbiKFklAkLI89aZxeST/cxdZo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SGrGV8hZ5GQitQD0JUZzHUo2Eg/nn9PH9pmnWPRRQW8PDZqGTIBbQx50hDg6FnScP
         IQJ2Ylsx6fAzbIzJ5g21cIj3JjhVDlb6bzHbsaYdIfzqhMAss5FoM8qG001+/XJbpH
         yzQ1FPXY8/s/PO0QPQ1kiSGLpWGC9HUGN/8ClcIQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1mLHOv0eHS-00y7pb; Fri, 28
 Jan 2022 17:57:03 +0100
Date:   Fri, 28 Jan 2022 17:57:01 +0100 (CET)
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
Subject: Re: [PATCH 09/12] merge-tree: provide a list of which files have
 conflicts
In-Reply-To: <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281755200.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <fcbb087fa8865ac05e20473d822cd9795590ee38.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E3hRRTPyxN3pT8FjLUj8HwcYFBcMJUsodBqBbmoWBgWLbDb5/ZS
 pslTu1dHD9RXfn1V1UPqwXOJlxLYoQmJMw/o7ZvDMd3e9CrrF/cbr5S/zyXbvzhFQGojjIY
 F2vhZhY8Mr1mEpIsUoaiNQue/empdfAvzLWYmgCXrzoRE8d0tx5S8LU+fmLHVJcXNB81kb3
 k0d9OhKei6Y8vFQifmLCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MCBnshuuzrY=:hwt0doFlkcMFBBoftdBFEX
 e0wi09mbxVe4Mnw1xQ19HQpQm/1uOyeEAt3280Z3NF7IXpPxjt12Tpxttw5NboeYHNurkh4+v
 GIrFmspDagVhjMr6mRvyXKEa4r894jzTL1PZ7JYSy1HGrp5jdosF0CBUtG9S50hec8YY5fPPp
 Zshz9Wb0O0JONKkv9osfZ2xdjOD+kPIrTpXibVylNoi7XO4sCc1OIBSvcHx81LNpkr5yYK9y9
 f7LFXXfceRmubXtUnvObYxuJUJTqjDnAuhPA9xx8RbmLqx51eMoNiEOj46Zpv+lzR0hHulaH5
 CetHBiRS5e0TXULSSnS+6/En6De98FwrOlu04f68ljz6E8dVWFgCgg7Ub8Orb6JMsDKB3gVj9
 Gs4b6mcIF982N8ii/mNa8PZX9cly+Zx8bi3++ewGH8F7ctaqePHY6pwAu5Qo31VSo+j1IjIY3
 sYtnTMocZZF9tGfqCbNYaxsjPgAQJjRu9y8ia2Vnn19I4zgBa4bWSj5RHKIXjFUBDUBQWUxjj
 763V22ciGZlpC2b6WDqnIYSqjXeVO2+HEebTeK9NV8WOtbLu3HWJ0TIEJcQJBWPI+7DK4vMWY
 Q2dnrgBkOnkdS+S5FFt6ESwJ/EctfP/kRH+k4wZmQWLZ0baNG2NTUGHfNgRgdqM97DONDpCc3
 xtVSfdJoZ0rqrQXtwR3t5/+yyP0v48XDOP/MF80COeDX5cybUz9m4GSr5AG++ubBKPBEXU/Dp
 OufuOGLjZug65Eu+CJyCzQ6aAPJB7w/mKaej/hGX0fuiT56htGf6HcK3nanoMy3Wu4D7cy7mW
 5wpa0uawVPh4g+v0+AnJh7+5C9iAlYpCWY7mDypRYRHQ0jOmlojeX7iRURPtd0xH63pl/Q7Ay
 bI3uFTejLb89uzwKfPifMWWI4+X3W5YIOQAJWXeG8hd3D1fQbOnRf13/sPy+P+fAyctnE8U00
 GaB9uXOf5qYk0Tfjz2QqprIciia8xeS6GRmcSx9g3yX0QemhQkMPuJQh1qo9AEeFyLnTfEy+n
 Jm9jDKGW5w8FnvKCGPWNhRpE1fhy1T1hmMg+2QL0jVzB3iES8kJg957hF1MJBV3EhidWNPKxM
 8lpWFUlTDicot4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Callers of `git merge-tree --write-tree` will often want to know which
> files had conflicts.  While they could potentially attempt to parse the
> CONFLICT notices printed, those messages are not meant to be machine
> readable.  Provide a simpler mechanism of just printing the files (in
> the same format as `git ls-files` with quoting, but restricted to
> unmerged files) in the output before the free-form messages.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-merge-tree.txt |  8 ++++++++
>  builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
>  t/t4301-merge-tree-real.sh       | 11 +++++++++++
>  3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-=
tree.txt
> index fd7a867de60..041a4ac2785 100644
> --- a/Documentation/git-merge-tree.txt
> +++ b/Documentation/git-merge-tree.txt
> @@ -58,6 +58,7 @@ simply one line:
>  Whereas for a conflicted merge, the output is by default of the form:
>
>  	<OID of toplevel tree>
> +	<Conflicted file list>
>  	<Informational messages>

To distinguish between the list of conflicted files and the informational
messages, I think it would be good to insert an empty line, as a
separator, like. And...

>
>  These are discussed individually below.
> @@ -69,6 +70,13 @@ This is a tree object that represents what would be c=
hecked out in the
>  working tree at the end of `git merge`.  If there were conflicts, then
>  files within this tree may have embedded conflict markers.
>
> +Conflicted file list
> +~~~~~~~~~~~~~~~~~~~~
> +
> +This is a sequence of lines containing a filename on each line, quoted
> +as explained for the configuration variable `core.quotePath` (see
> +linkgit:git-config[1]).
> +
>  Informational messages
>  ~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 560640ad911..d8eeeb3f306 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -11,6 +11,9 @@
>  #include "blob.h"
>  #include "exec-cmd.h"
>  #include "merge-blobs.h"
> +#include "quote.h"
> +
> +static int line_termination =3D '\n';
>
>  struct merge_list {
>  	struct merge_list *next;
> @@ -395,7 +398,8 @@ struct merge_tree_options {
>  };
>
>  static int real_merge(struct merge_tree_options *o,
> -		      const char *branch1, const char *branch2)
> +		      const char *branch1, const char *branch2,
> +		      const char *prefix)
>  {
>  	struct commit *parent1, *parent2;
>  	struct commit_list *common;
> @@ -449,6 +453,22 @@ static int real_merge(struct merge_tree_options *o,
>  		o->show_messages =3D !result.clean;
>
>  	printf("%s\n", oid_to_hex(&result.tree->object.oid));
> +	if (!result.clean) {
> +		struct string_list conflicted_files =3D STRING_LIST_INIT_NODUP;
> +		const char *last =3D NULL;
> +		int i;
> +
> +		merge_get_conflicted_files(&result, &conflicted_files);
> +		for (i =3D 0; i < conflicted_files.nr; i++) {
> +			const char *name =3D conflicted_files.items[i].string;
> +			if (last && !strcmp(last, name))
> +				continue;
> +			write_name_quoted_relative(
> +				name, prefix, stdout, line_termination);
> +			last =3D name;
> +		}
> +		string_list_clear(&conflicted_files, 1);
> +	}
>  	if (o->show_messages) {
>  		printf("\n");

... it seems that we do this already...

>  		merge_display_update_messages(&opt, &result, stdout);
> @@ -502,7 +522,7 @@ int cmd_merge_tree(int argc, const char **argv, cons=
t char *prefix)
>
>  	/* Do the relevant type of merge */
>  	if (o.real)
> -		return real_merge(&o, argv[0], argv[1]);
> +		return real_merge(&o, argv[0], argv[1], prefix);
>  	else
>  		return trivial_merge(argv[0], argv[1], argv[2]);
>  }
> diff --git a/t/t4301-merge-tree-real.sh b/t/t4301-merge-tree-real.sh
> index c34f8e6c1ed..43c9950dedb 100755
> --- a/t/t4301-merge-tree-real.sh
> +++ b/t/t4301-merge-tree-real.sh
> @@ -94,6 +94,8 @@ test_expect_success 'test conflict notices and such' '
>  	#   "whatever" has *both* a modify/delete and a file/directory conflic=
t
>  	cat <<-EOF >expect &&
>  	HASH
> +	greeting
> +	whatever~side1
>
>  	Auto-merging greeting
>  	CONFLICT (content): Merge conflict in greeting

... as illustrated by the test, too. I guess the documentation should show
the empty line, too?

Ciao,
Dscho

> @@ -105,4 +107,13 @@ test_expect_success 'test conflict notices and such=
' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'Just the conflicted files without the messages' '
> +	test_expect_code 1 git merge-tree --write-tree --no-messages side1 sid=
e2 >out &&
> +	sed -e "s/[0-9a-f]\{40,\}/HASH/g" out >actual &&
> +
> +	test_write_lines HASH greeting whatever~side1 >expect &&
> +
> +	test_cmp expect actual
> +'
> +
>  test_done
> --
> gitgitgadget
>
>
