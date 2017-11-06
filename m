Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A77020281
	for <e@80x24.org>; Mon,  6 Nov 2017 03:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbdKFDvR (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 22:51:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63579 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750844AbdKFDvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 22:51:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D14A2B756C;
        Sun,  5 Nov 2017 22:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SvUUFDpgzOtW
        K+tUoLdW/0QYDPM=; b=EKXEBW1+azV1JwSjXQaY2jNNDM1xXeVoTl86iBbgVaQK
        3Ibc/nQv7Kio4PIsD7iv+C4eDYZxM/EoEA6cKjwPkzMCO3U/MTOAbNDxsxrPKCKv
        9RhIN1no/sNnU2QZRZZ7K/L8RRi2DljqEb8dCmXebFIJbne2HBpPMEDl0DzWPzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GfJ3P5
        bG/7KWSht/HITa+g017k63mDXYPXZ18urcIkJGoxAAsFff+DJT3usu0MdGKrQfyD
        eYnULW3lkLsAUcOVoZ1IuTYYkN2rZKQZH5UPS7MzjZi+CvtoME7ZLYrVM+1q1Zai
        Drm24Js/GmYssNtIRbDlpF+ax8I4uHYwiTp5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C82ABB756B;
        Sun,  5 Nov 2017 22:51:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 399C4B756A;
        Sun,  5 Nov 2017 22:51:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        mhagger@alum.mit.edu, pclouds@gmail.com,
        ilari.liusvaara@elisanet.fi
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
References: <20171104004144.5975-1-rafa.almas@gmail.com>
        <20171104004144.5975-3-rafa.almas@gmail.com>
        <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
        <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
        <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com>
        <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
        <9168f7b8-3b9d-a933-e542-ae5b741cb824@gmail.com>
Date:   Mon, 06 Nov 2017 12:51:14 +0900
In-Reply-To: <9168f7b8-3b9d-a933-e542-ae5b741cb824@gmail.com> ("Rafael
        =?utf-8?Q?Ascens=C3=A3o=22's?= message of "Mon, 6 Nov 2017 03:24:02 +0000")
Message-ID: <xmqqpo8whxot.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BCED7890-C2A5-11E7-8B44-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> Would checking the output of ref_exists() make sense here?
> By that I mean, only add a trailing '/*' if the ref doesn't exist.

I do not think it would hurt, but it is not immediately obvious if
the benefit of doing so outweighs the cost of having to make an
extra call to ref_exists().


