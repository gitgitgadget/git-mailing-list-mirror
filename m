Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00378202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 01:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbdCGBAk (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 20:00:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51205 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752233AbdCGBAj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 20:00:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 022A66F841;
        Mon,  6 Mar 2017 18:03:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EeVZbvZ1ygy16YydJVC0U1iEDhE=; b=BCdEkh
        DKWdBvIFPWDhs8QdaR9Gq/QmEpfL0PW2QbVbYCRg6F4Zal++VnRRhSfKaM7HJwGC
        dFgt4lfNofklGqaKlv1Xi5DVPl4UamBLDyQImynSKjt0/rLd/Wnmrb1pGaA7XAYf
        v310YQatiloojKXzRtAvjMi2iWB18JCtr6SK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OnWq6OSA2Gia7NzCQuUHrLgi/ETyuNNx
        ydRk6uRNzz2J+N/K7RogB1aLRXKY/Q8VfL9TLoGp6/9/VyVqxgwvMXeonM8ES3zN
        sYqoq2iypwZe29biulLmiiprydLHPppOxsn2Yy3nXBVidVYFfZvie6aEZh5nhrYQ
        NHGmq4IYvUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE50F6F840;
        Mon,  6 Mar 2017 18:03:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.84])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B0316F83E;
        Mon,  6 Mar 2017 18:03:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     tom@oxix.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [Request for Documentation] Differentiate signed (commits/tags/pushes)
References: <CAGZ79kYxD9B_+3vBgO+Z-wh2GMg_REazA-xpTSAqe3_64VMV3w@mail.gmail.com>
        <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com>
Date:   Mon, 06 Mar 2017 15:03:15 -0800
In-Reply-To: <xmqqshmqm4ur.fsf@junio-linux.mtv.corp.google.com> (Junio
        C. Hamano's message of "Mon, 06 Mar 2017 14:13:00 -0800")
Message-ID: <xmqq8toiypn0.fsf@junio-linux.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15171828-02C1-11E7-9868-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> What is the difference between signed commits and tags?
>> (Not from a technical perspective, but for the end user)
> ...
>> A signed push can certify that a given payload (consisting
>> of multiple commits on possibly multiple branches) was transmitted
>> to a remote, which can be recorded by the remote as e.g. a proof
>> of work.
> ...
> A signed push is _NOT_ about certifying the objects in the history
> DAG.  It is about certifying the _intent_ of pointing _REFS_ into
> points in the object graph.
> ...
> Historically, "tag -s" came a lot earlier.  When a project for
> whatever reason wants signature for each and every commit so that
> they somehow can feel good, without "commit -s", it would have made
> us unnecessary work to scale tag namespace only because there will
> be tons of pointless tags.  "commit -s" was a remedy for that.

While we are enumerating them, it is worth mentioning the mergetag
header of a commit object.

This is added to a (merge) commit object when you merged a signed
tag that points at a commit, and the intent is to eliminate the need
to _keep_ the ref around that is created only for the purpose of
"please pull from me, I tagged and signed the tip of the history I
want you to pull" request.  From that point of view, you could say
it is also reducing the load on refs/tags/ namespace, but more
importantly by not requiring the ref around, it allows you to verify
that the merge commit merged the correct tag with _only_ the commit
object by reproducing the payload of the signed tag that was merged
in the commit object in full.
