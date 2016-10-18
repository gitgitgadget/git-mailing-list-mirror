Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A53620988
	for <e@80x24.org>; Tue, 18 Oct 2016 17:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbcJRRvJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 13:51:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932230AbcJRRvI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 13:51:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7894E483DD;
        Tue, 18 Oct 2016 13:51:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pebhW2Wdaj7zO590Tekh0WxV0hA=; b=mQFfG9
        tgqdSnGI3zFZ9qgl5f1g26WSG5J72OqEnIfXvGEYh5j9LIZa70clbSM7DtuEpfAr
        8adKJ1ltr0Gjd5KzzWIp3AOkjczAnL/pydDMnaMpJlKB1UBhOocugdl/6g1sdL7/
        UF/q3NyVD7u5z0tvSv9tJ9lRaQhsSy9BmWivc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hKWQtNKWi7JwkI21f346k2CaqNYdDf53
        +5707fMiUZ7uu4UJ7qZFvMnXnJs++IiYMSNkJvILzyLUnwX+gm7nKtDqRPCTO7Hh
        gBNWOnPx2yaRjWo3ntQbCa6AZQJ1qLMK+Wvfw9G0/nxsfTXTNscSM4jepygLphO2
        tCMuVhWN6+0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6440F483DC;
        Tue, 18 Oct 2016 13:51:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9E09483DA;
        Tue, 18 Oct 2016 13:51:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] submodule--helper: normalize funny urls
References: <20161017221623.7299-1-sbeller@google.com>
        <xmqqbmyisiae.fsf@gitster.mtv.corp.google.com>
        <xmqqr37dpoip.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZEFanPpdrE4sD64LJHmyrBiHafo1VzoGtoGh+wO_HCuw@mail.gmail.com>
Date:   Tue, 18 Oct 2016 10:51:04 -0700
In-Reply-To: <CAGZ79kZEFanPpdrE4sD64LJHmyrBiHafo1VzoGtoGh+wO_HCuw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 18 Oct 2016 10:17:44 -0700")
Message-ID: <xmqqinsppmuv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7207D2EE-955B-11E6-AF64-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> for(;;) {
>
> here ? (this code would not need a variable, and
> for wins over while:
> $ git grep "while (1)" |wc -l
> 107
> $ git grep "for (;;)" |wc -l
> 128
> )

I dunno; the numbers tells me there is no strong preference by wide
margin either way.

I am not sure if the end shape does not really need an exit
condition.  If there is a need for one, "for (; condition;)" would
look strange.  If there isn't, "for (;;)" is actually my personal
preference over "while (1)".

