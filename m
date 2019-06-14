Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E8B1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 16:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFNQJu (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 12:09:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51409 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfFNQJu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 12:09:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A5937DF4C;
        Fri, 14 Jun 2019 12:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=u7BJwFcp+XUD39yrt3WQlkB3bLU=; b=CRxyd+
        fLrOaSENBIZDzVGYVlLo3rNQPIF0DbjoLYdUaYqtRDqPWe9aEBnOtPgqmXlDOc/A
        /D88/LLagnOmAOsGc4aITMtuwHHvLJhZ5OQAv2BsC8dOL7UwpduSWTDBdqLOsazu
        PbcykIB7PsMrJBwek0okiSM9IoSboEVQcJBbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tfKOmPBMN0rzMZm1AhPBFiXgRJKK1FUu
        FtXGC9ymCiC3xBLk0TSB4QXzSBv7xQtDkpx8o5r2OQrYYCV/zE/POeMRsnRP7yHN
        f58XPKE0EGKVSQ8mr38Mzz4yalcEGGvo1IlMrBwTL/DJcGR4K8lwmQjqXSq77LTw
        lbMruyZgOJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72E217DF4B;
        Fri, 14 Jun 2019 12:09:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8BDE97DF4A;
        Fri, 14 Jun 2019 12:09:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-list: clarify --abbrev and --abbrev-commit usage
References: <20190613221541.10007-1-emilyshaffer@google.com>
Date:   Fri, 14 Jun 2019 09:09:43 -0700
In-Reply-To: <20190613221541.10007-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 13 Jun 2019 15:15:41 -0700")
Message-ID: <xmqq8su4up14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D39003F6-8EBE-11E9-B9F5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It looks like `git log --abbrev=5` also doesn't work the way one might
> expect, which makes sense to me, as they use the same internals for
> option parsing (parse_revisions()).

I suspect that was primarily because --abbrev-commit was only to
abbreviate the commit object names on the log header, and --abbrev
was to abbreviate the object names seen in the --raw output.  These
days, even --raw output seems to abbreviate by default, so --abbrev
alone lost its usefulness quite a bit.

