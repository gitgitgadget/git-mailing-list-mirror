Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677EDC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 12:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCUMdt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 08:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUMdr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 08:33:47 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2D7423B
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 05:33:46 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id ix20so15824523plb.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 05:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679402026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e65B2hGeGPWYscwgzd2yKeJqkNNxHSrbB7UbDFubPw0=;
        b=AEPmuSbWLTfgz3tHWAi2DAqrxcfArUuSXC3vTdcETn53kiGKsNH68byf8+gDgHWrJo
         U2Va/7SL8ah/4oHyP2iB5CDqaAboUYdM+Pmpd9wQdCYugrFlZq89icznSJAhb9jMbXn9
         v1kJTAE57tmeXtrbaI6QfjGd9KUeKQX/VIkVL6sYBqdq4nfP1geGEb0Rg5e0eUdDFbwY
         rMHySXUeAClSyGy8mlssrT5T381rAke8WTk1dpVlfPukiWlhVIMCGNI8NJRDkwv3/0HJ
         POrIgLUHgdq4kD3FRf0x6Pr/fPJZckVjLteI3vbd3RoHG7ZdPzQfPuldUgMykvccqQbH
         /1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679402026;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e65B2hGeGPWYscwgzd2yKeJqkNNxHSrbB7UbDFubPw0=;
        b=iYsWHcXvi15E/olRmSb6ucJ1ouytDliAFXv0Tc9+HDz9gkzen9h7fIBtppvJNERj+r
         vkITEnbiJ4iedacoxcuhWFaA9aONiVNxEP1OuLJo1mP248qhiY/rOBrE7/6VQFntjYch
         NA9ebQ+yXr6tLm+U8uU5jspiPbLZ6n0oIC1/uiheJN2lqE3uuVDW1qiLYGNI15aDgDRu
         WAND+a5AaqL54jVpX4tkkHfYmFzKQjuUo4IZoRVz3rCssOPLbjBcqnPoEj3W3aR0xmwo
         D54k5NMUtWTF1XGBBYi76wzD/ZdwZdqqU+an5Mr4bvyXbTgIXcNvSstPPPY922uycbi7
         x1ug==
X-Gm-Message-State: AO0yUKUWreHtchu2MaNGFWGzTebzdl3KQl45ptYlywrwQUhq+MmwZCS5
        e374CmWE67zly7N7nu51z5sSYHAqnvs=
X-Google-Smtp-Source: AK7set/oXpVD8eOknGfSbrFjzfJr6x/WBfFn2kYEZIGifFHjtnelxEr5hP9R1wEsmeeNwCyiwT41tg==
X-Received: by 2002:a17:902:da90:b0:19c:fd9e:f88c with SMTP id j16-20020a170902da9000b0019cfd9ef88cmr2592780plx.18.1679402025916;
        Tue, 21 Mar 2023 05:33:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b00194d14d8e54sm8622828plr.96.2023.03.21.05.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 05:33:45 -0700 (PDT)
Message-ID: <d228d2c7-ebd1-74b4-4b6c-f5ac037782d9@gmail.com>
Date:   Tue, 21 Mar 2023 19:33:42 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Suspected git grep regression in git 2.40.0
To:     Stephane Odul <stephane@clumio.com>, git@vger.kernel.org
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/23 15:04, Stephane Odul wrote:
> We have a CI pipeline on a private repository that started failing consistently while running `git grep -P` commands. The command fails with an exit code of -11 and is failing pretty consistently. With prior versions of git there is no issue whatsoever, but with 2.40.0 it always fails on the same call. Other git grep calls are fine, but that one is failing consistently.
> 
> I was not able to reproduce locally but my main machine is an M1 MacBook Pro, the CI pipeline runs under Kubernetes in AWS and the container is based on Ubuntu 20.04 with the git client installed via the PPA.
> 
> The error is for this pattern `git grep -cP '^\w+ = json.load'`.
> 
> As a  workaround we tried to download and install the microsoft-git v2.39.2 deb package since it allows us to downgrade, but then the git grep commands just got stuck.
> 

Can you do the bisection between v2.39.0..v2.40.0?

-- 
An old man doll... just what I always wanted! - Clara

