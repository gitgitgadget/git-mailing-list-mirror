Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B3C1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 06:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfFCGG7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 02:06:59 -0400
Received: from mx3.uni-regensburg.de ([194.94.157.148]:46974 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfFCGG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 02:06:58 -0400
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 3D0336000050
        for <git@vger.kernel.org>; Mon,  3 Jun 2019 08:06:56 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id CF87F600004F
        for <git@vger.kernel.org>; Mon,  3 Jun 2019 08:06:55 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Mon, 03 Jun 2019 08:06:55 +0200
Message-Id: <5CF4B8FE020000A100031962@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.1.1 
Date:   Mon, 03 Jun 2019 08:06:54 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Antw: Re: Q: git describe --always --tags .. gives "warning:
 tag 'tag1' is really 'tag2' here"
References: <5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de><5CEE38B4020000A1000317C6@gwsmtp.uni-regensburg.de>
 (Ulrich Windl's message of "Wed, 29 May 2019 09:45:56 +0200")
 <xmqqd0k1ywal.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0k1ywal.fsf@gitster-ct.c.googlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>> Junio C Hamano <gitster@pobox.com> schrieb am 29.05.2019 um 20:01 in
Nachricht
<xmqqd0k1ywal.fsf@gitster-ct.c.googlers.com>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni‑regensburg.de> writes:
> 
>> So I got the response:
>> warning: tag 'isredir‑0.3.0' is really 'iredir‑0.3.0' here
>> isredir‑0.3.0‑3‑gaf467c7
> 
> I suspect that "git cat‑file tag isredir‑0.3.0" would begin like
> 
> 	$ git cat‑file tag iredir‑0.3.0
> 	object .....
> 	type commit
> 	tag isredir‑0.3.0
> 	tagger ...
> 
> Notice that "tag" line records the true name of that tag, which does
> not match where you stored that tag in refs/tags/ hierarchy?

Hi!

Sorry for the delay (long weekend): Yes it is as you guessed. The tag is a
signed one, BTW.

> 
> While trying to describe af467c7 by following its ancestry and
> finding the ancestor three generations ago, the command found
> refs/tags/iredir‑0.3.0 and then noticed that discrepancy, which is
> what the warning is about.
> 
> Imagine you have only v1.0.0 (which is with known issues) but
> somebody did "cd .git/refs/tags && mv v1.0.0 v1.1.0" in an attempt
> to fool you.  The fact that your 'master' is a bit ahead of the
> commit that was tagged with the tag object (which is v1.0.0 but
> pretending to be v1.1.0) can be seen with "describe", but the
> command is careful enough to use the real version number
> (i.e. v1.0.0) and not the refname (i.e. v1.1.0).

Still I'm missing a verbose version of "git tag" that shows the commit IDs
along with the tag names. Unfortunately "-v" is not "--verbose" but "--verify"
(as opposed to "git remote" for example).

Regards,
Ulrich

