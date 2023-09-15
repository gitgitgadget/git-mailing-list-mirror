Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28441CD37A9
	for <git@archiver.kernel.org>; Fri, 15 Sep 2023 20:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbjIOUXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Sep 2023 16:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbjIOUXI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2023 16:23:08 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A7C268A
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 13:22:58 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CDCDB2DD66;
        Fri, 15 Sep 2023 16:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Mn+7d8fEScKohN2oFn+H5+8tB0PqCEXmnKzZjV
        s1x5s=; b=hnDGsunEVrfFhUbYzfTAxoaUKe2aKBt/+ODXD+GzhUDnAtpohV5TQl
        GCxjUa4w4n3SL8LQcj0TCVQlCcGuNpDqd5NAoZlFacaW8sf+5GjHDfleUj31MRlH
        2peUs+S0Ii+AyHASdTwMSUikyYVAp//27DBjqK5IUXEMPyUafc9fo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C71542DD65;
        Fri, 15 Sep 2023 16:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D70042DD64;
        Fri, 15 Sep 2023 16:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        nasamuffin@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [PATCH v3 6/6] git-std-lib: add test file to call git-std-lib.a
 functions
In-Reply-To: <20230915184321.1598611-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 15 Sep 2023 11:43:21 -0700")
References: <20230915184321.1598611-1-jonathantanmy@google.com>
Date:   Fri, 15 Sep 2023 13:22:50 -0700
Message-ID: <xmqqbke3dw4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A53E3A34-5405-11EE-8F8D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>> Add test file that directly or indirectly calls all functions defined in
>> git-std-lib.a object files to showcase that they do not reference
>> missing objects and that git-std-lib.a can stand on its own.
>> 
>> Certain functions that cause the program to exit or are already called
>> by other functions are commented out.
>> 
>> TODO: replace with unit tests
>> Signed-off-by: Calvin Wan <calvinwan@google.com>
>
> I think the TODO should go into the code, so that when we add a unit
> test that also deletes stdlib-test.c, we can see what's happening just
> from the diff. The TODO should also explain what stdlib-test.c is hoping
> to do, and why replacing it is OK. (Also, do we need to invoke all the
> functions? I thought that missing functions are checked at link time, or
> at the very latest, when the executable is run. No need to change this,
> though - invoking all the functions we can is fine.)
>  

Thanks for excellent reviews (not just against this 6/6 but others,
too).

