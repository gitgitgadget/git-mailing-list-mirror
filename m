Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31974C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1529D60E98
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhGWQTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGWQTA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 12:19:00 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B5FC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:59:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k4-20020a17090a5144b02901731c776526so9764899pjm.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T22C30y6ePoXR3UCu7YIwbJJR/SdYP2nzXUerYi4x/c=;
        b=e9LvDec2Tt1zYNo3BQzrTboiXxRDixnMc5MMbuu65lODZguvKv18bSavw3WFaucZWY
         P8u/XJ9Nltsefqynbz4JK6IJxv0eJ72ic+SPk+Wx8ChlLsX80Fr/XnX/n993F+PZyoLn
         saXaYhWTl1kfv3YE12C5XCn36B2iE2jfTTa/Ednb2vpxnwq5U6ajEUVbtWR8+Yu4fahD
         0GxgTfnAC0dJN95wssCtdoqy7OG0rQ6HecmB3UGfgSVTOTqbXLsAX/cyCXNbgDjmC4qS
         6DTaIvgr1vhAIQRNhutT3ifPZLXGOI74GTG7VQW1J4plVnGnpo+sBLlH1hnjXstMomeu
         j9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T22C30y6ePoXR3UCu7YIwbJJR/SdYP2nzXUerYi4x/c=;
        b=QFax47876zRFhgc2vLDEgQxrKnDL1j+nOiqb9buy56kw6xC7xGXFQGtzpguIFXrVcA
         8ub7xYdLF4BbRIMv02PFNjXge2YGbTRwRwzjUrLoIQlyyfM8ELTPA/4XYGS0bglkdy3M
         tHG59Onrse1E2hg5TEdjYCpr2vPyg+7kcqznkSlHzXkvXyoS7TunbIiIdGxaIlz4kVw0
         hqOYjwYAnPrr7fGJaAdP260/2D2bsReH7wQH/bsWQzfUDsEDcJWfiTY9w96QblyvFs/H
         6tNjNjm2ke2jiZF59fBfg3ELO5vww32zLVBuJ/AV/Wx8bMKzEwoGba3oFAzaU7uFUroI
         E6cg==
X-Gm-Message-State: AOAM530Ut+RTqCOV2PxWcABQXbjkSphp2EEMjKmpHF/09yHOOEGurZu4
        PsRROGCKs3V/Eysj1o6DWK0=
X-Google-Smtp-Source: ABdhPJxLmg47+SglS0T0GOm9BO10xQGygaaXEDgJuyeyl71Lsff162P0aj/JZtUXug9WDNf302q6+g==
X-Received: by 2002:a63:653:: with SMTP id 80mr5665045pgg.395.1627059572127;
        Fri, 23 Jul 2021 09:59:32 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id x7sm24650836pfu.158.2021.07.23.09.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 09:59:31 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [GSoC] [PATCH] submodule--helper: run update procedures from C
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <87r1fps63r.fsf@evledraar.gmail.com>
Date:   Fri, 23 Jul 2021 22:29:27 +0530
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9532C3EF-257E-4898-8C75-C49EA4B66A99@gmail.com>
References: <20210722134012.99457-1-raykar.ath@gmail.com>
 <87r1fps63r.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23-Jul-2021, at 15:07, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Thu, Jul 22 2021, Atharva Raykar wrote:
>=20
>> +/* NEEDSWORK: try to do this without creating a new process */
>> +static int is_tip_reachable(const char *path, struct object_id =
*sha1)
>> +{
>> +	struct child_process cp =3D CHILD_PROCESS_INIT;
>> +	struct strbuf rev =3D STRBUF_INIT;
>> +	char *sha1_hex =3D oid_to_hex(sha1);
>> +
>> +	cp.git_cmd =3D 1;
>> +	cp.dir =3D xstrdup(path);
>> +	cp.no_stderr =3D 1;
>> +	strvec_pushl(&cp.args, "rev-list", "-n", "1", sha1_hex, "--not", =
"--all", NULL);
>> +
>> +	prepare_submodule_repo_env(&cp.env_array);
>> +
>> +	if (capture_command(&cp, &rev, GIT_MAX_HEXSZ + 1) || rev.len)
>> +		return 0;
>> +
>> +	return 1;
>> +}
>=20
> I think it's fine to do this & leave out the NEEDSWORK commit, just
> briefly noting in the commit-message that we're not bothering with
> trying to reduce sub-command invocations. It can be done later if =
anyone
> cares.

Okay, fair enough. I realise I have not been consistent about leaving =
such
comments in all my conversion efforts.

>> [...]
>> +		strbuf_addf(&die_msg, "fatal: Unable to checkout '%s' in =
submodule path '%s'\n",
>> +			    sha1, ud->displaypath);
>> +		strbuf_addf(&say_msg, "Submodule path '%s': checked out =
'%s'\n",
>> +			    ud->displaypath, sha1);
>=20
> For all of these you're removing the translation from a message like:
>=20
>    die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodule =
path '\$displaypath'")"
>=20
> Which is easy enough to fix, just use _(), i.e.:
>=20
>    strbuf_addf(&die_msg, _("Unable to checkout '%s' in submodule path =
'%s'\n"), [...]

Thanks for catching this.

> I removed the "fatal: " per a comment below...
>=20
>> +		break;
>> +	case SM_UPDATE_REBASE:
>> +		cp.git_cmd =3D 1;
>> +		strvec_push(&cp.args, "rebase");
>> +		if (ud->quiet)
>> +			strvec_push(&cp.args, "--quiet");
>> +		strbuf_addf(&die_msg, "fatal: Unable to rebase '%s' in =
submodule path '%s'\n",
>> +			    sha1, ud->displaypath);
>> +		strbuf_addf(&say_msg, "Submodule path '%s': rebased into =
'%s'\n",
>> +			    ud->displaypath, sha1);
>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_MERGE:
>> +		cp.git_cmd =3D 1;
>> +		strvec_push(&cp.args, "merge");
>> +		if (ud->quiet)
>> +			strvec_push(&cp.args, "--quiet");
>> +		strbuf_addf(&die_msg, "fatal: Unable to merge '%s' in =
submodule path '%s'\n",
>> +			    sha1, ud->displaypath);
>> +		strbuf_addf(&say_msg, "Submodule path '%s': merged in =
'%s'\n",
>> +			    ud->displaypath, sha1);
>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_COMMAND:
>> +		/* NOTE: this does not handle quoted arguments */
>> +		strvec_split(&cp.args, ud->update_strategy.command);
>> +		strbuf_addf(&die_msg, "fatal: Execution of '%s %s' =
failed in submodule path '%s'\n",
>> +			    ud->update_strategy.command, sha1, =
ud->displaypath);
>> +		strbuf_addf(&say_msg, "Submodule path '%s': '%s %s'\n",
>> +			    ud->displaypath, =
ud->update_strategy.command, sha1);
>> +		must_die_on_failure =3D 1;
>> +		break;
>> +	case SM_UPDATE_UNSPECIFIED:
>> +	case SM_UPDATE_NONE:
>> +		BUG("update strategy should have been specified");
>> +	}
>> +
>> +	strvec_push(&cp.args, sha1);
>> +
>> +	prepare_submodule_repo_env(&cp.env_array);
>> +
>> +	if (run_command(&cp)) {
>> +		if (must_die_on_failure) {
>> +			retval =3D 2;
>> +			fputs(_(die_msg.buf), stderr);
>> +			goto cleanup;
>=20
> FWIW I'd find this clearer if we just kept track of what operation we
> ran above, and just in this run_command() && must_die_on_failure case
> started populating these die messages.

Could you clarify what you meant here?

I can't think of a way to do this at the moment without introducing one
or more redundant 'switch ()' statements. This is what I interpreted =
your
statement as:

...
	/* we added the arguments to 'cp' already in the switch () =
above... */

	if (run_command(&cp)) {
		if (must_die_on_failure) {
			switch (ud->update_strategy.type) {
			case SM_UPDATE_CHECKOUT:
				die(_("Execution of..."));
				break;
			case ...
			case ...
		}
		/*
		 * This signifies to the caller in shell that
		 * the command failed without dying
		 */
		retval =3D 1;
		goto cleanup;
	}
=09
	/* ...another switch to figure out which say_msg() to use? */
...

Or did you mean that instead of storing the die_msg in entirety at the
first switch, I instead store just the action, and in the conditional
finally have something like...?

	die(_("Unable to %s '%s' in submodule path '%s'"),
	    action, sha1, ud->displaypath);

...where 'action' is a value like "merge", "checkout" etc, set in the
first 'switch'.

I am guessing the motivation for this is to make more clear which error
message will be shown for each case?

> But even if not the reason I dropped the "fatal: " is shouldn't we =
just
> call die() here directly? Why clean up when we're dying anyway?

The reason I did not call die() directly is because the original shell
version originally specifically exited with 2 in the 'must_die_on_error'
case while die() in C exits with 128. I think it would be more =
semantically
correct for me to have done something like an 'exit(2)' instead of =
cleaning
up and returning.

That said, it occured to me that the receiving end does not do anything
special with the different exit code, other than just pass it on to =
another
exit, ie, this bit:

+		2|128)
+			exit $res
+			;;

This code currently sits in a weird middle position where it is neither
fully matching the exit codes as before the conversion (where a failure
unrelated to the command execution should have exited with 1, not 128),
nor is it having a complete disregard for their exact value, which would
somewhat simplify the failure handling code.

I wonder if any script in a machine somewhere cares about the exact exit =
value
of 'submodule add'. I suspect it would be relatively harmless if I just =
follow
your suggestion and just die() on command execution failure...

Thoughts?

> Also since I see you used _() here that won't work, i.e. with gettet =
if
> you happen to need to declare things earlier, you need to use N_() to
> mark the message for translation.
>=20
> The _() here won't find any message translated (unless the string
> happened to exactly match a thing in the *.po file for other reasons,
> not the case here).
>=20
> But in this case we can just die(msg) here and have used the _() =
above,
> or just call die() directly here not having made a die_msg we usually
> won't use...

Okay, I'll ensure that the translations are marked properly when I =
reroll.

>> +static int do_run_update_procedure(struct update_data *ud)
>> +{
>> +	if ((!is_null_oid(&ud->sha1) && !is_null_oid(&ud->subsha1) && =
!oideq(&ud->sha1, &ud->subsha1)) ||
>> +	    is_null_oid(&ud->subsha1) || ud->force) {
>> +		int subforce =3D is_null_oid(&ud->subsha1) || ud->force;
>> +
>> +		if (!ud->nofetch) {
>> +			/*
>> +			 * Run fetch only if `sha1` isn't present or it
>> +			 * is not reachable from a ref.
>> +			 */
>> +			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
>> +				if (fetch_in_submodule(ud->sm_path, =
ud->depth, ud->quiet, NULL) &&
>> +				    !ud->quiet)
>> +					fprintf_ln(stderr,
>> +						   _("Unable to fetch in =
submodule path '%s'; "
>> +						     "trying to directly =
fetch %s:"),
>> +						   ud->displaypath, =
oid_to_hex(&ud->sha1));
>> +			/*
>> +			 * Now we tried the usual fetch, but `sha1` may
>> +			 * not be reachable from any of the refs.
>> +			 */
>> +			if (!is_tip_reachable(ud->sm_path, &ud->sha1))
>> +				if (fetch_in_submodule(ud->sm_path, =
ud->depth, ud->quiet, &ud->sha1))
>> +					die(_("Fetched in submodule path =
'%s', but it did not "
>> +					      "contain %s. Direct =
fetching of that commit failed."),
>> +					    ud->displaypath, =
oid_to_hex(&ud->sha1));
>> +		}
>> +
>> +		return run_update_command(ud, subforce);
>> +	}
>> +
>> +	return 3;
>> +}
>=20
> Since this has excatly one caller I think it's better for readability
> (less indentation) and flow to just remove that "return 3" condition =
and
> do the big "if" you have at the end, i.e. have this function start =
with
> "int subforce =3D" and...

Yeah, that would be better. I'll change that.

>> static void update_submodule(struct update_clone_data *ucd)
>> {
>> 	fprintf(stdout, "dummy %s %d\t%s\n",
>> @@ -2379,6 +2552,79 @@ static int update_clone(int argc, const char =
**argv, const char *prefix)
>> 	return update_submodules(&suc);
>> }
>>=20
>> +static int run_update_procedure(int argc, const char **argv, const =
char *prefix)
>> +{
>> +	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
>> +	char *prefixed_path, *update =3D NULL;
>> +	char *sha1 =3D NULL, *subsha1 =3D NULL;
>> +	struct update_data update_data =3D UPDATE_DATA_INIT;
>> +
>> +	struct option options[] =3D {
>> +		OPT__QUIET(&quiet, N_("suppress output for update by =
rebase or merge")),
>> +		OPT__FORCE(&force, N_("force checkout updates"), 0),
>> +		OPT_BOOL('N', "no-fetch", &nofetch,
>> +			 N_("don't fetch new objects from the remote =
site")),
>> +		OPT_BOOL(0, "just-cloned", &just_cloned,
>> +			 N_("overrides update mode in case the =
repository is a fresh clone")),
>> +		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth =
for shallow fetch")),
>> +		OPT_STRING(0, "prefix", &prefix,
>> +			   N_("path"),
>> +			   N_("path into the working tree")),
>> +		OPT_STRING(0, "update", &update,
>> +			   N_("string"),
>> +			   N_("rebase, merge, checkout or none")),
>> +		OPT_STRING(0, "recursive-prefix", =
&update_data.recursive_prefix, N_("path"),
>> +			   N_("path into the working tree, across nested =
"
>> +			      "submodule boundaries")),
>> +		OPT_STRING(0, "sha1", &sha1, N_("string"),
>> +			   N_("SHA1 expected by superproject")),
>> +		OPT_STRING(0, "subsha1", &subsha1, N_("string"),
>> +			   N_("SHA1 of submodule's HEAD")),
>> +		OPT_END()
>> +	};
>> +
>> +	const char *const usage[] =3D {
>> +		N_("git submodule--helper run-update-procedure =
[<options>] <path>"),
>> +		NULL
>> +	};
>> +
>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>> +
>> +	if (argc !=3D 1)
>> +		usage_with_options(usage, options);
>> +	update_data.force =3D !!force;
>> +	update_data.quiet =3D !!quiet;
>> +	update_data.nofetch =3D !!nofetch;
>> +	update_data.just_cloned =3D !!just_cloned;
>=20
> For all of these just pass the reference to the update_data variable
> directly in the OPT_*(). No need to set an "int force", only to copy =
it
> over to update_data.force. Let's just use the latter only.

Hmm, I'm trying to remember why the single bit values are treated this =
way
in this whole file...

...there seems to be no good reason for it. The API docs for parse =
options
state that OPT_BOOL() is guaranteed to return either zero or one, so =
that
double negation does look unnecessary.

>> +
>> +	if (sha1)
>> +		get_oid_hex(sha1, &update_data.sha1);
>> +	else
>> +		oidcpy(&update_data.sha1, null_oid());
>=20
> Nit: Even if a historical option forces us to support --sha1, let's =
use
> "oid" for the variable etc. But in this case the --sha1 is new, no?
> Let's use --object-id or --oid (whatever is more common, I didn't
> check)>

Okay. I can see the confusion this may cause.

>> +
>> +	if (subsha1)
>> +		get_oid_hex(subsha1, &update_data.subsha1);
>> +	else
>> +		oidcpy(&update_data.subsha1, null_oid());
>=20
> Ditto. Also I think for both of these you can re-use
> parse_opt_object_id. See "squash-onto" and "upstream" in
> builtin/rebase.c.
>=20
> Then you just supply an oid variable directly and let that helper do =
all
> the get_oid etc.

Thanks for pointing me to this!

>> +	if (update_data.recursive_prefix)
>> +		prefixed_path =3D xstrfmt("%s%s", =
update_data.recursive_prefix, update_data.sm_path);
>> +	else
>> +		prefixed_path =3D xstrdup(update_data.sm_path);
>> +
>> +	update_data.displaypath =3D =
get_submodule_displaypath(prefixed_path, prefix);
>> +
>> +	determine_submodule_update_strategy(the_repository, =
update_data.just_cloned,
>> +					    update_data.sm_path, update,
>> +					    =
&update_data.update_strategy);
>> +
>> +	free(prefixed_path);
>> +
>> +	return do_run_update_procedure(&update_data);
>=20
> ....(continued from above) ...here just do:
>=20
>    if (that big if condition)
>        return do_run_update_procedure(&update_data);
>    else
>        return 3;

Okay.

Thanks for the review!

