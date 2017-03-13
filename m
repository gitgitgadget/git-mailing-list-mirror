Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8676220375
	for <e@80x24.org>; Mon, 13 Mar 2017 21:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753000AbdCMV1i (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:27:38 -0400
Received: from mout.gmx.net ([212.227.15.15]:53985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbdCMV1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:27:37 -0400
Received: from virtualbox ([95.208.58.29]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZz01-1cO7qw1App-00liu6; Mon, 13
 Mar 2017 22:27:31 +0100
Date:   Mon, 13 Mar 2017 22:27:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     David Aguilar <davvid@gmail.com>,
        Christophe Macabiau <christophemacabiau@gmail.com>,
        Git ML <git@vger.kernel.org>
Subject: Re: [PATCH] difftool: handle changing symlinks in dir-diff mode
In-Reply-To: <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703132204410.3767@virtualbox>
References: <alpine.DEB.2.20.1703072332370.3767@virtualbox> <20170313175640.14106-1-davvid@gmail.com> <xmqqlgs9rprt.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tKacijiS7902Nol203Jn5HikXYyVQklZxvFLUptOJWdK74Et44R
 m9t7/tr4oDFV5t5ktH1yhiFgIUnAACHz/HDPDtOvVbsaC/a9W/1r4cnx8Tv8WnNTwR9kQs2
 /ixsOWP+NK7M0oV2zkbwAYvacTfvjn3M8a29oMLyb0s5g2D9Evnsuwo1jcnHVWy9/5phRs2
 hDsbz83errqUjFqbVry4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3KcGv4iAMyo=:NGsM27lbRqPXkkhxwv290P
 VbAyCJ0kOPrt+xa9b8fjkfFUvThCcqWeUhTRUlWMcmRII28k2cFcxEBcFCfOjmLsoKZiQnSEm
 I+4i95ougwHaQbdgFL5DUUip3A0pcuyUPiaSqSqD2pjzbFdj9c5pC2CJagCqc/e+KLDBWwsUl
 EwX7APkVCjdJoYCSHkV81axPijYpsapMu2taV2wSgAYZNfv79y/EA/pyjadbKHPB1Pcoq1nVA
 E44skDL60oV/9HiboAA/YIL6Cs4W/B1glMMcne0/jtYT9FqWcVStuEOv2L9Z54qCwBewPm5s/
 J5fT+hsfDsfmpc36CD3Omxu23sO+6HIfKoc5I1UHDO2DO5T+1eG9m51xqmZUkpNo8BpOvPqgJ
 xwHwG9gYHHyp5K99vew8geoGG3rqFdvuUI2qAg8pj4v6xLeaAhD0MxUz7/IvrFNUv70Fo+cRK
 oC93JFcUfFcwsFvhHy4s7ebqCB0jqpCdFOZfYSm8qxvd3Qq2gZu7vatAtUi5/dRaOpHG14k7i
 NsFJi+V+T2xgUcLR+S2+Dv9RaRtTfL/taOQMZHt5mbblqT4ZmVY5wwhf34ZLdsOnNRdufuHjB
 4Q8ofbdcsGgCcQoWG9c+9NbhxhyiN5EM24USPEiAgEEPpWly/WcJcS6/iMCLUEPNO4tvreIzD
 oDHk4dWP0mqxs2Upyrl+1wVF72N6ykSCTxzS8bODHGQE7zO1yzFZk+OqG8b9XjOzLpbaoOAfM
 3uA58hohIUIDW6vP7KxtmMmj8139mbQ7Gkw+FtDBgJIL+Po1LnXByO4RsfMfTCD1WdEpix0Fp
 1igSJ8Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 13 Mar 2017, Junio C Hamano wrote:

> David Aguilar <davvid@gmail.com> writes:
> 
> > +static int create_symlink_file(struct cache_entry* ce, struct checkout* state)
> 
> Asterisk sticks to variable, not type.

If only we had tools to format the code so that authors as well as
reviewers could concentrate on essential parts of the patches :-)

> > +	 * into the checkout state's path.
> > +	 */
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct strbuf link = STRBUF_INIT;
> > +
> > +	int ok = 0;
> > +
> > +	if (strbuf_readlink(&link, ce->name, ce_namelen(ce)) == 0) {
> > +		strbuf_add(&path, state->base_dir, state->base_dir_len);
> > +		strbuf_add(&path, ce->name, ce_namelen(ce));
> > +
> > +		write_file_buf(path.buf, link.buf, link.len);
> 
> This does "write content into symlink stand-in file", but why?

From the commit message:

	> Detect the null object ID for symlinks in dir-diff so that
	> difftool can prepare temporary files that matches how git
	> handles symlinks.

The obvious connection: when core.symlinks = false, Git already falls back
to writing plain files with the link target as contents. This function
does the same, for the same motivation: it is the best we can do in this
case.

> Also, I am not sure if strbuf_readlink() can unconditionally used
> here.  On a filesystem without symbolic link, the working tree
> entity that corresponds to the ce that represents a symlink is a
> stand-in regular file, so shouldn't we be opening it as a regular
> file and reading its contents in that case?

I think you are right, we cannot simply call strbuf_readlink(), we would
have to check the core_symlinks variable to maybe read the file contents
instead.

But then, it may not be appropriate to read the worktree to begin with...
see my reply to the patch that I will send out in a couple of minutes.

Ciao,
Johannes
