Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EA7C1975A
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B5D206E7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 00:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dJJ2nYtZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCMAKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:10:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54094 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCMAKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 20:10:17 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7811F52513;
        Thu, 12 Mar 2020 20:10:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=V0GIMRf9Y9d5N8w4MlRP1T7pXPw=; b=dJJ2nY
        tZZXLk1HNrZbiPTRqZNWUnCZVW5SMQUjWc5bhYvKyQTNM3uymMRSfxi/T69Rhe8S
        IcxaRZ7f9NlgKkL37jGXXl7qB7ZfwVTKxYHHxwYlRgsxHqiHskQQIgpKLSLNBOom
        pLLNGnYqOYZ/gMUOZQXnU7gTU62TnzP3qZ8f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CklDFopkkseKz/nG7n9ByC+bcHwlIfP4
        C/uWc4BvM2moxiSLtR66pnTjsQWWOnOJtCwTjWEvaIW4qh7d2JcvkMA7iae47UCf
        0Bssvedr8L0TJTOv+IWDy2ghlH5065QLBdU8dO2uWleyn+dEmM5CYHJdJeH2tGLd
        bQNUxeXw81Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7051752512;
        Thu, 12 Mar 2020 20:10:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1D9E52511;
        Thu, 12 Mar 2020 20:10:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
        <20200312170714.180996-1-jonathantanmy@google.com>
        <20200312175151.GB120942@google.com>
        <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
Date:   Thu, 12 Mar 2020 17:10:14 -0700
In-Reply-To: <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
        (Christian Couder's message of "Thu, 12 Mar 2020 22:54:29 +0100")
Message-ID: <xmqqblp1dsih.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0384B972-64BF-11EA-AAFE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> My opinion has always been that "extensions.partialClone = <remote>"
> is a mistake as it is inherently making difficult to have many
> promisor remotes.

Is there a reason why extensions.partialClone cannot be
multi-valued, just like say "remote.origin.fetch" is?
