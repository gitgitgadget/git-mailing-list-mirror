Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72795C636D4
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 15:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjBCPS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 10:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjBCPSe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 10:18:34 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E07A42A5
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 07:15:51 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m2so5531691plg.4
        for <git@vger.kernel.org>; Fri, 03 Feb 2023 07:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CVFqXzx4JVUg+ct9yJDIKyb1B1dprrKLpb0+MJpHNPI=;
        b=kNn+9JQjDGdaFBcYcAqFJjzWkWIi1uGVsARNwsVpyJSO+2MD+AsUTw42vrxNgiyRkO
         oLhdHHWbRs5e8/jFWAnNh/KXsG0yoe3/mNfV26/b9uoklUzHSGzzIT6Nah/2HxA8NYuM
         lBjCRsXzvm8Lh/RldmlsOWdhMdN9r+UDxFanx6ZQ9raRdLn0678cbEBF/j/NZZ896zcz
         g6R1WulwUR0rIkofFpjCVdvQm17csXPSR3CF3/lUtcc+wiMP7TqZWq1Ycf9BfseCuiXF
         cUrW/Rx8cmgSCZSnpamS9H1lcx5sK31C/BgPh8rKvWYpgwJwRTmr/+DjclV/O+2yqv99
         zePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVFqXzx4JVUg+ct9yJDIKyb1B1dprrKLpb0+MJpHNPI=;
        b=Cz4kMr0GqGFuGcqFnyC3yKUaUEw51avKhnagcd17NP+NXg5hyg6Eu9V9My4exmBGcE
         WvyTAeJrItW4dT5/PUQ6AL9V3R4o5C5SIneYAWkU83wOwoSfn+ztl5i1XZr9EJhr0wu/
         toYtom0BclSaAdrmWSgJAMsnfQ/09AaMkg2oea6kxfrtGsyw2lcyPlwodNH++BTW+CgU
         qUohwurBNxgSjj+EwmibqWdKaTeY2BXnIWEk2BIcEBQX5bNKKG6ffEr5PsWNKDEwxvN1
         ANVbH9EDMiBshQwXyNKLHz1xaEU7Uxhkt3ihqfDMP7nrR3HV5J8/0n3K9fXIYEtDKBns
         M+Pg==
X-Gm-Message-State: AO0yUKW8CXBmf0oXJatB6Yy/Cb6DquDllP9fGTKG/5Jb7zIf1ZTrZt5V
        WX+Ib1ENZHPjEP8xYwFq9CrVSqFehfeQd7v+
X-Google-Smtp-Source: AK7set92p+Vt4q6VOK64jXfVyM1G93Wwd2mIpG2/7dRe/34U4EdquY3rQz5ThrGjnhZcnGTebe7gIQ==
X-Received: by 2002:a17:90b:1e50:b0:22b:e8bc:7f32 with SMTP id pi16-20020a17090b1e5000b0022be8bc7f32mr10935702pjb.49.1675437321970;
        Fri, 03 Feb 2023 07:15:21 -0800 (PST)
Received: from localhost ([2001:ee0:50c5:86d0:18bc:74ea:9b3c:e4dd])
        by smtp.gmail.com with ESMTPSA id t2-20020a17090a0d0200b002298e0641b6sm4982097pja.27.2023.02.03.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 07:15:21 -0800 (PST)
Date:   Fri, 3 Feb 2023 22:15:16 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Andry <andry@inbox.ru>
Cc:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
Subject: Re: Hash for a commit sourcetree beside to a commit hash
Message-ID: <Y90lBJ8b5nCUcLv2@danh.dev>
References: <1798489336.20230203042837@inbox.ru>
 <Y9xq5VAMjzUqTb6X@danh.dev>
 <563617028.20230203052145@inbox.ru>
 <22255406-42da-9ac3-4783-11a035877a3c@iee.email>
 <1309893232.20230203163720@inbox.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1309893232.20230203163720@inbox.ru>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-03 16:37:20+0300, Andry <andry@inbox.ru> wrote:
> Hello Philip,
> >> Nice, but I can not apply this over a git hub or a web interface without a clone.
> 
> PO> As a 'Distributed'-VCS, cloning the repository would be the de-facto
> PO> normal approach, otherwise you have re-invented centralised VCS ;-)
> 
> Cloning repository is a heavy operation by downloading everything
> instead of search a single commit.

You can limit the download with "git clone --filter=tree:0"
which only fetch the commit but not any tree or file contents.

-- 
Danh
