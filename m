Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D9FD203C1
	for <e@80x24.org>; Thu, 21 Jul 2016 01:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbcGUBk4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 21:40:56 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37142 "EHLO
	mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbcGUBky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 21:40:54 -0400
Received: by mail-it0-f41.google.com with SMTP id f6so4500924ith.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 18:40:54 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3iQ59vj9vZ/qa7TsPRJztwhv4cKK5476d8cnCioRkuo=;
        b=QMeilM8HzWB4G8OhZH4i5Sk3Ei00bWniXymZY5WUFb3mzaqXsrxYH37lpq1JtnKE2u
         mrhTRpBOa78dlZbYJxPZ8f7US2ZH6jnVFeivsv403h32J0sWx7H51Cvqt9AZzSzlLZVl
         7UFIyCCNFpM3QNy3Nrz6Xgnprez+xxBuM0r22x/yQE7Q/L8RjktPd5L999hVbhML0hdn
         0P65kVQOCPssqKB2HFYg5wfyrmkMcVF3+FeUbpVHNSdGsHOl+95FZhdjxt9jTPe3vSha
         MnrSayW0rLfXf/dOAvmfpaF58XM/kPv4KmMa7n4F2OX3liMe8AspcS9W2CzVLGUwOsfC
         jokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3iQ59vj9vZ/qa7TsPRJztwhv4cKK5476d8cnCioRkuo=;
        b=abdC4fNUx9KQqDEmxKGYcH5q9zT+VNyaUBhIn+2Hb4mVRw3cPcilNT/c+6gLXGj4Ci
         z7p3lqJcFU7053YV0g2hrb+zMAQ+O6yLVCEvsjhK5wG2qWAB6M/sbh4G45T0IKSBD5lp
         RFBBksFYj9CLhN7duIZqXf0jlGpdSd4wZvEyyrBDqGMo1fPgq+PWyElGmBTXyF9E4TLb
         SUrYVW+jNUVU5yvPnxyDBA+BWBAAylKLBtjAGi+6EHXvfJqw9LFNf2mEIxyxHS5t9pri
         lUX+rd1XG/MONNBA03w9KAH8ZtOREAMvM2LMRqVtqg9XYsU3JYaRjf3VcWx/ZOCpFYPv
         39xw==
X-Gm-Message-State: ALyK8tKRltu/WQop1V9ASW9mF9w/xizPeJahNGQrO1RXMpfOMINaZj1plAYZ1wdpKRMgygALK7fS/cN65/mfrX1k
X-Received: by 10.36.217.12 with SMTP id p12mr13329876itg.46.1469065253571;
 Wed, 20 Jul 2016 18:40:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 20 Jul 2016 18:40:53 -0700 (PDT)
In-Reply-To: <20160721010029.GG29326@google.com>
References: <20160721005122.15966-1-sbeller@google.com> <20160721010029.GG29326@google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 20 Jul 2016 18:40:53 -0700
Message-ID: <CAGZ79kYZphh7f6tf0a7=6gKf+=Vg1zO5MdCNypZ0vC8d3Fh7=A@mail.gmail.com>
Subject: Re: [PATCH] submodule: do no re-read name in shell script
To:	Jonathan Nieder <jrnieder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 20, 2016 at 6:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> -                     needs_cloning, ce->name);
>> +                     needs_cloning, sub->name, sub->path);
>
> Are there any restrictions on what characters a submodule name can
> contain?  Does this need e.g. to be quoted with sq_quote?

Oh good point, this ought to fail with weird names. So instead of quoting it,
let's just drop this patch.

>
> Thanks,
> Jonathan
