Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C1C1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935195AbcKNTvj (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:51:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53805 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932462AbcKNTvi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:51:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5567550942;
        Mon, 14 Nov 2016 14:51:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ImMFqm3c+SrAOZERUrGxyX7uIfo=; b=iQSb34
        GV5s7tXei4/uHo6O8MTHwCLijRk+D3nGw5lE6m4eqIvwPShos24nRbd3vAcqckrM
        8jajgJO6MK199NwxH3C/5tc4ppdsEoneu0hfC+IlsaQAWUriZSXtOgPQDkPIeeqt
        GJuhUxzEZLiSPzvL9Hy0KA4fpS+NxTEWAVcdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HFeLfpVIDvguu0ZCIT9LuPM9Pma2U/zR
        C2elTNmgH9QzJ6QxSfyNUyI6TD6bqXptWZ6MYVZ1j0KqpquuNBQg3b6IWZIWZszr
        jTPWZjgWc5lqizHFqTn4u74/W7ov3mNpN44MK4zZtLbFXhJxj55R2ROoR9pQYTNf
        GqQESeNpB4k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C33650941;
        Mon, 14 Nov 2016 14:51:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD99550940;
        Mon, 14 Nov 2016 14:51:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for ref printing atoms
References: <20161108201211.25213-1-Karthik.188@gmail.com>
        <20161108201211.25213-14-Karthik.188@gmail.com>
        <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
        <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
        <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com>
        <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
Date:   Mon, 14 Nov 2016 11:51:35 -0800
In-Reply-To: <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
        (Karthik Nayak's message of "Tue, 15 Nov 2016 01:06:45 +0530")
Message-ID: <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C087EE4C-AAA3-11E6-88E4-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Karthik Nayak <karthik.188@gmail.com> writes:

>>  - More importantly, what do these do?  I do not think of a good
>>    description that generalizes "base of refs/foo/bar/boz is foo" to
>>    explain your :base.
>
> $ ./git for-each-ref --format "%(refname)%(end) %(refname:dir)"
> refs/heads/master                  refs/heads
> refs/heads/ref-filter                refs/heads
> refs/remotes/junio/va/i18n     refs/remotes/junio/va
>
> $ ./git for-each-ref  refs/heads --format
> "%(align:left,30)%(refname)%(end) %(refname:base)"
> refs/heads/master                 heads
> refs/heads/ref-filter                heads
> refs/remotes/junio/va/i18n     remotes
>
> I guess this should clear it up.

Hmph.

I would guess from these examples that :dir is an equivalent to
dirname().  But it is unclear how :base is defined.  Is it the path
component that comes immediately after "refs/" that appears at the
beginning?
