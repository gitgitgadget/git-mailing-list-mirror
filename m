Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CCDC433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F98207C4
	for <git@archiver.kernel.org>; Fri, 15 May 2020 14:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uK7wvg5W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgEOO6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 10:58:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51030 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOO6m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 10:58:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66D6DCC524;
        Fri, 15 May 2020 10:58:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hR4rHjtupwtuFZp69/VWe6pe04E=; b=uK7wvg
        5WcAQvAzL/eSrVfUMBzQ7BuRzQipGIZj9KfXjXVSv1gdhQVT5TLkbCxyT+g8JRG+
        a4k+WGOsnmUXxUR0jotd86KWo2zkB8heqSc1pVeNdX/cP/VSTnxLk8SKm3K+Nvhe
        kidx65Xro/xC9CMEQVfYJu+J4Gb6qf0cdA3Nc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xOwzhr2YIMmDB8Hj0rurqosYUeKn8lYw
        i+lbaOQOkwYQ795G9dR8T4NowZh19U2eFokMr0B99E0ReeSJMhJawpU0bwfesRvs
        ljpNW7oeeUWPmGWuA/+dAvzec4XssGebogRT3Uy3kzaCbD2CI3kGmgtFiCQVK0qh
        2vJrl6Zqp1c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5EFF0CC523;
        Fri, 15 May 2020 10:58:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A45A8CC522;
        Fri, 15 May 2020 10:58:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2020, #05; Thu, 14)
References: <xmqqpnb6nk7x.fsf@gitster.c.googlers.com>
        <74397ce4-be15-51e8-fb28-81eafdca792c@gmail.com>
Date:   Fri, 15 May 2020 07:58:37 -0700
In-Reply-To: <74397ce4-be15-51e8-fb28-81eafdca792c@gmail.com> (Derrick
        Stolee's message of "Fri, 15 May 2020 06:16:35 -0400")
Message-ID: <xmqqh7whnt2a.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8F16F408-96BC-11EA-9B01-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 5/14/2020 7:57 PM, Junio C Hamano wrote:
>> --------------------------------------------------
>> [Graduated to "master"]
>> 
>> * ds/bloom-cleanup (2020-05-11) 7 commits
>>   (merged to 'next' on 2020-05-11 at 046d49d455)
>>  + completion: offer '--(no-)patch' among 'git log' options
>>  + bloom: use num_changes not nr for limit detection
>>  + bloom: de-duplicate directory entries
>>  + Documentation: changed-path Bloom filters use byte words
>>  + bloom: parse commit before computing filters
>>  + test-bloom: fix usage typo
>>  + bloom: fix whitespace around tab length
>> 
>>  Code cleanup and typofixes.
>>  This is an early part of ds/line-log-on-bloom that has been cooking
>>  in 'next'.
>
> Thanks for taking the time to merge this portion for the release
> candidate.
>
>> * ds/line-log-on-bloom (2020-05-11) 5 commits
>>   (merged to 'next' on 2020-05-11 at 046d49d455)
>>  + line-log: integrate with changed-path Bloom filters
>>  + line-log: try to use generation number-based topo-ordering
>>  + line-log: more responsive, incremental 'git log -L'
>>  + t4211-line-log: add tests for parent oids
>>  + line-log: remove unused fields from 'struct line_log_data'
>> 
>>  "git log -L..." now takes advantage of the "which paths are touched
>>  by this commit?" info stored in the commit-graph system.
>> 
>>  Will cook in 'next'.
>
> Good plan. This can wait until after the release.

I wasn't sure about the split---we could have gone one of three ways
(none, all or the above splti)---but the early parts of fixes all
looked like good and safe changes.  Thanks.


