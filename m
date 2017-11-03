Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE0620281
	for <e@80x24.org>; Fri,  3 Nov 2017 05:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbdKCFSa (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 01:18:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50083 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752354AbdKCFS3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 01:18:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 925CD9D7D2;
        Fri,  3 Nov 2017 01:18:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i/SxgJ/KCPWE70Y+D1bG1GAxLpc=; b=TKpwsO
        TSkfQs1hEtUMZUFPGmI5lW1WJdiuwJjg6fr1N7GQ8E+PG+bDWeKvOSPnBhx6apy9
        7Y3UyF/ZlhzRTwtVZN6tTWL49SV2NccxmNGaIyc5/6VXDAtNEddRWdOIfLHGHOsw
        14QPKzrwd+Ys4RGDPHCEqK2SwEXiqoD4HhVME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DJJLMH6LFYHSzCzzQsqrYv5AmJXQyuwx
        KSwYDUkxpOgQNMrKf+9bqxIuYzoDSLG33OGTpEAW9e0GCMlSkSRuWF1SOhBPI1ck
        4XXDYcc8lbGWBqCtQxLrI13ykb/gjN+ksyskiTT4E4B2GKgQ36CaijZPKsXv5u10
        bW2pZ6D0rI4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 897EF9D7D1;
        Fri,  3 Nov 2017 01:18:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDE439D7D0;
        Fri,  3 Nov 2017 01:18:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-7-sbeller@google.com>
        <xmqqbmkmvdrq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1711011329300.6482@virtualbox>
        <CAGZ79kZPNiNnSJd6CNYb7XkTVsT2ONLQLhwAQxt6_SPFTSwMcw@mail.gmail.com>
        <EF573E5E-EA72-4DEE-822C-B44265FD581B@gmail.com>
        <alpine.DEB.2.21.1.1711012310250.6482@virtualbox>
        <CAGZ79kbOEM_W65Rym4yiDNHpFGTNWMYdh=aVPjThNWjEHPQong@mail.gmail.com>
        <alpine.DEB.2.21.1.1711012340290.6482@virtualbox>
        <CA+P7+xqw9zKNUkn9P-qA57ADSB5G_7Sd0JCc6SaK6bBf9-Jhtg@mail.gmail.com>
Date:   Fri, 03 Nov 2017 14:18:24 +0900
In-Reply-To: <CA+P7+xqw9zKNUkn9P-qA57ADSB5G_7Sd0JCc6SaK6bBf9-Jhtg@mail.gmail.com>
        (Jacob Keller's message of "Wed, 1 Nov 2017 23:05:00 -0700")
Message-ID: <xmqqtvycos7z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B6A3B58-C056-11E7-821C-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> I think both questions are valuable, the first is "which commit last
> had this blob", the second  is "which commit first introduced this
> blob", neither of which can always give a definitive answer. It really
> depends on what question you're asking up front.

Given that "describe" is about giving an object _a_ name that is
plausibly useful to refer to it, it is not a good match for the
above query that wants to know where it came from, how long it
remains in the tree and where it ceases to be relevant.  In order to
support that use case, a totally different and possibly more useful
avenue would be to think how this can be hooked into "git log"
machinery.

A refresher for how "git log [--options] <pathspec>" works may be
beneficial.  We walk history and compare the tree of the commit we
are looking at with the tree of its parent commits.  If everything
within <pathspec> is the same, we mark the transition between the
parent and our commit TREESAME (other commits, i.e. the ones that
have meaningful change within <pathspec>, are !TREESAME).  Then the
output routine presents the set of commits that includes commits
that are !TREESAME, within the constraints of the --options given
(e.g. with --full-history, sides of a merge that is TREESAME may
still be shown to preserve connectedness of the resulting graph).

It is easy to imagine that we can restrict "git log" traversal with
a "--blobchange=<blob>" option instead of (or in addition to) the
limitation <pathspec> gives us.  Instead of treating a commit whose
diff against its parent commit has any filepair that is different
within <pathspec> as "!TREESAME", we can treat a commit whose diff
against its parent commit has a filepair that has the <blob> on
either side of the filepair as "!TREESAME" (in other words, we
ignore a transition that is not about introducing or forgetting the
<blob> we are looking for as an "interesting change").  That would
give you a commit history graph in which only (and all) such commits
that either adds or removes the <blob> in it.

Hmm?
