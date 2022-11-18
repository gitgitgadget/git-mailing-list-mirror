Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B8DC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiKRNkk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 08:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241913AbiKRNkM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 08:40:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3651090
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 05:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668778805; bh=RGgfp0Zx/6fNZ3+XSK/gXWucIp0OemUlKtSBL9AlfrM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kI1xHjZsG37LJabvggIMxB4u4ft4srAshg3aW74WOjeoxXxqs9F1S7qRbXrrf3Roe
         AB0cikAvEvgmFBjmzErs+ssc+aLeeRfr7W58r2BwkqqNcYCImByZIHx7IFmP5hlOZI
         pjZQbtEhR7dgZL4Zoe1CNBjjVEvJMhE8f1q7xcEzWQAMgN/oRU9mnKbqlQCmQHXLeI
         Zh+6w7N7/WJA/5g2vDtN0le24kHMrglbdgc1m/5s1WuBTQKYW6E28SSc4smNS641hb
         Fbil45vuYx5Yg4smkDxZTJ9sHZPORs3ZpLp25IPfvDq4fBrudfg8qG537DsAhwlKEH
         WhWKlNvp2O94w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.212.27] ([89.1.212.70]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zFj-1oza0U2bA3-0153EB; Fri, 18
 Nov 2022 14:40:05 +0100
Date:   Fri, 18 Nov 2022 14:40:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] sequencer: unify label lookup
In-Reply-To: <ecb81b873a8d72c57fd4812ec86d103927437cf1.1668098622.git.gitgitgadget@gmail.com>
Message-ID: <93qo066o-8r35-9q15-rq62-9r398o50p5p6@tzk.qr>
References: <pull.1414.git.1668098622.gitgitgadget@gmail.com> <ecb81b873a8d72c57fd4812ec86d103927437cf1.1668098622.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ztHd0y0b0rwsClJ4wyJ+xh+tWu42cPw83h3ke9NgWIbrWkGSlRj
 Ownz8JpbsiMg1j1Dg/Xs6mWtKAgWYe9a/lRzivxzdOUDqSfC8i8yD4pK6u67HAZ9OIsVmD7
 4XuO6+d2eLP2MBI29ul3Q8CtuUF8sIZTAkyp6R8lWKqrehXtPPcB3Z7iokQW/xWV8bXF26J
 BZGq8L+mPWmCLVBnK3GiA==
UI-OutboundReport: notjunk:1;M01:P0:0Gk2/Qo6+io=;4eeZmL/xpqaMyV/abDO6jJksIJi
 MSkV2IzvPfuFM6iRcpeA792XyFRnHvwqNt8eKBjcdUueyMF9CymFLswr7BDwkN3l6tzsP5jzg
 LiPfJfTZN48UDqECshDKjm0m23Az8mh6DBzwwBYpGfkhMCkBXjgbeCzVShTc5ZEXvQDxxeJDl
 5tvsvYhW3JEdWcsXIAZtJeew94/xTxJkeopIBY1+3MSbT8ggKfBL/aWVeQdtLqJrxTBBRjqDt
 t2W/O8XI428Qmw8d3QWEFDiJvfyw4elEcaL5WkB5sD8wLk3AU18M6X786/pH9zeHyXDoV5V//
 /CoIwY0r0C6O337PyWQjTrmwDl9PpavbGhG0alZ7dsJ/XHsHxlDhrEauFmKJYw9srOpxTuhTj
 gbzkuqpwdyP5ognUR325gamHyZSTiuyyd/F2NNLTq+OmlKRarXx+w4g7lwXnvL0r4RjtUAKd0
 l4v+FXBUEU43PMNgNpUc1NETNSTY+JpyNYH0lZ1Xg7Jl4B5U0PhJY1P3iQcBa22OC5of7FZ2M
 EBwDzK0LJtfhe7bEupstB5k+dJhBwkUsZTFA/TPShVguc5OmVHoxi8dKM5TaTD7hz+5dJtMJx
 9jYJ0D1gRqGrHGJL46m+LkmPn1CSARpOzxQSUaugVBy6XtNhzmtfzzPEx/MRrSa8EsUNy7m1u
 0ZjDprd937GbmnRJ3QR0tW0oGNjJcX7YjcwGsijMKbSIVyw2A9bMHspDB4pBFabnVKN1vOwbC
 JgCAVWXZKnjHcsjaGHKc6TJN4VbY0ZoJlsOq4WSXHZLOgWFeKb8utC9Nn6tZWJq8VeSKXbTCb
 ZfMUcH3SvzuqmxgYlMFwMRAS0duYUlVQx3Z1OYLhU8/N7YdKfC/ZvoMc40l3Rs5JzlTJA+Y/C
 P5nfcVWkrqgsP93jkpzrPcE0r4r2D2TNm4OcnnQbU4QzKvk9Yqhj81HH2MLBhnnRSMU2TEGTj
 +a3VoQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 10 Nov 2022, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The arguments to the `reset` and `merge` commands may be a label created
> with a `label` command or an arbitrary commit name. The `merge` command
> uses the lookup_label() function to lookup its arguments but `reset` has
> a slightly different version of that function in do_reset(). Reduce this
> code duplication by calling lookup_label() from do_reset() as well.
>
> This change improves the behavior of `reset` when the argument is a
> tree.  Previously `reset` would accept a tree only for the rebase to
> fail with
>
>        update_ref failed for ref 'HEAD': cannot update ref 'HEAD': tryin=
g to write non-commit object da5497437fd67ca928333aab79c4b4b55036ea66 to b=
ranch 'HEAD'
>
> Using lookup_label() means do_reset() will now error out straight away
> if its argument is not a commit.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---

Very nice.

=46rom reading the patch, I get the impression that this also addresses
https://github.com/gitgitgadget/git/issues/199, i.e. allowing `reset
<tag>`.

Am I right?
Dscho

P.S.: FWIW here is my ACK for both patches.

>  sequencer.c              | 49 ++++++++++++++++++++--------------------
>  t/t3430-rebase-merges.sh |  8 +++++++
>  2 files changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index e658df7e8ff..21f5032df0d 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3696,6 +3696,26 @@ static const char *reflog_message(struct replay_o=
pts *opts,
>  	return buf.buf;
>  }
>
> +static struct commit *lookup_label(const char *label, int len,
> +				   struct strbuf *buf)
> +{
> +	struct commit *commit;
> +
> +	strbuf_reset(buf);
> +	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
> +	commit =3D lookup_commit_reference_by_name(buf->buf);
> +	if (!commit) {
> +		/* fall back to non-rewritten ref or commit */
> +		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
> +		commit =3D lookup_commit_reference_by_name(buf->buf);
> +	}
> +
> +	if (!commit)
> +		error(_("could not resolve '%s'"), buf->buf);
> +
> +	return commit;
> +}
> +
>  static int do_reset(struct repository *r,
>  		    const char *name, int len,
>  		    struct replay_opts *opts)
> @@ -3727,6 +3747,7 @@ static int do_reset(struct repository *r,
>  		oidcpy(&oid, &opts->squash_onto);
>  	} else {
>  		int i;
> +		struct commit *commit;
>
>  		/* Determine the length of the label */
>  		for (i =3D 0; i < len; i++)
> @@ -3734,12 +3755,12 @@ static int do_reset(struct repository *r,
>  				break;
>  		len =3D i;
>
> -		strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
> -		if (get_oid(ref_name.buf, &oid) &&
> -		    get_oid(ref_name.buf + strlen("refs/rewritten/"), &oid)) {
> -			ret =3D error(_("could not read '%s'"), ref_name.buf);
> +		commit =3D lookup_label(name, len, &ref_name);
> +		if (!commit) {
> +			ret =3D -1;
>  			goto cleanup;
>  		}
> +		oid =3D commit->object.oid;
>  	}
>
>  	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
> @@ -3786,26 +3807,6 @@ cleanup:
>  	return ret;
>  }
>
> -static struct commit *lookup_label(const char *label, int len,
> -				   struct strbuf *buf)
> -{
> -	struct commit *commit;
> -
> -	strbuf_reset(buf);
> -	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
> -	commit =3D lookup_commit_reference_by_name(buf->buf);
> -	if (!commit) {
> -		/* fall back to non-rewritten ref or commit */
> -		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
> -		commit =3D lookup_commit_reference_by_name(buf->buf);
> -	}
> -
> -	if (!commit)
> -		error(_("could not resolve '%s'"), buf->buf);
> -
> -	return commit;
> -}
> -
>  static int do_merge(struct repository *r,
>  		    struct commit *commit,
>  		    const char *arg, int arg_len,
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index f351701fec2..fbbc4439bfe 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -138,6 +138,14 @@ test_expect_success '`reset` refuses to overwrite u=
ntracked files' '
>  	git rebase --abort
>  '
>
> +test_expect_success '`reset` rejects trees' '
> +	test_when_finished "test_might_fail git rebase --abort" &&
> +	test_must_fail env GIT_SEQUENCE_EDITOR=3D"echo reset A^{tree} >" \
> +		git rebase -i B C >out 2>err &&
> +	grep "object .* is a tree" err &&
> +	test_must_be_empty out
> +'
> +
>  test_expect_success 'failed `merge -C` writes patch (may be rescheduled=
, too)' '
>  	test_when_finished "test_might_fail git rebase --abort" &&
>  	git checkout -b conflicting-merge A &&
> --
> gitgitgadget
>
>
