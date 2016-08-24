Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76891F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756363AbcHXQYI (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:24:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61120 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757050AbcHXQYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:24:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 368E636134;
        Wed, 24 Aug 2016 12:22:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qPaTJG2W7erIX/pyEfOo3J1qJYo=; b=GU8Ktu
        tEWtB74SOsAd4s2rQZIPnFROyP/2YaaHtIE35xsHkZ9jIROyM+lYvO6m9K6QmAtv
        DDq+kGfSj7Au4zpJvEggpVup9v/dGeIZUfggp/KY7/n2qXIDCArJN7nCZ2AI+2Zk
        FsUcUL/kp3Bb7sgWN5kjHMoMB8mOt7ZjwdqMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rmx+SKBWKnvd7A4YISVzMlGTjye7lUpW
        GyiEPSYUfzHAEEBIQDs6WIxUzHwvG2Fjjx9ojauyQEZXP3HSewCC6ylhexrGUmW/
        VjSO0QkcO7GnnBhXXNQgI/RY5b86XJIQU41BVrcSqugcodQXg2qbmsoQufc4ohhu
        XVToICx5mXE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2F39A36133;
        Wed, 24 Aug 2016 12:22:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B35C236132;
        Wed, 24 Aug 2016 12:22:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: diff <commit> using 3-dot behavior
References: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
Date:   Wed, 24 Aug 2016 09:22:40 -0700
In-Reply-To: <CAHd499DL2WiTgnk5A--qihUh-jF9m7aXDzHAQuW=bLRVW4Bniw@mail.gmail.com>
        (Robert Dailey's message of "Wed, 24 Aug 2016 09:28:24 -0500")
Message-ID: <xmqqbn0irvan.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FBC9A220-6A16-11E6-AFF1-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> $ git diff master...topic

... which is defined roughly as

	git diff $(git merge-base master topic) topic

The merge-base is to compute the point you forked your topic from
the mainline.  So if you want to compare your current state in the
index with the fork point, you'd do

	git diff --cached $(git merge-base master topic)

and comparing your working tree state would be

	git diff --cached $(git merge-base master topic)

