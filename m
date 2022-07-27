Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D678EC19F21
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 09:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiG0J1W (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiG0J1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 05:27:14 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92473474FC
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:27:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id m10so12516753qvu.4
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=bvU0ARA9CJimav0F2TZHs8XnWjgn5vL3t4LEe8rimZc=;
        b=e52gMZtd7sZ3zsX/y7Z/JE18XykP5I/Go/IyyoNQOAvVP26bKVX6TWbnGmEj3loEW5
         coGz9a0pO9FFx0KaxhLRevJeV2UEPBF/Y0XPzBC8Rh/4+5SbuqIYrNzWs+exEDpRhpHn
         pshkCeiA2cqvwvMwD8k7cEgy85yP8YIdk/wkMflCvoSpz6U/gLtZiq4YR6Mtr2uGK9zq
         cPYfg+8hF9AA02PxVHRKzHsmNm3kCD/dnd4hRZtVkIiMQkjBvxypsd5t8Il354og7K5x
         pyVk3AsxRaHI5iEsQ7RbbqliOrjZmrH0MEdJM07HAbSDslvc4PTRsR2kaPHKfEUQo8at
         MPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=bvU0ARA9CJimav0F2TZHs8XnWjgn5vL3t4LEe8rimZc=;
        b=qxjXx+v3AH/dLx2IMXdsysD9r/XIXuELxBi7GshQHNfmhqDee3hDd1puWYUY4TsMLA
         ZswbRwWNyVfDJGQMDPP8L0biKeaIwDtlYsp8CpXFKbXcdYuqGS6v5dA1S3hPXS2NZphC
         AvGrhkdDsloNbKbPCIIOhiExdD3A6WA+f+VOXSkFN/GK5EpdMHSwb8sWjnU/tjg2fqZ5
         pyD+fe9OkVtPwHXp9shlzigCB6PSgB8ahTRJ2YeLYFhUR7bHX3lD2cjNhz8VGFQ7DAPW
         Pkku+tbi2YmQObfWqHDkPyizcl22HluFGJufgUmRin4iV/NhN6jxFZi1Ta6J4dj3ARsX
         8yKA==
X-Gm-Message-State: AJIora9SBj2VkbsdXC2qPGtSO34znJu+HMhxcRlHiQYo1r/XVNjel8bQ
        FVAAa+yM8phxdmxPrFOk3/lhP/JrEaI6+dJE
X-Google-Smtp-Source: AGRyM1vTE2nAN/ll9phNA9jSDQ5JA33YV2kiHzt+Ftl80fDuCuitROIo6TSSBvSvQG9TksfXeJVldw==
X-Received: by 2002:a05:6214:29e3:b0:473:7170:dafd with SMTP id jv3-20020a05621429e300b004737170dafdmr18479190qvb.38.1658914027435;
        Wed, 27 Jul 2022 02:27:07 -0700 (PDT)
Received: from [192.168.67.200] (dsl-10-133-182.b2b2c.ca. [72.10.133.182])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a12a800b006b5b7a8e6a2sm11759715qki.23.2022.07.27.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 02:27:07 -0700 (PDT)
Message-ID: <80dd46c5-f9ff-d2b3-2d7f-4b80e00494b8@gmail.com>
Date:   Wed, 27 Jul 2022 05:24:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
From:   Thomas Guyot <tguyot@gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
In-Reply-To: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-07-27 04:56, ZheNing Hu wrote:
> if there is a monorepo such as
> git@github.com:derrickstolee/sparse-checkout-example.git
>
> There are many files and directories:
>
> client/
>      android/
>      electron/
>      iOS/
> service/
>      common/
>      identity/
>      list/
>      photos/
> web/
>      browser/
>      editor/
>      friends/
> boostrap.sh
> LICENSE.md
> README.md
>
> Now we can use partial-clone + sparse-checkout to reduce
> the network overhead, and reduce disk storage space size, that's good.
>
> But I also need a ACL to control what directory or file people can fetch/push.
> e.g. I don't want a client fetch the code in "service" or "web".

Pushes can easily be blocked with a pre-receive or update hook on the 
server side. That covers the case where you want to prevenr users to 
update certain paths in the repo.
> Now if the user client use "git log -p" or "git sparse-checkout add service"...
> or other git command, git which will  download them by
> "git fetch --filter=blob:none --stdin <oid>" automatically.
>
> This means that the git client and server interact with git objects
> (and don't care about path) we cannot simply ban someone download
> a "path" on the server side.

Indeed - core devs can correct me if I'm wrong but afaik even in the 
case of sparse checkouts and partial clones the packs may include other 
objects. I have no ideas how git selects objects and packs on sent and 
when it decides to repack objects... What I know is it can pack entire 
repos in just a few files using delta compression and it would probably 
make sense to sent these pack if there is no real benefit in repacking 
just the requested objects.
> What should I do? You may recommend me to use submodule,
> but due to its complexity, I don't really want to use it :-(

Submodules is definitively an option for read ACLs, and considering git 
was not originally designed to hide information from a single store it's 
probably your only option. Moreover, if the git client is able to fetch 
directly blobs and trees (the later includes partial trees as a tree 
object is a single "directory" that can contain other blobs and trees), 
then even the server has no knowledge of where a tree hook into, or even 
how it's named. All that information would have to be mapped elsewhere.

To take your example above, the "common" subtree of "service/" could be 
in multiple top level directories (i,e, the same tree with same 
contents), and each top level dirs could have a different "common" 
subtree. So git would have to find where each tree object (one per 
directory) is accessible from for *each revision* before deciding if a 
client should be authorized to fetch an object, and the same would be 
required for blobs (and tree objects don't even know their own name, 
that comes from the reference in the parent tree or commit object for 
the top-level tree).

So even before solving the client/server protocol issue you mentioned, 
you can't just hide part of a repo in git right now and changing that is 
definitively not trivial.

--
Thomas
