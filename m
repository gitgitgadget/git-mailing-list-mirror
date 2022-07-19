Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE8C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbiGSOcO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbiGSOcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:32:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A77713EBE
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 07:21:06 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r24so4470768qtx.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 07:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=l+KmQIQf55DG+d1QMp3DrxI3fQ7Uw6IlsHE6kNv1bNw=;
        b=Pmy8sYY8TQMoecQc167qYw8RY9DjtFp4VKgxkYObdaIp71IB51rObTsmtVIiLYR9Om
         UMPuVNC5HljF+8s7attqiaJGMqMnqp+tXUAzP0kLosNWf+fDtn6D8XXjVUyyACxQJ0DI
         YyBOwYXvgdUPVAd/kLbaPWcJeg3bOrfFdpfdYDJfpNFbnE7tCbDq1MtpJsOjwx+RqR9P
         pwIoU3WwYfNtigshGEP7sNviVlynLx0V1ZAK7cRTJ1f44sN8T8IcEz/XywS5iGs4bJmK
         4WzH7SbB9tDmD32K3ain+MvnJYjCf6nkY+0ZPibqY7eUIrukSRI/knnf0ql3Xncrskse
         5s3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l+KmQIQf55DG+d1QMp3DrxI3fQ7Uw6IlsHE6kNv1bNw=;
        b=0KYVSab2f+wiAaMlEkA1VoBEG1mbiVE6UCQG2zlaALMbfaWVnq/9LsGFFl7H08dIOk
         +6vdZC2hjdNvesTlVTAzEXyVR3EmAepf0o47fzFWyP+bCxsnUBYgf4ZZ2wm0e1ialwpl
         rSCTu9trpSegr9/w6eDRFvfHoSmY33GglUQTSXsu2zlbkTAY3whM6dU9tB2AJ8WGn+Se
         QJXa7+EfKau18vyQVcrEh9JtGULktq1qq/sBTB018JqSKEneJwa15HSlSFumVNBb+Il2
         xeczzbH+l6SanyxHxn8JkoeMGK2UhMM8lqKxyl1nZaSZMg01a4pluPl8ku+C2+tcLe1Q
         rhqQ==
X-Gm-Message-State: AJIora8PNtZQyOaOhzGnsNBcUMkEUYc7SHPZZENuBOl3PGYV5z6RIPeJ
        TouNZYCFvRwfxeaUAHoEhKY9
X-Google-Smtp-Source: AGRyM1u1npSRu10+mE9l2jmtAtrt6X2OyzmRbXtFkmcO3Ru4T67ncdJw/zyK47yCrV55qyV3pZnU+w==
X-Received: by 2002:ac8:7e92:0:b0:31e:f40e:55b9 with SMTP id w18-20020ac87e92000000b0031ef40e55b9mr6032244qtj.477.1658240465940;
        Tue, 19 Jul 2022 07:21:05 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3950:7a99:4a4a:8622? ([2600:1700:e72:80a0:3950:7a99:4a4a:8622])
        by smtp.gmail.com with ESMTPSA id o17-20020a05620a2a1100b006b5d6ab6a3bsm11047539qkp.76.2022.07.19.07.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:21:05 -0700 (PDT)
Message-ID: <0fe031b8-1eec-7407-4e5c-cae298ddeb8e@github.com>
Date:   Tue, 19 Jul 2022 10:21:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] Documentation: remove use of whitelist
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <19632a2d2459114484dcdaddd4db0d22dfd64fa7.1657852722.git.gitgitgadget@gmail.com>
 <220715.86sfn2zlkm.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220715.86sfn2zlkm.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/2022 6:47 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Jul 15 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
>> index fdc28c041c7..7a0539cb411 100644
>> --- a/Documentation/git-daemon.txt
>> +++ b/Documentation/git-daemon.txt
>> @@ -32,8 +32,8 @@ that service if it is enabled.
>>  It verifies that the directory has the magic file "git-daemon-export-ok", and
>>  it will refuse to export any Git directory that hasn't explicitly been marked
>>  for export this way (unless the `--export-all` parameter is specified). If you
>> -pass some directory paths as 'git daemon' arguments, you can further restrict
>> -the offers to a whitelist comprising of those.
>> +pass some directory paths as 'git daemon' arguments, the offers are limited to
>> +repositories within those directories.
>>  
>>  By default, only `upload-pack` service is enabled, which serves
>>  'git fetch-pack' and 'git ls-remote' clients, which are invoked
>> @@ -50,7 +50,7 @@ OPTIONS
>>  	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
>>  	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
>>  	'git daemon' will refuse to start when this option is enabled and no
>> -	whitelist is specified.
>> +	specific directories are specified.
> 
> Structurally this series should be changed so that like changes are
> coupled together, this would be much easier to review with the daemon.c
> changes in 3/3.

Sure. That makes sense. The point here is that git-daemon's documentation
and error messages currently make the word "whitelist" a critical point to
understanding how the feature works. Instead, we can explain it more
clearly using other language. Since this is the biggest place where such
important is placed on the word, then making the changes isolated to this
command makes sense.
 
> But that also shows that this change is needed, but really lacking
> compared to what we could do here, which is that both the the SYNOPSIS
> and the heading here should be, respectively:
> 
> 
>     [--strict-paths=<path>...]
> 
> And:
> 
>     --strict-paths=<path>...:
> 
> I.e. all we're trying to get across here is "this option has a mandatory
> argument", so let's just say something like that explicitly? I think in
> this case we don't need the prose at all, the synopsis + heading + error
> would be enough.

This example is misunderstanding that --strict-paths is a boolean
option and changes how the list of "undecorated" arguments at the end
is interpreted.

The point is that there is an optional list of directories given as
arguments, and the --strict-paths mode changes those directories to
not include recursive subdirectories as repo roots.
>>  	`protocol.allow` is set to `never`, and each of the listed
>>  	protocols has `protocol.<name>.allow` set to `always`
>>  	(overriding any existing configuration). In other words, any
>> -	protocol not mentioned will be disallowed (i.e., this is a
>> -	whitelist, not a blacklist). See the description of
>> +	protocol not mentioned will be disallowed. See the description of
>>  	`protocol.allow` in linkgit:git-config[1] for more details.
>>  
>>  `GIT_PROTOCOL_FROM_USER`::
> 
> I agree with Junio's earlier feedback about "in other words" being a
> telltale sign of prose that needs improving.
> 
> But the point of the previous prose (such as it was) was to elaborate on
> th existing "allow" to say "oh, allow means the same as whitelist",
> surely?
> 
> So I think we really could just delete this "in other words" entirely,
> i.e. it's basically saying "you are allowed to eat ice cream (in other
> words, you are not disallowed)", it's not adding anything anymore. The
> "(...)" can just be removed.

I guess I stopped at the first level of "in other words", that being the
"i.e." parenthetical. I didn't realize that this was already nested inside
an aside that was unnecessary.

Thanks,
-Stolee
