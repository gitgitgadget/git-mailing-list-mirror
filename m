Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F440C2BA2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113CB21D93
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 02:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KM+6TjYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgDQCBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:01:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63491 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDQCBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 22:01:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4388B721E;
        Thu, 16 Apr 2020 22:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rvui+ZhldKsQaGAUTt1YEiugpwQ=; b=KM+6Tj
        YyXb0/kA8Zb5QQlXtl8sypiVp5emGyH8vO26evkk/5iWk8vpMugtiWF8BhiLqxMK
        FAEOK/oa38x1xnun7MUSGU67MfYQxYIHa4BdGYlEadzSOY2M8QpBLfrBwzg3xT4A
        ACjxWnlPY/jMnrL64MX5g8tgKfeJ5YEoKi/iA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WErRYiQRzCkKAP0JfzqYz4S7cteFffKF
        f6T7UtqVOP636hZqhKDa2u1DD1gP942HF1qctxfcBdkGvCtRNDzhyccGQfB53s2M
        2v1iJFggEr3ZNydEfePXM8o/LdcSFFiDyMa4kZXzjiiAPOTZzf+vFf+KMAUL9oKk
        G4yuEpZ6YWw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CE41B721C;
        Thu, 16 Apr 2020 22:01:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE806B7216;
        Thu, 16 Apr 2020 22:00:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emma Brooks <me@pluvano.com>
Cc:     git@vger.kernel.org, Eric Wong <e@80x24.org>
Subject: Re: [PATCH] Documentation: explain "mboxrd" pretty format
References: <20200416041658.85100-1-me@pluvano.com>
        <xmqqlfmw2f9z.fsf@gitster.c.googlers.com>
        <20200417014713.GA20574@pluvano.com>
Date:   Thu, 16 Apr 2020 19:00:58 -0700
In-Reply-To: <20200417014713.GA20574@pluvano.com> (Emma Brooks's message of
        "Fri, 17 Apr 2020 01:47:13 +0000")
Message-ID: <xmqqzhbax44l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48BBA73E-804F-11EA-BFB2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emma Brooks <me@pluvano.com> writes:

> On 2020-04-15 22:03:36-0700, Junio C Hamano wrote:
>> > +Like 'email', but lines in the commit message starting with "From "
>> > +(preceded by zero or more ">") are quoted with ">" so they aren't
>> > +confused as starting a new commit.
>> 
>> I am torn between rephrasing "starting a new commit" with "starting
>> a new e-mail message", and keeping it as-is.  Technically, the latter
>> is more correct---the >From quoting is a technique to avoid starting
>> a line with "From " in a reversible way, as pieces of e-mails in a
>> single mailbox file needs to be split at the boundary.  But in the
>> context of format-patch, perhaps saying each "record" in the output
>> file is a "commit" (not a piece of e-mail message) would probably be
>> an acceptable white lie.
>
> While it is more accurate to say "starting a new email" rather than
> "commit", I think it might be less confusing to say "starting a new
> commit", if the reader isn't already familiar with how mbox works or its
> variants, since the pretty formats control commit display and would
> typically be thought about in terms of commits rather than emails.

Exactly.  That is why I said that I was torn between technical
correctness and tool-specific description.  "torn between" is quite
different from "inclined to prefer the one different from yours" ;-)

