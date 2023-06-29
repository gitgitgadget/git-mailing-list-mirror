Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD754EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjF2Ta7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjF2Tah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:30:37 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE95B4222
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:28:46 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 34476209AC;
        Thu, 29 Jun 2023 15:28:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TlEkCDdfz36oesL5+MZpUi4H2KPcYGLO2oQsm3
        urh3g=; b=RLIBIQhuhmEqKa0NW1RHSiLRCpM798/z5EkK8m/Lna4A4828dQJJn8
        JS7JeAw++WhJEZ5ojIpjNOQKzIHTqJPzqFSfrr4hRh4zHUD/kKhf5NdPabMiNFAz
        /Eo0Cix2lr62iWK16agLCPZtD5lDCdu4vVspvcy6SwJOAPtYhE80Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B94C209AB;
        Thu, 29 Jun 2023 15:28:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4F2AD209AA;
        Thu, 29 Jun 2023 15:28:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Vinayak Dev <vinayakdev.sci@gmail.com>, git@vger.kernel.org
Subject: Re: Documentation/MyFirstObjectWalk: add #include "trace.h" to use
 trace_printf()
References: <CADE8Naq5W3Bn=gwV7W-xMvYOMMRO=ZY9Ly6im4Rb_qFjMWTbTg@mail.gmail.com>
        <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
Date:   Thu, 29 Jun 2023 12:28:42 -0700
In-Reply-To: <CAJoAoZ=OEfsgkqsag926tH4GEuafX26A09SGZ1vR1uLh2W_4TA@mail.gmail.com>
        (Emily Shaffer's message of "Thu, 29 Jun 2023 09:33:49 -0700")
Message-ID: <xmqq1qhu9ifp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28BB8550-16B3-11EE-A783-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> Yeah, it's almost certainly stale in MyFirstObjectWalk - there was
> very recently a patch to clean up some headers which probably were
> implicitly including trace.h when I wrote this walkthrough.

We are lucky that we have folks like Vinayak who tried out the
examples and then bothered to spend time reporting the failure
discovered.  What does it take, however, for us to have a bit more
automated way to prevent such a breakage that comes from API
changes?  Is it feasible, for example, to add a test that extracts
code snippets from the MyFirstObjectWalk document and try to build
the result?  Alternatively, we can ship such a set of sample source
files somewhere in our tree (e.g. contrib/examples?) and have such
a test try to build using the current set of source files, but then
we need a mechansim to ensure that the sample source files will not
go out of sync with the document.

Thoughts?

Thanks.

