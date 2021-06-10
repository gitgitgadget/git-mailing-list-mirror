Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B385BC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FC7613FE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 09:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhFJJ05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 05:26:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:42917 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJJ04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 05:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623317094;
        bh=nyMtpDtf/lbdNKrCRvtX9QL6pqxMsmpxsp9SZI7HbIU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FpmcJjuuXLXzBKlV2vIVp0L9y3oE/75nspX0sD18hkWnaj5/9yWfEFFbRMRzollZB
         skG2k7qa+4F+B26rFT6n/hWv38q3gGwFWZmXyU2Cb/B3SczBu1ny6VrKVlMu64tGRO
         rGEHM7UF/+q6sE3O5bHAmwMktnzrMTDs25xY/Psg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1fis-1lBIJp45Si-011zbQ; Thu, 10
 Jun 2021 11:24:54 +0200
Date:   Thu, 10 Jun 2021 11:24:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] remote: initialize values that might not be set
In-Reply-To: <xmqqlf7ltg4q.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106101046470.57@tvgsbejvaqbjf.bet>
References: <pull.974.git.1623069570553.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet> <xmqqlf7ltg4q.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XITryIljrAF8Gv4js6lS9LHyIIA7SiPs6ivvlUVjdXorD8HxauI
 I4O4uZiboiwADTLfE8jx5ycvsAmqj1NqeUABlzokp8iwBy1FkYvpOncFYu39VbCNwecAXp0
 MsIS9MzGpGxZGyyLEskuw55LiGdzYe9cmYsvz0U2BlqmQlMclZKM5nWd6KamWB76mbqA5Y3
 pNX4EHx6aBaLiBotDyxDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zfmL2GjQNmA=:zXvRFqqlvAmgAkelQVz/jS
 c6XQ91HFHK0DGiiz5FX1vS92+dcalZZtPoSxhuxE4hAjsYZeIt/QZuoN9zo8ZYz+UIQPEPie7
 7KthGz5n1rbtT+TD8SuADOJ8sTqb5WGbv725f2fZBgKq9VbcuH2OOESW5GzXVNHNiRN+1hef/
 /wqZo1lxfXmkNbhCNeRZ5H/H4sJ0bpqoBRfyNnqjhY/ujDYFODemqOr4oPkMcUlpAUkzH/4d0
 6ZtXIfNBtV84gc2adIVFWix+QMXPxzzI8hqE/OA4KnNO3TOIj5vS2XWaBTOsIFioGIDmycTKm
 LAHtw324fTieGPwkWfyZ9bgC74LVSeQNmBbBGxxNkDPk1Q8mW4wzh2FdvhuM5YipJOhimYutf
 5HpvJzjXXw73gNPPaU6+lrBgVk9kgUJEhqPQPJnRRSoGwovc801c77e/dwFnY+YBpHcxomrmU
 ZCBonuV7un1FA9ZHsN/oGDrkK88mb8tkL0ScS1s+5JYlEx55kcOu7icokD7GUBhlzYfhB2QAK
 bHLHLIY3XZS8uF/FLyUsx1pSR+Kb46el0aCkSw7q3lsfCPHhV4VaxD/1LNleeXTjj/lc9U7Ad
 3dxC9Y1RvIHmuUYyIEKT35Iw+iKDO+HIKqJ/BgXB22lrYEza3PzmvcweOLxMImHG6qGDAlW4H
 Avf2WWHoojpZev4vtLZTuADKLtWcD0RYFCZef989615+ssXS4MsDIAdKd6iOq4KFOnqwCkClJ
 J/OZoHXIpV+sfmDX7yGvubaUKZIqYfNgIYaigYtD5TGhiUYqr7SSGvadEEx3asl35z0JwyBB6
 g57e8/MKBaOQ8qySepgFjMfxCCo23h8PSRlvstENT0rTwtLsJXQ1Q+zUo9wNArjtDUWG6EfHR
 3Rbm65fhpIoHSOV53A5GbTQLTt9wiSduqZ5HeUypZ65/iw0Me+lDTZyFkszZkTcwHd3n9Rlcl
 3U32rO0S9KPk2lZdVToGVlArnlZm/xMCe+5afzOX+BjwzJpy7s5gm7lA2/EoaLVk3xVpKjQ9+
 zlQsUXEqBQ+Kfy6IprAHqfXIb45yuxv3xYIaUXtlkh86njbHyVhzVSAXDrvU43oWX/bj1gHrd
 Rrc+xMMmyKIcdVvgaFSQMk5PWG9TAF9+T7GlWeRAVFRVmrOqTDaxHwABg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 8 Jun 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> diff --git a/remote.c b/remote.c
> >> index c3f85c17ca7c..a116392fb057 100644
> >> --- a/remote.c
> >> +++ b/remote.c
> >> @@ -2101,7 +2101,7 @@ int stat_tracking_info(struct branch *branch, i=
nt *num_ours, int *num_theirs,
> >>  int format_tracking_info(struct branch *branch, struct strbuf *sb,
> >>  			 enum ahead_behind_flags abf)
> >>  {
> >> -	int ours, theirs, sti;
> >> +	int ours =3D 0, theirs =3D 0, sti =3D 0;
> >
> > While I like this change, I am somewhat confused where the values are =
used
> > for branching. The only time I see them used when `stat_branch_pair()`=
 has
> > _not_ initialized `ours` and `theirs` is in those `trace2_data_intmax(=
)`
> > calls. Otherwise `sti` is set to -1 and the other users of `ours` and
> > `theirs` aren't reached.
> >
> > If my reading of the code is correct, maybe the commit message could b=
e
> > adjusted to talk about tracing instead of branching?
>
> I too wondered why initializing them to 0 is safe (instead of hiding
> latent bugs).  I think that stat_tracking_info() would always return
> -1 if returns before reaching the point in stat_branch_pair(),

While that is true, I was trying to make a different point: I noticed that
the `ours`/`theirs` variables _are_ used, even if `sti` is negative. The
code that I looked at reads like this:

	int format_tracking_info(struct branch *branch, struct strbuf *sb,
				 enum ahead_behind_flags abf)
	{
		int ours, theirs, sti;
		const char *full_base;
		char *base;
		int upstream_is_gone =3D 0;

		trace2_region_enter("tracking", "stat_tracking_info", NULL);
		sti =3D stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
		trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_flags", abf)=
;
		trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_result", sti=
);
		if (abf =3D=3D AHEAD_BEHIND_FULL) {
		    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_ahead", =
ours);
		    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_behind",=
 theirs);
		}
		trace2_region_leave("tracking", "stat_tracking_info", NULL);

		if (sti < 0) {
			if (!full_base)
				return 0;
			upstream_is_gone =3D 1;
		}

You will notice that there are two Trace2 calls in that conditional `abf
=3D=3D AHEAD_BEHIND_FULL` block.

Now, what I failed to realize when reviewing this code (and I _bet_ Stolee
was in the same boat when they contributed the patch) is that this version
of `format_tracking_info()` is different from what is in v2.32.0. It is
the version we have in the `microsoft/git` fork, and it has not yet made
it upstream. To be precise, it is this commit:
https://github.com/microsoft/git/commit/91209e591b0398c8334a78001a245807f7=
eb348a

In light of this, it might make more sense for us to fixup! this commit
thusly:

=2D- snip --
diff --git a/remote.c b/remote.c
index caed9cbc31b1..cfb7b6bd8d30 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -2110,7 +2110,7 @@ int format_tracking_info(struct branch *branch, stru=
ct strbuf *sb,
 	sti =3D stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
 	trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_flags", abf)=
;
 	trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_result", sti=
);
-	if (abf =3D=3D AHEAD_BEHIND_FULL) {
+	if (sti >=3D 0 && abf =3D=3D AHEAD_BEHIND_FULL) {
 	    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_ahead", =
ours);
 	    trace2_data_intmax("tracking", NULL, "stat_tracking_info/ab_behind",=
 theirs);
 	}
=2D- snap --

This would be in line with how `format_tracking_info()` avoids accessing
`ours` and `theirs` if `stat_tracking_info()` returned a negative value.

I opened the corresponding PR here:
https://github.com/microsoft/git/pull/373

> but it is not clear how we can futureproof the whole thing.
>
> If these two are initialized to say -1 here, and then we had some
> sanity check, perhaps like so:
>
> 	sti =3D stat_tracking_info(branch, &ours, &theirs, &full_base, 0, abf);
> +	assert(sti < 0 || (0 <=3D ours && 0 <=3D theirs));
> 	if (sti < 0) {
> 		if (!full_base)
> 	...
>
> to enforce the invariant we assume (i.e. OK sti means ours and
> theirs are set), it would allow us to sleep better, perhaps?

As I have stated elsewhere, I am somewhat doubtful of the benefit those
`assert()` calls give us.

I wish there was a way to integrate some sort of static analysis that
would warn us about using uninitialized values.

Of course, we would have to make sure that it does not show as many false
positives about `struct strbuf` and `struct strvec` "overrunning" on their
buffer. This is what dominates Coverity's report, for example.

FWIW I played a little with CodeQL on GitHub, but have not found time to
continue on that in a long time... my current state is pushed as `codeql`
to my fork: https://github.com/git/git/compare/master...dscho:codeql, just
in case somebody interested wants to take this further).

Ciao,
Dscho
