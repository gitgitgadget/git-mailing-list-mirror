Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B93020954
	for <e@80x24.org>; Fri, 24 Nov 2017 06:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbdKXGin (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 01:38:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50930 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751643AbdKXGim (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 01:38:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8E72B7330;
        Fri, 24 Nov 2017 01:38:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqxXBF86xkmBvGE0l/FzYFhBaKk=; b=V2Hl9m
        dP6NPqmHZktQu3CDimxbRZZ1giCv69xX8N5w3Ax/37t4DuTk1K8nv6uQ1cXaPVni
        FCFISTUR/MvtK7e2XsT9vnSOQRasynw82/qk8oKHGAry2o8LBhRtBrZdm5Z96eTl
        GyBzY+47LbhRNPMCyWqWVng82W1TegooHNY3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jIZmXR931LQXf18/0y/WDe3RcG77nxvt
        ZsTzXTQVm9E6vfriZOWRgRGkiEQ9Jw6CwItKduAouRTIqE0FgbKcXUruwVABHfR8
        1yYeHuBBOZfAiamBnQJDwHw5CwYEn/zIEt+trjqId61DMj/ThCWaDZtZ6UGoKICE
        Ks6Fd/r3Pm8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0FE8B732E;
        Fri, 24 Nov 2017 01:38:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3DE4AB732D;
        Fri, 24 Nov 2017 01:38:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user input
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
        <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
        <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
        <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com>
        <xmqqvai5ollx.fsf@gitster.mtv.corp.google.com>
        <998E3A52-C710-447A-82A3-50C58354CC31@gmail.com>
Date:   Fri, 24 Nov 2017 15:38:40 +0900
In-Reply-To: <998E3A52-C710-447A-82A3-50C58354CC31@gmail.com> (Lars
        Schneider's message of "Wed, 22 Nov 2017 17:55:29 +0100")
Message-ID: <xmqqk1ygnpu7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C41FF74-D0E2-11E7-8052-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> Of course it is possible, if you really wanted to.  The code knows
>> if it gave the "we launched and waiting for you" notice, so it can
>> maintain not just one (i.e. "how I close the notice?") but another
>> one (i.e. "how I do so upon an error?") and use it in the error
>> codepath.
>
> I think a newline makes sense. I'll look into this for v3.

As this is an error codepath, I am OK to waste one more line with a
line break after the "we launched and are waiting..." message, but
with a shorter "we are waiting..." message, I do not know if it is
bad enough to have these two on the same line, so I am on the fence.
