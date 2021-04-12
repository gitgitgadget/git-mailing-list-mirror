Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F137C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731DA61244
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbhDLOE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:04:28 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:45613 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238881AbhDLOE2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 10:04:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 95350174C;
        Mon, 12 Apr 2021 10:04:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 12 Apr 2021 10:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=LlkvfDj/imLkTwsPLYD+FgY5+ZM
        Hg3N/+vPOI7vgFbA=; b=UBkp9k0AS9P0gCvSJ7Y9BfaNm/7j/UuU8WVJfTGlrMD
        /K6o+MV5GcfiDog0IGT9gcxI4738q/2BcTEcwdQXtg55HdKZ7HQAwFmV61m5ma3Y
        kvJ9N57of/dmiNql3fMrkehTRA4/NOMcu7w7FkijdP019BhRPYi7ukV4e/2EsfV+
        u8r9FWGFKaArKN+KX6BhcA8g2FgTvG55wwONv/YaB11PyD+kveau5qCot8w+4cH1
        yjqTd65F3m5kg3AfvGyQifRYc8UfSOLKPNW/M9MvULrxCKNV+MIwtK8gdZLtz9SZ
        Xjou72178rd1iWNri3Pn/OQ0jPIdDeOw915CT03fZIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=LlkvfD
        j/imLkTwsPLYD+FgY5+ZMHg3N/+vPOI7vgFbA=; b=fpZFDgyCt/gYOcUpK6X0YG
        9PoNBAUshVxOhd4yiWvghOjsC9ru6+oF6967OV11mMZT4vM7rRLHqVruFLueLxU2
        eA7l0WxSl6lZCnV8GrTOchEBsc4/PDmeTalDng6kpQlThZcmJ4L4XimtqM5fyFdi
        zkrX8cwELg4gYLbymMTyOU+Qn8lfVSleSDrg0P12auFvufMWAihz75rgDnphmEjS
        ITrfj5kO7xtHtRs6WPONa4NfuSeTIsEcvN3A7pDxZ1kE7v9DjJs5XRgHftrNQWmV
        5aLfnVRJ6aDgLGdFbPE56LFHfyHwUZqWjn/vVsF5M6Ekxul+bXmKSgGUG6LMSlGg
        ==
X-ME-Sender: <xms:WFN0YNZqvQbwjbpeWtxesK_hOD45FGSmkckAxM7WtVSpKcd8UXHFMQ>
    <xme:WFN0YEVCYIaShObDA3plpv2z0t6veBLKvS3U-DOALSM_P6Zzjr4iCKYNZ0Zh1COzV
    bGPdoCYTdQkeyNNDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WFN0YM0qR0F0UwjfL_IK2SDhbM_8nMC4LSIlDnhgD2Kr2bPtP-DjOQ>
    <xmx:WFN0YDZUaLi4fuowDdRrKKwqZQrmlfq9PT0Sht6tRo6LFJrZlEutCQ>
    <xmx:WFN0YHpo28RF-iu4rO9ry7aHcH36bMeKasDibUsT33BDXERNNptQMA>
    <xmx:WVN0YLk3S-Ps3WJfj9fD9zLYm09NqsVMuah71l0SCm8y-cbeT1VkVg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB6C224006A;
        Mon, 12 Apr 2021 10:04:07 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b229c79d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 14:04:02 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:04:01 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] config: allow overriding of global and system
 configuration
Message-ID: <YHRTUVJZ2m9a0zDa@ncase>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
 <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
 <YHB092HN2oVLmqC1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eTHJBdd50iqVq/ED"
Content-Disposition: inline
In-Reply-To: <YHB092HN2oVLmqC1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--eTHJBdd50iqVq/ED
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 09, 2021 at 11:38:31AM -0400, Jeff King wrote:
> On Fri, Apr 09, 2021 at 03:43:30PM +0200, Patrick Steinhardt wrote:
>=20
> > In order to have git run in a fully controlled environment without any
> > misconfiguration, it may be desirable for users or scripts to override
> > global- and system-level configuration files. We already have a way of
> > doing this, which is to unset both HOME and XDG_CONFIG_HOME environment
> > variables and to set `GIT_CONFIG_NOGLOBAL=3Dtrue`. This is quite kludgy,
> > and unsetting the first two variables likely has an impact on other
> > executables spawned by such a script.
> >=20
> > The obvious way to fix this would be to introduce `GIT_CONFIG_NOSYSTEM`
> > as an equivalent to `GIT_CONFIG_NOGLOBAL`. But in the past, it has
>=20
> I think you have NOSYSTEM and NOGLOBAL mixed up in both paragraphs here?
>=20
> Otherwise the motivation and description here look very good (and I like
> the overall direction).
>=20
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index 3a9c44987f..2129629296 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -670,6 +670,16 @@ for further details.
> >  	If this environment variable is set to `0`, git will not prompt
> >  	on the terminal (e.g., when asking for HTTP authentication).
> > =20
> > +`GIT_CONFIG_GLOBAL`::
> > +`GIT_CONFIG_SYSTEM`::
> > +	Take the configuration from the given files instead from global or
> > +	system-level configuration files. The files must exist and be readable
> > +	by the current user. If `GIT_CONFIG_SYSTEM` is set, `/etc/gitconfig`
> > +	will not be read. Likewise, if `GIT_CONFIG_GLOBAL` is set, neither
> > +	`$HOME/.gitconfig` nor `$XDG_CONFIG_HOME/git/config` will be read. Can
> > +	be set to `/dev/null` to skip reading configuration files of the
> > +	respective level.
>=20
> Makes sense. The reference to `/etc/gitconfig` here may not be accurate,
> depending on the build parameters. I notice below in the context that we
> say:
>=20
> >  `GIT_CONFIG_NOSYSTEM`::
> >  	Whether to skip reading settings from the system-wide
> >  	`$(prefix)/etc/gitconfig` file.  This environment variable can
>=20
> which is _also_ not quite right (if $(prefix) is "/usr", then the file
> really is /etc/gitconfig).
>=20
> I think it might be possible to pull the value of the ETC_GITCONFIG
> Makefile variable into the documentation, so we could probably give the
> "real" value. But I wonder if it would suffice to just say:
>=20
>    ...the system config (usually `/etc/gitconfig`) will not be read.
>=20
> Or is that too confusing (it invites the question "when is it not
> /etc/gitconfig")? I guess we could say "the system config file defined
> at build-time (usually `/etc/gitconfig`)", which is perhaps more clear.
>=20
> > @@ -1847,8 +1847,22 @@ static int git_config_from_blob_ref(config_fn_t =
fn,
> >  const char *git_system_config(void)
> >  {
> >  	static const char *system_wide;
> > -	if (!system_wide)
> > -		system_wide =3D system_path(ETC_GITCONFIG);
> > +
> > +	if (!system_wide) {
> > +		system_wide =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
>=20
> I wondered, given the "const char *" return values in the last patch, if
> you might pass back the result of getenv() directly. But you duplicate
> it here, which is good, as it avoids portability problems hanging on to
> the result of getenv().
>=20
> > +		if (system_wide) {
> > +			/*
> > +			 * If GIT_CONFIG_SYSTEM is set, it overrides the
> > +			 * /etc/gitconfig. Furthermore, the file must exist in
> > +			 * order to prevent any typos by the user.
> > +			 */
> > +			if (access(system_wide, R_OK))
> > +				die(_("cannot access '%s'"), system_wide);
> > +		} else {
> > +			system_wide =3D system_path(ETC_GITCONFIG);
> > +		}
> > +	}
>=20
> I was on the fence about whether to enforce the "this file must exist"
> property, with respect to the overall design. But seeing how we must
> actually add extra code here to handle it makes me want to just treat it
> exactly like the other files.
>=20
> Using a separate access() here is also a TOCTOU race, but I'm pretty
> sure the existing config code makes the same mistake (and it's not that
> big a deal in this context).
>=20
> > @@ -1857,8 +1871,20 @@ void git_global_config(const char **user, const =
char **xdg)
> >  	static const char *user_config, *xdg_config;
> > =20
> >  	if (!user_config) {
> > -		user_config =3D expand_user_path("~/.gitconfig", 0);
> > -		xdg_config =3D xdg_config_home("config");
> > +		user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
> > +		if (user_config) {
> > +			/*
> > +			 * If GIT_CONFIG_GLOBAL is set, then it overrides both
> > +			 * the ~/.gitconfig and the XDG configuration file.
> > +			 * Furthermore, the file must exist in order to prevent
> > +			 * any typos by the user.
> > +			 */
> > +			if (access(user_config, R_OK))
> > +				die(_("cannot access '%s'"), user_config);
> > +		} else {
> > +			user_config =3D expand_user_path("~/.gitconfig", 0);
> > +			xdg_config =3D xdg_config_home("config");
> > +		}
> >  	}
>=20
> And this looks as I'd expect (but the same comments as above apply, of
> course).
>=20
> > +test_expect_success 'override global and system config' '
> > +	test_when_finished rm -f "$HOME"/.config/git &&
> > +
> > +	cat >"$HOME"/.gitconfig <<-EOF &&
> > +	[home]
> > +		config =3D true
> > +	EOF
> > +	mkdir -p "$HOME"/.config/git &&
> > +	cat >"$HOME"/.config/git/config <<-EOF &&
> > +	[xdg]
> > +		config =3D true
> > +	EOF
> > +	cat >.git/config <<-EOF &&
> > +	[local]
> > +		config =3D true
> > +	EOF
> > +	cat >custom-global-config <<-EOF &&
> > +	[global]
> > +		config =3D true
> > +	EOF
> > +	cat >custom-system-config <<-EOF &&
> > +	[system]
> > +		config =3D true
> > +	EOF
>=20
> Minor style nit, but we usually prefer non-interpolating "\EOF" if we
> don't intend to interpolate within the here-doc. It does look like
> t1300 has quite a mix of styles, though.
>=20
> > +	cat >expect <<-EOF &&
> > +	global	xdg.config=3Dtrue
> > +	global	home.config=3Dtrue
> > +	local	local.config=3Dtrue
> > +	EOF
> > +	git config --show-scope --list >output &&
> > +	test_cmp expect output &&
> > +
> > +	sane_unset GIT_CONFIG_NOSYSTEM &&
> > +
> > +	cat >expect <<-EOF &&
> > +	system	system.config=3Dtrue
> > +	global	global.config=3Dtrue
> > +	local	local.config=3Dtrue
> > +	EOF
> > +	GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_CONFIG_GLOBAL=3Dcustom-g=
lobal-config \
> > +		git config --show-scope --list >output &&
> > +	test_cmp expect output &&
> > +
> > +	cat >expect <<-EOF &&
> > +	local	local.config=3Dtrue
> > +	EOF
> > +	GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOBAL=3D/dev/null git confi=
g --show-scope --list >output &&
> > +	test_cmp expect output
> > +'
>=20
> And this test covers all of the new stuff we care about. Good.
>=20
> > +test_expect_success 'override global and system config with missing fi=
le' '
> > +	sane_unset GIT_CONFIG_NOSYSTEM &&
> > +	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist git version &&
> > +	test_must_fail env GIT_CONFIG_SYSTEM=3Ddoes-not-exist git version &&
> > +	GIT_CONFIG_NOSYSTEM=3Dtrue GIT_CONFIG_SYSTEM=3Ddoes-not-exist git ver=
sion
> > +'
>=20
> Makes sense to test given the patch, though if we rip out the "missing"
> check, then obviously this goes away.
>=20
> > +test_expect_success 'write to overridden global and system config' '
>=20
> Hmm. I hadn't really considered _writing_ to these files (after all, you
> can just use "git config --file" to do so). I guess it is consistent,
> and would probably be more work (and more error-prone) to try to
> distinguish reading versus writing in the code.
>=20
> > +	cat >expect <<EOF &&
> > +[config]
> > +	key =3D value
> > +EOF
>=20
> No "<<-EOF" here to fix the indentation?
>=20
> > +	test_must_fail env GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --g=
lobal config.key value &&
> > +	touch write-to-global &&
> > +	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --global config.key va=
lue &&
> > +	test_cmp expect write-to-global &&
>=20
> In the writing case, the "must exist" thing makes it even weirder, since
> we might be intending to create the file! If we leave in the writing,
> that makes me even more convinced that we should drop the "must exist"
> check.
>=20
> -Peff

I do agree that for the writing side it's limiting to require the file
to exist. The question is really what's gained by it. The worst thing
that could happen is that the user writes to a file he didn't intend to
write to -- this can happen regardless of whether or not the file
exists, and in fact the worse case is where we overwrite values of a
file which the user didn't intend to overwrite. The case where we create
a new file by accident doesn't seem to be that interesting to me.

In any case, the user would probably use `git config -f` anyway. Which
raises the question whether it's sensible to allow writing to the file
in the first place. And for the sake of scripts, I lean towards "yes":
the dev can set up envvars once, and then use the config for both
reading and writing.

On the reading side, I can relate with Junio's argument that there's now
two possibilities for typos: once in the envvar, and once in the file
path. But given that git won't check the envvar's key for typos, we
cannot really reduce the chance for typos down to zero anyway.

So I do tend towards just allowing for the file to not exist: when
reading, we silentely ignore it, and when writing we create it.

Patrick

--eTHJBdd50iqVq/ED
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0U1AACgkQVbJhu7ck
PpStFQ//RxRA+Hc7v2uBfvPEcQLDuS9dnISP1JN5MJiq/h9bLo1O8I5/cn0zp1rX
PfCxgLOm/NG7/RRXp+sbD3KLeG56rEP5cpOm4e387st0aTvg8J8HT1MuxhWMPz/f
KP1M8TK2imSrkDiN4scPNhNL1oeHJuIsRrYTx00a/n6HMV6FN5Ya2dMCnILyjE8S
FALjOzAX3Noup+Tr67u2qlb3PgxQZDiPtHag8+LYBqRJ7wvFNg7O3FxDU0luHo4P
QWgQvnTPfqdiFVztEiAUw6zqB8AB84Ns/T7aThpkcDw7Isw+rektGPDmH3VtiCwj
M8kdcpZPH7toMixFmQNBPJPITmU6ZV9ltbXwlR1q9PEecsoMsLLtLYtHj/avXRCt
/aj/Xf8N4Q0ZOxzsvueTbOvhfdGbhMAIoVJA6C/yC5apPTH8S6mlK358hfVBZLdB
BIb26gt3MsjggzQZT8edeIu1UdKReAHptLNcrny2OKKdJKabOTNfKDsQzkzwCDBf
AOFLBJ6bIbzPIpYhqAgF3Vl6nJ0TfrCWuVXWO3UeB2TLKVypRROLnCyoTvwlGFKj
FmwyjGcMvNG1z1U9ftJK2QS6NW+0DUW2axcT6oBt9/N456525G0tK1avG3o3Z6kf
30WPjwFMPEc3IB6PjFkl2uRM2urahsZ/jg7ZB1zKkWWizap/LpQ=
=gnWu
-----END PGP SIGNATURE-----

--eTHJBdd50iqVq/ED--
