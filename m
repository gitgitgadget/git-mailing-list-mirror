Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E6FC5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488E720773
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 23:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Uc2rGcFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgKVXye (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 18:54:34 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54941 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgKVXye (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 18:54:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38DD31177C4;
        Sun, 22 Nov 2020 18:54:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QYBpckygEqiUUnTXXH5W2xV5lhg=; b=Uc2rGcFYUI0yUtMNvSAG
        ZTZzTBKIXRaBb9bAcqzOwo2ZJ6gu4O5IWdRgU59CvwZb0qJRP0pkY2G2EzIggw20
        /BW7+2d0iJQHG9JkH+Yc4vBJzVgXxOQdHIqFYS13rgXmeGXAZpdzIMY1r/mcH2HL
        f9zLdrMLVrnAciB/dYBDxUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=N8PV/8dC5gz+os0r3u9euRXS6rB+uStUYVaYIE2cPTJkit
        3PVhdtBct0lHVK7DTpEteNLs1mivOePL4efnQcLpQgNyiptHWdNS1Y/t5DzxSwur
        cmx6lXvo8KE4SP9lLSdM++DCwkH+UL1+hoxISUcAw9Nkkxz1rmAmYDEJiPEqo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3153E1177C3;
        Sun, 22 Nov 2020 18:54:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 802D81177C2;
        Sun, 22 Nov 2020 18:54:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
        <87r1oraewl.fsf@x220.int.ebiederm.org>
        <xmqqv9e34mq5.fsf@gitster.c.googlers.com>
        <1389dabc-33c9-1e65-a3de-43729a6c2e70@iee.email>
        <xmqqh7pmyuzn.fsf@gitster.c.googlers.com>
        <7df660f2-ad74-7d1f-eb13-a0edadffbfbf@iee.email>
        <871rgpr497.fsf@osv.gnss.ru> <xmqqpn46qppl.fsf@gitster.c.googlers.com>
        <87y2it8zfm.fsf@osv.gnss.ru>
        <CAMP44s2eccgXTqFgHwv-ciUJ+v2PkHzHtCpA_+vQ9XZ1Kw6VUA@mail.gmail.com>
Date:   Sun, 22 Nov 2020 15:54:28 -0800
Message-ID: <xmqq8satosln.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FFC0D2C-2D1E-11EB-8673-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It is clearly a branch, for example you can do "git push origin @:my-fix".

Hmm, you can also do "git push origin c2f3bf071e:maintenance", but
it does not make a bare object name a branch.  

At least I doubt the "clearly" part of your statement.  There might
be a better example to support the above claim, but this one is not.


