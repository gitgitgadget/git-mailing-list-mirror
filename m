Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EACFC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236595AbhKVNRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:17:16 -0500
Received: from mout.gmx.net ([212.227.17.20]:56387 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhKVNRN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637586834;
        bh=I8tU67L722t1hVeDEphOXd+y81g6i68cyzHuOomAnOU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=chM0sCnw0to489TYlAzwbY2xim0spYXdvfi+hH3Of7xTUrNeigtmCTKkzPLcXzVYm
         QvnRz5VHvHhjjTn9gYsEptbPGy/C01OALqxCop/exFf0HxvMSTadioiaSAQd672mzZ
         fG9IENGiMgh7HFfxNCrGdSL4mENEc8VgCFE5mmX0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkYbu-1mMzs73DIs-00m5pP; Mon, 22
 Nov 2021 14:13:53 +0100
Date:   Mon, 22 Nov 2021 14:13:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 5/8] fetch: protect branches checked out in all
 worktrees
In-Reply-To: <20211113033358.2179376-6-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111221358160.63@tvgsbejvaqbjf.bet>
References: <20211113033358.2179376-1-andersk@mit.edu> <20211113033358.2179376-6-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1786659332-1637586298=:63"
Content-ID: <nycvar.QRO.7.76.6.2111221405350.63@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:x3ClQigW4fIBmziY2bjVluxsfUE/ztxyatM0/Nbm+ZnE7khxYRu
 ch5up8+itBR06dDVqE/mTFwfURM1rnBP5d7mE/+5mX/EKKkev+TUE6Efc7p7DlvvKV0kNFm
 oEsUFryyTAdVTUNjkW02Mjki8uhQrk15df8X+f0Kv1dEF0+S6z471aWTd4oXsxAvevW6sXL
 mgXKxc1xqAsMS6nGsRw0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:knoPv36cxbc=:4kg/2jF7OAAGdjqeFWCMwp
 Iyl3XtxDWmXST7trTW/HLs/c9j970AAZmdaKqve7l+MTeVDJ6AIGpYSrV9+MmKH5goq+89qCD
 ni9dbzj6OznnRIpwsYbn4X2AXHCl/gxgxj09jpKC0nUkAo1i3MFnvZ66pjQ597tfUw5sL95Z4
 T9w9qsCA9rwqnPx3838Gq2IDGAxGPW2giBB3tQRoR5VKVht/pSgB7pn0JEfdPPdnEG9kyOQiK
 yIt2WYxa/A2eNF04T5FdPKzRAKL76BpdAdk32DVLJMD/YdfNc9cfru82GkbNfwLggjs7iStIT
 R0b14EElBjdKCTndtKGuazo2Rhpm0vGrS/kwD3dIha6untz/hd1slm4nSH2ijb0BWLwJg5ia6
 oMpWRO47LaOggwZly2p+EEBhkP2jyXN8fXJSEhbTQHMV4w+n8oznnhDEuQBqbXoKBxcO6XgT1
 YKQmppSxPeRN4/9N/UJiEUnFRVS5g3lhAHSpFoWMROR+eN3lgwbSN9pK+z4iWxHE3IWeES1Ev
 ehqRoNA/4UCfozSVlpVclfQ3iZjLuuYBuP0nZIm5sE3Ff66k4lncfY+6b40g6Wz5st+rPAZqs
 Y42GbiFH5Fc0LunvWzm/pxs6OK3QF+79WihBlXrDk3hqeQJ6cJq8VtLLdL5ALUBqlwnr5yZHf
 F7LUX/ePARGcq+Y2wHJSiXqnGY8Y5CmK5sXy47Y/vjcAkQdh9NhiocWKJExggGrXzT2ElTOBN
 dbNm0TLGoCEcd7g7vhgttnLEVu0cTBRcSrOujNN4U/yWuGWkJ2ij43cKkNT96fZ0Opxdbv5rE
 Tvpq2zalxRvdY7azZOqav3/2rDr8ihobUAPlguO16JVIHhxAfsMBgC8R62IQKvtRbmMq5XqBd
 1V1GtS6Dv1KpW7splHGm6y94akwL4buyDMxj1sWHWI0jMJnN9p1cg25NNAkeD2zYOAD87hXvp
 Duhwu5EpQF62+3CGOis1FsAt5FjMp7q8bob6Etu+smqKZBRk6gznFlY9RsNuVvkLFsNpqApxC
 O7X+T1erKxZbgIgtapNGTCqxN8IHJn0ZAjVvJFO9PWFE0p1wa5yReN4eDYMJ3D0gD7yf3k8lQ
 lpMsLyyad77bnc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1786659332-1637586298=:63
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111221405351.63@tvgsbejvaqbjf.bet>

Hi Anders,

tl;dr the patch looks nice! A few remarks below, to prove that I did not
merely glance over the patch.

On Fri, 12 Nov 2021, Anders Kaseorg wrote:

> Refuse to fetch into the currently checked out branch of any working
> tree, not just the current one.
>
> Fixes this previously reported bug:
>
> https://public-inbox.org/git/cb957174-5e9a-5603-ea9e-ac9b58a2eaad@mathem=
a.de

These days, I think the lore.kernel.org/git/ links are slightly preferred.

>
> As a side effect of using find_shared_symref, we=E2=80=99ll also refuse =
the
> fetch when we=E2=80=99re on a detached HEAD because we=E2=80=99re rebasi=
ng or bisecting
> on the branch in question. This seems like a sensible change.
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>
> ---
>  builtin/fetch.c       | 75 +++++++++++++++++++++++--------------------
>  t/t5516-fetch-push.sh | 18 +++++++++++
>  2 files changed, 58 insertions(+), 35 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index e5971fa6e5..f373252490 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -28,6 +28,7 @@
>  #include "promisor-remote.h"
>  #include "commit-graph.h"
>  #include "shallow.h"
> +#include "worktree.h"
>
>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>
> @@ -840,14 +841,13 @@ static void format_display(struct strbuf *display,=
 char code,
>
>  static int update_local_ref(struct ref *ref,
>  			    struct ref_transaction *transaction,
> -			    const char *remote,
> -			    const struct ref *remote_ref,
> -			    struct strbuf *display,
> -			    int summary_width)
> +			    const char *remote, const struct ref *remote_ref,
> +			    struct strbuf *display, int summary_width,

As a reviewer, I prefer to spend my time reviewing the actual change. In
this case, the re-wrapping is a bit distracting. Not really important
here, but maybe for future contributions. The easier a contributor makes
it on reviewers, the better (it definitely helps avoid the grumpy judge
bias[*1*]).

> +			    struct worktree **worktrees)
>  {
>  	struct commit *current =3D NULL, *updated;
>  	enum object_type type;
> -	struct branch *current_branch =3D branch_get(NULL);
> +	const struct worktree *wt;
>  	const char *pretty_ref =3D prettify_refname(ref->name);
>  	int fast_forward =3D 0;
>
> @@ -862,16 +862,17 @@ static int update_local_ref(struct ref *ref,
>  		return 0;
>  	}
>
> -	if (current_branch &&
> -	    !strcmp(ref->name, current_branch->name) &&
> -	    !(update_head_ok || is_bare_repository()) &&
> -	    !is_null_oid(&ref->old_oid)) {
> +	if (!update_head_ok &&
> +	    (wt =3D find_shared_symref(worktrees, "HEAD", ref->name)) &&
> +	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
>  		/*
>  		 * If this is the head, and it's not okay to update
>  		 * the head, and the old value of the head isn't empty...
>  		 */
>  		format_display(display, '!', _("[rejected]"),
> -			       _("can't fetch in current branch"),
> +			       wt->is_current ?
> +				       _("can't fetch in current branch") :
> +				       _("checked out in another worktree"),
>  			       remote, pretty_ref, summary_width);
>  		return 1;
>  	}
> @@ -1071,7 +1072,8 @@ N_("it took %.2f seconds to check forced updates; =
you can use\n"
>     " to avoid this check\n");
>
>  static int store_updated_refs(const char *raw_url, const char *remote_n=
ame,
> -			      int connectivity_checked, struct ref *ref_map)
> +			      int connectivity_checked, struct ref *ref_map,
> +			      struct worktree **worktrees)
>  {
>  	struct fetch_head fetch_head;
>  	struct commit *commit;
> @@ -1188,7 +1190,8 @@ static int store_updated_refs(const char *raw_url,=
 const char *remote_name,
>  			strbuf_reset(&note);
>  			if (ref) {
>  				rc |=3D update_local_ref(ref, transaction, what,
> -						       rm, &note, summary_width);
> +						       rm, &note, summary_width,
> +						       worktrees);
>  				free(ref);
>  			} else if (write_fetch_head || dry_run) {
>  				/*
> @@ -1301,16 +1304,15 @@ static int fetch_refs(struct transport *transpor=
t, struct ref *ref_map)
>  }
>
>  /* Update local refs based on the ref values fetched from a remote */
> -static int consume_refs(struct transport *transport, struct ref *ref_ma=
p)
> +static int consume_refs(struct transport *transport, struct ref *ref_ma=
p,
> +			struct worktree **worktrees)
>  {
>  	int connectivity_checked =3D transport->smart_options
>  		? transport->smart_options->connectivity_checked : 0;
>  	int ret;
>  	trace2_region_enter("fetch", "consume_refs", the_repository);
> -	ret =3D store_updated_refs(transport->url,
> -				 transport->remote->name,
> -				 connectivity_checked,
> -				 ref_map);
> +	ret =3D store_updated_refs(transport->url, transport->remote->name,
> +				 connectivity_checked, ref_map, worktrees);

Again, this rewrapping is slightly distracting to my brain.

>  	transport_unlock_pack(transport);
>  	trace2_region_leave("fetch", "consume_refs", the_repository);
>  	return ret;
> @@ -1643,7 +1647,7 @@ static int do_fetch(struct transport *transport,
>  				  "you need to specify exactly one branch with the --set-upstream o=
ption"));
>  		}
>  	}
> - skip:
> +skip:

Okay, this one is distracting _but also_ pleasing. I am only pointing this
out to prove that I did not go over your patch sloppily. :-)

> @@ -1653,11 +1657,12 @@ static int do_fetch(struct transport *transport,
>  		ref_map =3D NULL;
>  		find_non_local_tags(remote_refs, &ref_map, &tail);
>  		if (ref_map)
> -			backfill_tags(transport, ref_map);
> +			backfill_tags(transport, ref_map, worktrees);
>  		free_refs(ref_map);
>  	}
>
> - cleanup:
> +cleanup:

Same here.

> +	free_worktrees(worktrees);
>  	return retcode;
>  }
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 4db8edd9c8..36fb90f4b0 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1770,4 +1770,22 @@ test_expect_success 'denyCurrentBranch and worktr=
ees' '
>  	git -C cloned push origin HEAD:new-wt &&
>  	test_must_fail git -C cloned push --delete origin new-wt
>  '
> +
> +test_expect_success 'refuse fetch to current branch of worktree' '
> +	test_when_finished "git worktree remove --force wt && git branch -D wt=
" &&
> +	git worktree add wt &&
> +	test_commit apple &&
> +	test_must_fail git fetch . HEAD:wt &&
> +	git fetch -u . HEAD:wt
> +'
> +
> +test_expect_success 'refuse fetch to current branch of bare repository =
worktree' '
> +	test_when_finished "rm -fr bare.git" &&
> +	git clone --bare . bare.git &&
> +	git -C bare.git worktree add wt &&
> +	test_commit banana &&
> +	test_must_fail git -C bare.git fetch .. HEAD:wt &&
> +	git -C bare.git fetch -u .. HEAD:wt
> +'
> +
>  test_done

Reads nicely.

Thanks,
Dscho

Footnote: https://en.wikipedia.org/wiki/Hungry_judge_effect

--8323328-1786659332-1637586298=:63--
