Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AD1C433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD1360E77
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349162AbhIHTAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 15:00:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:38555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhIHTAL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 15:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631127537;
        bh=jUkW7Gx55Gph7MBlTHAEWm9y2YjXjsiybIqI7PvC6i4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jgVeUh0FEU+29gfuPCbLmgXGHyxXGg/YpowTxP9zIZfPci7O4IpLCQ1BvWInP91N4
         vWiu+HJdtxZAibC2JlxTZKA7R+n6stH0xUuOXDFro7+7s7NI42A1ZE5Eh/kwtziYDV
         a60+vgyWdiBrzZyt1L+9rG4NM14pU1nOBOlRx0rI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQeK-1mGvEl19Ow-00AUdA; Wed, 08
 Sep 2021 20:58:57 +0200
Date:   Wed, 8 Sep 2021 20:59:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
In-Reply-To: <xmqqwnnxftzn.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109082049290.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com> <xmqqsfyoqm6e.fsf@gitster.g> <nycvar.QRO.7.76.6.2109031709190.55@tvgsbejvaqbjf.bet> <xmqqwnnxftzn.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nJ69/jysqwiJkhFRn3JtU9h78OFTTK2DQNzw3fjktHOwww1AHd+
 kACDWl3iILVgWKqLssjRS9vGNlBQlKHDqsLF4y1Ta6AsULv0p1udvQGmSlUxg6gASiEyAUq
 QT8GbqnOJWRfOyiW2FOMs3dd5fVYCgYuap6WuUdkmVXSuMlz8/QpDBIq48pg5UvK6Jpcjar
 S0163/axZOa5nDliGq68w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AhrV2YkcKpA=:cJKItgjT9DHKyxBUKf/U2Z
 qLKsEvV1BrHt/Bhga6OhJhKivdGxg+9G3I4dhSfIFTqoVu/ayMPVRxmJ1yx7xoXFs/hZl9LgQ
 y44QnepdGS20dO1SWldzvmVPyzIWFxMkTN4W00Vx+km8WrYBeZznWfKyGdvgNU5WcSm3O9Jv1
 6DQaclTnpZdIIYJXD4lm6mpizT52S9Lc/nDaGzqsho0oLFLIv8BBuc3GL4qp4jod0IrVLHIMt
 o2AWyj5fJx40g4CoNkdFzvp+gfEOULSre+jrhMEUqtigPYrqzLJPLIJ5sx9dWjXNJi0ZkEC3+
 o9Rp6L17WVEgcSYPwMG7rq1jziie8t45wFoderyH0+umyTBBDdMLOTkgf4Y1gCKbl9Ij3s/K8
 gB8JfeyLfC4krvQ8yfvV8NFCL7V2K2z7qEfS3i88+jm8uOK4d/M5nWYPOg1FyOdBG1EeEoi0X
 lVYezFLyqhs6irVN+TlSSQTrFBTJfl5FDqk72T3ejwGiQpk3tFSNjwSPcvYwWqRoKgnlDAiXL
 sxTUsW+A6LcEsnCHe/u9gc3h2w7iipQQM1HfBihvKsq7fqW8Q5Uv+JZMfQeI0fO7PtI5W/5S4
 Ig5XyQi6ZNpKlzxxWSqm2qSEVnL6nuQxPXgKfvlK/Z6wg7Ca53k4RuTPTulwyOeM8mBL4PnMr
 MQ78qbmi4A8dPMI73wO/srXXWiBljAXslfbCTi07dt69yRgpAOp3bHoJ41QEsjukpvzrvlsgd
 +9wOqrvshOFxkJryZ1oeU0Frx+9KBZOdIxCIEJ8wbRp2dUK1ZJDOu8TrXkTJWClP0eYDAr/AO
 MAC8+hfkwXlfXd30iFvRdR+sL/BYjwTR0wVNfOIsK5MR1N0IIMtPwgXJ6q2m/rZk+iQJE8OCV
 SyQsFjQrabUEjPaGlCnqsJZbrm7Ub2Srq5THbSTc6K3O+zwj9y7dPS/fIXeURpdupBYBqsT+X
 DLrACGjk381mOMEMC+oICdGWgqnRmVPbILLmkeSvwdr+ht18o/sFv42/ZnI6eFeGSH0oiTDZl
 lAPIrc9ap+OjDcFPMTnj6rCAoj1/rH9tWOSO/2h+5g3KCjM5lS5vQ0ygwoOeKsXtf1qCaTnM0
 5vj/weZPKHyWEw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 3 Sep 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > It would even work if the current line is shorter, but as you point ou=
t:
> > it is wasteful. And it could be improved to be more readable. I rework=
ed
> > it, and it now looks like this:
> >
> > 	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> > 		const char *line =3D out.buf;
> >
> > 		while (*line) {
> > 			const char *eol =3D strchrnul(line, '\n'), *p;
> > 			size_t len =3D eol - line;
> > 			char *branch;
> >
> > 			if (!skip_prefix(line, "ref: ", &p) ||
> > 			    !strip_suffix_mem(line, &len, "\tHEAD")) {
> > 				line =3D eol + (*eol =3D=3D '\n');
> > 				continue;
> > 			}
> >
> > 			eol =3D line + len;
> > 			if (skip_prefix(p, "refs/heads/", &p)) {
> > 				branch =3D xstrndup(p, eol - p);
> > 				strbuf_release(&out);
> > 				return branch;
> > 			}
> >
> > 			error(_("remote HEAD is not a branch: '%.*s'"),
> > 			      (int)(eol - p), p);
> > 			strbuf_release(&out);
> > 			return NULL;
> > 		}
> > 	}
> >
> > It now parses the output line by line, looking for the expected prefix=
 and
> > suffix, then verifies the ref name format, and either returns the shor=
t
> > branch name or errors out with the message that this is not a branch.
>
> It is much easier to read and understand how the loop works with
> above.

Excellent.

> >> > +			error(_("remote HEAD is not a branch: '%.*s'"),
> >> > +			      (int)(head - ref), ref);
> >> > +			strbuf_release(&out);
> >> > +			return NULL;
> >>
> >> OK.  Any symref whose basename is HEAD in their remote-tracking
> >> hierarchy would have been rejected earlier in the loop.
> >>
> >> Is there a particular reason why we return early here, instead of
> >> breaking out of hte loop and let the generic "failed to get" code
> >> path below to handle this case?
> >
> > Yes, the reason is that I wanted to err on the side of caution. If the
> > remote repository reports a default branch that is not a default branc=
h at
> > all, I do not want to pretend that things are fine and then run into
> > trouble later when we set up a non-branch as remote-tracking target or
> > something like that.
>
> Wouldn't we have the same problem when the remote end does not
> advertise HEAD and we fall back to "local default", though?  We'd
> run into trouble later as we use "local default" that may correspond
> to a non-branch there as remote-tracking target, or something like
> that.

All true, there will be trouble at some stage.

The difference between the two cases, in my mind, is that cloning an empty
repository would run into the latter code path and might still have a
chance to work as intended by using the local default branch name.

In any case, as I indicated earlier, I am _very_ interested in moving as
much functionality as possible from Scalar to Git proper. In this
instance, I hope to move most of the code from `scalar.c` to `clone.c`
(guarded by one or more new options). And as soon as that happens, the
discussion we're having right now will be moot ;-)

Which means that I want to weigh how much effort to put into polishing an
unlikely code path on one side, and on the other side how much effort to
put into moving the functionality away from `contrib/` and deleting that
unlikely code path.

In the same vein, while this patch series contains (mostly) code in
`contrib/` (and therefore technically does not need to adhere strictly to
Git's code style), it is probably wise to pay closer attention to the code
style particularly in those parts that are prone to be moved verbatim (or
close to verbatim) to Git proper.

Thanks,
Dscho

> Not that I care too deeply in the error case, though.  I just felt
> that this early return was an uneven way to follow the principle to
> err on the side of caution, as we continue with the local default
> when the other side fails to tell us what their HEAD points at.
>
> Thanks.
>
