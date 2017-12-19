Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BAB01F406
	for <e@80x24.org>; Tue, 19 Dec 2017 22:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbdLSWNg (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 17:13:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50524 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752630AbdLSWNf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 17:13:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D206AB0795;
        Tue, 19 Dec 2017 17:13:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XNNM94AumjOwG1/uzdzyeMjvQEk=; b=ZyLlEa
        DRziHwQmgWD1nS+M4WtOzxmESzRncYw1cE1COHILZrkO+QUAjwvfRnr8F+HCY5h4
        +7s7TMi6FGzBOA4s8cttZNyvRC5EQpV8q/eZ2sIjm4Mm5TyJ/5+0N6CnAeGVWUm6
        K56FI5SmP7X7Tt6mXdseM6XhQSLGufPe4aMZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=glrhOLzpfL0gVyKJ7/ZqvW7kL919Quoy
        NjOZ9LKZ72PWeOUly0m5W+NgVHVG/seK20e3cqsUvKsRQJUjJTuz8C1HTIOkAtnl
        QmjuQqbysYiFYjKYwWAiogiGpRXYdfUOf5PNNPXCQcM7smw7LNmxEmUqNZUrwPm3
        JOxKax3bpok=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C8FC6B0793;
        Tue, 19 Dec 2017 17:13:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31F2FB0791;
        Tue, 19 Dec 2017 17:13:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] http-backend: respect CONTENT_LENGTH as specified by rfc3875
References: <20171126193813.12531-1-max@max630.net>
Date:   Tue, 19 Dec 2017 14:13:33 -0800
In-Reply-To: <20171126193813.12531-1-max@max630.net> (Max Kirillov's message
        of "Sun, 26 Nov 2017 21:38:11 +0200")
Message-ID: <xmqqo9mutlgy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DA96A1C4-E509-11E7-BB62-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> v6:
>
> Do not implement generic git_env_ssize_t(), instead export git_parse_ssize_t() from config.c
> and hardcode the rest.
>
> Florian Manschwetus (1):
>   http-backend: respect CONTENT_LENGTH as specified by rfc3875
>
> Max Kirillov (1):
>   t5560-http-backend-noserver.sh: add CONTENT_LENGTH cases
>
>  Makefile                         |  1 +
>  config.c                         |  2 +-
>  config.h                         |  1 +
>  http-backend.c                   | 50 +++++++++++++++++++++++++++++++++++++++-
>  t/helper/test-print-values.c     | 10 ++++++++
>  t/t5560-http-backend-noserver.sh | 30 ++++++++++++++++++++++++
>  6 files changed, 92 insertions(+), 2 deletions(-)
>  create mode 100644 t/helper/test-print-values.c

So... is there going to be an update (or has there been one and I
missed it)?

Thanks.
