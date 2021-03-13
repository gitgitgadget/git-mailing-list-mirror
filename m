Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4809FC433E0
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C5664EC6
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 23:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhCMXek (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 18:34:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50133 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbhCMXe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 18:34:29 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61DFD113997;
        Sat, 13 Mar 2021 18:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IqVWsJiC+9jOB0nswZha6ZFCsZo=; b=T7Fb2+
        Gh7LSLrz241QrGX097S2blOA2fajNzr6I3Q4l0NwII/Vpge/tOwkWf9PA1mUkYYb
        JutJcEkEKmcQGP+FTTANd9CZQQP+guRW77Z17N/UBjFvCFP3iFzkxX558NA4gYAM
        nYUNPDuVXyLKhj9w01q41X+xgwsYyAMdziNfE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wDyghSLJoOh2OS9KqDqnXdax/NDm64eK
        Fh1/Tht+e0/pMtb3NRxWOtR4S1bYiD0SguILT4X7kapAMrYHzrkC9nNIuazXDHlY
        k9ys+srepaa9oOVuR15flCTyMXTG8Yb7E8fZL7HuKbrebB3nEGEBmA1VFtu4qnuZ
        1l1xKP+VN4c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 593C3113996;
        Sat, 13 Mar 2021 18:34:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99FCC113994;
        Sat, 13 Mar 2021 18:34:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Seth House <seth@eseth.com>,
        Dana Dahlstrom <dahlstrom@google.com>
Subject: Re: [PATCH 2/2] doc: describe mergetool configuration in
 git-mergetool(1)
References: <20210130054655.48237-1-seth@eseth.com>
        <20210209200712.156540-1-seth@eseth.com>
        <20210209200712.156540-2-seth@eseth.com> <YEbdj27CmjNKSWf4@google.com>
        <xmqqmtvbjuvl.fsf@gitster.g> <xmqqzgzafo5o.fsf@gitster.g>
        <xmqqlfas55mk.fsf@gitster.g> <YEv5d0pGvEVpepoY@google.com>
        <xmqqh7lg54h4.fsf@gitster.g> <YEx5hM/HWby3FBJv@google.com>
        <YEx6ve6AbqacVTQH@google.com>
Date:   Sat, 13 Mar 2021 15:34:24 -0800
In-Reply-To: <YEx6ve6AbqacVTQH@google.com> (Jonathan Nieder's message of "Sat,
        13 Mar 2021 00:41:33 -0800")
Message-ID: <xmqqsg4y4ohr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A6436DC4-8454-11EB-AB12-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:
> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index 6b14702e784..e587c7763a7 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -99,6 +99,10 @@ success of the resolution after the custom tool has exited.
>  	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
>  	use `-O/dev/null`.
>  
> +CONFIGURATION
> +-------------
> +include::config/mergetool.txt[]
> +

It is a nice touch.  We don't have much explanation other than the
description below ...

mergetool.hideResolved::
	During a merge Git will automatically resolve as many conflicts as
	possible and write the 'MERGED' file containing conflict markers around
	any conflicts that it cannot resolve; 'LOCAL' and 'REMOTE' normally
	represent the versions of the file from before Git's conflict
	resolution. This flag causes 'LOCAL' and 'REMOTE' to be overwriten so
	that only the unresolved conflicts are presented to the merge tool. Can
	be configured per-tool via the `mergetool.<tool>.hideResolved`
	configuration variable. Defaults to `false`.

... which appears in the included file on the feature.

Thanks.
