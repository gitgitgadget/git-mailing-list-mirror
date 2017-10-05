Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3011B20281
	for <e@80x24.org>; Thu,  5 Oct 2017 12:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751318AbdJEMTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 08:19:09 -0400
Received: from mout.gmx.net ([212.227.15.15]:60454 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdJEMTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 08:19:08 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lp3Lw-1dLXlU1abM-00evJl; Thu, 05
 Oct 2017 14:19:04 +0200
Date:   Thu, 5 Oct 2017 14:19:03 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] for-each-ref: add :remoteref and :remotename
 specifiers
In-Reply-To: <cover.1506952571.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1507205895.git.johannes.schindelin@gmx.de>
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:hHllK8IKsgxOZZJ1AennoYgaWHIcJjXJXs+NgOb3wfcniYO+ZHJ
 Iy27uRo8r0ffZCLCmz7PXpoN5gNXUniVOOU2MksorcJiWszWyZUz5qh7PdgK4kNJLb46Mns
 qiclkJmX781eltM8o2ceF0Ol87kqJ0BN+Sawn9sPApaQatocok+J9oKxcuXDN6zFyOjDpYJ
 DQU2u00vWfYS/FlK0Pmtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GGUaVSFhnwA=:Mo9kt74cbvJwyq4I/z7q/y
 au8Ark75bpJDc/2dQ4OB/4R0uqNi5RRXAlEYe7B1SaNVDS5g+7wa5gfJX/7xuwacFTLwzRcrq
 LDyhXxkB9ViYP7cA8XCop4Ado+oFIm+m51UdToCUJS/ZUHt35OM2SCgHQKUEJzIK6p0DLMh1q
 dVDCAhoVSM3VpLLFFWoBokeBQSRdMLkcw4PpJ3bzu2pMfMkr533J+mnqoHwv2iLGy8NgQ5N7m
 c3Mx4JoBfDNdJBbsWzw3E3cMvB/VO6ZTd8U+rCPep+Qk6HxunZU3vLMMBGFbCDDL7DUul9MOL
 MeeI0gDvLyNCBGMRLoSZ74E9BPzLFsNQxREX0NJXzc8ccYhD2AqdS/pQY/VGSs7KS6VA099MK
 4h6WHv3qazAVvLjDvSnJx8LbiTpf7CikCe0RxSntnTJMAHtljp7P9G9mpy86g2W/gdja4arLS
 uq8AJdYYKiuLLgWk4qKP8hhYlQJjyeNww2JPn3hf6avQO7u4HVADmikhmDvI5ViUdARVFi1Pu
 IpNj7RBQt1cbYkQgSKEChK9OUO20TIzHKrhCy36aeYxZQMPlR20x3Vyx+wJQQbB3wnKfvZfZ6
 6j47b/T/SckGuKE7nKyT/5fNOo2ieAF26kJP0DOkwOibiooIJUK9b/JJzBJYrH5qS9H1CA84U
 92qRfImMbqStL4JBemQuqXWyKPtTV5JSGmnV+P9zjY4R0AyH5nW4IuzED3ePpJGMPN0nBMp+z
 ryCGeUgbMnt7S7IpMmHUM5eHVz1QMFh69lx3uVrxSVyfTjNLkEW7phupYZbSm0c9EFYH2mLoJ
 piKnN3kuXtDvDDsaY+NMbiRLAr+1KxNFKJS9tmw1e6hVKTBEdk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This introduces support for

	git for-each-ref \
		--format="%(merge:remotename),%(merge:remoteref)"
	git for-each-ref \
		--format="%(push:remotename),%(push:remoteref)"

to figure out the remote nickname as well as the name of the corresponding
branch on the remote.

Note: the `%(push:remotename)` placeholder is only interpolated by the value
of `branch.<name>.pushRemote`; unlike `git push`, it does not fall back to
`branch.<name>.remote`. Likewise, `%(push:remoteref)` interpolates to the
empty string unless `remote.<nick>.pushRefs` is configured.

This is useful for third-party tools that need to know this type of information
for tons of branches.

Changes since v1:

- added the missing sign-offs

- removed a full stop from the end of the oneline of 2/3 (quite frankly, I am
  surprised I was not slammed for that in the first round of reviews ;-))

- fixed stale commit message parts that were leftovers from previous, internal
  review rounds

- moved the added git-for-each-ref.txt documentation into its own paragraph

- renamed the :remote-name and :remote-ref suffixes into the dashless form
  :remotename and :remoteref, following the example of :trackshort

- clarified the motivation for not DWIMming in the commit messages

- added fields `push` and `push_remote` to the atom to precompute whether we
  are talking about a `push` atom and whether it has a suffix starting with
  `remote`, respectively

Note that this last point actually fixes a bug when the user specified more
than one suffix (`push:short,remotename`; even if that `short` has no effect,
the `remotename` should).


J Wyman (1):
  for-each-ref: let upstream/push optionally remote ref name

Johannes Schindelin (2):
  for-each-ref: let upstream/push optionally report the remote name
  for-each-ref: test :remotename and :remoteref

 Documentation/git-for-each-ref.txt | 20 ++++++++++-------
 ref-filter.c                       | 46 ++++++++++++++++++++++++++++++++------
 remote.c                           | 30 +++++++++++++++++++++++++
 remote.h                           |  2 ++
 t/t6300-for-each-ref.sh            | 32 ++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 15 deletions(-)


base-commit: 217f2767cbcb562872437eed4dec62e00846d90c
Published-As: https://github.com/dscho/git/releases/tag/ref-filter-remote-name-v2
Fetch-It-Via: git fetch https://github.com/dscho/git ref-filter-remote-name-v2

Interdiff vs v1:
 diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
 index ba1147a1223..22767025850 100644
 --- a/Documentation/git-for-each-ref.txt
 +++ b/Documentation/git-for-each-ref.txt
 @@ -140,10 +140,11 @@ upstream::
  	(behind), "<>" (ahead and behind), or "=" (in sync). `:track`
  	also prints "[gone]" whenever unknown upstream ref is
  	encountered. Append `:track,nobracket` to show tracking
 -	information without brackets (i.e "ahead N, behind M").  Also
 -	respects `:remote-name` to state the name of the *remote* instead
 -	of the ref, and `:remote-ref` to state the name of the *reference*
 -	as locally known by the remote.
 +	information without brackets (i.e "ahead N, behind M").
 ++
 +Also respects `:remotename` to state the name of the *remote* instead
 +of the ref, and `:remoteref` to state the name of the *reference* as
 +locally known by the remote.
  +
  Has no effect if the ref does not have tracking information associated
  with it.  All the options apart from `nobracket` are mutually exclusive,
 @@ -152,7 +153,7 @@ but if used together the last option is selected.
  push::
  	The name of a local ref which represents the `@{push}`
  	location for the displayed ref. Respects `:short`, `:lstrip`,
 -	`:rstrip`, `:track`, `:trackshort`, `:remote-name`, and `:remote-ref`
 +	`:rstrip`, `:track`, `:trackshort`, `:remotename`, and `:remoteref`
  	options as `upstream` does. Produces an empty string if no `@{push}`
  	ref is configured.
  
 diff --git a/ref-filter.c b/ref-filter.c
 index 696a8241408..b4b2c9b2190 100644
 --- a/ref-filter.c
 +++ b/ref-filter.c
 @@ -80,7 +80,7 @@ static struct used_atom {
  				RR_REF, RR_TRACK, RR_TRACKSHORT, RR_REMOTE_NAME, RR_REMOTE_REF
  			} option;
  			struct refname_atom refname;
 -			unsigned int nobracket : 1;
 +			unsigned int nobracket : 1, push : 1, push_remote : 1;
  		} remote_ref;
  		struct {
  			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 @@ -139,6 +139,9 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
  	struct string_list params = STRING_LIST_INIT_DUP;
  	int i;
  
 +	if (!strcmp(atom->name, "push") || starts_with(atom->name, "push:"))
 +		atom->u.remote_ref.push = 1;
 +
  	if (!arg) {
  		atom->u.remote_ref.option = RR_REF;
  		refname_atom_parser_internal(&atom->u.remote_ref.refname,
 @@ -158,11 +161,13 @@ static void remote_ref_atom_parser(const struct ref_format *format, struct used_
  			atom->u.remote_ref.option = RR_TRACKSHORT;
  		else if (!strcmp(s, "nobracket"))
  			atom->u.remote_ref.nobracket = 1;
 -		else if (!strcmp(s, "remote-name"))
 +		else if (!strcmp(s, "remotename")) {
  			atom->u.remote_ref.option = RR_REMOTE_NAME;
 -		else if (!strcmp(s, "remote-ref"))
 +			atom->u.remote_ref.push_remote = 1;
 +		} else if (!strcmp(s, "remoteref")) {
  			atom->u.remote_ref.option = RR_REMOTE_REF;
 -		else {
 +			atom->u.remote_ref.push_remote = 1;
 +		} else {
  			atom->u.remote_ref.option = RR_REF;
  			refname_atom_parser_internal(&atom->u.remote_ref.refname,
  						     arg, atom->name);
 @@ -1253,7 +1258,7 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
  			*s = "<>";
  	} else if (atom->u.remote_ref.option == RR_REMOTE_NAME) {
  		int explicit;
 -		const char *remote = starts_with(atom->name, "push") ?
 +		const char *remote = atom->u.remote_ref.push ?
  			pushremote_for_branch(branch, &explicit) :
  			remote_for_branch(branch, &explicit);
  		if (explicit)
 @@ -1377,14 +1382,14 @@ static void populate_value(struct ref_array_item *ref)
  			if (refname)
  				fill_remote_ref_details(atom, refname, branch, &v->s);
  			continue;
 -		} else if (starts_with(name, "push")) {
 +		} else if (atom->u.remote_ref.push) {
  			const char *branch_name;
  			if (!skip_prefix(ref->refname, "refs/heads/",
  					 &branch_name))
  				continue;
  			branch = branch_get(branch_name);
  
 -			if (starts_with(name, "push:remote-"))
 +			if (atom->u.remote_ref.push_remote)
  				refname = NULL;
  			else {
  				refname = branch_get_push(branch, NULL);
 diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
 index edc73dd79aa..d9eb2be0256 100755
 --- a/t/t6300-for-each-ref.sh
 +++ b/t/t6300-for-each-ref.sh
 @@ -675,7 +675,7 @@ test_expect_success 'Verify usage of %(symref:rstrip) atom' '
  	test_cmp expected actual
  '
  
 -test_expect_success ':remote-name and :remote-ref' '
 +test_expect_success ':remotename and :remoteref' '
  	git init remote-tests &&
  	(
  		cd remote-tests &&
 @@ -687,11 +687,11 @@ test_expect_success ':remote-name and :remote-ref' '
  		git config remote.to.push "refs/heads/*:refs/heads/pushed/*" &&
  		git config branch.master.pushRemote to &&
  		for pair in "%(upstream)=refs/remotes/from/stable" \
 -			"%(upstream:remote-name)=from" \
 -			"%(upstream:remote-ref)=refs/heads/stable" \
 +			"%(upstream:remotename)=from" \
 +			"%(upstream:remoteref)=refs/heads/stable" \
  			"%(push)=refs/remotes/to/pushed/master" \
 -			"%(push:remote-name)=to" \
 -			"%(push:remote-ref)=refs/heads/pushed/master"
 +			"%(push:remotename)=to" \
 +			"%(push:remoteref)=refs/heads/pushed/master"
  		do
  			echo "${pair#*=}" >expect &&
  			git for-each-ref --format="${pair%=*}" \
 @@ -701,7 +701,7 @@ test_expect_success ':remote-name and :remote-ref' '
  		git branch push-simple &&
  		git config branch.push-simple.pushRemote from &&
  		actual="$(git for-each-ref \
 -			--format="%(push:remote-name),%(push:remote-ref)" \
 +			--format="%(push:remotename),%(push:remoteref)" \
  			refs/heads/push-simple)" &&
  		test from, = "$actual"
  	)
-- 
2.14.2.windows.1.2.gdc85205db4d

