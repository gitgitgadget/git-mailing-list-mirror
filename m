Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F79C35677
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27053246BB
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fHhGXqjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgB0Q0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:26:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63129 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbgB0Q0N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:26:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F41115F888;
        Thu, 27 Feb 2020 11:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VzCb4RWnmADpKe674s1eOthBoHA=; b=fHhGXq
        jCarsjONRuL00X7rE2im2FMYGGDozVh1W5h/9u3dyQ+BAQFaKEJchEVpZ9Ppjj/4
        LHjnsv1NifQ170sDir+nYvZyMPAHHo6xJZu8nWlgVnb0dcS47ph/xsJgM2NZ5ltj
        UTREc/cqowGbICa8w9q1QL2e3ttlOL77XA+v4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XKa8wGZVYD4zBoP5xumCo94God21Q8k+
        oGRYGmpfJX452dMkjAhlhD49YW0XfPnfFJrMSjioVeMCLPJlD5BXp8M07fWDpNeQ
        3hEa+LruvgKBhYW9rJnDRhq2BWX8AKAThZnXjNbejQxl27CYRdKAn3++aktbDFaD
        jHECeO7ucIg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB2E55F887;
        Thu, 27 Feb 2020 11:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 537B75F886;
        Thu, 27 Feb 2020 11:26:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
        <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
        <xmqqwo89ghmt.fsf@gitster-ct.c.googlers.com>
        <CAFQ2z_NR1HtEphYC1A+J8oU+YAyoa2P69k9enQ8w4Q5pa=NtEA@mail.gmail.com>
Date:   Thu, 27 Feb 2020 08:26:10 -0800
In-Reply-To: <CAFQ2z_NR1HtEphYC1A+J8oU+YAyoa2P69k9enQ8w4Q5pa=NtEA@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 27 Feb 2020 17:01:11 +0100")
Message-ID: <xmqq1rqggfod.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE4D1754-597D-11EA-9B7F-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Sounds great to me. Could we submit a patch that changes this into
> master already so Brian and can work on the same basis?

Heh, "into master already" is never be the way things work around
here.  But if these two topics can agree the best way forward, it
can be proposed, polished and then merged to 'master', just like any
other topic.  And the two topics both can build on top of that
topic.

>> I am not sure how quickly Brian's SHA-256 work solidifies enough to
>> build on top of, but if it is a good option to build on top of the
>> topic, that may save some work from this topic, too, as the
>> mechanism to choose something (i.e. hash algorithm for Brian's
>> topic, ref backend for this topic) fundamental to the repository at
>> runtime and at initialization time needs similar supporting
>> infrastructure, such as changes in "[12/24] setup: allow
>> check_repository_format to read repository format", and "[13/24]
>> builtin/init-db: allow specifying hash algorithm on command line"
>> of that series.
>
> Can I pull this series as a git branch somewhere?

There is a single merge somewhere on "git log --first-parent master..pu"
that merges bc/sha-256- something (I assume you know how to obtain
'pu').

Thanks.

