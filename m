Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BACC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 14:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344485AbiDZOw1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 10:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiDZOw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 10:52:26 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9440919
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 07:49:19 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-e93bbb54f9so6901118fac.12
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=n/HrI69XJPBkJKGrO9NdTuHFlLKWOItfHcx72mgVYB4=;
        b=GcV25GfAmB3Cmzr7cJjA4hQ3UcuTqw+D9FmmFkk65ZliQDc7oIzUAx1Rlywi1+kmux
         xcArj+ZGw/Q4c7K4PBO9wsh0FiA+5XWV+JuzIf0+p+AND3Ns3RWhJbUIkbvhs1LXjGFQ
         gc/OjgW5wtTdtGUxV2NkiCYW3t+jH/9JowKbzrYeJnC66vI0USJ1cYE0Fnk6ktn+lQCr
         6mbSLayXMgVyXH1JrG94tm6Y7ZAJvCYGAwwQa+GDApZXaMSR01e3cVt/2fUJbYl9BMaR
         a1fsV91ECMRaaDfnQSOvoTT/SVoqyzb+1zgYZJu3FZuUMA5zM5IuwzFHTP0sfnNp9IXk
         1DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n/HrI69XJPBkJKGrO9NdTuHFlLKWOItfHcx72mgVYB4=;
        b=4OTdtaS13vqYA9crkR553fLB699zYv55JiZ/aldVMn51e9bLSLKvjo+sNTsYUrPZh+
         QYpHiE+QCyxvtxD+/6n0MwXt3Q0UngnJy30Aow76IOmh1j2xTP4L8rGpjihVrZAjzKGD
         Suha/9zSdcOg57UUeYArBoHiSfkysH3b753Fm/8P4OcS9JBjHLkF13oCTxTkFN4u0tzS
         ovDRC1JKiBgtBV6s4uIq+69n/XWRLgz+jdousg47+hwca7gUbIv0hU/08p/sjspCDQGV
         ByGFIdMqEzUB9p6A5FdS1vdCc/FUJr9wFypSRb5Pyc/aCFui0cyGv5NdbhFKlQUGmimw
         CPyA==
X-Gm-Message-State: AOAM533QfgoIO/jCztyVDGZby7GIJxLqJlkRkftPx1IWAmigVWJsuH+4
        kmBBRbZlEyU81v7T4AJFjU7vP3CcVA8=
X-Google-Smtp-Source: ABdhPJyA2FGiCHZEfQ0TWBQJWEjKz1852qEcE2pPVkQvBTn2ATE+ACi3030S1e6+vq52X9Co9WnvNg==
X-Received: by 2002:a05:6870:d192:b0:de:691:81ad with SMTP id a18-20020a056870d19200b000de069181admr13781960oac.165.1650984557413;
        Tue, 26 Apr 2022 07:49:17 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id j5-20020a4a9445000000b00329dab1a07fsm5592546ooi.17.2022.04.26.07.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:49:17 -0700 (PDT)
Date:   Tue, 26 Apr 2022 07:49:14 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     "Elektronik (C.Gerhardt GmbH & Co. KG)" <elektronik@gerhardt.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "CRM (C.Gerhardt GmbH & Co. KG)" <crm@gerhardt.de>
Subject: Re: Error after update from 2.31.1 -> 2.36: Unable to negotiate with
 IP port X: no matching host key type found.
Message-ID: <20220426144914.nyaohjqqqlotxnnm@carlos-mbp.lan>
References: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR05MB6495349A4C42AA568A665D7BCCFB9@VI1PR05MB6495.eurprd05.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2022 at 02:05:14PM +0000, Elektronik (C.Gerhardt GmbH & Co. KG) wrote:
>  
> I found that after an update from git 2.31.1. to 2.36 the authentication to our git server (running gitea 1.13.1) fails. We are getting the following error: 

I am guessing the issue might be the one documented in the following git for
windows issue:

  https://github.com/git-for-windows/git/issues/3468

The problem is not with git (neither a git for windows) specific issue, but
with the underlying version of openssh that is used in your server and the
best course of option is to upgrade that and generate a new host key, but
there are other options shown in that ticket that might help in the meanwhile.

Carlo
