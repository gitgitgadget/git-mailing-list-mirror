Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52AC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0747360527
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 19:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhG2T40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:56:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51563 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhG2T40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 15:56:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B5BE147FB2;
        Thu, 29 Jul 2021 15:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wuxkJTPRu5/AOsZvUehGA7mTlG5YpAlJQuDD4a
        fuNdw=; b=WXFbHeaHZ46pw+lohIK0OfdLWyOjfvx22EWxOkp6CS2Sga32Ig76n4
        6RFloQmxN3ndRuoAGjKy1fFWTIhSzAvfTH8AjRmHgFL+iNd73pI4QHCRneZWJru0
        Umv2iKs8ptkVnqoaoCdeQRpdZR/3Lcb67ChxW6fw99c42z/qi42wQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4382D147FB1;
        Thu, 29 Jul 2021 15:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89923147FB0;
        Thu, 29 Jul 2021 15:56:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Fabian Stelzer <fs@gigacodes.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        gitgitgadget@gmail.com, git@vger.kernel.org, hanwen@google.com,
        sandals@crustytoothpaste.net, rsbecker@nexbridge.com,
        bagasdotme@gmail.com, hji@dyntopia.com, avarab@gmail.com,
        felipe.contreras@gmail.com, sunshine@sunshineco.com,
        gwymor@tilde.club
Subject: Re: [PATCH v6 3/9] ssh signing: retrieve a default key from ssh-agent
References: <071e6173d8e418349d94fea97624e8cee9f1dde5.1627501009.git.gitgitgadget@gmail.com>
        <20210728224832.2717826-1-jonathantanmy@google.com>
        <f3e72ec9-3ed4-9955-a7bd-042fa6eb016c@gigacodes.de>
        <YQL84R7qNv8pnHro@google.com>
Date:   Thu, 29 Jul 2021 12:56:17 -0700
In-Reply-To: <YQL84R7qNv8pnHro@google.com> (Josh Steadmon's message of "Thu,
        29 Jul 2021 12:09:21 -0700")
Message-ID: <xmqqwnp851y6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0AC52396-F0A7-11EB-A339-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Rather than making this behavior the default, could it instead be
> enabled only if the signing key is set to "use-ssh-agent" or something
> similar?

Interesting.  But is it too much trouble to find out the string that
is used to identify the ssh key you want to use to sign, which would
make it worth supporting "use-ssh-agent" feature?  Unless you want
to use multiple keys in a single project, and choose one of them
depending on whatever condition, and find it convenient to specify
the key-of-the-day by loading it to your ssh-agent, I do not quite
see why you'd want to explicitly configure it to "use-ssh-agent" and
not the actual key (either the textual key itself or some key-id to
choose one of your keys).  Care to clarify your expected use case a
bit more?

Thanks.

