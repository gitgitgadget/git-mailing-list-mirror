Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5911F453
	for <e@80x24.org>; Thu, 14 Feb 2019 20:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406859AbfBNUdW (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 15:33:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37253 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387975AbfBNUdW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 15:33:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so7963250wrs.4
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 12:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SI/hJpUHCg4/WJ36dEFwUFaygs2IAPA6BMEmN4TNd8U=;
        b=pXww+pJuWN5xP02t/k89Qp2LeBVddAbbcBBgFePeWyZovLcMlDT153y/QXEY/b83xW
         mxW4MmK3kTtqsU+4iVwh7EwVptOkDJe+ye/At47CAFCNPvIgIVsu5uPiCjj593CIc2Ru
         YcO87Osn04GdEUA7E6un2XOZsEcWxVSjfcMGhQMG/Jch5e6ADmGPqdXsLfwSOuc0lNso
         /ksuN8K8JsbEVgfT6MQBxzbdRz8Z3XRiNXkY6BKfEggoKtkPDkrdgtqH+v+BidBVBC2d
         1t49Km+GTfBefAcETVKMEqJhP4RJclPEWlqJOzCSiV9v541BEwWpqCeHDYIkJznn8ahW
         +mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SI/hJpUHCg4/WJ36dEFwUFaygs2IAPA6BMEmN4TNd8U=;
        b=DzSn6Kn/z0uh0uadO0UX+v72lIs5WDcFPlICytKLMRXCBLDk+MIjLvzVuOJDTGeG/o
         jCsblMTtwEx9YNUUC/a2NCfdAKLTXYai4DfR75CgiJXsVZC9KOtB4O1o+V9eHOrtD8ev
         lMpcSUreRWKE/Q/VPE9Gc63zFWEu0kJCVY+MRumB0zg0Ssdf4jdwLKF5fm64LzCPyDlH
         r3ukhK2PP4vuUrUL7M41vlnYw5PLB8cT6Fwmh1rb9qS/iKP5Ta9XLstK0M6BLPpWG+H+
         BRMc9SLW55taKUjYg9pUQ0jUYCvs2furekl8Pm61sgowWEsdTaEQP0jdMw3QveKcJZ21
         JPWw==
X-Gm-Message-State: AHQUAuYSg89/EkrKTILvgQekUrevglqklJxovQOnmW8DGZoUcFjJcDi1
        Q7PFloR+fU/xD1DxriHS/e8=
X-Google-Smtp-Source: AHgI3IZ6z+HSiAzv+0pJOH614QBgUXSF85nCEdK+ahfRjq80vIpCTDvbtReVhSdbFdNZG7aT6UIEJA==
X-Received: by 2002:adf:91a7:: with SMTP id 36mr4014194wri.77.1550176400556;
        Thu, 14 Feb 2019 12:33:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v6sm3748210wro.57.2019.02.14.12.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:33:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        benpeart@microsoft.com, kewillf@microsoft.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] read-cache: add post-indexchanged hook
References: <20190208195115.12156-1-peartben@gmail.com>
        <20190214144241.11240-1-peartben@gmail.com>
        <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
Date:   Thu, 14 Feb 2019 12:33:19 -0800
In-Reply-To: <2f08ee3b-4511-2838-4c70-640d01fe1658@ramsayjones.plus.com>
        (Ramsay Jones's message of "Thu, 14 Feb 2019 16:28:09 +0000")
Message-ID: <xmqqa7iy860g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 14/02/2019 14:42, Ben Peart wrote:
>> From: Ben Peart <benpeart@microsoft.com>
>> 
>> Add a post-indexchanged hook that is invoked after the index is written in
>
> s/post-indexchanged/post-index-changed/

Good.  I wasn't paying close attention to the previous round, but is
that the only name-related bikeshedding?  I somehow feel that
without s/changed/change/ the name does not roll well on my tongue
and does not sit well together with existing ones like post-receive
(which is not post-received).  I dunno.

Will queue.  Thanks.

>> do_write_locked_index().
>> 
>> This hook is meant primarily for notification, and cannot affect
>> the outcome of git commands that trigger the index write.
>> 
>> The hook is passed a flag to indicate whether the working directory was
>> updated or not and a flag indicating if a skip-worktree bit could have
>> changed.  These flags enable the hook to optmize its response to the
>
> s/optmize/optimize/
>
> ATB,
> Ramsay Jones
