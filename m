Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B504C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 00:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiCNAUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 20:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235688AbiCNAUn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 20:20:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADFF7B
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 17:19:34 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7869211FE40;
        Sun, 13 Mar 2022 20:19:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RWt+Ffd6j75MDdbsSNquP80sl5VKtOy2Spfmh+
        /wVNk=; b=kd2AYRMDzCzOwyLDz2LfcIX/GrVt/VYidH+u3Wazi5s8WUrOGQ5i4B
        bTDPthSTsU2VXRUa+c9fI0rMOsLNhzlSFrnyvEAG/k1gTKE8hQkeslI1iZQhTWsb
        SJrKzbbsQ3C/iqKVLuU7PPAuA7yL7Kc+2X/FYRNiAxzLk7GioVpwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E93111FE3F;
        Sun, 13 Mar 2022 20:19:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BED1D11FE3E;
        Sun, 13 Mar 2022 20:19:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     "'Sean Allred'" <allred.sean@gmail.com>,
        "'Philip Oakley'" <philipoakley@iee.email>, <git@vger.kernel.org>,
        <sallred@epic.com>, <grmason@epic.com>, <sconrad@epic.com>
Subject: Re: Dealing with corporate email recycling
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
        <01cc01d83671$0acd4a20$2067de60$@nexbridge.com>
        <87zglu9c82.fsf@gmail.com>
        <01f201d836e5$89247c30$9b6d7490$@nexbridge.com>
        <87v8whap0b.fsf@gmail.com>
        <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
        <87r175amw2.fsf@gmail.com>
        <f6ecca05-b669-0e36-302f-a6113571ac12@iee.email>
        <87ilsha2b7.fsf@gmail.com> <xmqqtuc1tpdj.fsf@gitster.g>
        <021401d83731$62813630$2783a290$@nexbridge.com>
Date:   Mon, 14 Mar 2022 00:19:30 +0000
In-Reply-To: <021401d83731$62813630$2783a290$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Sun, 13 Mar 2022 19:23:38
        -0400")
Message-ID: <xmqqlexdtmgd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B6FB264-A32C-11EC-B2EA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> Could we not use SSH's ssh-keygen -V for this purpose when establishing
> persistent identities independent of user/email? We already do this for
> signed commits.

Fingerprint of cryptographic key would be easy to use as an
identity, for which the person who claims ownership can easily
produce proof of ownership.  Various other "identitying strings"
like human readable name and e-mail addresses from different
validity periods can be all tied to such an identity.  Taking key
revocation into account, keys from different validity period may
have to be tied together in a same way.  "The person who used to
sign the commits with key A and the person who signs the commits
with key B are the same, and in real life, they are known as
A. U. Thor"

But proving that such a mapping is in a meaningful way is much
harder, I would imagine, but perhaps addresses and human readable
names do not matter as much.  Or continuity of identity, for that
matter.  I dunno.



