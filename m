Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82307202A0
	for <e@80x24.org>; Tue,  7 Nov 2017 16:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934707AbdKGQbC (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 11:31:02 -0500
Received: from mout.gmx.net ([212.227.15.19]:50163 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751824AbdKGQbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 11:31:00 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZzKf-1ex0pn1OcX-00lmcY; Tue, 07
 Nov 2017 17:30:54 +0100
Date:   Tue, 7 Nov 2017 17:30:52 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
Subject: [PATCH v3 0/3] for-each-ref: add :remoteref and :remotename
 specifiers
In-Reply-To: <cover.1507205895.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1510072200.git.johannes.schindelin@gmx.de>
References: <cover.1507205895.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Wy5s4jHVJcVOqUDgS1z8Xn3lRPybAZwjBI707QVYNowvtL/r+M5
 Hw2bI6dUXQrNdRSQwBZ5eMaOuLmLwRsy1rJN26d9KSrfRpJApO5j/NjB/C1LNYNZGoDJ+5r
 rxccI2DCvRTAjYk220b0QhI+Sy3VCaBn4bvo0IufiR8ZvFbvvZVH5UjrMCZD9ZLDuUl72ek
 eaa2ypuBS6BipJSdLxTbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v6DDGnmlwd8=:JKeNxgGN1eqLQwdEjd5buO
 m2Cqe9gH63AZ8D0crIZ9gDScDF/HKt0U6AgQ/Jp5nSlqV4s8c2KgbQjT0njFi0U8hMjLtFwoS
 hhfKfOdx9t+zwnfUs3BeCA+jkygfuVrib0Rzp44ZWBNyhizWo/fXKQhyaPxJAyjNz9knC/V+k
 ugkwB3FR65yppeW2z24EWcdDWLJQBLqL35OfCaT7aJtNdObJTbFgJSqZTr9t5Z0KhdcpcKxt+
 S9ERsfL7PSR/ZfPfWwDxWbFOUBSeO/+tHVeCjEjVeRAxIywh+iefzj1tQbMfOd9Cyg2nwyQnY
 PXjKs3NwahhMGngVsPIntULtPT7z0PIZbGJL1SM38u6LNt3YZWbdLVO72dpzB1sZEmYkonvq3
 +yu3YHuWs4xQ0SI+TOuSXsxIy5umoO3JOX841uiGCDrp1Vv7qHSJ+/NUJaPIA9StDU+R+BGkN
 GW13+/BAVXKR4PUMdkfh1DOapbBafIzPJH48l2auXAzHnBBjcc6giPTOkS/wcHeeuR7rTuPF/
 qrRxWXVIbecNpoCqm8YhAEvRvfjdCV2kHxZYLlwp8ZjrBC1qr4k6AADQdcFR+3UJ99qI+0Z0B
 pkEcqqIFKuxfWVtLOMlGJjO1go9b3LD3MPw2Wp7aBhji2uSbbLro/NoP02Mt3IkCaZ4+7jLjT
 tXB/c/iscLli9VxHvkr8989cgOzPPTYwJh7mkKLMPWI84BaFNECj/5WKlDKRvRun2CD3lPoKZ
 JmnS0dWEWNNwKphVxagTYgXYYK8pNokDG3V2K2XQeMeA8mb3ypaY+57kyEmkBnJJAMdDBqowx
 F9KvDPcbgcYpN3N1waRAuDqzI9BbbiESjRQB4qsZ6z0KB2233w=
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

Changes since v2:

- fixed the commit message of 1/3 to no longer talk about :remote.

- used the push atom in 2/3, made the code look more as suggested by Junio.

- fixed the oneline of 2/3 to use a verb ("report").

- butchered Junio's proposed documentation update for 2/3 to hopefully make
  the description of :remotename and :remoteref a lot clearer.


J Wyman (1):
  for-each-ref: let upstream/push report the remote ref name

Johannes Schindelin (2):
  for-each-ref: let upstream/push optionally report the remote name
  for-each-ref: test :remotename and :remoteref

 Documentation/git-for-each-ref.txt | 23 +++++++++++-------
 ref-filter.c                       | 48 ++++++++++++++++++++++++++++++++------
 remote.c                           | 30 ++++++++++++++++++++++++
 remote.h                           |  2 ++
 t/t6300-for-each-ref.sh            | 32 +++++++++++++++++++++++++
 5 files changed, 120 insertions(+), 15 deletions(-)


base-commit: 7668cbc60578f99a4c048f8f8f38787930b8147b
Published-As: https://github.com/dscho/git/releases/tag/ref-filter-remote-name-v3
Fetch-It-Via: git fetch https://github.com/dscho/git ref-filter-remote-name-v3

Interdiff vs v2:
 diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
 index aff44c064a4..dffa14a7950 100644
 --- a/Documentation/git-for-each-ref.txt
 +++ b/Documentation/git-for-each-ref.txt
 @@ -147,9 +147,12 @@ upstream::
  	encountered. Append `:track,nobracket` to show tracking
  	information without brackets (i.e "ahead N, behind M").
  +
 -Also respects `:remotename` to state the name of the *remote* instead
 -of the ref, and `:remoteref` to state the name of the *reference* as
 -locally known by the remote.
 +For any remote-tracking branch `%(upstream)`, `%(upstream:remotename)`
 +and `%(upstream:remoteref)` refer to the name of the remote and the
 +name of the tracked remote ref, respectively. In other words, the
 +remote-tracking branch can be updated explicitly and individually by
 +using the refspec `%(upstream:remoteref):%(upstream)` to fetch from
 +`%(upstream:remotename)`.
  +
  Has no effect if the ref does not have tracking information associated
  with it.  All the options apart from `nobracket` are mutually exclusive,
 diff --git a/ref-filter.c b/ref-filter.c
 index bf078657d91..3f9161707e6 100644
 --- a/ref-filter.c
 +++ b/ref-filter.c
 @@ -1289,9 +1289,11 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
  		else
  			*s = "";
  	} else if (atom->u.remote_ref.option == RR_REMOTE_REF) {
 -		int explicit, for_push = starts_with(atom->name, "push");
 -		const char *merge = remote_ref_for_branch(branch, for_push,
 -							  &explicit);
 +		int explicit;
 +		const char *merge;
 +
 +		merge = remote_ref_for_branch(branch, atom->u.remote_ref.push,
 +					      &explicit);
  		if (explicit)
  			*s = xstrdup(merge);
  		else
-- 
2.15.0.windows.1

