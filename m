Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F229C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CFF2068F
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 05:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O5k3EsNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfKVFmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:42:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50100 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVFmP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 00:42:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CF5239812;
        Fri, 22 Nov 2019 00:42:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lZBVTznzzSVVWBoQa8PwpDKj3Ag=; b=O5k3Es
        NLoKzTSCKPf1ZTe4Tp6j+Qa6ErKSG2b72CWODl/6i0cvSyLy1tiXKd96xz9tieqY
        i9evRbufknCRuGNLdtmEMC66oYu7uoYUAGmQGGLKET6wRgzY5MYjz6kgwXkIQc59
        Z6O7/w8hgXz0Pn/aMeu77LmKYR8IDeQV89cTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O5IQRXMRdJZ6V4diJmrAJO19KD86CZjB
        VMIWf8rppMJJW4sx6Z2gC3gv5Jg8piOyjGuNq5eaDi+cKluRPDrF4nLeGxBiYYIH
        v8oeCu2+BhFn9ZnEq4phv/RwFRwoJH2ng5LObMr0b61U8yNEmcWLNVGexrTyjtJP
        YWwVMWHjQh4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53D5F39811;
        Fri, 22 Nov 2019 00:42:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BE94639810;
        Fri, 22 Nov 2019 00:42:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
        <20191119175850.GL23183@szeder.dev>
        <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
        <039f7668-53e3-9c6d-d813-ca412c4d1ed2@gmail.com>
        <xmqqy2wa9ibs.fsf@gitster-ct.c.googlers.com>
        <dc0bbc13-8204-c6b4-8d3b-db101027fe1c@gmail.com>
Date:   Fri, 22 Nov 2019 14:42:11 +0900
In-Reply-To: <dc0bbc13-8204-c6b4-8d3b-db101027fe1c@gmail.com> (Derrick
        Stolee's message of "Thu, 21 Nov 2019 06:10:55 -0500")
Message-ID: <xmqq5zjc79ho.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D541B820-0CEA-11EA-9285-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 11/20/2019 7:36 PM, Junio C Hamano wrote:
>> Derrick Stolee <stolee@gmail.com> writes:
>>> That commit can be ejected from the series without affecting the
>>> correctness of any of the other commits. That will require reverting
>>> the merge at this point, though.
>> 
>> I've done the "reverting" part of everything, so that other patches
>> that need further work, if any, can be given a fresh start.
>
> I see that more feedback was given, so I'm working on a new version.
>

Thanks.
