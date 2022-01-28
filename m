Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65951C433EF
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 16:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349866AbiA1QbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 11:31:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:49735 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbiA1QbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 11:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643387466;
        bh=NpCiFR83j+DkMuXKQE4+pEYUKWNbb2aoKbJuc97HKtQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WVPiSt7+c1wEVbWRA7+CO89YixrKq4ZC1Jb0FTde3YhCxK7j2V0x9mjxBuwKYqwfu
         HNi2e2Z1P/3rpXnHxN3izk+XEfxiNXojO+SAQOfV1ZpRF1+lw9k3zSZiR1U2aU5zXb
         bUbvjNj3aR/zafpBCUXEHNlMoBmMzKgW2OU76vWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.213.181]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9dsV-1m8tTw2YhJ-015bEO; Fri, 28
 Jan 2022 17:31:05 +0100
Date:   Fri, 28 Jan 2022 17:31:03 +0100 (CET)
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
Subject: Re: [PATCH 06/12] merge-ort: allow update messages to be written to
 different file stream
In-Reply-To: <e3ef17eb46fdfd759030761ab6d7c35fbf24ee0f.1642888562.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201281716420.347@tvgsbejvaqbjf.bet>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com> <e3ef17eb46fdfd759030761ab6d7c35fbf24ee0f.1642888562.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gye5lENrlKpO/r6ccDqjU2UGS6a1iQm5UpTpa9xHAIVWARuhSEI
 O19vVyjCcPK5VKj1WBFCzQSQgXawW9shHJ4kA0m1uOBMnRcrdSPQINw/YqGYFSPFsdolxdj
 ZUai42ryz5kqy7MP7KY7+iOEHFSuU631wrPvsE7wnTAT+K2r4oyTWVj2IzKJa/W2HG80+bc
 trkjg3T5orHQkL2P0RGxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0HnUWR1MgpE=:FmbVFGRy/SCWkRnkXeAm4q
 x36NzweJdBukcURW4IwZVEvguXv0VgQe1ZJeXh41jbdwOgX/vau/B7Iko7InauAee3r0G0bgY
 /MGnF3799qjWhTwC/Cp7WFIujdTnEH41WGfJAxAgGhJOgHAyM15ZXUa5fbZ7r7+MxJRY2+Rks
 IVyTfDbROvqbizjBBXOiZvg9avNOHm7zLqNoPDbmcFaV9OHvZtgcqBln9uX9SGY5Zu8mDuolk
 lpdB/v7GKEpVh6yI3jq4nG5/ZHJE/iuOgYyr+qNDXyJ6FZhOkKk/n3Ea2Iniac0S0q9Tkm9az
 4bo7B/yK7MNVvRGktRbC6TFbmxcMn2RWJSda4pDJ1zm0ECKEXkcxgAcFn9vwdRqpJNSgHYoQb
 qGpy73yHi8DNC7huxW37xY/Z1ZlGiQh8Sez4emYQhmv8gEl+JEx2e4AIw94N8gGjvjjA9Zigp
 AIaNnGUp3BkAqIkOoFrJhKkzc8m6UHfy8oMw5+l1mCiI1gS2gHQjqeWzQuukvholtPsiYEfXM
 6lCGFxb/C2TRXbkclPtl15SzVhdA8VwCapzSAVGrqbLQFdK7jBv0kpeoWj2p1SvYhr7gF3oYh
 hrKcVjnMV68MG6fapGmIx30srOMNYKh8RT6HFJALhEMGkbJIg4MiVIS/VPc5zTVY/71Y+KnDA
 FR0hZ1ZvJVS0qa48QGjDFOjh/ov/kdE2zffnTsae9i3+m6Jgl+wgF241qnF5im5V5mbO0IEuj
 CfYQ0w/78AynEG3Ed43WES76IHrpGYjhPoWkjjUjlp+IxYw1tzMJNIA1ASXk9jeMU4JB9jFKi
 GOE8KcLTl+FPK2Wrw0XnU5ahYuxvFY8ZdiOzszPsSrHNyNEA/0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 22 Jan 2022, Elijah Newren via GitGitGadget wrote:

> diff --git a/merge-ort.c b/merge-ort.c
> index f9e35b0f96b..b78dde55ad9 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4236,7 +4236,8 @@ static int record_conflicted_index_entries(struct =
merge_options *opt)
>  }
>
>  void merge_display_update_messages(struct merge_options *opt,
> -				   struct merge_result *result)
> +				   struct merge_result *result,
> +				   FILE *stream)
>  {
>  	struct merge_options_internal *opti =3D result->priv;
>  	struct hashmap_iter iter;
> @@ -4263,7 +4264,7 @@ void merge_display_update_messages(struct merge_op=
tions *opt,
>  	for (i =3D 0; i < olist.nr; ++i) {
>  		struct strbuf *sb =3D olist.items[i].util;
>
> -		printf("%s", sb->buf);
> +		fprintf(stream, "%s", sb->buf);

Maybe `strbuf_write(sb, stream);` instead? Whenever I see a `"%s"`, I feel
like it's unnecessary churn...

>  	}
>  	string_list_clear(&olist, 0);
>

Missing from this hunk:

        /* Also include needed rename limit adjustment now */
        diff_warn_rename_limit("merge.renamelimit",
                               opti->renames.needed_limit, 0);

This function explicitly writes to `stdout`, and will need to be adjusted,
I think, before we can include an adjustment to this call in this patch.

Unless we override `warn_routine()` (which is used inside that function),
that is. Which is hacky, and we would not have addressed the
`fflush(stdout)` in `diff_warn_rename_limit()`. So I would much prefer
something like this:

=2D- snip --
diff --git a/diff.c b/diff.c
index 861282db1c3..87966602cbd 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -6312,17 +6312,25 @@ static const char rename_limit_advice[] =3D
 N_("you may want to set your %s variable to at least "
    "%d and retry the command.");

-void diff_warn_rename_limit(const char *varname, int needed, int degraded=
_cc)
+void diff_warn_rename_limit(const char *varname, int needed, int degraded=
_cc,
+			    FILE *out)
 {
-	fflush(stdout);
+	const char *fmt =3D NULL;
+
 	if (degraded_cc)
-		warning(_(degrade_cc_to_c_warning));
+		fmt =3D _(degrade_cc_to_c_warning);
 	else if (needed)
-		warning(_(rename_limit_warning));
+		fmt =3D _(rename_limit_warning);
 	else
 		return;
 	if (0 < needed)
-		warning(_(rename_limit_advice), varname, needed);
+		fmt =3D _(rename_limit_advice);
+
+	fflush(out);
+	if (out =3D=3D stdout)
+		warning(fmt, varname, needed);
+	else
+		fprintf(out, fmt, varname, needed);
 }

 static void diff_flush_patch_all_file_pairs(struct diff_options *o)
@@ -6754,7 +6762,7 @@ int diff_result_code(struct diff_options *opt, int s=
tatus)

 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
-			       opt->degraded_cc_to_c);
+			       opt->degraded_cc_to_c, stdout);
 	if (!opt->flags.exit_with_status &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
diff --git a/diff.h b/diff.h
index 8ba85c5e605..be4ee68c0a2 100644
=2D-- a/diff.h
+++ b/diff.h
@@ -596,7 +596,8 @@ void diffcore_fix_diff_index(void);
 int diff_queue_is_empty(void);
 void diff_flush(struct diff_options*);
 void diff_free(struct diff_options*);
-void diff_warn_rename_limit(const char *varname, int needed, int degraded=
_cc);
+void diff_warn_rename_limit(const char *varname, int needed, int degraded=
_cc,
+			    FILE *out);

 /* diff-raw status letters */
 #define DIFF_STATUS_ADDED		'A'
diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..e6b5a0e7c64 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -4264,7 +4264,7 @@ void merge_switch_to_result(struct merge_options *op=
t,

 		/* Also include needed rename limit adjustment now */
 		diff_warn_rename_limit("merge.renamelimit",
-				       opti->renames.needed_limit, 0);
+				       opti->renames.needed_limit, 0, stdout);

 		trace2_region_leave("merge", "display messages", opt->repo);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index d9457797dbb..10b2948678c 100644
=2D-- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3731,7 +3731,8 @@ static void merge_finalize(struct merge_options *opt=
)
 		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
-				       opt->priv->needed_rename_limit, 0);
+				       opt->priv->needed_rename_limit, 0,
+				       stdout);
 	FREE_AND_NULL(opt->priv);
 }

=2D- snap --

The rest of the patch looks good to me.

Thanks,
Dscho

> @@ -4313,7 +4314,7 @@ void merge_switch_to_result(struct merge_options *=
opt,
>  	}
>
>  	if (display_update_msgs)
> -		merge_display_update_messages(opt, result);
> +		merge_display_update_messages(opt, result, stdout);
>
>  	merge_finalize(opt, result);
>  }
> diff --git a/merge-ort.h b/merge-ort.h
> index e5aec45b18f..d643b47cb7c 100644
> --- a/merge-ort.h
> +++ b/merge-ort.h
> @@ -86,7 +86,8 @@ void merge_switch_to_result(struct merge_options *opt,
>   * so only call this when bypassing merge_switch_to_result().
>   */
>  void merge_display_update_messages(struct merge_options *opt,
> -				   struct merge_result *result);
> +				   struct merge_result *result,
> +				   FILE *stream);
>
>  /* Do needed cleanup when not calling merge_switch_to_result() */
>  void merge_finalize(struct merge_options *opt,
> --
> gitgitgadget
>
>
