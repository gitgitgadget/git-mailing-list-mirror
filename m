Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1130AC433EF
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 09:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0FCF60F6D
	for <git@archiver.kernel.org>; Sat,  9 Oct 2021 09:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbhJIJOT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Oct 2021 05:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhJIJOS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Oct 2021 05:14:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72687C061570
        for <git@vger.kernel.org>; Sat,  9 Oct 2021 02:12:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c4so7728154pls.6
        for <git@vger.kernel.org>; Sat, 09 Oct 2021 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=bdA6/9IKDJ8nelT2VtvwCo8bP562z6ARYeBaSkab3YU=;
        b=LQgWIWa+tMsW9vMrxJRzUq5CJutFZsWKikAaYt6YGn/9YdJxNs5mz9WQvAYR28HxOY
         voUYWJgxgBaxS8XaEZSXz/RSXr/s/0uLR8WuDsHwim9treR4zQCBi6I1DWVFkX3hs19B
         4Pba+15win0zc3KWO/p0WH8L5za62uUF3ZDAs7kZ3N7bQenLQlNrfPQS8FyZH2N7G+a3
         y8eYrhN5VlNItcOFONjXEQJqjy2AHYyKzhQRVrisNvi3lG8qbGBFe5f4/ej/oUse6pIA
         mzfma6ibpgCfwsXlJNwYCMfehZOi3O3lC/m+ojPUaLYD2abhfuvnSTDxnmr/arB5zZj0
         WZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bdA6/9IKDJ8nelT2VtvwCo8bP562z6ARYeBaSkab3YU=;
        b=hpQEO0LogE2hnJ9kFqr+a64n3zFsZNjKNGdv60Ah6RNY9YT1yUCUke+EVUUZ2QV3rX
         57Ay2DUhednHfevDq9U7rlUAJMLhvyFqxzb4/quWRYrIWzyBdzcBZwTzO/npkjaeRQdw
         aEkHBCiMDL7p7nNFmlSllx0oe919mqLXvT3e8P1ScRaHydcKRpb2kRdLHhaT+Dx2zav/
         Lhzt7i1GZM5iKo0a7wCFOOWIogYfMuTNBDhsi+xAZ/Tu5AgHuQfC7cBGipxtLEIP6FId
         1kmBQxNgpjvdyXpbDKBVrF85GvnjxZCdgShVXppaPR9X7L4uR/a4zbmlrjq79yzdBXsR
         27dQ==
X-Gm-Message-State: AOAM532+IZqF06GGX9k6Xv52ZH2G5oVPu/V3RNyPotLZtPeY6V9P0nHc
        HTXMznHGWbwYqAXorVkWH2U=
X-Google-Smtp-Source: ABdhPJyjfQaaU6eQfV6LVkgBD0natMD9a9Fid+HnNv23VmgiqZzfR4KJ8ElPI9swM71VP+a7L0cWmw==
X-Received: by 2002:a17:903:31cd:b0:134:5b6f:2ff8 with SMTP id v13-20020a17090331cd00b001345b6f2ff8mr13696764ple.46.1633770741852;
        Sat, 09 Oct 2021 02:12:21 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-90.three.co.id. [180.214.232.90])
        by smtp.gmail.com with ESMTPSA id z11sm1607587pfk.204.2021.10.09.02.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 02:12:21 -0700 (PDT)
Message-ID: <ffe633c5-151a-8646-20ef-be4f50c5f59e@gmail.com>
Date:   Sat, 9 Oct 2021 16:12:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Some problems for git beginners
Content-Language: en-US
To:     ZhangJinbao <zhang709787793@icloud.com>, git@vger.kernel.org
References: <2EC9E24E-A8FD-4851-9F6A-F3D104465A23@icloud.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2EC9E24E-A8FD-4851-9F6A-F3D104465A23@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/10/21 14.43, ZhangJinbao wrote:

> Third, when a commit event occurs, the current blob file stores the full amount of data, while the previous version stores the incremental data
> 

When you `git commit`, Git will initially write objects related to the 
commit (blob, tree, and commit) as loose objects. Some point on the 
time, Git will repack many loose objects into one big packfile and write 
the corresponding pack index. Delta compression is applied when writing 
the packfile.

-- 
An old man doll... just what I always wanted! - Clara
