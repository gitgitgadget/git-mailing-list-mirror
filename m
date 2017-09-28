Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 294382047F
	for <e@80x24.org>; Thu, 28 Sep 2017 04:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbdI1Ehk (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 00:37:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53967 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750947AbdI1Ehj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 00:37:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B02679D210;
        Thu, 28 Sep 2017 00:37:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dWElSiu0c5nUbRuzbDRobKdRb/o=; b=ZS2yRY
        qVJBMSLFhAZ42ZgSoBYnoN/9WK3cIPWdPeYiZPUx8K+B9Vc2H8ZdgfuvDIC9YD5F
        AMuG/F61RSbiMpWUNwp5MhCKDXApHHFU0MIuiineEVxwHZN9yyLSqlzEI7MoTfW9
        a4RVk1L7jx0XAIVs8e1W6uvZDTZSZr0DWYgxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oQ6mpzD6VXw6XJxGKrxo3MQ3eV4ipJRB
        xiP+SgoA181NRpWSGAW3ihcRgsouaBGq6te7WgieUt1s5lESdTgz/hU2xLX/qEX7
        RRzVyu0lNfWqi/g7odn1kQ+9nZekPUGcyLVECknmGhbt92xLsyRjvpTPEmvpCYdM
        DP5oFv+8z1U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9566B9D20E;
        Thu, 28 Sep 2017 00:37:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E614E9D20D;
        Thu, 28 Sep 2017 00:37:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Max Kirillov <max@max630.net>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
References: <20170928041417.28947-1-max@max630.net>
Date:   Thu, 28 Sep 2017 13:37:36 +0900
In-Reply-To: <20170928041417.28947-1-max@max630.net> (Max Kirillov's message
        of "Thu, 28 Sep 2017 07:14:17 +0300")
Message-ID: <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C16672FE-A406-11E7-B15F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Max Kirillov <max@max630.net> writes:

> Tilda-based path may confise some users. First, tilda is not known
> for Window users, second, it may point to unexpected location
> depending on various environment setup.
>
> Expand the path to "nativename", so that ~/.config/git/gitk-tmp
> would be "C:\Users\user\.config\git\gitk-tmp", for example.
> It should be less cryptic

It might be less cryptic, but for those of us whose $HOME is a
looooooong path, ~/.config/git/gitk-tmp is much easier to understand
than the same path with ~/ expanded, which would push the part of
the filename that most matters far to the right hand side of the
dialog.

I somehow find this change just robbing Peter to pay Paul.

>  	} else {
> -	    error_popup "There appears to be a stale $config_file_tmp\
> +	    error_popup "There appears to be a stale \
> + \"[file nativename $config_file_tmp]\" \

