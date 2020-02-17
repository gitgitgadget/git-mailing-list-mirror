Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB5C7619B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 07:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C69206D5
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 07:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q6d0HlMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgBQHig (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:38:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48178 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgBQHig (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 02:38:36 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01H7cXQI084709;
        Mon, 17 Feb 2020 01:38:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581925113;
        bh=uvoPPLOkVNhhkIM/xGGrKYIl4ITBelqq4CEFN/U4jGY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Q6d0HlMyWfEfliFQDFsNNxbbgCdhx8q3G3i/AileNqlDhjJhWuI69xXC85Vxv2pfh
         c6AWlzj4SCWmM8KCAW1UDDtWMF+T6SDj+v0Vl83Ag2YE+7LzyRPEiKCl8/Ckgfj6d1
         A41VRcRH9im++NhLfG83oWooINrlIJw9Ti9OOrqg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01H7cXec032362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Feb 2020 01:38:33 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 17
 Feb 2020 01:38:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 17 Feb 2020 01:38:33 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01H7cWV4114881;
        Mon, 17 Feb 2020 01:38:32 -0600
Date:   Mon, 17 Feb 2020 13:08:31 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Elijah Newren <newren@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2020, #03; Wed, 12)
Message-ID: <20200217073829.m3njrrczdbaosynx@ti.com>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
 <CABPp-BEdrFnSqPnK6FsRqpyP7qZALg_K8JDkdqxnhwkD4yFdzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABPp-BEdrFnSqPnK6FsRqpyP7qZALg_K8JDkdqxnhwkD4yFdzA@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/02/20 08:42PM, Elijah Newren wrote:
> On Wed, Feb 12, 2020 at 2:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Here are the topics that have been cooking.  Commits prefixed with
> > '-' are only in 'pu' (proposed updates) while commits prefixed with
> > '+' are in 'next'.  The ones marked with '.' do not appear in any of
> > the integration branches, but I am still holding onto them.
> >
> > The fourth batch of topics are now in 'master'.
> 
> Somewhat of a tangent, but is there any plan to update tinyurl.com/gitCal?

Heh, so I'm not the only person who noticed ;-)

-- 
Regards,
Pratyush Yadav
