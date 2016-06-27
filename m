Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C462018A
	for <e@80x24.org>; Mon, 27 Jun 2016 16:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbcF0Q34 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 12:29:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751770AbcF0Q3z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 12:29:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38B6B27EB7;
	Mon, 27 Jun 2016 12:29:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PD6TorMYCm0OSgLn/shRm9AsNs=; b=VY2adl
	riSkRl3Att2k8SV+zOAwzhN6W5x+bOaTYfAad2J4TZzJFcWAYOoW5r9kIgqm9laj
	ispG8t1eyr5bg0It/HQOQmXq9STJxHIsJYmzQqZTruDlDmsWc6KuAYxCPgW/WTv2
	NpC7JbnnI0It7mNpth2ubWPA4uMCM/yVIquCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HEfsRPcpqOOHubQ7ItsUrLEdzSYp6G7+
	y6D0rTjkzRpJlzENqcfidixWhAxM+hGGBIT0ck4rF4Z03qDpsrzhnjbNHhLrN0yH
	XjS5PMJ+xMBRtwlNMZw1MNzSDs/I+yD/tipfKfPCOBHmxKTsjfccOag+hj1jSkre
	Aud6d6EliUI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F9B227EB6;
	Mon, 27 Jun 2016 12:29:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A70D827EB5;
	Mon, 27 Jun 2016 12:29:48 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>, novalis@novalis.org
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
	<1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
	<576650E7.70107@alum.mit.edu>
	<xmqqmvmhvyn5.fsf@gitster.mtv.corp.google.com>
	<xmqqd1ncvisw.fsf@gitster.mtv.corp.google.com>
	<8E05CEA5-C573-4271-A73F-99E7BAE1BF06@gmail.com>
	<576B9081.3020405@alum.mit.edu>
Date:	Mon, 27 Jun 2016 09:29:46 -0700
In-Reply-To: <576B9081.3020405@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 23 Jun 2016 09:32:17 +0200")
Message-ID: <xmqqinwubnnp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DB68A0E-3C84-11E6-A6C7-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I'd like to request that the change for the p4 temprefs be made in two
> steps:
>
> 1. Write references to `refs/git-p4-tmp` or whatever, without
>    worrying about making them per-worktree.
>
> 2. Carve out a per-worktree namespace, bikeshed about its name and
>    semantics, make sure it works correctly, then finally move the
>    p4 temporary references and eventually the bisect references there.

Hasn't 2. already happened long time ago?  I thought that the
direction was that bisect will have to be grandfathered to stay
there, and new things would hang beneath a single per-worktree
hierarchy.

I would have expected that your 1. would be a request to use
refs/worktrees/git-p4-tmp.

... goes and looks ...

Ahh, I did misremember the discussions.

http://thread.gmane.org/gmane.comp.version-control.git/276628
http://thread.gmane.org/gmane.comp.version-control.git/276960/focus=276963

It appears that in the latter, a more generic refs/worktrees/ was
somehow postponed, and only bisect was made per-worktree to fix the
immediate breakage.

> The reason is that step 1 is low-risk, could be made quickly, and is
> enough to unblock mh/split-under-lock and the other patch series that
> depend on it. Step 2, on the other hand, could take quite a while, and
> its implementation might benefit from changes to reference handling that
> are in the pipeline (e.g., perhaps the horrible hack can be dispensed
> with). Meanwhile, as far as I understand these references are transient,
> so there are no backwards-compatibility considerations that make
> renaming them twice more cumbersome than renaming them once.
