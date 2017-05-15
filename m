Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE4AB201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932886AbdEOM5F (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:57:05 -0400
Received: from freefriends.org ([96.88.95.60]:54018 "EHLO freefriends.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932839AbdEOM5E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:57:04 -0400
X-Envelope-From: arnold@skeeve.com
Received: from freefriends.org (localhost [127.0.0.1])
        by freefriends.org (8.14.9/8.14.9) with ESMTP id v4FCpbJP016641;
        Mon, 15 May 2017 06:51:37 -0600
Received: (from arnold@localhost)
        by freefriends.org (8.14.9/8.14.9/submit) id v4FCpaxQ016640;
        Mon, 15 May 2017 12:51:36 GMT
From:   arnold@skeeve.com
Message-Id: <201705151251.v4FCpaxQ016640@freefriends.org>
X-Authentication-Warning: frenzy.freefriends.org: arnold set sender to arnold@skeeve.com using -f
Date:   Mon, 15 May 2017 06:51:36 -0600
To:     Johannes.Schindelin@gmx.de, arnold@skeeve.com
Subject: Re: [PATCH 1/7] compat/regex: add a README with a maintenance guide
Cc:     stefano.lattarini@gmail.com, ramsay@ramsayjones.plus.com,
        neleai@seznam.cz, j6t@kdbg.org, gitster@pobox.com,
        git@vger.kernel.org, avarab@gmail.com
References: <20170504220043.25702-1-avarab@gmail.com>
 <20170504220043.25702-2-avarab@gmail.com>
 <xmqqwp9m99zw.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1705121214470.146734@virtualbox>
 <xmqqbmqx6bbh.fsf@gitster.mtv.corp.google.com>
 <201705141914.v4EJETGf029570@freefriends.org>
 <alpine.DEB.2.21.1.1705151358590.146734@virtualbox>
In-Reply-To: <alpine.DEB.2.21.1.1705151358590.146734@virtualbox>
User-Agent: Heirloom mailx 12.4 7/29/08
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for the info!  I appreciate the background.

In the future if you folks do find a bug, please let me know.

Thanks!

Arnold

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi Arnold,
>
> On Sun, 14 May 2017, arnold@skeeve.com wrote:
>
> > With respect to bug fixes that may have happened downstream, please do
> > let me know of any.  But I do request it as a bug report to
> > bug-gawk@gnu.org and not just a pull request with no commentary.
>
> I dabbled with updating our compat/regex/ myself, a while ago, and just
> found my notes. Note: at least some of these notes should help with the
> next iteration of Ævar's patch series.
>
> First of all, our original import could have been accompanied by better
> documentation what was done. Granted, back then gawk was still maintained
> in CVS, so things would have been a little tougher with regard to, say,
> specifying which gawk revision was imported. In the meantime, gawk uses a
> Git repository, though: http://git.savannah.gnu.org/r/gawk.git. Therefore,
> we can say pretty precisely that gawk's 40b3741f (Bring in development
> gawk changes., 2010-11-12)) was imported into Git as per d18f76dccf
> (compat/regex: use the regex engine from gawk for compat, 2010-08-17).
>
> My approach of updating compat/regex/ differed from Ævar's in that I
> checked out that Git commit, applied the interdiff to gawk's newest
> commit, and rebased that onto the current commit of Git. But I think Ævar
> & Junio's approach (replace compat/regex/ wholesale by the newest gawk
> revision's files, then re-apply clean patches of our `git log 40b3741f..
> -- compat/regex/` on top, as individual commits) is saner, as it will make
> future updates substantially easier.
>
> With my approach, I still had 16 merge conflicts, pointing in large part
> to changes we do *not* want to contribute back: gawk's code style differs
> from ours, and we adjusted the files in compat/regex/ to ours (which I
> think was a mistake).
>
> I also reinstated support for compiling with NO_MBSUPPORT, which included
> a new guard of the btowc() definition.
>
> I also had to reintroduce explicit #defines of bool, true and false, as
> gawk's source code split those out into their own header file.
>
> I apparently also "skipped a guarded #include <stddef.h> that was not
> actually necessary, but simply a late fixup to a997bf423d (compat/regex:
> get the gawk regex engine to compile within git, 2010-08-17)", but I do
> not remember what that was about.
>
> In summary, I do not think that any of our patches should go "upstream"
> into gawk's source code, as they are pretty specific to Git's needs.
>
> Ciao,
> Johannes
