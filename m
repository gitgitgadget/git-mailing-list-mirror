Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95DC433B4
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 06:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2178161074
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 06:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDJGvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 02:51:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58064 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhDJGvM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 02:51:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B3B4B1E48;
        Sat, 10 Apr 2021 02:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/d47vAs/U6EQ
        452KJ4tMsh9g+BA=; b=Y2SlWttf+NgEOLP5tUaCO4fB5QdUeaIHC9vVQr6psXmG
        MEal6CHipJ5TXAQgSfbWBrGuegvjbp79NgY6DBNXnHjUGdVXj4WvE8pyxMtjGDSR
        RHRGAcAmNOxcf6dph3QmN6IDx+WULVy0Vj0S53lcMXPCNUqkR2xpM5XjVTORsWY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dftp5B
        pyG+ggsXHvzo2zI6G3jmlbDC7OQIGaY4oMLMXfoUoY49tVufBodIIlcBdecWfJDo
        uVx03ISoav3y7cFRHLF1PjugyuOFOBDy7wWwkTmdZkaLl1Ttt/7ZC3RltZLCOCQg
        T5q3KwmRWw4wg6LYqCUkbtdw0GBDdr01/K8Es=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3939DB1E46;
        Sat, 10 Apr 2021 02:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D961B1E45;
        Sat, 10 Apr 2021 02:50:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yuri <yuri@rawbw.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Warning during 'git stash push'
References: <e493ca9b-c686-68ea-cd8d-c7b13766d65e@rawbw.com>
Date:   Fri, 09 Apr 2021 23:50:55 -0700
In-Reply-To: <e493ca9b-c686-68ea-cd8d-c7b13766d65e@rawbw.com>
        (yuri@rawbw.com's message of "Fri, 9 Apr 2021 21:58:31 -0700")
Message-ID: <xmqqim4uk4z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 19E1E5C4-99C9-11EB-A295-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yuri <yuri@rawbw.com> writes:

> What did you do before the bug happened? (Steps to reproduce your issue=
)
> Tried to stash a particular subdirectory
>
> What did you expect to happen? (Expected behavior)
> Directory should be stashed, obviously,
>
> What happened instead? (Actual behavior)
> =C2=A0git stash push -- x11-toolkits/fltk
> Saved working directory and index state WIP on main: 4c2cc95952a6
> graphics/mesa-devel: update to 21.0.b.4390
> <stdin>:83: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 LIBS=3D"$LIBS -lX11 $X_EXTRA_LIBS"
> <stdin>:84: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 CFLAGS=3D"$CFLAGS $X_CFLAGS"
> <stdin>:85: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 CXXFLAGS=3D"$CXXFLAGS $X_CFLAGS"
> <stdin>:88: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 DSOFLAGS=3D"$X_LIBS $DSOFLAGS"
> <stdin>:89: space before tab in indent.
> =C2=A0=C2=A0=C2=A0=C2=A0 $as_echo "#define USE_X11 1" >>confdefs.h
> warning: squelched 40 whitespace errors
> warning: 45 lines add whitespace errors.


Thanks for a report.

I wonder if this is one of those regressions introduced during the
rewrite.

Not even compile tested, but I think the following patch may be a
good starting point to help somebody who wants to fix it (it is too
late at night for me ;-).

 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/builtin/stash.c w/builtin/stash.c
index d68ed784d2..c65685de29 100644
--- c/builtin/stash.c
+++ w/builtin/stash.c
@@ -1510,7 +1510,7 @@ static int do_push_stash(const struct pathspec *ps,=
 const char *stash_msg, int q
=20
 			cp_apply.git_cmd =3D 1;
 			strvec_pushl(&cp_apply.args, "apply", "--index",
-				     "-R", NULL);
+				     "-R", "--whitespace=3Dnowarn", NULL);
 			if (pipe_command(&cp_apply, out.buf, out.len, NULL, 0,
 					 NULL, 0)) {
 				ret =3D -1;
@@ -1547,7 +1547,7 @@ static int do_push_stash(const struct pathspec *ps,=
 const char *stash_msg, int q
 		struct child_process cp =3D CHILD_PROCESS_INIT;
=20
 		cp.git_cmd =3D 1;
-		strvec_pushl(&cp.args, "apply", "-R", NULL);
+		strvec_pushl(&cp.args, "apply", "-R", "--whitespace=3Dnowarn", NULL);
=20
 		if (pipe_command(&cp, patch.buf, patch.len, NULL, 0, NULL, 0)) {
 			if (!quiet)
