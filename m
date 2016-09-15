Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58FDC2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbcIOU5v (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:57:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62433 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752143AbcIOU5t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:57:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 672333D8AE;
        Thu, 15 Sep 2016 16:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v8YCphsMBwuR2UvZborzkKOXPwM=; b=g0a0vs
        3h2JtQYkEIxYssU5xRmi6zT5a9ygt0ECepze1xjK+cqO5cHtFktmZkwA9J1ziAUA
        CwmBCva7/hTNUJmyK3kkAZ2axrabDzIAUz7SHXQ7jIwaq4j5+DOqtg7MTUZ4KR4Z
        1q6W6h43PsOOzVyWqgxXUEWWmJ6RvBdn9ntbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Or+UqNYWOI9lMj2fyiS+EQI+LdFG2wej
        ywqc+6TqGbTeQlOAtrDfGpaFlxk/bDDVY5pyQJN0FnR+UOdDT7HosbwJyKqy8G2G
        UMNmTiVK89NZov/XtBNE+TByUZnNnn5jIRLHIHAizuLN2DyVRGx4dI4w4LJkJNxe
        KJSP0zV9Y4U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F4B23D8AD;
        Thu, 15 Sep 2016 16:57:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD9D43D8AA;
        Thu, 15 Sep 2016 16:57:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] ls-files: adding support for submodules
References: <1473458004-41460-1-git-send-email-bmwill@google.com>
        <1473726835-143289-1-git-send-email-bmwill@google.com>
        <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Sep 2016 13:57:45 -0700
In-Reply-To: <xmqqzinbvk15.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 13 Sep 2016 09:31:18 -0700")
Message-ID: <xmqqeg4knanq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0EAFBB78-7B87-11E6-BD1E-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks, will queue with a minimum fix.

So here are two squashable patches, one is the "minimum" one, the
other is a bit more invasive one to use "a pointer to an optional
setting is set to NULL" convention.  I am undecided, and I'll stay
to be without further comments from others, on the latter one.

I understand that many internal changes in your work environment are
titled like "DOing X", but our convention around here is to label
them "DO X", as if you are giving an order to somebody else, either
telling the codebase "to be like so", or telling the patch-monkey
maintainer "to make it so".  So I'd retitle it

	ls-files: optionally recurse into submodules

or something like that.  It is an added advantage of being a lot
more descriptive than "adding support", which does not say what kind
of support it is adding.
