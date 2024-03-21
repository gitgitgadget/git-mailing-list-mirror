Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398CE83CA6
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711024668; cv=none; b=ugcL8ojWLymLeukbpN5oYIt9NFq4atRuezBhDYDT4gCn3KonsIUm1pDTMiUtd+CYC3xIac4p/2KBf/qeBWrjDBXFkwac1+Jg7YVBJY/BEEMz/mfHG5a7AVXtiEUPsmIFIxfTEPYpnOYfqQIpbiE/RIX53evS4bdnJGT5A1a+ux8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711024668; c=relaxed/simple;
	bh=WoAiUnZNHy46i/xIBFsQjLqQhKaAZyY8GXmViUTwfj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmLYEkMjwfif1aISOAZ26r/7EbyFjMEZCj2awzNjsa/gl9H05C39tUUtEvsZYP1e0dF/ES9H1bfzD2YuhIRZGZZ7tjdGZoSI3fQS03vEr4an646ZLftbBpfITMUuorGDMf/HbCRra9h+RapEsr0zvC9lCRBgvyzNag/f/5ja75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NMBHcG+n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuK+XcE/; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NMBHcG+n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuK+XcE/"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 07B2032001FC;
	Thu, 21 Mar 2024 08:37:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 08:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711024664; x=1711111064; bh=PoYAAB+p4B
	rCF7Pxyomu8MRl2RVKDvx19BdY1XeWchA=; b=NMBHcG+nL6k1IawDLLwKAbw3UY
	h6I6sxHwug16HPgmAuN1DYwyJ4TNgFi0d8lM6nJBW+BHRCNUsglDty4hZv3y4o0k
	4N2zYQYTnoVbJ1fYpgrdkuazklti+iuN9qZRLfs7VzWc3cg/qgYeJu5oyleXtDEH
	sI15xmWPkIylRRMnPBumDX9PTxd7mosjP2wRxZIJNkDTY6+comjqmxfpBdzPbNKM
	56Ah2TLYuywKwU7loPVUQwBTIliqe4MOxP/aAchkj5zi8H+yaJBUT1ESILKZf7yp
	nrF8Jkw+Vy05zsHnQm3CiQUVtld9fSTrc32wZTOC0T8I5Rt1Ak0quFQnBEJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711024664; x=1711111064; bh=PoYAAB+p4BrCF7Pxyomu8MRl2RVK
	Dvx19BdY1XeWchA=; b=OuK+XcE/QGVsnZ2jw0e0B/b5RZd6aTuZVogprSh0PGB9
	dOE9Gl8a7mWxNCKknY6o6rbDkrLF5G/qSkLUeON1sj6rBX1BUqMsNmXLTzMLJWHP
	O8MAfoYVATfF9IcSFv0hwTGF9IXsYas6q73EAoe+upeZ9gqXCeuowalQ4MlU8qum
	mAsgoli5pf1nm4UBc40GwGn8YcvOobGGB010WuR20L1+t/gF2V8ZjRNSM/VL13jq
	dZRdJobED//wMTvZBaIsfDhF87A+Do4M4jvbMFoXJeAbjPgdernW3+K0C6+JbExd
	sPkX//urhUK0KKNRGlZTgjFJcBaYsB0lQ1CAxz0AUA==
X-ME-Sender: <xms:GCr8ZReqKTEK38FpO44AzrgbPNtOcLUhvHwNRhKCZoTg8L0MxLUMbg>
    <xme:GCr8ZfMxuGTdsnMoFiTFEB9uo7GmB4D1FGLTk16RE2-Wzg95LN8Prj8gXiUtUr8Ix
    P2aCM7ldxKs_bRaNA>
X-ME-Received: <xmr:GCr8ZajusRyd8Dpky2r6TNiZApD5TMuCTd-ERaSproviBvLLDjJRxGRrdIMWAa2gsz3pc5ZX3z3zCLI0B1c5cS0dwq1nF4P13qoJ-y4dT_oeuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:GCr8Za_58AvBVR1PW_xqU15-mgMCmCWQGVd_Z--fQYJ_MPvnJ67hgA>
    <xmx:GCr8ZdtNhcFhv_GRxpIGl36L4HbiCHl23b-Z7RQpxlRQWFWndEJT2A>
    <xmx:GCr8ZZGEf1p3fEenvEfw0vJB4ddhPbG99iV-0JjKE_UcLQQW5PvvhQ>
    <xmx:GCr8ZUNJr383ySqiEVBMJFnhC2duUVplHQCA_sJUFX6vT5sdkwj4zQ>
    <xmx:GCr8ZXKdudypTWFH2v4xnD5TGuszHcSLVk7VXHO_dk_H-GEcwMnpCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:37:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 98e3383b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:37:39 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:37:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 3/5] maintenance: use packaged systemd units
Message-ID: <ZfwqFU_b3MqLCZNR@tanuki>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-4-mg@max.gautier.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YHKX3w2tCbStRE98"
Content-Disposition: inline
In-Reply-To: <20240318153257.27451-4-mg@max.gautier.name>


--YHKX3w2tCbStRE98
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 04:31:17PM +0100, Max Gautier wrote:
> - Remove the code writing the units
> - Simplify calling systemctl
>   - systemctl does not error out when disabling units which aren't
>     enabled, nor when enabling already enabled units
>   - call systemctl only once, with all the units.
> - Add clean-up code for leftover units in $XDG_CONFIG_HOME created by
>   previous versions of git, taking care of preserving actual user
>   override (by checking the start of the file).

We very much try to avoid bulleted-list-style commit messages. Once you
have a list of changes it very often indicates that there are multiple
semi-related things going on in the same commit. At that point we prefer
to split the commit up into multiple commits so that each of the bullet
items can be explained separately.

Also, as mentioned before, commit messages should explain what the
problem is and how that problem is solved.=20

Patrick

> Signed-off-by: Max Gautier <mg@max.gautier.name>
> ---
>  builtin/gc.c | 293 ++++++++-------------------------------------------
>  1 file changed, 45 insertions(+), 248 deletions(-)
>=20
> diff --git a/builtin/gc.c b/builtin/gc.c
> index cb80ced6cb..981db8e297 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2308,276 +2308,73 @@ static char *xdg_config_home_systemd(const char =
*filename)
>  	return xdg_config_home_for("systemd/user", filename);
>  }
> =20
> -#define SYSTEMD_UNIT_FORMAT "git-maintenance@%s.%s"
> -
> -static int systemd_timer_delete_timer_file(enum schedule_priority priori=
ty)
> -{
> -	int ret =3D 0;
> -	const char *frequency =3D get_frequency(priority);
> -	char *local_timer_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "tim=
er");
> -	char *filename =3D xdg_config_home_systemd(local_timer_name);
> -
> -	if (unlink(filename) && !is_missing_file_error(errno))
> -		ret =3D error_errno(_("failed to delete '%s'"), filename);
> -
> -	free(filename);
> -	free(local_timer_name);
> -	return ret;
> -}
> -
> -static int systemd_timer_delete_service_template(void)
> -{
> -	int ret =3D 0;
> -	char *local_service_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service"=
);
> -	char *filename =3D xdg_config_home_systemd(local_service_name);
> -	if (unlink(filename) && !is_missing_file_error(errno))
> -		ret =3D error_errno(_("failed to delete '%s'"), filename);
> -
> -	free(filename);
> -	free(local_service_name);
> -	return ret;
> -}
> -
> -/*
> - * Write the schedule information into a git-maintenance@<schedule>.timer
> - * file using a custom minute. This timer file cannot use the templating
> - * system, so we generate a specific file for each.
> - */
> -static int systemd_timer_write_timer_file(enum schedule_priority schedul=
e,
> -					  int minute)
> -{
> -	int res =3D -1;
> -	char *filename;
> -	FILE *file;
> -	const char *unit;
> -	char *schedule_pattern =3D NULL;
> -	const char *frequency =3D get_frequency(schedule);
> -	char *local_timer_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, frequency, "tim=
er");
> -
> -	filename =3D xdg_config_home_systemd(local_timer_name);
> -
> -	if (safe_create_leading_directories(filename)) {
> -		error(_("failed to create directories for '%s'"), filename);
> -		goto error;
> -	}
> -	file =3D fopen_or_warn(filename, "w");
> -	if (!file)
> -		goto error;
> -
> -	switch (schedule) {
> -	case SCHEDULE_HOURLY:
> -		schedule_pattern =3D xstrfmt("*-*-* 1..23:%02d:00", minute);
> -		break;
> -
> -	case SCHEDULE_DAILY:
> -		schedule_pattern =3D xstrfmt("Tue..Sun *-*-* 0:%02d:00", minute);
> -		break;
> -
> -	case SCHEDULE_WEEKLY:
> -		schedule_pattern =3D xstrfmt("Mon 0:%02d:00", minute);
> -		break;
> -
> -	default:
> -		BUG("Unhandled schedule_priority");
> -	}
> -
> -	unit =3D "# This file was created and is maintained by Git.\n"
> -	       "# Any edits made in this file might be replaced in the future\n"
> -	       "# by a Git command.\n"
> -	       "\n"
> -	       "[Unit]\n"
> -	       "Description=3DOptimize Git repositories data\n"
> -	       "\n"
> -	       "[Timer]\n"
> -	       "OnCalendar=3D%s\n"
> -	       "Persistent=3Dtrue\n"
> -	       "\n"
> -	       "[Install]\n"
> -	       "WantedBy=3Dtimers.target\n";
> -	if (fprintf(file, unit, schedule_pattern) < 0) {
> -		error(_("failed to write to '%s'"), filename);
> -		fclose(file);
> -		goto error;
> -	}
> -	if (fclose(file) =3D=3D EOF) {
> -		error_errno(_("failed to flush '%s'"), filename);
> -		goto error;
> -	}
> -
> -	res =3D 0;
> -
> -error:
> -	free(schedule_pattern);
> -	free(local_timer_name);
> -	free(filename);
> -	return res;
> -}
> -
> -/*
> - * No matter the schedule, we use the same service and can make use of t=
he
> - * templating system. When installing git-maintenance@<schedule>.timer,
> - * systemd will notice that git-maintenance@.service exists as a template
> - * and will use this file and insert the <schedule> into the template at
> - * the position of "%i".
> - */
> -static int systemd_timer_write_service_template(const char *exec_path)
> -{
> -	int res =3D -1;
> -	char *filename;
> -	FILE *file;
> -	const char *unit;
> -	char *local_service_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service"=
);
> -
> -	filename =3D xdg_config_home_systemd(local_service_name);
> -	if (safe_create_leading_directories(filename)) {
> -		error(_("failed to create directories for '%s'"), filename);
> -		goto error;
> -	}
> -	file =3D fopen_or_warn(filename, "w");
> -	if (!file)
> -		goto error;
> -
> -	unit =3D "# This file was created and is maintained by Git.\n"
> -	       "# Any edits made in this file might be replaced in the future\n"
> -	       "# by a Git command.\n"
> -	       "\n"
> -	       "[Unit]\n"
> -	       "Description=3DOptimize Git repositories data\n"
> -	       "\n"
> -	       "[Service]\n"
> -	       "Type=3Doneshot\n"
> -	       "ExecStart=3D\"%s/git\" --exec-path=3D\"%s\" for-each-repo --con=
fig=3Dmaintenance.repo maintenance run --schedule=3D%%i\n"
> -	       "LockPersonality=3Dyes\n"
> -	       "MemoryDenyWriteExecute=3Dyes\n"
> -	       "NoNewPrivileges=3Dyes\n"
> -	       "RestrictAddressFamilies=3DAF_UNIX AF_INET AF_INET6 AF_VSOCK\n"
> -	       "RestrictNamespaces=3Dyes\n"
> -	       "RestrictRealtime=3Dyes\n"
> -	       "RestrictSUIDSGID=3Dyes\n"
> -	       "SystemCallArchitectures=3Dnative\n"
> -	       "SystemCallFilter=3D@system-service\n";
> -	if (fprintf(file, unit, exec_path, exec_path) < 0) {
> -		error(_("failed to write to '%s'"), filename);
> -		fclose(file);
> -		goto error;
> -	}
> -	if (fclose(file) =3D=3D EOF) {
> -		error_errno(_("failed to flush '%s'"), filename);
> -		goto error;
> -	}
> -
> -	res =3D 0;
> -
> -error:
> -	free(local_service_name);
> -	free(filename);
> -	return res;
> -}
> -
> -static int systemd_timer_enable_unit(int enable,
> -				     enum schedule_priority schedule,
> -				     int minute)
> +static int systemd_set_units_state(int enable)
>  {
>  	const char *cmd =3D "systemctl";
>  	struct child_process child =3D CHILD_PROCESS_INIT;
> -	const char *frequency =3D get_frequency(schedule);
> -
> -	/*
> -	 * Disabling the systemd unit while it is already disabled makes
> -	 * systemctl print an error.
> -	 * Let's ignore it since it means we already are in the expected state:
> -	 * the unit is disabled.
> -	 *
> -	 * On the other hand, enabling a systemd unit which is already enabled
> -	 * produces no error.
> -	 */
> -	if (!enable)
> -		child.no_stderr =3D 1;
> -	else if (systemd_timer_write_timer_file(schedule, minute))
> -		return -1;
> =20
>  	get_schedule_cmd(&cmd, NULL);
>  	strvec_split(&child.args, cmd);
> -	strvec_pushl(&child.args, "--user", enable ? "enable" : "disable",
> -		     "--now", NULL);
> -	strvec_pushf(&child.args, SYSTEMD_UNIT_FORMAT, frequency, "timer");
> +
> +	strvec_pushl(&child.args, "--user", "--force", "--now",
> +			enable ? "enable" : "disable",
> +			"git-maintenance@hourly.timer",
> +			"git-maintenance@daily.timer",
> +			"git-maintenance@weekly.timer", NULL);
> +	/*
> +	** --force override existing conflicting symlinks
> +	** We need it because the units have changed location (~/.config ->
> +	** /usr/lib)
> +	*/
> =20
>  	if (start_command(&child))
>  		return error(_("failed to start systemctl"));
>  	if (finish_command(&child))
> -		/*
> -		 * Disabling an already disabled systemd unit makes
> -		 * systemctl fail.
> -		 * Let's ignore this failure.
> -		 *
> -		 * Enabling an enabled systemd unit doesn't fail.
> -		 */
> -		if (enable)
> -			return error(_("failed to run systemctl"));
> +		return error(_("failed to run systemctl"));
>  	return 0;
>  }
> =20
> -/*
> - * A previous version of Git wrote the timer units as template files.
> - * Clean these up, if they exist.
> - */
> -static void systemd_timer_delete_stale_timer_templates(void)
> +static void systemd_delete_user_unit(char const *unit)
>  {
> -	char *timer_template_name =3D xstrfmt(SYSTEMD_UNIT_FORMAT, "", "timer");
> -	char *filename =3D xdg_config_home_systemd(timer_template_name);
> +	char const	file_start_stale[] =3D	"# This file was created and is"
> +						" maintained by Git.";
> +	char		file_start_user[sizeof(file_start_stale)] =3D {'\0'};
> +
> +	char *filename =3D xdg_config_home_systemd(unit);
> +	int handle =3D open(filename, O_RDONLY);
> =20
> -	if (unlink(filename) && !is_missing_file_error(errno))
> +	/*
> +	** Check this is actually our file and we're not removing a legitimate
> +	** user override.
> +	*/
> +	if (handle =3D=3D -1 && !is_missing_file_error(errno))
>  		warning(_("failed to delete '%s'"), filename);
> +	else {
> +		read(handle, file_start_user, sizeof(file_start_stale) - 1);
> +		close(handle);
> +		if (strcmp(file_start_stale, file_start_user) =3D=3D 0) {
> +			if (unlink(filename) =3D=3D 0)
> +				warning(_("deleted stale unit file '%s'"), filename);
> +			else if (!is_missing_file_error(errno))
> +				warning(_("failed to delete '%s'"), filename);
> +		}
> +	}
> =20
>  	free(filename);
> -	free(timer_template_name);
> -}
> -
> -static int systemd_timer_delete_unit_files(void)
> -{
> -	systemd_timer_delete_stale_timer_templates();
> -
> -	/* Purposefully not short-circuited to make sure all are called. */
> -	return systemd_timer_delete_timer_file(SCHEDULE_HOURLY) |
> -	       systemd_timer_delete_timer_file(SCHEDULE_DAILY) |
> -	       systemd_timer_delete_timer_file(SCHEDULE_WEEKLY) |
> -	       systemd_timer_delete_service_template();
> -}
> -
> -static int systemd_timer_delete_units(void)
> -{
> -	int minute =3D get_random_minute();
> -	/* Purposefully not short-circuited to make sure all are called. */
> -	return systemd_timer_enable_unit(0, SCHEDULE_HOURLY, minute) |
> -	       systemd_timer_enable_unit(0, SCHEDULE_DAILY, minute) |
> -	       systemd_timer_enable_unit(0, SCHEDULE_WEEKLY, minute) |
> -	       systemd_timer_delete_unit_files();
> -}
> -
> -static int systemd_timer_setup_units(void)
> -{
> -	int minute =3D get_random_minute();
> -	const char *exec_path =3D git_exec_path();
> -
> -	int ret =3D systemd_timer_write_service_template(exec_path) ||
> -		  systemd_timer_enable_unit(1, SCHEDULE_HOURLY, minute) ||
> -		  systemd_timer_enable_unit(1, SCHEDULE_DAILY, minute) ||
> -		  systemd_timer_enable_unit(1, SCHEDULE_WEEKLY, minute);
> -
> -	if (ret)
> -		systemd_timer_delete_units();
> -	else
> -		systemd_timer_delete_stale_timer_templates();
> -
> -	return ret;
>  }
> =20
>  static int systemd_timer_update_schedule(int run_maintenance, int fd UNU=
SED)
>  {
> -	if (run_maintenance)
> -		return systemd_timer_setup_units();
> -	else
> -		return systemd_timer_delete_units();
> +	/*
> +	 * A previous version of Git wrote the units in the user configuration
> +	 * directory. Clean these up, if they exist.
> +	 */
> +	systemd_delete_user_unit("git-maintenance@hourly.timer");
> +	systemd_delete_user_unit("git-maintenance@daily.timer");
> +	systemd_delete_user_unit("git-maintenance@weekly.timer");
> +	systemd_delete_user_unit("git-maintenance@.timer");
> +	systemd_delete_user_unit("git-maintenance@.service");
> +	return systemd_set_units_state(run_maintenance);
>  }
> =20
>  enum scheduler {
> --=20
> 2.44.0
>=20
>=20

--YHKX3w2tCbStRE98
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8KhQACgkQVbJhu7ck
PpRQYg/+LqYpb/t8KFvLLgaOewREbeoa4VTCYuo3eQ6OZFyFjygPwoK9/ZU2o6Iv
/vf8xiG4QO32eeS6bqMa0Gxtjjiz/6z0bj3NOSZqvIl5/n3lq20MmmoS4W+bvd6Z
Joyo3OGN6m78gh0BBuBDRSD8NJ6J+w5CqDRofwKTZt57LWZnyKz6+gKHr1xLIl3P
cZ02SQKGpueVIOkz9/2/kPkMEnVw6rgbzA64DupKIinkRcftrLFplyUXoDs91Wf9
HZMvA2Q/aQ2cD90k6p+YzFRk6UKdjOcUgIiEX8e4+n+9SVHBNX9/GDKch7VlKXck
2bMtTWjLGaqhNOzB6/8txSvGZTEexcAoWpDpHna2xIQxrRm3Ckl6tSv0G6u39t9X
9FxDc0fF06ssY9/mGo6nVeWX/wV+ueretOaQ4kkr45L0ztsEawcUhVCoMiIbTBPm
l1j9T7byPm++42kxNztBXIDLAKO0slbdVO0rVyk9LmifviH8lDs3uKM3F+isqyZL
tITjXpTbi6R+9KghKJBdTRergwt+ZdnzY8wyiBjrfsr0HM0jncXLaEcfkiy2j5Od
Ch9kqfcHhUo5LpMjpHf2++5IOMS0an9tVEoJ6QycjuclluE3w/OpkC2nOPNOEJdG
2t/x5qiPUaeJpqpsJLYYQcF6/aAPqKXL4EoufNPBrtxsL6vJm00=
=WbAd
-----END PGP SIGNATURE-----

--YHKX3w2tCbStRE98--
