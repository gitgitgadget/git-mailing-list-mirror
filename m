Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B69C4332D
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB64920739
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNqtY7aC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgCTQ1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:27:23 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52641 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCTQ1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Mar 2020 12:27:22 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so2700299pjb.2
        for <git@vger.kernel.org>; Fri, 20 Mar 2020 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XEt6ZCCT/SabS8d93PGLUqSy3GNs9qaZ+PAN0iF+0rQ=;
        b=bNqtY7aCEGx1pr+vECTvlcl4flxo4Yacw2vkqlyWOWFMXxuE+yliN6Vi878Yc7XdCk
         jSoImc4ujg8weKvHnC0RRqbcnuI+kLQ+wZRoyj6DFVbUICswwMZg/6xjp2Idk8CNO6hR
         fCKLEWMmf3W2laqVqrtwuK1zmXQGNwq0qfXkVPKnSkL2uime4JVbQkGa4+Gjkjk3FW6Y
         CZb3WT+bTnOET9zKE3H0GOUw9ICJxdTvrtLuf6G5SJhEoPY2YW4Js1KoAU3rlxrg4OCu
         T22kvsxgAboBT/GjWZZzWIYDPunMAXfbB5KLt8RRXQZnt1zuaax7EEdHgZebkXAIUUF4
         51KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XEt6ZCCT/SabS8d93PGLUqSy3GNs9qaZ+PAN0iF+0rQ=;
        b=YhvwSoNjQCWCx+MOZcFXJDa4YF5w/MNZkqfA8NsCJPPSaxLAP4/EnzVC78dkmFrmbc
         4rtshc0KoT/4cIC9OBDKAtbddDd3HDUi2MEmsym5um6/gtMTpAVgd3+EBdw6U6jtQJG6
         WMU+Jc/COHczy63s/nyQkochwi1ewrU9H00KpEGeA1cS8AW5yDxW4C+9kOQls/ePOrEI
         RS0R0GVIwoNXeIeDiRa65jTEhh3a+Qy4VYX9pUBeONVFSnXcDYA3LOAIeUHkz3jWKOsY
         M+Ufr2wZ7FA7xGI6WK1PQLXYvOwLj90utYc2AK4O4Be5dPbR7oAbmQ8xIeReTz28zNYa
         tyCA==
X-Gm-Message-State: ANhLgQ0BqzrhnLP4OFR+GGBYz2e3A2WdpFch2CkH3b87+GMaYokXnZ90
        zzCDxBG7bhi6MyQPyYXBde2QjWIhORA=
X-Google-Smtp-Source: ADFU+vvA2hhXsLuV9sXDmi8FTPLZX8HA7+zKMEqL4GPBmBe51+PUjOzyAIwU4imYeK3gwdf+YwIhvQ==
X-Received: by 2002:a17:90b:19c3:: with SMTP id nm3mr10686010pjb.149.1584721639715;
        Fri, 20 Mar 2020 09:27:19 -0700 (PDT)
Received: from [192.168.2.6] ([43.247.159.138])
        by smtp.gmail.com with ESMTPSA id 184sm5571510pgb.52.2020.03.20.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2020 09:27:19 -0700 (PDT)
Subject: Re: [GSoC] Query regarding Microproject
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <CAGNOEmugZDWpvAHsOzmm_Fqo_Vj5GcC--GfTg3JHPm701HjBXA@mail.gmail.com>
 <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
From:   Shanthanu <shanthanu.s.rai9@gmail.com>
Message-ID: <47a1db25-914a-2e59-c0a6-6d0ff77bc2aa@gmail.com>
Date:   Fri, 20 Mar 2020 21:57:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD2bgzvc2K2Sj4HSeXo16kB8D8se=+=Y7gp6FN+4Y3C1BQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, I had faced some issues while running tests with the below command:
sh t9116-git-svn-log.sh

I ran the test without making any changes to the file.

To get more verbose output for the reason of failure, I ran:
sh t9116-git-svn-log.sh -v -i -d (-i to figure out why the first test fails)

In the verbose output, I got the below error msg:

Couldn't open a repository: Unable to connect to a repository at URL
'file:///{hidden}/git/t/trash%20directory.t9116-git-svn-log/svnrepo':
Unable to open an ra_local session to URL: Unable to open repository
'file:///{hidden}/git/t/trash%20directory.t9116-git-svn-log/svnrepo':
Expected FS format between '1' and '6'; found format '7' at
{hidden}/git/perl/build/lib/Git/SVN.pm line 310.

I can share the entire verbose output if needed.

On 20/03/20 7:11 pm, Christian Couder wrote:
> Hi,
>
> On Fri, Mar 20, 2020 at 7:39 AM Shanthanu Rai
> <shanthanu.s.rai9@gmail.com> wrote:
>> Hi, I am a 3rd Computer Science Undergrad at National Institute of
>> Technology Surathkal, India. I wish to apply to git for GSoC.
>>
>> I am currently working on the microproject titled "Avoid pipes in git
>> related commands in test scripts". I found 't/t9116-git-svn-log.sh' to
>> have some commands wherein output of git is redirected to grep (using
>> pipe). So shall I go ahead and make the required changes, i.e., redirect
>> the output of git to a file and grep this file, in the relevant commands?
> Yeah, sure.
>
> In 't/t9116-git-svn-log.sh' it seems to me that some refactoring might
> be needed too.
>
> Best,
> Christian.
