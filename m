Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBE311F461
	for <e@80x24.org>; Fri, 19 Jul 2019 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfGSSMh (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 14:12:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40599 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfGSSMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 14:12:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so29846783wmj.5
        for <git@vger.kernel.org>; Fri, 19 Jul 2019 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1fnymX75Mwp7fndyDl7fkHrjGPFPbJ04RbWPBV/azD4=;
        b=XZup1hqIE4jNYXfVIpcx2HwF4oyyccO8q+wFY7dZxOvWDUtqHE7lM3OTCDQS5x3WSO
         WQtPJt74ChFBCFSmv+GAbUDg0hd9PHnxbhx+fx539995/Fug5tWFi1pJUU72HWoNwV0/
         twYcqeplU4Idgqu76iRHrjqSlW6Sm0+SRFCQLiySvI08T2UvrO8ESp13Mc1mmQ4fgRSW
         H3r5V7zsNSAo/CzraER4bWlVlYAfIl7CQyZAKzawKE8TkwB0mmBFQ2DHVHEj6CgsM7fa
         KzxC/5nzgZFNVn6nlLzDxT2WBEnGmZ7nzSgjGX2HcsO89KJhXER6idZ6CEQtBlPD2YPz
         wFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1fnymX75Mwp7fndyDl7fkHrjGPFPbJ04RbWPBV/azD4=;
        b=ay5Df9kJjB+pk8W19wtr/JnJ2NcgAluBUPa6ka1Fjr6Egt+rlW0xMJn6n0Y3I5xRqn
         dzh65jYQCY13F2iVtggZs1vj3TSHd9ncGl93NLks1XDzyazjK6fDT/L2fnQfr78fWVlQ
         spLvanFjEiTjyRsoLQkDFkRYkfK1EySby17kk6rmZCLuez9XXZEv2qjSLlY8A15ZlgVb
         e4IyHJ0vytusVOk8srYWELMmmGQl5BjFhm7qBDiy5ZuhhpQgDa3TpC4sAyl3/CAdVC3A
         rltriu14P3GCbLS/eql5vHBJuM7TiUPJQ0cZfhFIQoSjacglCLNG6GklIaSA8pSIbVDY
         Xg8g==
X-Gm-Message-State: APjAAAXf8qd6kMd9z09u6FVCQ3J851brZUcHI/yqRtBzDoYIyeo9LP/5
        WDugDaCguVrqoigOCqnRcfAGy+kT
X-Google-Smtp-Source: APXvYqyiCO19RCR0cE6uz/0WIroehj2N323dnQDaNIa7xn1Y6X2j2cTne2vmntcqzvqQaoU3AR06rQ==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr47985376wma.68.1563559954848;
        Fri, 19 Jul 2019 11:12:34 -0700 (PDT)
Received: from andromeda.localnet ([80.214.30.27])
        by smtp.gmail.com with ESMTPSA id l17sm18055259wrr.94.2019.07.19.11.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jul 2019 11:12:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC PATCH 1/9] t3404: demonstrate that --edit-todo does not check for dropped commits
Date:   Fri, 19 Jul 2019 20:12:27 +0200
Message-ID: <2836634.HGSAIcGHtf@andromeda>
In-Reply-To: <xmqqwogfxkhx.fsf@gitster-ct.c.googlers.com>
References: <20190717143918.7406-1-alban.gruin@gmail.com> <20190717143918.7406-2-alban.gruin@gmail.com> <xmqqwogfxkhx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 18/07/2019 =C3=A0 20:31, Junio C Hamano a =C3=A9crit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> > When set to "warn" or "error", `rebase.missingCommitCheck' would make
> > rebase -i warn if the user removed commits from the todo list to prevent
> > mistakes.  Unfortunately, rebase --edit-todo and rebase --continue don't
> > take it into account.
> >=20
> > This adds three tests to t3404 to demonstrate this.  The first one is
> > not broken, as when `rebase.missingCommitsCheck' is not set, nothing in
> > particular must be done towards dropped commits.  The two others are
> > broken, demonstrating the problem.
> >=20
> > Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> > ---
> >=20
> >  t/t3404-rebase-interactive.sh | 82 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >=20
> > diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive=
=2Esh
> > index 461dd539ff..f5c0a8d2bb 100755
> > --- a/t/t3404-rebase-interactive.sh
> > +++ b/t/t3404-rebase-interactive.sh
> > @@ -1345,6 +1345,88 @@ test_expect_success 'rebase -i respects
> > rebase.missingCommitsCheck =3D error' '>=20
> >  	test B =3D $(git cat-file commit HEAD^ | sed -ne \$p)
> > =20
> >  '
> >=20
> > +test_expect_success 'rebase --edit-todo respects
> > rebase.missingCommitsCheck =3D ignore' ' +	test_config
> > rebase.missingCommitsCheck ignore &&
> > +	rebase_setup_and_clean missing-commit &&
> > +	set_fake_editor &&
> > +	test_must_fail env FAKE_LINES=3D"1 2 bad 3 4" \
> > +		git rebase -i --root >/dev/null 2>stderr &&
>=20
> Do you need to capture into stderr?  Nobody seems to use it.
>=20

No.  I=E2=80=99m changing this.

> > +	FAKE_LINES=3D"1 2 4" git rebase --edit-todo &&
> > +	git rebase --continue 2>actual &&
> > +	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> > +	test_i18ngrep \
> > +		"Successfully rebased and updated refs/heads/missing-
commit" \
> > +		actual
> > +'
> > +
> > +cat >expect <<EOF
> > +error: invalid line 5: badcmd $(git rev-list --pretty=3Doneline
> > --abbrev-commit -1 master) +Warning: some commits may have been dropped
> > accidentally.
> > +Dropped commits (newer to older):
> > + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> > +To avoid this message, use "drop" to explicitly remove a commit.
> > +
> > +Use 'git config rebase.missingCommitsCheck' to change the level of
> > warnings. +The possible behaviours are: ignore, warn, error.
> > +
> > +EOF
> > +
> > +tail -n 8 <expect >expect.2
>=20
> Having this outside the test_expect_success block that uses the file
> is bad.  You may have mimicked other tests in the same script, but
> that is not a good excuse to make things worse.  Just make sure
> these new stuff follow the best-current-practice pattern without
> touching the existing bad examples (and later fix them up after the
> dust settles, but don't let it distract you from the theme these
> patches are addressing).
>=20

Okay.

> > +
> > +test_expect_failure 'rebase --edit-todo respects
> > rebase.missingCommitsCheck =3D warn' ' +	test_config
> > rebase.missingCommitsCheck warn &&
> > +	rebase_setup_and_clean missing-commit &&
> > +	set_fake_editor &&
> > +	test_must_fail env FAKE_LINES=3D"1 2 3 4 bad 5" \
> > +		git rebase -i --root >/dev/null 2>stderr &&
>=20
> Ditto.
>=20
> > +	FAKE_LINES=3D"1 2 3 4" git rebase --edit-todo 2>actual &&
> > +	test_i18ncmp expect actual &&
>=20
> So, after "--edit-todo", you are supposed to get an error and a warning,
> but ...
>=20
> > +	git rebase --continue 2>actual.2 &&
> > +	head -n 8 <actual.2 >actual &&
> > +	test_i18ncmp expect.2 actual &&
>=20
> ... after "--continue", you do not get any error, as you removed
> 'bad' from the input, but you still get a warning, followed by a
> report of the fact that a commit has been dropped.  OK.
>=20
> > +	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> > +	test_i18ngrep \
> > +		"Successfully rebased and updated refs/heads/missing-
commit" \
> > +		actual.2
> > +'
> > +
> > +cat >expect <<EOF
> > +error: invalid line 3: badcmd $(git rev-list --pretty=3Doneline
> > --abbrev-commit -1 master~2) +Warning: some commits may have been dropp=
ed
> > accidentally.
> > +Dropped commits (newer to older):
> > + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master)
> > + - $(git rev-list --pretty=3Doneline --abbrev-commit -1 master~2)
> > +To avoid this message, use "drop" to explicitly remove a commit.
> > +
> > +Use 'git config rebase.missingCommitsCheck' to change the level of
> > warnings. +The possible behaviours are: ignore, warn, error.
> > +
> > +EOF
> > +
> > +tail -n 9 <expect >expect.2
> > +
> > +test_expect_failure 'rebase --edit-todo respects
> > rebase.missingCommitsCheck =3D error' ' +	test_config
> > rebase.missingCommitsCheck error &&
> > +	rebase_setup_and_clean missing-commit &&
> > +	set_fake_editor &&
> > +	test_must_fail env FAKE_LINES=3D"1 2 bad 3 4" \
> > +		git rebase -i --root >/dev/null 2>stderr &&
> > +	test_must_fail env FAKE_LINES=3D"1 2 4" \
> > +		git rebase --edit-todo 2>actual &&
> > +	test_i18ncmp expect actual &&
> > +	test_must_fail git rebase --continue 2>actual &&
>=20
> OK, and this one fails as the configuration is set to 'error'.
>=20
> > +	test_i18ncmp expect.2 actual &&
> > +	cp .git/rebase-merge/git-rebase-todo.backup \
> > +		.git/rebase-merge/git-rebase-todo &&
>=20
> Why?  Who uses this copy?
>=20

The same technique is used in "rebase -i respects rebase.missingCommitsChec=
k =3D=20
error".

> > +	FAKE_LINES=3D"1 2 drop 3 4 drop 5" \
> > +		git rebase --edit-todo &&
> > +	git rebase --continue 2>actual &&
> > +	test D =3D $(git cat-file commit HEAD | sed -ne \$p) &&
> > +	test_i18ngrep \
> > +		"Successfully rebased and updated refs/heads/missing-
commit" \
> > +		actual
> > +'
> > +
> >=20
> >  test_expect_success 'respects rebase.abbreviateCommands with fixup,
> >  squash and exec' '> =20
> >  	rebase_setup_and_clean abbrevcmd &&
> >  	test_commit "first" file1.txt "first line" first &&



