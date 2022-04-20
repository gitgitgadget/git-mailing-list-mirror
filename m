Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25FFC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 22:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383027AbiDTW5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 18:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiDTW5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 18:57:14 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394F72BB0D
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 15:54:27 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p3so1980359pfw.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:reply-to:from:in-reply-to:content-transfer-encoding;
        bh=dFkdbjnuJoa9ftiZUQc9NoP8FHSwrx22S3EuVSGakqM=;
        b=g1qQ2HB+IHsnOyl3dlJXO2+oPEfBWFRDCqZtX/6o3GYobJ4Bc7jwVgpzzsZ7VRePw1
         pNPvj2+ynHwDRrHnbjm/3l0DBuVW+LClDyOCMs3MMrZUh/3atKym7Qsx4VKmw9K1xki5
         QMdMR57frS8/rfP3CPeHAE+KrpDXHckQDBfC9h0UwIB3/HJrVb96uNEl4M2E8TOf+iEy
         /Y9buxxZM7xPIlxb6TyxF7vaYEhy5TqD4nTFBm7VPnamv/Oj4XyRcaoLNi86IDxLIxPk
         qxWW8gqEPe6HzvoJNTlDhmKcBp165VUC66bDZ6oaXCs7J3KVLXBKuE3H/YRjj6AhcW0s
         j6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:reply-to:from:in-reply-to
         :content-transfer-encoding;
        bh=dFkdbjnuJoa9ftiZUQc9NoP8FHSwrx22S3EuVSGakqM=;
        b=2wBDIAK4F76FdBSpNiINaEGegYyVhtXlqWKcZZR92vB7O7CXVSSSklDWImJEzpX0JX
         lDd8tRrUf7uGwKA1ThiPuGSP+UL+BZploVIr+wXtuec47zZA5tKntVLvGQQLegdB6Ol5
         01CB1v1O4suqEANbKuS6tKAG0age+lFwz1wOvAuB7vSF02DMcQuiJ423r1+Dzw1Nvaup
         HjHvZzpyyVym8AJDEsK3Afjr3sznAvcJt/0mxO/kfdXyUV8UU3p9e7VTkF6taHGlteJ2
         79Nq1eaULMTEOkW6ilOf9PM9nX1C6rVlHMfUQqUvJ9eYzyz6o20qkuBCtz5U68UX6CPD
         9O/A==
X-Gm-Message-State: AOAM533kBoFX4IhIaQRxgk/Z3f1/PVlvFy+u5Lw7N39Hqpbw40RYyNwz
        clEhtpU9F1tweMdaV0RNck3d/1R0sSEGiQ==
X-Google-Smtp-Source: ABdhPJyeGki99BcOBTHK65BtTq7kNrzMRkK8GtAdAFTWOM6rbodIJDi3nunSm8UP7XOVSDRV13HH6w==
X-Received: by 2002:a65:4848:0:b0:39c:c393:688c with SMTP id i8-20020a654848000000b0039cc393688cmr20746738pgs.376.1650495266686;
        Wed, 20 Apr 2022 15:54:26 -0700 (PDT)
Received: from ?IPV6:2001:4898:d8:33:c1ba:740d:4c92:5a89? ([2001:4898:80e8:38:41a5:740d:4c92:5a89])
        by smtp.gmail.com with ESMTPSA id bt21-20020a056a00439500b0050a4dfb7c44sm16895219pfb.155.2022.04.20.15.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 15:54:26 -0700 (PDT)
Message-ID: <04a50f96-363f-210f-b894-11945d0eb3e8@gmail.com>
Date:   Wed, 20 Apr 2022 15:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Git bug report - disk errors on Windows after push
Content-Language: en-US
To:     Attila Csosz <csosza@designsoftware.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <4026b85f-8cae-bcca-af14-e886e80725d4@designsoftware.com>
 <Yl2h5I0apzWhpVtr@camp.crustytoothpaste.net>
 <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
Reply-To: neerajsi@microsoft.com
From:   Neeraj Singh <nksingh85@gmail.com>
In-Reply-To: <fa40a6e6-dd83-9e88-e2f7-ab8aff2ca5a4@designsoftware.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2022 8:52 PM, Attila Csosz wrote:
> I've experienced the problem at least 3 different external disk.
> I'm not using cloud syncing service (e.g., Dropbox or OneDrive) for git.
> 
> Attila
> 
Hi Attila,
Could you please share a bit more information about the disks that are 
being corrupted and the specific error messages you're seeing?

What is the underlying storage type (e.g. USB key, external hard drive,
etc)?  Also, which filesystem is the drive formatted as?

Could you please save one instance of a volume in the corrupted state so 
that we can consider further investigations?

I believe the output of "fsutil fsinfo volumeinfo <drive letter>" and
"fsutil fsinfo drivetype <drive letter>" should give us some useful info 
about the volume that's being corrupted.

Thanks,
Neeraj Singh,
Windows FileSystem Dev
