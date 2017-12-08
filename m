Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 351941FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbdLHUhh (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:37:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55349 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750951AbdLHUhg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:37:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAAC8AC7F7;
        Fri,  8 Dec 2017 15:37:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+rNQ39xNYP1Wl96rMeishCa6iiQ=; b=DXZ8jM
        Tlw8SEwFYtc1i5+0H5kR/4DCsyXzNFUhI6p68imUzFgRUS9x6jdbyN0JH2ZdF9g2
        NoLnrHraPu0GoUBDnHd5XZc/2I0+Sk0FW6LNO5GsE0jAZPwNNgg3sSpUcqVPLdtq
        L246JNXhGKK8/2L6QTKQL+j6Iz+REPln7WdDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A1o66etYSHQlGpDVnnzoXbwNXqhMADFY
        Ekw4SvJ45rsY81Xjk10if9MBGrTJmLnlvDQoeo7RgSblPK/ZJmKKxAqwN9qYUbcl
        tkWFoUeIiMLSJGAucAGNSO/LbLtuI9vifyAuUbK6kRILXac7ppZGgbSB3slK9tvU
        AF7ZGsjcXEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B39C5AC7F6;
        Fri,  8 Dec 2017 15:37:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 295FCAC7F5;
        Fri,  8 Dec 2017 15:37:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH Outreachy 1/2] format: create pretty.h file
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
Date:   Fri, 08 Dec 2017 12:37:33 -0800
In-Reply-To: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
        (Olga Telezhnaya's message of "Fri, 8 Dec 2017 13:21:56 +0000")
Message-ID: <xmqqr2s56jn6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F5A4BD4-DC57-11E7-B66E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Olga Telezhnaya <olyatelezhnaya@gmail.com> writes:

>  archive.c             |  1 +
>  builtin/notes.c       |  2 +-
>  builtin/reset.c       |  2 +-
>  builtin/show-branch.c |  2 +-
>  combine-diff.c        |  1 +
>  commit.c              |  1 +
>  commit.h              | 80 ----------------------------------------------
>  diffcore-pickaxe.c    |  1 +
>  grep.c                |  1 +
>  log-tree.c            |  1 +
>  notes-cache.c         |  1 +
>  pretty.h              | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  revision.h            |  2 +-
>  sequencer.c           |  1 +
>  sha1_name.c           |  1 +
>  submodule.c           |  1 +
>  16 files changed, 101 insertions(+), 84 deletions(-)
>  create mode 100644 pretty.h
>
> diff --git a/archive.c b/archive.c
> index 0b7b62af0c3ec..60607e8c00857 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -2,6 +2,7 @@
>  #include "config.h"
>  #include "refs.h"
>  #include "commit.h"
> +#include "pretty.h"
>  #include "tree-walk.h"
>  #include "attr.h"
>  #include "archive.h"

This has a toll on topics in flight that expect the symbols for
pretty are available in "commit.h"; they are forced to include
this new file they did not even know about.

I notice that "commit.h" is included in "builtin.h"; perhaps adding
a new include for "pretty.h" there would be of lessor impact?  I
dunno.

