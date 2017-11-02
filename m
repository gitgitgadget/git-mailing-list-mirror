Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2239B202A0
	for <e@80x24.org>; Thu,  2 Nov 2017 01:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbdKBBNe (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 21:13:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55098 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751988AbdKBBNd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 21:13:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28536AC1D8;
        Wed,  1 Nov 2017 21:13:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iDah5THYXZ2zmvC0qurGlqFXWiA=; b=wjO9hO
        TMg/+eA6frW2axXj4k1NptbzsrJ8OmiMu1R1Vfm0hRpaBsIRffL1Wg2iDg9pMwWe
        0uDWyWtvpTzDrO7vtRCjjJgCExyBkeWJ02auScaKqPhY6xZXdDcJuqcs2v1NJwX/
        Ng+5uxJ295PierDXrCDUqSNoNU+FKV9fChfBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RqPmBCVRJc/Eo50yvlwqQ+J1D6bcZ3fE
        YapfNw2oUksoKF95SAiMfKc4VP2F49NEGrZUKEdc2Rtojf3jtB336XRT4btAiU4X
        /iPd9TqHfxuLqMVnBDlehpjHFqITFJvEWySkn7cienoygtFEtJ7k3hJX4lskT3WG
        kLlLOGEdyEI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 200B3AC1D6;
        Wed,  1 Nov 2017 21:13:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95437AC1D4;
        Wed,  1 Nov 2017 21:13:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <Jeff.Hostetler@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
        <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
        <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
        <SN4PR2101MB07369D19A150418D5ACB858B8A5E0@SN4PR2101MB0736.namprd21.prod.outlook.com>
        <xmqqd152yesv.fsf@gitster.mtv.corp.google.com>
        <20171101105833.dddaadec0640b7e01962f900@google.com>
Date:   Thu, 02 Nov 2017 10:13:30 +0900
In-Reply-To: <20171101105833.dddaadec0640b7e01962f900@google.com> (Jonathan
        Tan's message of "Wed, 1 Nov 2017 10:58:33 -0700")
Message-ID: <xmqq4lqdtrd1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A7A3D0C-BF6B-11E7-9BBB-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio, would you prefer that the combined effort be in one single patch
> series or separated out into 3? The way I see it, there are two
> independent patch series - this one (object filter support in rev-list
> and pack-objects) and my one (repo extension for partial clone, fsck,
> and gc), and one patch series that depends on these two.

I agree with the general 3-way split "here is how you systematically
omit objects from enumeration (so that you an later use it to
produce incomplete packs for transferring)", "here is how you deal
with missing objects by treating them as non-errors when they are
anchored by objects you got from the promisor", and "now both pieces
are in there, let's plumb through the omitting enumeration code to
pack generator used for object transfer, and add a mechanism for the
two sides to communicate the parameter for object omission".

I agree that Jeff's (what should we call it?  the "object-filter"
topic?) is interesting on its own and it is a good idea to have it
as a separate topic.

If you remove the "size based filtering" from your series (again,
what should we call it?), however, does the remainder still have
enough to demonstrate and exercise the features needed for "partial
clone", though?

The resulting repository will not lack any object that needs to be
anchored by objects you obtained from your promisor unless you have
some filtering capability in the series, which means bugs in that
series will long lay undetected until the third step that depend on
the two series starts working, and at that time, we would have to
sift bugs we find to see if they were bugs in the code added by the
second topic or new bugs in the third topic, reducing the value we
might gain by keeping these separate topics.

That's the one thing that worries me.

