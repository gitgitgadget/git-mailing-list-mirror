Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE45EC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF16020740
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EeNdZxRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCTA2R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 20:28:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63397 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgCTA2R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 20:28:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C4AFACAA6;
        Thu, 19 Mar 2020 20:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C+s902/8kjpogRPx/5goD/EJdjA=; b=EeNdZx
        RCcdfPDaSp/uPI/5knzn5GAWmHQpxDL4ZD+IBgwmt0tFAqMTpro+FjwEPfP13TVZ
        JEZp1G/isrXN35EVBptIDDGaUipOmogKCOH9e5/FvYRnsP1mATl6SlkBjaCwbhGm
        AOdVRq18Xpr7YhkaorbEiRbHg/DWr4E3wuB+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GAzhJQ34AaUktcyqtmgfttdiObTZ6DdL
        uXI8f+d08UhIy2dtAqc8kvrh/7UdJ6moCyeW2WDSgA6if4BZbUXJ0UBY3zp8e/Iy
        4U9Blt6g1UIoPJW2BlXVrO/R8dfO/WovqHpaR3uwqBKD4BaCtbbCa/vTnK8GDFZ/
        Yzj2VPfDXf8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63FC8ACAA5;
        Thu, 19 Mar 2020 20:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AC6BCACAA1;
        Thu, 19 Mar 2020 20:28:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
References: <20200302230400.107428-1-emilyshaffer@google.com>
        <20200302230400.107428-3-emilyshaffer@google.com>
        <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet>
        <20200319213902.GB45325@google.com>
Date:   Thu, 19 Mar 2020 17:28:11 -0700
In-Reply-To: <20200319213902.GB45325@google.com> (Emily Shaffer's message of
        "Thu, 19 Mar 2020 14:39:02 -0700")
Message-ID: <xmqqd097dg4k.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEDAA980-6A41-11EA-B33C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Builtin:
> + Don't have to call out-of-process to identify 'git version --build-options'
> + Better assurance that we aren't shipping a broken bugreport alongside a new
>   version
> - Binary bloat, possible startup time hit
> ? Libraries will behave identically to where the user is seeing issues
>   (This point is a possible pro but also a possible con; see similar point in
>   standalone list)

 - Makes it hard to pull in libraries that "bugreport" alone will
   want to use in the future without negatively impacting the rest
   of Git.

>  - Time to editor for 'git bugreport' with the same setup as previous

This is something we absolutely should totally ignore.  Even if the
bulitin version takes 1 sec to spawn an editor while a standalone
one took only 0.1 sec, if other criteria you listed that are more
important favours the builtin solution, we should pick it.

In any case, I think we've wasted enough time on this.  Let's see a
minimum working version that won't break/affect the rest of Git and
ship it standalone.

Thanks.
