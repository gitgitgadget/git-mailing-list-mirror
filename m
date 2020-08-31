Return-Path: <SRS0=A5vO=CJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52EBC433E6
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 09:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8939C206EB
	for <git@archiver.kernel.org>; Mon, 31 Aug 2020 09:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dqc/6WX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgHaJ7d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:59:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:45589 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgHaJ7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Aug 2020 05:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598867944;
        bh=sXju7xJIJ1YdJ6TY94zDb9y15qnE1y1r7oZYC3y6qog=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dqc/6WX7FWaj9w1M/vtjyvBf8MIbgeKBrmEs5h2WHGuPSMuVbTvlhpahaJh82Ixz8
         lctuU28oRh5xE58C+W75uDTg14W7T9ZPDt86BUv/2zZ6J6gQjLDP49Fr7HgokEBG9g
         zOrtZvr9s0XIcJYwSFZDRFtiH3erUcHPZ5bC3cIA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.169.176] ([89.1.213.246]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mk0JM-1ksN3Q12qG-00kLzm; Mon, 31
 Aug 2020 11:59:04 +0200
Date:   Mon, 31 Aug 2020 11:59:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
In-Reply-To: <xmqq1rjqo2bp.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008311156020.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-4-gitster@pobox.com> <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet> <xmqq1rjqo2bp.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:JMCqUm829EgedWEXpX8JH10oZ2B6foKW1VuwAQGmC9ygDYeE/Or
 hY1C0S/BeROGoZSXxlQVFAFAJVf7Il1z4xT9gg0vlk5BYKcA3tW2nP9PWgG+DfBOhfULbzN
 3dfN2ve1oYMWRzO84aDABdn3cxvkRpNdAZlGLTMZ2tPLwoFmWhQDeslUjYnk4oNl14WVPwI
 gFB0EQtRIYhM3Owx04iaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:18x45k/EtSI=:CDqOA3Y6d8elUKf7TT+zs3
 /N2MfSgfI112lUnRUvBt4nCp3GZ+1ALvORZ2/T+TC9+VSd2GP2aEZ9n/ulrOFU4VqhppGJ2md
 Y2L2Avl5bd4JIrAoqg/P2mZXLvCNfDoEA/v3RLQBGzu/WpxNx4mH/yVXFD2axJsf+BUCI4uhC
 gJYTyDrUpEOJK3CsjKyU1dUPhic4MFYH2Km9jg9NAotX7MfjAalXfuhVoWti9o6gtW5Tk2z8D
 6/KcrKwzw3sY6xzY6xBZDiqrCMwwpvzgI5IvyFRkUiAYzBUiJCDR9ObB+w4/oJtagaW5Im41Y
 ntoXrsSBzSmR/oQHy6Xexe9HAEsKe0Ng/c0Kzd47lWxu6U1+loGkkBMRr3xm/097zGEiYSVLb
 oHNun8gHRVRDlMEAK5MADnR9yZdeAykaz9IzNjBkaMcvg1mcbq5rSqDnl/Q4kxaxCqiiaRwMO
 aDZNPOlRUGFiFVkKdKvgbdm0dwVLc1jVgyViisFCfAl5uLvTU9VHKhyZW+oxlHQmib6v89MhF
 6Bs7qa5XgSpJ2mo30Vym60UHPPwWWaEm2RD9ErR376RE7fKT/SK/6/D7AezDF87HOZhL22f13
 Io8QSnNOvSlsmMiK0kuAjL2QB5g2lc43k4BF9+A0U3H8ur+OKbMQYUqkA5UMsWCpkf90ZxoXS
 WIjyhoaf0zfkmUJeR98Jj8Jerve26zsr4RbBmrfqYiDXlgJliq/L4kms4P9eh9cFSHNibZojb
 h5Op5HSkdISWTJzsr7cGQYv4Lzmx2ey46japW/SmPjaBBSL/yUFGdojLgd5qEr7EiaH+KsWrY
 if/mcH85B85PAf/wHT/olu0cJaQc0G0HFudrIB80hsssCWXMEXjpbTnN/jHh4q00VBJeR1tGl
 VEf7Sc9bVDcBnWP5z642ProjcMnKfoM4BCdsfEzs3gJ6F4jPtLU7LYcsg9mXz6kSuXA+mHKvw
 xwDwFFC4/M2Gtpqq581dz7/umrYeR2kBMWTos1spP5FNrMP1tMYoz1A6FTmHPtDSDkxu0KqKN
 7yYspWuoLSPbP9193QU/GbRkONmWeDSwXHG1iaxJ0kRPMP+gDceIfNcpNnJl3Ts0Ez1CqlY8t
 dkl50L86+0IGjGUwyoQsl/b+7OJ4dJdIPLRXDHGgD0I600Yuir6+X6hHOqgPfTlkWia1bbtOF
 4al6r6f7FQ7uQZSSJYxF1RbWnyWKOWxvGAscrRxSQ25/xfD676vfdSA/0hm1/08JPv/pdEDMC
 dgBi9vAvHPWR2TKnlGmIPLr0xqRRxCep53w3I1g==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 28 Aug 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git.c  | 3 ++-
> >  help.c | 5 ++++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/git.c b/git.c
> > index 71ef4835b20e..863fd0c58a66 100644
> > --- a/git.c
> > +++ b/git.c
> > @@ -851,7 +851,8 @@ int cmd_main(int argc, const char **argv)
> >  	 * that one cannot handle it.
> >  	 */
> >  	if (skip_prefix(cmd, "git-", &cmd)) {
> > -		warn_on_dashed_git(argv[0]);
> > +		strip_extension(&cmd);
> > +		warn_on_dashed_git(cmd);
>
> The argv[0] may have been NULL from the beginning of cmd_main(), and
> cmd would be "git-help" in such a case. We used to pass NULL to
> warn_on_dashed_git() in such a case because "git-help" is not what the
> user typed, but what we internally trigger, so we didn't want
> warn_on_dashed_git() to do anything based on that internal string.

True. The test suite passes with this, though, which means we haven't
covered that case.

> As there is no special casing of "help" in warn_on_dashed_git()
> mechanism, it probably would start triggering a warning/die when
> "git<ENTER>" is typed, no?
>
> +	if (argv[0]) {
> 		strip_extension(&cmd);
> 		warn_on_dashed_git(cmd);
>
> may be the minimum fix, but I would strongly prefer to keep the
> interface into warn_on_dashed_git() (eh, the most important is the
> interface into find_cmdname_help() helper function, which is
> designed to be reused by other parts of help.c) to take the full
> command name, not without "git-" prefix.  This is primarily because
> the entirety of the help.c API is driven by full command names,
> without removing "git-" prefix, and it has to, because the help.c
> API needs to handle "gitk", from which you cannot remove any "git-"
> prefix.
>
> Perhaps
>
> 	if (starts_with(cmd, "git-")) {
>                	strip_extension(&cmd);
> 		if (argv[0])
> 			warn_on_dashed_git(cmd);
> 		argv[0] =3D cmd + 4;
>                 handle_builtin(argc, argv);
> 		die(...);

Sure.

> How does your handle_builtin() work, by the way?
>
> The original code (even before we added warn_on_dashed_git() in this
> codepath) did not do any strip_extension(), so handle_builtin() can
> take commands with ".exe" suffix, but now we are feeding the result
> of strip_extension() to it, so it can deal with both?

Yes, it can deal with both. It calls `strip_extension()`, which on Windows
removes the `.exe` suffix, if found.

> Sounds convenient and sloppy (not the handle_builtin's
> implementation, but its callers that sometimes feeds the full
> executable name, and feeds only the basename some other times) at
> the same time.

Right, it does not _require_ the extension. I do not necessarily agree
that it is sloppy, but I do agree that it is convenient ;-)

Ciao,
Dscho

> >  		argv[0] =3D cmd;
> >  		handle_builtin(argc, argv);
> > diff --git a/help.c b/help.c
> > index c93a76944b00..27b1b26890be 100644
> > --- a/help.c
> > +++ b/help.c
> > @@ -724,9 +724,12 @@ NORETURN void help_unknown_ref(const char *ref, c=
onst char *cmd,
> >  static struct cmdname_help *find_cmdname_help(const char *name)
> >  {
> >  	int i;
> > +	const char *p;
> >
> > +	skip_prefix(name, "git-", &name);
> >  	for (i =3D 0; i < ARRAY_SIZE(command_list); i++) {
> > -		if (!strcmp(command_list[i].name, name))
> > +		if (skip_prefix(command_list[i].name, "git-", &p) &&
> > +		    !strcmp(p, name))
> >  			return &command_list[i];
> >  	}
> >  	return NULL;
> > --
> > 2.28.0.windows.1
>
