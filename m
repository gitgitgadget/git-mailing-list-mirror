Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9302C678DC
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 22:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355740AbjHQWht (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 18:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355906AbjHQWhf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 18:37:35 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68C03C0A
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 15:37:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 63C123788A;
        Thu, 17 Aug 2023 18:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VbtWl8oiM4sKdqajgnU6JQya0yMTFu7zemLPEm
        AQlnw=; b=u8Cua4vj2BJHuSmvlvbXRVRRso1/1sQAWwf1UfkApz12Vu8Q8dSsAL
        Xlqx4mSq81pj610fp7mf6+nSm9+C55hj+hhY+bZ45MLfI3vhfJ7YmcdnlpcPhKMp
        5O5LBTm5pWPDbvjfgiNbr4FuvQdh/G7JgVPP4gYmyof+8o9AUT7ZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DA4E37889;
        Thu, 17 Aug 2023 18:37:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 961CA37888;
        Thu, 17 Aug 2023 18:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/5] fix interactions with "-w" and "--exit-code"
References: <xmqqttsxbfyw.fsf@gitster.g>
        <20230817222949.3835424-1-gitster@pobox.com>
Date:   Thu, 17 Aug 2023 15:37:20 -0700
In-Reply-To: <20230817222949.3835424-1-gitster@pobox.com> (Junio C. Hamano's
        message of "Thu, 17 Aug 2023 15:29:44 -0700")
Message-ID: <xmqqpm3lz467.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A13345B0-3D4E-11EE-9032-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The first patch is not part of the main theme, but because I'll be
> adding the first use of "--dirstat" to t4015 that has been leak
> sanitizer clean, and the "--dirstat" codepath has known leaks, I am
> plugging the leaks as a preliminary step to avoid having to mark
> t4015 as leak sanitizer unclean again.

I completely forgot that I already have done 1e1dcb2a (Merge branch
'jc/dirstat-plug-leaks', 2023-05-15) in Git 2.41 timeframe.  I was
basing my work on Git 2.38 maintenance track and needed [1/5] but in
newer codebase it is not needed.
