Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01B5C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C67F222D9
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 20:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VFustWsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBGU71 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 15:59:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63050 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgBGU71 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 15:59:27 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 39F78A8F06;
        Fri,  7 Feb 2020 15:59:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=35BU8WGwzktwFh/BTUCbCCVa7Lg=; b=VFustW
        su2YpPQRpufDeqXoeKIXTtFLlUc3uTBqgaxU0VjMcU4+wVEhPYXRSwU36LefsyJZ
        s6/4h0sQTyxeND6qIdeIzOt2OvqAyIrpr73tKl/FxXLzs71vOgBRhUnLW+Xy1Zgs
        GBVwmViVHtptCOI6dV36uydNWRXT0wZ0P47R8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bVl6q+ss631J0Ao/g5UggiLEoQspiiXI
        m0lGYLEEg7rlBTBq2R5IgMtpgt5qGhXYCpnT9BHd5uF/F1JZxKjaoSZxQvQMh6Qy
        215S+2mIata9gkY8N8x/8zKiUKBTeou5kZFhkKxTD6Td/rNRPB1yexBVMQf2cUvq
        Va2Kt/iK7MU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 326F3A8F05;
        Fri,  7 Feb 2020 15:59:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 649BFA8F01;
        Fri,  7 Feb 2020 15:59:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Masaya Suzuki <masayasuzuki@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3] doc: describe Git bundle format
References: <20200131221800.240352-1-masayasuzuki@google.com>
        <20200207204225.123764-1-masayasuzuki@google.com>
        <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
Date:   Fri, 07 Feb 2020 12:59:20 -0800
In-Reply-To: <CAJB1erXMR_aCqVPsH6WQZdC7yybOBCUbwkJDv3LtU2f0ymNmbQ@mail.gmail.com>
        (Masaya Suzuki's message of "Fri, 7 Feb 2020 12:44:12 -0800")
Message-ID: <xmqqlfpe2jx3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B747B916-49EC-11EA-BA99-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Masaya Suzuki <masayasuzuki@google.com> writes:

> On Fri, Feb 7, 2020 at 12:42 PM Masaya Suzuki <masayasuzuki@google.com> wrote:
>> +=== Note on the shallow clone and a Git bundle
>> +
>> +Note that the prerequisites does not represent a shallow-clone boundary. The
>
> the prerequisites do not

Grammo aside, I am not sure if that particular Note is beneficial to
begin with.  I would imagine that you can get a bundle that holds
all the objects in a shallow repository by specifying the range that
match the shallow-clone boundary when you run "git bundle create"
while disabling thin-pack generation.

The support of shallow-clone by Git may be incomplete and it may not
be easy to form such a range, and "git bundle create" command may
not have a knob to disable thin-pack generation, but that does not
mean that the bundle *format* cannot be used to represent the
shallow boundary.

