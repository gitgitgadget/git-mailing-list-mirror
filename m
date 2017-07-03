Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41CD20209
	for <e@80x24.org>; Mon,  3 Jul 2017 07:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbdGCHB0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 03:01:26 -0400
Received: from mail.peralex.com ([41.164.8.44]:57461 "EHLO mail.peralex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752552AbdGCHBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 03:01:20 -0400
Received: from [192.168.1.188] (noel1.ct [192.168.1.188])
        by mail.peralex.com (Postfix) with ESMTPSA id 7FF1F336F5C;
        Mon,  3 Jul 2017 09:01:08 +0200 (SAST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=peralex.com;
        s=default; t=1499065268;
        bh=XFYOTC/KYZF7b/Ftzi8l4Ie9sNG+iEC2+AQ1vHPDwfo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H/8DhpGjuRxufzm2TWBsNpjo7/mzk2QoBoPHkoPUY5Ur+84C/F8NEEumFvMj0ePQz
         I4EOvLX+tVSKs64Xr/V19EOanr7Awhhgf9O1+uFm1g3XDbqqkrttDUAxeLD0gwBtGR
         V7EccWbQZdNASGaHemBeCs5FABhbVToN2Zod2ZOY=
Subject: Re: speeding up git pull from a busy gerrit instance over a slow
 link?
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <19ee7852-efcc-66d0-24ad-3462a4d5eaf6@peralex.com>
 <20170630145912.1047890d@twelve2.svl.corp.google.com>
From:   Noel Grandin <noel@peralex.com>
Message-ID: <e68b650f-7e16-6935-9867-f54e391b9eaf@peralex.com>
Date:   Mon, 3 Jul 2017 09:01:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170630145912.1047890d@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.peralex.com [0.0.0.0]); Mon, 03 Jul 2017 09:01:08 +0200 (SAST)
X-Scanned-By: MIMEDefang 2.78 on 41.164.8.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017/06/30 11:59 PM, Jonathan Tan wrote:
>
> Out of curiosity, what is the timestamp difference between the first and
> last GIT_TRACE_PACKET log message containing "refs/changes"?
>

Cut down log looks like:

08:37:17.734527 pkt-line.c:80           packet:        fetch< baeb5486c43d39b063371f91cfaae8efc2c8700b 
refs/changes/00/1000/1
... 3 minutes ..
08:40:10.983005 pkt-line.c:80           packet:        fetch< b0dd80238089dfcc0b3bf7bed99564adce649397 
refs/changes/99/6799/2
08:40:10.983054 pkt-line.c:80           packet:        fetch< 5c5dd57b54e3107b3069dc8f82df74df63d13555 
refs/heads/distro/collabora/cp-4.0
..
08:40:11.134355 pkt-line.c:80           packet:        fetch< f8c345808ceafe87be6207e5ae304a9fa6c4cd16 refs/heads/master
08:40:11.134404 pkt-line.c:80           packet:        fetch< 3cacadc5c9e6a0780a4c75cd3614eddc8db8e933 
refs/remotes/origin/HEAD
...
08:40:11.173013 pkt-line.c:80           packet:        fetch< 6c1b76c38f0fc469a2cbf41ffacde4d76df11ead 
refs/remotes/origin/origin/feature/submodules
08:40:11.173025 pkt-line.c:80           packet:        fetch< a7d2fe68fd1db70f16a827f828dc541954f9d0f2 refs/tags/COOL_1.0
...
08:40:11.814181 pkt-line.c:80           packet:        fetch< 9125509a7c6e65336330b8ac42a293aa77b18ee3 
refs/tags/windows_build_successful_2011_11_08^{}
...
08:40:12.724809 pkt-line.c:80           packet:     sideband< 0000


Disclaimer: http://www.peralex.com/disclaimer.html


