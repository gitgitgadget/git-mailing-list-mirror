Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5612FC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3767F617E5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 19:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhKHTLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 14:11:42 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61204 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236640AbhKHTLj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 14:11:39 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4871B1687D9;
        Mon,  8 Nov 2021 14:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ntpqwVo204AA3+XVb4+nocE5uoKSooSocbxtyZ
        0zipI=; b=N796ZKuTEBJuAMATxDkFHts8XTSu6HJWIDcbadGk0oibIdYTF0grJG
        95O/DG0eIkDAEhgKGJmso5q/RChEOyStTXURIqdhq0RKSahaenZc9ZEBW6AOBACF
        vKoYZLdrj1N7rFHN/AYYOHiAKxDVfvRCbXYTbbtnhV08d7IJM6STo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40C0A1687D8;
        Mon,  8 Nov 2021 14:08:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C5C41687D7;
        Mon,  8 Nov 2021 14:08:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Git Mailing List <git@vger.kernel.org>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH 2/3] vimdiff: add tool documentation
References: <20211104160959.183402-1-greenfoo@u92.eu>
        <20211104160959.183402-3-greenfoo@u92.eu>
        <CAJDDKr4icrigRO-2S_HVdY7+W0EGJ8XBn5dD=O-qy1tXym4u8w@mail.gmail.com>
Date:   Mon, 08 Nov 2021 11:08:49 -0800
In-Reply-To: <CAJDDKr4icrigRO-2S_HVdY7+W0EGJ8XBn5dD=O-qy1tXym4u8w@mail.gmail.com>
        (David Aguilar's message of "Sun, 7 Nov 2021 13:24:47 -0800")
Message-ID: <xmqqfss6v51a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4ECFD89A-40C7-11EC-8646-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

>     (diff_mode && ... || merge_cmd_help ...) |
>     while IFS= read -r line
>     do
>        ...
>     done
>
> How come we have to unset IFS here?

We are taking the input into a single variable "line", so what are
we splitting with IFS anyway?

In any case, thanks for spotting bash-isms to avoid.  We started
allowing "local", I think, at least in the tests, but otherwise many
bash-only things like "<(process)" redirection and "${substring:4}"
substitution are simply no-no.


