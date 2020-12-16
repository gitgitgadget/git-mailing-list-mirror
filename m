Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C39C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F50222D05
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgLPAY0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:24:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63403 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgLPAYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 19:24:24 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8E569F4F03;
        Tue, 15 Dec 2020 19:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hO8sqNBj+fSA
        6Uk675hJdEz2xs4=; b=yNxgUqv/c4Xc0SWB3sb053HsbL6ti1yi0f9QxHkQ5m5s
        +BgFd3k9V1oNRrkH6RAmkKfi9nSkep31lAF/bT8ScBxV+XMAXONphOZlZFjezE1T
        EmVdkq2YRuTgW+Y6ynQ/ycmAfQZ4zHQ7ETG8fgji5j3ng/xbP6wLDklaFQlWipQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=H+5qjO
        XXQFQ017nxrIWxdqxTBBR5EVgMRuFVmijzFnJw6rVDwBxwf+22L9/2VaFGsyTjHi
        MB/fcxXzMO9a3XdAm603KD+9PPWLs7o16WJxYsaTPF2e4tm7B698yaIy09eUc7Id
        dYcaIibo6Sjq+t7CXIohzNX4WxI/HGmRhCDms=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 861EBF4F02;
        Tue, 15 Dec 2020 19:23:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D2253F4F01;
        Tue, 15 Dec 2020 19:23:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stuart MacDonald <stuartm.coding@gmail.com>, git@vger.kernel.org,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
        <F55DC360-9C1E-45B9-B8BA-39E1001BD620@gmail.com>
        <20170511234259.gnbr6aiu26oqysxo@sigill.intra.peff.net>
        <CACBZZX7-Gw7G7yY=ah6AQCJKzWKB002iAo6RNJwZmvMRe4Pd+w@mail.gmail.com>
        <875z52wu2a.fsf@evledraar.gmail.com>
Date:   Tue, 15 Dec 2020 16:23:34 -0800
In-Reply-To: <875z52wu2a.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 16 Dec 2020 00:03:41 +0100")
Message-ID: <xmqq4kkm7g55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F0626168-3F34-11EB-AEF6-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But it's not a "no" until that point (and not even then, maybe we can
> keep the general idea of Y, but have Z which is mostly the same & works
> for most people), it's just "nobody's really worked on it yet".

Thanks for spelling these out.

Here is my snack-time hack to add the --pretend-gitdir option to "git
config".  It _might_ not be a bad idea to trigger this behaviour
(using $(pwd)/.git as the pretended directory path) automatically
when do not have a repository, but that would certainly be a
compatibility breaking change and would break existing workflow.

Only very lightly tested, and certainly not ready for inclusion (it
does not even have a doc update).


 builtin/config.c          |  4 ++++
 config.c                  |  2 ++
 config.h                  |  1 +
 t/t1305-config-include.sh | 21 +++++++++++++++++++++
 4 files changed, 28 insertions(+)

diff --git c/builtin/config.c w/builtin/config.c
index f71fa39b38..2603dc448c 100644
--- c/builtin/config.c
+++ w/builtin/config.c
@@ -30,6 +30,7 @@ static int use_worktree_config;
 static struct git_config_source given_config_source;
 static int actions, type;
 static char *default_value;
+static char *pretend_gitdir;
 static int end_nul;
 static int respect_includes_opt =3D -1;
 static struct config_options config_options;
@@ -165,6 +166,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (fil=
e, standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktr=
ee, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, u=
se default value when missing entry")),
+	OPT_FILENAME(0, "pretend-gitdir", &pretend_gitdir, N_("when outside a r=
epository, pretend this is the gitdir")),
 	OPT_END(),
 };
=20
@@ -732,6 +734,8 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
 		config_options.commondir =3D get_git_common_dir();
 		config_options.git_dir =3D get_git_dir();
 	}
+	if (pretend_gitdir)
+		config_options.pretend_gitdir =3D pretend_gitdir;
=20
 	if (end_nul) {
 		term =3D '\0';
diff --git c/config.c w/config.c
index 1137bd73af..d8d406ecda 100644
--- c/config.c
+++ w/config.c
@@ -224,6 +224,8 @@ static int include_by_gitdir(const struct config_opti=
ons *opts,
=20
 	if (opts->git_dir)
 		git_dir =3D opts->git_dir;
+	else if (opts->pretend_gitdir)
+		git_dir =3D opts->pretend_gitdir;
 	else
 		goto done;
=20
diff --git c/config.h w/config.h
index c1449bb790..14e8d8c576 100644
--- c/config.h
+++ w/config.h
@@ -89,6 +89,7 @@ struct config_options {
 	unsigned int system_gently : 1;
 	const char *commondir;
 	const char *git_dir;
+	const char *pretend_gitdir;
 	config_parser_event_fn_t event_fn;
 	void *event_fn_data;
 	enum config_error_action {
diff --git c/t/t1305-config-include.sh w/t/t1305-config-include.sh
index f1e1b289f9..883762ad36 100755
--- c/t/t1305-config-include.sh
+++ w/t/t1305-config-include.sh
@@ -162,6 +162,27 @@ test_expect_success 'relative includes from stdin li=
ne fail' '
 	test_must_fail git config --file - test.one
 '
=20
+test_expect_success 'conditional include, pretend gitdir' '
+	test_when_finished "git config --global --unset-all \"includeif.gitdir:=
*.path\"" &&
+	git config --global "includeif.gitdir:*.path" included &&
+
+	git config --file included "custom.variable" value &&
+	echo value >expect &&
+
+	# in the TRASH repository
+	git config --get custom.variable >actual &&
+	test_cmp expect actual &&
+
+	# nongit without pretend should not find stuff from included
+	nongit test_must_fail git config --get custom.variable >actual &&
+	test_must_be_empty actual &&
+
+	# nongit with pretend should find stuff from included
+	nongit git config --pretend-gitdir "$(pwd)/.git" \
+		--get custom.variable >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'conditional include, both unanchored' '
 	git init foo &&
 	(
