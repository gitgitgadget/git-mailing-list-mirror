Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13CF020964
	for <e@80x24.org>; Mon,  3 Apr 2017 06:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdDCG5C convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 3 Apr 2017 02:57:02 -0400
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:41065 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbdDCG5B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 02:57:01 -0400
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 01E41583C0
        for <git@vger.kernel.org>; Mon,  3 Apr 2017 08:57:00 +0200 (CEST)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 8DC4D4F893
        for <git@vger.kernel.org>; Mon,  3 Apr 2017 08:56:59 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Mon, 03 Apr 2017 08:56:59 +0200
Message-Id: <58E1F239020000A100025732@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 14.2.2 
Date:   Mon, 03 Apr 2017 08:56:57 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Terrible bad performance for it blame --date=iso -C
 -C master -- <file>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
 <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de><58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
 (Ulrich Windl's message of "Fri, 31 Mar 2017 09:30:32 +0200")
 <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

thanks for explaining! So if there are at least two commits, blame is fast, but with only one commit blame tries hard to find another commit that might have contributed to the one file?
I verified that without those "-C" options the result is very quick.
In the other case (for the user bored of waiting seeking for some entertainment ;-)) a "-v (verbose) option could be useful.
Or at the very least: If git is expecting that some operation will take (or already did take) a lot of time, give some message explaining why it is taking a lot of time, and maybe how to avoid that.

Regards,
Ulrich


>>> Junio C Hamano <gitster@pobox.com> schrieb am 31.03.2017 um 17:52 in Nachricht
<xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
> 
>> I was running "vc-annotate" in Emacs for a file from a large
>> repository (>40000 files, a big percentage being binary, about 10
>> commits). For the first file the result was presented rather soon, but
>> for a second file the command did not finish even after about 10
>> minutes!
>>
>> The file in question is a rather short text file (124 kB), and
>> according to git log it has one commit.
>>
>> While being bored, I did an strace of the command to find out that a
>> huge number of files is inspected.
> 
> With -C -C the user (vc-annotate?) is asking to inspect huge number
> of files, to find if the contents of the file (except for the part
> that came from its own previous version) came from other existing
> files.  So this is very much expected.
> 
> It might not be a bad idea to teach "blame" not to pay attention to
> any path that is marked as "-diff" (e.g. binary files) when trying
> to see if remaining contents appeared by borrowing from them.  We do
> not have that heuristics (yet).




