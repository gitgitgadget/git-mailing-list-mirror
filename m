Return-Path: <SRS0=SopW=7V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C757C433DF
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE842076A
	for <git@archiver.kernel.org>; Mon,  8 Jun 2020 22:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PIba9aC0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgFHWKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:10:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50385 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgFHWKv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 18:10:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EF221C9778;
        Mon,  8 Jun 2020 18:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kbclEE4Hwz1avcZ+q/mZ+ci76uA=; b=PIba9a
        C0dWTZA9lQbDyWjyzWYriVl8VDKkpCbp0Wfrf3lFZKtjost14Kk8IaRXORH6OAH9
        sPbS9E2LRxL/IiUA7zR07/zz5JLvZEwf6uIYlVStdZY9yMPa8BcmVEo1xoOjaOPm
        qBCf/IMl0zLPhtVyDVzhfKc8XD6NXJPJTWGjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DU6m4sIYd7Gr7K2oBQSBFqbovyq8lu9s
        EsK/E3SMp/kDYIvY3d8AKu/motZ3WfvhgU9Hml8JQG8FOGGxaRZneIFy73jVHz/J
        RSW+5ToNDRw8cV5n/pQU/joCl0MTLzscrOvVs2oaYM5MWopkjm9/B58DpO8eLtIH
        8SBwO/p7ce4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7CADC9777;
        Mon,  8 Jun 2020 18:10:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 39143C976B;
        Mon,  8 Jun 2020 18:10:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 2/8] cmake: generate the shell/perl/python scripts and templates, translations
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com>
        <pull.614.v3.git.1590759624.gitgitgadget@gmail.com>
        <f19794fdbc09cc3c57392dc522920f7b01691d88.1590759624.git.gitgitgadget@gmail.com>
        <xmqqwo4uy20z.fsf@gitster.c.googlers.com>
        <CAKiG+9Ue1fqrzqHduZY4Pnsh4q+Thqq618JymkonmVhGewmM1g@mail.gmail.com>
        <CAKiG+9VcAx2xRFzrqQpXFc+sVuRZ2ydoVYTpCtWpi9z2Oa0fCw@mail.gmail.com>
Date:   Mon, 08 Jun 2020 15:10:44 -0700
In-Reply-To: <CAKiG+9VcAx2xRFzrqQpXFc+sVuRZ2ydoVYTpCtWpi9z2Oa0fCw@mail.gmail.com>
        (Sibi Siddharthan's message of "Tue, 9 Jun 2020 01:37:56 +0530")
Message-ID: <xmqqa71djjiz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E708E7A4-A9D4-11EA-8F2F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:

> Hi Junio,
>
> I have done the suggested changes namely:
> 1) Format code inside check_c_source_compiles/runs
> 2) Moved the changelog of the patch series from the commit messages to
> the cover letter
> 3) parse for SCRIPT_LIB
> 4) glob templates and po files
> 5) add logic as to where the template file should be built.
>
> Any other changes I should do before I a new version of the patch series?
>
> Thank You,
> Sibi Siddharthan

Sorry, but I read too many patch series that I do not remember
glitches I pointed out in the previous round of individual topics.

So asking that question is waste of both of our times.  Just use the
time necessary to compose that message to instead proofread one more
time, scan the review thread of previous round and make sure you
took everybody's input into consideration (you do not have to follow
everything other people said---you just need to be able to solidly
stand behind the decision you made to follow or not follow them in
your latest version).

Thanks.
