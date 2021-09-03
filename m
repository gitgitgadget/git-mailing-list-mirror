Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D237C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6885560462
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349590AbhICPmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:42:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:33627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235553AbhICPmg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630683689;
        bh=8p/XELWXLZj/i3ME1ysCTb5kSD693qNstVJsciOE2Z4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AQW15jBCtSe5mt7t2DIaJM6mes0KTD41Dudyq+NB00i/dKHh8TgfPQG9tLouJ0UvH
         ZBgqAdKpLZuU1vcIwT2Pu6sKoqBxls8JxNI9HcoD+tqgcwAsJ6Eon2oOl/z0Csp5xm
         /bGd1A61MADAuOaO/lqt/tZ24KEL9K/WWWBFp4e4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1mNq0g3zoI-002o8T; Fri, 03
 Sep 2021 17:41:29 +0200
Date:   Fri, 3 Sep 2021 17:41:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/15] scalar: 'register' sets recommended config and
 starts maintenance
In-Reply-To: <xmqq5yvks22s.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109031724560.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <3786f4c597fffc13f638efd26875dcb257d54ab4.1630359290.git.gitgitgadget@gmail.com> <xmqq5yvks22s.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:676fz8yPweRrDKsyuPS9UCb9dXkMV3k0y9B5kwtOnrhRIq+Jaf2
 YSWLcuPhoNi0nYTtQUEkAuKmDQGmDrLKhidOS67jDh0S/R0eGZIRQWW/7rRjwJKHuAsgm0k
 R0/j/ha43JHvKv8fe3pk38tFZqr3pVLY0wwliKADi7gC9QH77T7x8dDaydcBhWRYZgAEXc5
 5A8fuCCvD5t87TIN0uExg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zKjNO6+qths=:J3iCZDTJ4xxhSZ41PJUe+9
 DBPbTQkJrJgqRJ8HEOSSQqdtMJn31oeu/qj5th0cJe/sbseVUQdcai39eO/8CKY5O9c79TT0r
 ezcXwABATkG3fO/au648ozcQeD6Utv0Dj4JU5LBKODRqzJWM4UkJxJoygVJn5q7FN/ScLySqu
 GgiF0Z4VttpM+CYqhPTebgX3KyVVO8lOtDteWH3wZIAEAnvl9vReAkxTHaFkZ/Fsr7cexcONq
 Uy1sYFo+jEaL9nQ7awuUnTzh88EYD3DJ1yMTl94zw70qaTgxysI9YbfKM72KAVKS2Tz54D+RM
 0l/BmprQ1x7qw8hpbSjMO/9IpysguZ6NYX87xZdxpZa+LoBkqXa6cRVpIQXITWv8smYgZYM00
 jMn7/0BBKyciE8iAgqCDLc8KVylZRxA5HrXc4jJpFhUbTyc8LTJPz8fBGhPXkwivJ1OGAt4DF
 +F2UQbOtKQJJdSffyrwpCfOk/JxV9iWLjLi387vgg2ADmWuVYS9y91m2RYiGFMocQd/Qu1d1M
 9ZlnkjsYkRSNTBchRLPCFvLSh5wO3E6+RVLIuIu25RwD515u6vi4rtQW9PL0ot2t6sjnJTwg3
 YD7HIsjTwvCR7hZgMHwSY5QPQM+HSPH8Fg1O7C9ROGXYTHpyomxyKTpIThVyL8g9Uy9D27Ker
 oOmmvJ7F0r7U7FZFmWBQlZK/yVhDFX8N6e4FTdQUKab2AS/Dk6cd32oTGKzsd/3QYnfYla82k
 yuqxIDDos8pAWJSNCtEm+wgIcqPH3tFOJAUPizK+lKZ7O+KLxAs99OmyfBDOr/55F11Ia+mks
 BqMikeZikRr+Rh7A7HtZdHTdcbpNm2ZifnqG6POHdzpgdZg0eFXMBuVpNUAr8voxCFEXnCGgx
 h9L9l/oEG1MEiZQ3pAbWGCm5WzPRosOnrUhcgmdU2MrUKyc+hJyG1JSYUnQcIEfjXTvaZZvzU
 4CknStfCbeDggjkyf8RZzX2A/xo2HiEuGT1vH+xwKSgQF7Ye53v7LoHDr6YCUHEEDndK3UVF6
 h13evVuGlrVq0f6eon5Q3jW6Tgw7ihqooQehcLf+hPpcDXw3mGC+qumZhwQasfPQBuY0GLz7m
 TbwAoJhu1DFYwnvNj283sb9wgxPK8O6eR0F1PfgvZ+it+IZR0WHbwIdmA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Sep 2021, Junio C Hamano wrote:

> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +static void setup_enlistment_directory(int argc, const char **argv,
> > +				       const char * const *usagestr,
> > +				       const struct option *options,
> > +				       struct strbuf *enlistment_root)
> > +{
> > +	struct strbuf path =3D STRBUF_INIT;
> > +	char *root;
> > +	int enlistment_found =3D 0;
> > +
> > +	if (startup_info->have_repository)
> > +		BUG("gitdir already set up?!?");
> > +
> > +	if (argc > 1)
> > +		usage_with_options(usagestr, options);
> > +
> > +	/* find the worktree, determine its corresponding root */
> > +	if (argc =3D=3D 1)
> > +		strbuf_add_absolute_path(&path, argv[0]);
> > +	else if (strbuf_getcwd(&path) < 0)
> > +		die(_("need a working directory"));
> > +
> > +	strbuf_trim_trailing_dir_sep(&path);
> > +	do {
> > +		const size_t len =3D path.len;
> > +
> > +		/* check if currently in enlistment root with src/ workdir */
> > +		strbuf_addstr(&path, "/src/.git");
> > +		if (is_git_directory(path.buf)) {
> > +			strbuf_strip_suffix(&path, "/.git");
> > +
> > +			if (enlistment_root)
> > +				strbuf_add(enlistment_root, path.buf, len);
> > +
> > +			enlistment_found =3D 1;
> > +			break;
> > +		}
>
> This special casing of "normally the top of the working tree is
> enlisted, but if the repository is called src/, then we enslist
> one level up" is a bit of eyesore because
>
>  (1) it is unclear why such a directory with 'src/' subdirectory is
>      so special, and
>
>  (2) it fails to serve those who has the same need but named their
>      source subdirectory differently (like 'source/').

All true. I wish we had come up with a better way, or with a way to
override this via an option.

Unfortunately, we are now bound by the fact that there are already users
out there...

> "The design decisions we made are all part of being opinionated" can
> all explain it away, but at least we should let the users know where
> the opinionated choices scalar makes want to lead them to, and this
> "src/" stuff needs a bit of clarification.  Perhaps a documentation
> will be added in later steps?

I had hoped that the initial blurb of the manual page was sufficient, but
you're right, the `register` subcommand is particular in that it allows to
force Scalar to consider the worktree to be identical to the Scalar
enlistment. I added this:

	diff --git a/contrib/scalar/scalar.txt b/contrib/scalar/scalar.txt
	index 1593da45eae..568987064b2 100644
	--- a/contrib/scalar/scalar.txt
	+++ b/contrib/scalar/scalar.txt
	@@ -40,6 +40,10 @@ register [<enlistment>]::
		and starts background maintenance. If `<enlistment>` is not provided,
		then the enlistment associated with the current working directory is
		registered.
	++
	+Note: when this subcommand is called in a worktree that is called `src/`=
, its
	+parent directory is considered to be the Scalar enlistment. If the workt=
ree is
	+_not_ called `src/`, it itself will be considered to be the Scalar enlis=
tment.

> > +	for (i =3D 0; config[i].key; i++) {
> > +		if (git_config_get_string(config[i].key, &value)) {
> > +			trace2_data_string("scalar", the_repository, config[i].key, "creat=
ed");
> > +			if (git_config_set_gently(config[i].key,
> > +						  config[i].value) < 0)
> > +				return error(_("could not configure %s=3D%s"),
> > +					     config[i].key, config[i].value);
> > +		} else {
> > +			trace2_data_string("scalar", the_repository, config[i].key, "exist=
s");
> > +			free(value);
> > +		}
>
> I wonder if we should have a table of configuration variables and
> their default values.  The above code implements a skewed "we only
> avoid overriding what is explicitly configured".  A variable that
> the user left unconfigured because the user found its default
> satisfactory will be overridden, and if the value scalar wants to
> use happens to be the default value, we leave an explicit
> configuration to that default value in the resulting configuration
> file.
>
> But I think the above is the best we can do without such a central
> registry of configuration variables.

Even with such a central registry, there would still be the question
whether the user, by staying with the default, wanted Git (or in this
instance, Scalar) to keep using the old default. The intention is
unfortunately not clear just from setting the variable.

So I think this is the best we can do.

Ciao,
Dscho
