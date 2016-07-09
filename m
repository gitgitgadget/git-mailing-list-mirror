Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3E6C20705
	for <e@80x24.org>; Sat,  9 Jul 2016 07:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbcGIHff (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 03:35:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:49905 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbcGIHfd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 03:35:33 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LuxG5-1bD9rT0OQr-010327; Sat, 09 Jul 2016 09:35:26
 +0200
Date:	Sat, 9 Jul 2016 09:35:24 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607090928500.6426@virtualbox>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com> <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:1esXxnHWHPePOMbbhVJg23dsGU+rE7Futu/lK3tk5FBbgP2cg7b
 yn7xkpR+HbGh4EzjqejMRmnWgubeE21oLb/I4pbk2TQQexd9FDSin+Fz3zwuwUr6dBpmDbA
 VbNyP5FO2xC7DgCskkzmV7v0RCY/7FTq7w1B8nRBpD3z6xJ3Qa/eye8+1JOQzoZk73Sf92O
 SSQERLdSLKK9f5CqUbq/g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xn5ph/mKNjc=:KQiF7X5MQt7NkAv0T0edW9
 hqiKw5YKgdq3m+8D7MJGuVeGGeNQKxp3Ar3u82zbyl0v5Trs7B9Upn90Y2lJ2Y2YyCudVQWOA
 KgKJegTu2QkkZaamD4IzPHSIBgsEcio8BhCg+NrxmrCCMF5WNPEeCKkezH0a6lhZCl18NpxGl
 V25RdX2xDeZ5BwMu4tKgTm1+GWo8hgj//cbK/lgn+eXEislNgWengoL7rT4KXW2rU+WJp+vRC
 /YV3G7QEvpBDlK71Fa9m8pyZtIMbanpxzKRieqwjqxlXNrR08+Ojw5krQwHMdODZBP7S0NXeA
 80yYhw4nI1khhovlAE7s7+lyJkVI8h2wAETFsLKWKOxn7O9LDbVV0jgwsnY1mMsmO4P40GZ+f
 DGynYgYv5lLSfoP/V9S22Jykax9z6MusuNVR+CUHB0KIOogaGkp/cmvwAglRGDeANRpCUgkiX
 NmsvAPyue/6SYncW7lk14PWP+/0Cj2Pg+5scZ7Br0ZZ2ANn0QOUWbizQL3kC+W7ZY2GcJK6i0
 P04eW/i7GgqDA4LXhhkZkPH5edckpYFY/s2lzjAwIX4t6wfV3tZKtGTasXjrYiNtrWjCZNXzY
 lA6/MiyH3UyD2izTZh1C0qTuSwyFz8+XZwd/wsjBhwNogtsnKt4dHnPqIb9Fdi9ZakSW5b1fv
 Csup/UdYd8UQ8XiEr9GL2yGdLwy6F2AlukwZ5ZjLjjnh1kXzuDqRlstuWU/1YoRX5EWQjWDTL
 UWhiP5s1oIhjwBkjo1WZoGzKd01IMAmEyH0bw4H/I8fgq43dwzS0VOLcTMsLwja+Q7HkL94QF
 5cu+uOR
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 8 Jul 2016, Junio C Hamano wrote:

> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > That sounds reasonable.  And if they *do* end up taking any time to
> > traverse, it's because they weren't reachable from other anchoring
> > points, so taking the extra time to traverse them seems fine.
> 
> The only thing that is hard is to clearly define _what_ are the new
> anchoring points.
> 
> It cannot be "anything directly under .git that has all-caps name
> that ends with _HEAD".  The ones we write we know are going to be
> removed at some point in time (e.g. "git reset", "git bisect reset",
> "git merge --abort", etc.).  We do not have any control on random
> ones that the users and third-party tools leave behind, holding onto
> irrelevant objects forever.

Please note that bisect already uses the (transient) refs/bisect/
namespace. So I do not think we need to take specific care of the
BISECT_* files.

If we had thought of it back then, we could have used such a transient
namespace also for FETCH_HEAD, CHERRY_PICK_HEAD and also for detached
HEADs (which we should have called "unnamed branches").

Now, how about special-casing *just* these legacy files in gc: HEAD,
FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
live in the refs/ namespace, which is already handled.

BTW this issue is getting much more problematic when you have a lot of
worktrees, some of which operate on detached HEADs. Which I do.

Ciao,
Dscho
