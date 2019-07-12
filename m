Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146481F461
	for <e@80x24.org>; Fri, 12 Jul 2019 16:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfGLQZT (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 12:25:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53180 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfGLQZT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 12:25:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E231F1517C7;
        Fri, 12 Jul 2019 12:25:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uJF0Yv08FGc/DzRtHbm/Klm1few=; b=V/K74y
        zDoaCNetqGl/r/zE8RNF13vgzGL43a2P0HSVVIvORrntJ9AKCkrvVRfh0stF4rEV
        ulxqkQNajwFWSBEahXgZBKOpaOAzp+AocAjonHhj0XFEI3ieKil2c+ZkWp3plTbU
        sxUyFXDjxaS7wupWUG9I7V6ynt6Mjh66m4g7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Fgcmx7ucEQ3Ejzq0XSTy9a4y5VEKf5Bu
        m+yW1PtPV44T24RDdeGVa+8P24ta7gFjcruJkymz4rIzpOi/FGviBHmb8Ykyi+GV
        nPornxJKD2YKqT6Fau6BEipabAh9d6TPBC7Nb7CekFFKs2dCWmkNeAdv5CkZ2Ing
        Ow/76tgDT5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D81BF1517C6;
        Fri, 12 Jul 2019 12:25:14 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D67271517C5;
        Fri, 12 Jul 2019 12:25:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] transport-helper: enforce atomic in push_refs_with_push
References: <20190711211919.32734-1-emilyshaffer@google.com>
Date:   Fri, 12 Jul 2019 09:25:12 -0700
In-Reply-To: <20190711211919.32734-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 11 Jul 2019 14:19:19 -0700")
Message-ID: <xmqq36jbqkyf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0720B2C-A4C1-11E9-B091-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +test_expect_success 'push --atomic also prevents branch creation, reports collateral' '
> +	# Setup upstream repo - empty for now
> +	d=$HTTPD_DOCUMENT_ROOT_PATH/atomic-branches.git &&
> +	git init --bare "$d" &&
> +	test_config -C "$d" http.receivepack true &&
> +	up="$HTTPD_URL"/smart/atomic-branches.git &&
> +
> +	# Tell "$up" about two branches for now

Ahh, that's what you meant ;-)  Makes sense.
