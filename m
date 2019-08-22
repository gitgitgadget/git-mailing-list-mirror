Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D37F1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 18:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbfHVSNb (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 14:13:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58611 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbfHVSNa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 14:13:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C057F165F85;
        Thu, 22 Aug 2019 14:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sEoDGYiZOMGEsS5kn/bDGvAEFPs=; b=yE9Ovb
        qtlCv5Yl0qEatoGfvFD2rO+szhJEneBVPif7S2ZN6ZWWi/TD6uMb0IQ+UmeyJCcG
        2sMHcSSjkIITyISCxAwOWzULiX9wWCvayuJaLataZJf4DVrtHUxKMWucdJCH8c+v
        zgpZpVJKHCgtiqNc6/cprhIzhxAPG5pw6MFYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xIdZBIPcAIcGBwx4E6aKBhZlJwDkZh4I
        CyvH1gulZ8hQpgoyHBdHjxA3yHv60PYXgaKppMZPshaQLk/gY9D6pIbg38hdM9zD
        15kQCURRsBiT3kvq7oZeWH49P7MkTyd3rd4dwjTbvQVNQjeak/8u1EuUSIGUlvbD
        2Ynx0LLDr1w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8230165F84;
        Thu, 22 Aug 2019 14:13:28 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 288C4165F83;
        Thu, 22 Aug 2019 14:13:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Saravanan Shanmugham \(sarvi\)" <sarvi@cisco.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: First Git status takes 40+ minutes, when mounting fileystem/diskimage with 50G GIT repo + 900G of builds articles
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
Date:   Thu, 22 Aug 2019 11:13:27 -0700
In-Reply-To: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com> (Saravanan
        Shanmugham's message of "Thu, 22 Aug 2019 18:02:06 +0000")
Message-ID: <xmqqh869oypk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A46FAE4-C508-11E9-BDD1-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Saravanan Shanmugham (sarvi)" <sarvi@cisco.com> writes:

> I suspect warming the filesystem caching is in play.
> But so is the fact that walk every tree to find untracked files as well. 

Enable the untracked cache and "update-index --refresh", before
freezing the repository + working tree state in the diskimage?
