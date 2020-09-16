Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CCC43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2F6821D90
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NfDgBCE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgIPSVI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:21:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:60499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbgIPSP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600280109;
        bh=BFaS1pBmu4VsURtnQv/+jwr/Ca7U5qNbkC4di3N1xNI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NfDgBCE/oKRIOKr7I38LkcRFOH6s/7cZZI7/guLyrGA/P/t6yxbd2KQeZHtm+Vehf
         Xn/Urt0Y1j0fAMGNQFB5nuimD4IAktWyhlqCF5ITIfpCWTHzhQ5TPvwokk4A9Za+fB
         RuEHMXXFf84sYp3NlSIsDiD4q+H2ZQ3OJq1do7Ks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.239.213] ([213.196.213.124]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1kEikT1cVa-00Eu6l; Wed, 16
 Sep 2020 14:35:03 +0200
Date:   Wed, 16 Sep 2020 14:35:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/7] remote: add reflog check for
 "force-if-includes"
In-Reply-To: <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009161356560.56@tvgsbejvaqbjf.bet>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com> <20200913145413.18351-1-shrinidhi.kaushik@gmail.com> <20200913145413.18351-2-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bPztFUfVbRCIvlUPa3mzjFi21/Nl4T3dnB/313Cnj8dEM/jJkte
 q8mL5KOPwIoroFL1kkbVDJS6LWmMQYrLDrPvXTa9PczOZukraMr2MNM2rTHcRRAAMhXSuT/
 PaTfsO0KfJufUUCaBgh+SfKpF9uFUfVqdvWumoSc0N4p/EqmpawdMtxiTubOwRoQOQVAI5s
 W/rFK+QLcpJcX4DLTxJkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cRaL4u1TyCY=:of7SFs2fDYsR5eoCMk7jaN
 EH0UtdSiS+KEzcu9ek/Xxqt6etAyJ/FDLW6O1HAQdwZ/tUZwGu2whQIqE2yKTOW8VUW//yFZ4
 j6hNjBnbLxTPyGzMGrlw3Mcja4yZF4ujSYzNqBq7pOvh5fNEtCWhXjNa06kZ25iYkxf6Ow2IJ
 9EpZxG9EX4jyNwSXYnOV8ybjStaac5SwtHfJbaFGq91I6YY+Mfem5sOm5z4PeEzRuJpqowOM0
 1gN0UWNcbyaZOR34ckGc3Q24gYtEhSDIKIyrS9O4HKhWMhuIdfkl9vEIDpAMYE/YIhltpVnSt
 5GFCTco0E38KYlLHeYpYamtu3xld5KfVZ1FEwI6yZxsZOWx4DfsIeAwoaC8tGH6Q6b0Tllf3M
 rJA6ngt6I3zs9hMTImHxnrtRcw2tvZw795OWdhmFcw0geo6SrgKmqUPQ/tlSPegW2RVhFiHHU
 klkTYFu8auhLfCmzqer2c/qzN3e94bymNzFEAFRIlXfLl9L+05L6SobYObLe6kPN5y52c178e
 XBXKbhpxuS5Bp6Y+Ij1YPo0x6g+omDIDgclz25zH4BKa0TsDd0HDGNXOGZq0MYlKXoGwzY+CL
 g4qmCWpFtlfIkHg8LfiqhUp802f1ItHzt8IXsWIVBnMOmpvpjplNUsJFOoPCBrI0mWQcJQIgf
 Q5CBn3sWQTS8p3pM9TDPdYL8Nkg4UrapzpPXALxA4jVaUlyDh00QMYUAl2L0sZfvNH4NHDOOu
 LXCj3/jbUcvlkR4K5ulCag7FqeadKU4juObM15xcQ+qEF6bwSeyQlBLIdV3Fm4H6sL3rBAmbs
 IDLknomrs5CK6Pr0j1j1JQdX7DkoLbkVWlVwGbY0ncYEvLT++yoNtUZySifdopFy5I//XmGo+
 UmK0iEcVIzr1bO+or+2Ik+oZ+o8PPUGCW+xsTPlHPvmoyRE/I0Zz7l5QiXtgovW9Mu33Psl4c
 OBsl/q003J0qLD6e0ca9BJfoFsTXLJOatPT3MSTQaDAP6DhsLnGUE1pnEjM6tpdCoEgRI68i7
 PSTublfpK5S5WpIYGzS5DVsuudC8uYRy4o0W5mqSQSgxW4za8gMlp7TuUiyL0154feHfk1rtw
 swMe9wMnyW0stuL9TWJxXjrRWJHG4uW1BUJXJ8LG1WofRc72nyeAAiNH5ywy807cXk9dlCfzM
 tFaCxrgLvk/o6hcXekD4oD0dkO3o+nNYnwaLWZZ9Oi2V5qiBJJLq/8av+gY3Npu3pP91zlRs5
 1FP9T4WUajyyxFPIVJE89+3Wd18ewGS8PvDlBZA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Sun, 13 Sep 2020, Srinidhi Kaushik wrote:

> diff --git a/remote.c b/remote.c
> index 420150837b..e4b2d85a6f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1484,6 +1484,36 @@ void set_ref_status_for_push(struct ref *remote_r=
efs, int send_mirror,
>  				force_ref_update =3D 1;
>  		}
>
> +		/*
> +		 * If the tip of the remote-tracking ref is unreachable
> +		 * from any reflog entry of its local ref indicating a
> +		 * possible update since checkout; reject the push.
> +		 *
> +		 * There is no need to check for reachability, if the
> +		 * ref is marked for deletion.
> +		 */
> +		if (ref->if_includes && !ref->deletion) {
> +			/*
> +			 * If `force_ref_update' was previously set by
> +			 * "compare-and-swap", and we have to run this
> +			 * check, reset it back to the original value
> +			 * and update it depending on the status of this
> +			 * check.
> +			 */
> +			force_ref_update =3D ref->force || force_update;
> +
> +			if (ref->unreachable)
> +				reject_reason =3D
> +					REF_STATUS_REJECT_REMOTE_UPDATED;
> +			else
> +				/*
> +				 * If updates from the remote-tracking ref
> +				 * have been integrated locally; force the
> +				 * update.
> +				 */
> +				force_ref_update =3D 1;
> +		}
> +
>  		/*
>  		 * If the update isn't already rejected then check
>  		 * the usual "must fast-forward" rules.
> @@ -2272,11 +2302,74 @@ static int remote_tracking(struct remote *remote=
, const char *refname,
>  	return 0;
>  }
>
> +static int ref_reachable(struct object_id *o_oid, struct object_id *n_o=
id,
> +			 const char *ident, timestamp_t timestamp, int tz,
> +			 const char *message, void *cb_data)
> +{
> +	int ret =3D 0;
> +	struct object_id *r_oid =3D cb_data;
> +
> +	ret =3D oideq(n_oid, r_oid);
> +	if (!ret) {

Rather than having the largest part of the actual code statements in this
function indented, it would make more sense to write

	if (oideq(n_oid, r_oid))
		return 1;

	if (!(local =3D lookup...) ||
	    !(remote =3D lookup...))
		return 0;

	return in_merge_bases(remote, local);

> +		struct commit *loc =3D lookup_commit_reference(the_repository,
> +							     n_oid);
> +		struct commit *rem =3D lookup_commit_reference(the_repository,
> +							     r_oid);
> +		ret =3D (loc && rem) ? in_merge_bases(rem, loc) : 0;
> +	}

This chooses the strategy of iterating over the reflog just once, and at
every step first testing whether the respective reflog entry is identical
to the remote-tracking branch tip. Only when they are different do we test
whether the remote-tracking branch tip is at least reachable from the
reflog entry.

Let's assume that our local branch has 20 reflog entries, and the 4th one
is identical to the current tip of the remote-tracking branch. Then we
tested reachability 3 times. But that test is rather expensive.

Therefore, I would have preferred to have a call to
`for_each_reflog_ent_reverse()` with a callback function that only returns
the `oideq()` result, and only if the return value of that call is 0, I
would have wanted to see another call to `for_each_reflog_ent_reverse()`
to go through, this time looking for reachability.

> +
> +	return ret;
> +}
> +
> +/*
> + * Iterate through the reflog of a local branch and check
> + * if the tip of the remote-tracking branch is reachable
> + * from one of the entries.
> + */
> +static int ref_reachable_from_reflog(const struct object_id *r_oid,
> +				     const struct object_id *l_oid,
> +				     const char *local_ref_name)
> +{
> +	int ret =3D 0;
> +	struct commit *r_commit, *l_commit;
> +
> +	l_commit =3D lookup_commit_reference(the_repository, l_oid);
> +	r_commit =3D lookup_commit_reference(the_repository, r_oid);

At this point, we already LOOked up `r_commit`. But we don't pass that to
`ref_reachable()` at any point (instead passing only `r_oid`), so we have
to perform the lookup again.

That's wasteful. Shouldn't we pass `r_commit` directly?

With the two-pass strategy I outlined above, the first pass would use
`r_oid`, and only when the second pass is necessary would we resort to
calling the expensive reachability check.

> +
> +	/*
> +	 * If the remote-tracking ref is an ancestor of the local
> +	 * ref (a merge, for instance) there is no need to iterate
> +	 * through the reflog entries to ensure reachability; it
> +	 * can be skipped to return early instead.
> +	 */
> +	ret =3D (r_commit && l_commit) ? in_merge_bases(r_commit, l_commit) : =
0;

Correct me if I am wrong, but isn't the first reflog entry
(`<remote-branch>@{0}`) identical to `r_commit`? In that case, the first
iteration of the second pass over the reflog would trivially perform this
check, and we do not need to duplicate the logic here.

> +	if (!ret)
> +		ret =3D for_each_reflog_ent_reverse(local_ref_name, ref_reachable,
> +						  (struct object_id *)r_oid);
> +
> +	return ret;
> +}
> +
> +/*
> + * Check for reachability of a remote-tracking
> + * ref in the reflog entries of its local ref.
> + */
> +void check_reflog_for_ref(struct ref *r_ref)
> +{
> +	struct object_id r_oid;
> +	struct ref *l_ref =3D get_local_ref(r_ref->name);
> +
> +	if (r_ref->if_includes && l_ref && !read_ref(l_ref->name, &r_oid))

If `r_ref->if_includes` is 0, we do not even have to get the local ref,
correct? It would make `check_reflog_for_ref()` much easier to read for me
if it was only called when that flag was already verified to be 1, and
then followed this structure:

	if (!l_ref)
		return;
	if (read_ref(...))
		warning(_("ignoring stale remote branch information ..."));
	else
		r_ref->unreachable =3D ...

Also, it might make a lot more sense to rename `check_reflog_for_ref()` to
`check_if_includes_upstream()`, and to rename `r_ref` to `local` and
`l_ref` to `remote_tracking` or something like that: nothing is inherently
"left" or "right" about those refs.

> +		r_ref->unreachable =3D !ref_reachable_from_reflog(&r_ref->old_oid,
> +								&r_oid,
> +								l_ref->name);
> +}
> +
>  static void apply_cas(struct push_cas_option *cas,
>  		      struct remote *remote,
>  		      struct ref *ref)
>  {
> -	int i;
> +	int i, is_tracking =3D 0;
>
>  	/* Find an explicit --<option>=3D<name>[:<value>] entry */
>  	for (i =3D 0; i < cas->nr; i++) {
> @@ -2288,16 +2381,26 @@ static void apply_cas(struct push_cas_option *ca=
s,
>  			oidcpy(&ref->old_oid_expect, &entry->expect);
>  		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>  			oidclr(&ref->old_oid_expect);
> -		return;
> +		else
> +			is_tracking =3D 1;

As part of `remote_tracking()`, we already looked up the branch name.
Since we need it in the `is_tracking` case, maybe this should not be a
Boolean anymore but store a copy of the remote-tracking branch name
instead?

Oh, following the code path all the way down to
`match_name_with_pattern()`, it seems that `remote_tracking()`'s `dst`
variable _already_ contains a copy (which means that that memory is
leaked, right?).

> +		break;
>  	}
>
>  	/* Are we using "--<option>" to cover all? */
> -	if (!cas->use_tracking_for_rest)
> -		return;
> +	if (cas->use_tracking_for_rest) {
> +		ref->expect_old_sha1 =3D 1;
> +		if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> +			oidclr(&ref->old_oid_expect);
> +		else
> +			is_tracking =3D 1;
> +	}
> +
> +	/*
> +	 * Mark this ref to be checked if "--force-if-includes" is
> +	 * specified as an argument along with "compare-and-swap".
> +	 */
> +	ref->is_tracking =3D is_tracking;
>
> -	ref->expect_old_sha1 =3D 1;
> -	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
> -		oidclr(&ref->old_oid_expect);
>  }
>
>  void apply_push_cas(struct push_cas_option *cas,
> @@ -2308,3 +2411,21 @@ void apply_push_cas(struct push_cas_option *cas,
>  	for (ref =3D remote_refs; ref; ref =3D ref->next)
>  		apply_cas(cas, remote, ref);
>  }
> +
> +void apply_push_force_if_includes(struct ref *remote_refs, int used_wit=
h_cas)
> +{
> +	struct ref *ref;
> +	for (ref =3D remote_refs; ref; ref =3D ref->next) {
> +		/*
> +		 * If "compare-and-swap" is used along with option, run the
> +		 * check on refs that have been marked to do so. Otherwise,
> +		 * all refs will be checked.
> +		 */
> +		if (used_with_cas)
> +			ref->if_includes =3D ref->is_tracking;
> +		else
> +			ref->if_includes =3D 1;
> +
> +		check_reflog_for_ref(ref);
> +	}
> +}
> diff --git a/remote.h b/remote.h
> index 5e3ea5a26d..1618ba892b 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -104,7 +104,10 @@ struct ref {
>  		forced_update:1,
>  		expect_old_sha1:1,
>  		exact_oid:1,
> -		deletion:1;
> +		deletion:1,
> +		if_includes:1, /* If "--force-with-includes" was specified.  */
> +		is_tracking:1, /* If "use_tracking[_for_rest]" is set (CAS). */
> +		unreachable:1; /* For "if_includes"; unreachable in reflog.  */
>
>  	enum {
>  		REF_NOT_MATCHED =3D 0, /* initial value */
> @@ -134,6 +137,7 @@ struct ref {
>  		REF_STATUS_REJECT_NEEDS_FORCE,
>  		REF_STATUS_REJECT_STALE,
>  		REF_STATUS_REJECT_SHALLOW,
> +		REF_STATUS_REJECT_REMOTE_UPDATED,
>  		REF_STATUS_UPTODATE,
>  		REF_STATUS_REMOTE_REJECT,
>  		REF_STATUS_EXPECTING_REPORT,
> @@ -346,4 +350,12 @@ int parseopt_push_cas_option(const struct option *,=
 const char *arg, int unset);
>  int is_empty_cas(const struct push_cas_option *);
>  void apply_push_cas(struct push_cas_option *, struct remote *, struct r=
ef *);
>
> +/*
> + * Runs when "--force-if-includes" is specified.
> + * Checks if the remote-tracking ref was updated (since checkout)
> + * implicitly in the background and verify that changes from the
> + * updated tip have been integrated locally, before pushing.
> + */
> +void apply_push_force_if_includes(struct ref*, int);

This function is not even hooked up in this patch, right? I don't think
that it makes sense to introduce it without a caller, in particular since
it makes it harder to guess what those parameters might be used for.

In general, it appears to me as if the code worked way too hard to
accomplish something that should be a lot simpler: when
`--force-if-includes` is passed, it should piggy-back on top of the
`--force-with-lease` code path, and just add yet another check on top.

With that in mind, I would have expected something more in line with this:

=2D- snip --
 struct push_cas_option {
 	unsigned use_tracking_for_rest:1;
 	struct push_cas {
 		struct object_id expect;
-		unsigned use_tracking:1;
+		enum {
+			PUSH_NO_CAS =3D 0,
+			PUSH_CAS_USE_TRACKING,
+			PUSH_CAS_IF_INCLUDED
+		} mode;
 		char *refname;
 	} *entry;
 	int nr;
 	int alloc;
 };
=2D- snap --

and then adjusting the respective code paths accordingly.

Ciao,
Dscho

> +
>  #endif
> --
> 2.28.0
>
>
