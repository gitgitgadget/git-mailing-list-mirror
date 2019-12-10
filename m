Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2C5C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF8207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 14:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX1LUeie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfLJOUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:20:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36646 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJOUI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 09:20:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id a203so6403395qkc.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 06:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=au5f5Q1OyNHmUm79WmPwTI8yZSD3ETvjveBI9TaKIWI=;
        b=KX1LUeieCUpVC8deN5DLW/z02PAfndK+5ew1UF26P8d6LGhQDEDgAuHxKXrNMt2ZN8
         B8MpyPaGx71tEnNFqHnvDOFMC9JyM1fWr61JXOc+6yt1vgONgcYLdU9TVVPEkdO65FgT
         mToW8HmDc/kAx6ysf22bwQhDA87wTuR4UOZZhgfExf2/VZaYtLKpnzQBxDGTPJDNgXSb
         b7qTBzVyucEz/Ku9JRwU532tr9ZL4CblV3ljS/9FWW/HdwyQxx7O3/pq2c245c+ADFNF
         FNabwZAn9JLIUydK75FOi+ZALcr2qsDrk15MXCpkCDqz2qYKC8MJn5lZZ3vS3PjWtBHa
         P1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=au5f5Q1OyNHmUm79WmPwTI8yZSD3ETvjveBI9TaKIWI=;
        b=FyS0NAoYhuvC50k+FjlVkVpmTqjw0ls4cs1D/ysnpOx+erQoytYCDHWW6BEUZrjDiB
         Z2wYe97NL1lDo47+f7PfFsdX+4cLf0xucPZ+47vU3hTw3fYx9kA5E6ssnFly30/rKH78
         V6vNq2t0IFW/2LObsU6gQHrRt5vuu2n+TJUoSOmG7ZNGr97PMUdTiWLa2v/8aGoIDI+b
         j46QCo0O/hOsfhBo0Cjk/ih9bdTsmLn9MVbbpcz+9jddqACMiC1LGJnqo5XYTMdIRdP/
         s4LOeletsLSSNKEnWEescE9e2abVApPiauphQMMDVlHsMW8V2qkjjHjLJs9WL27F7g4Z
         dxKA==
X-Gm-Message-State: APjAAAVIpSPDT+Vx0Ppr/W6Pa+zWYfrY/DAlPMc9Si/VPgNybpbhBGqt
        yYM+oVtV4WZpjOzpX9iqKjp+xM53C1I=
X-Google-Smtp-Source: APXvYqwY7JCBH2TA04fXAtLX0qg9590FQiLDHX+Dib9Mj+gnDS+nKF+ZLMsbgnP5RTgVgojyfo1Ysw==
X-Received: by 2002:a37:684a:: with SMTP id d71mr13213908qkc.201.1575987606922;
        Tue, 10 Dec 2019 06:20:06 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 68sm966329qkj.102.2019.12.10.06.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 06:20:06 -0800 (PST)
Subject: Re: [PATCH 00/13] git-p4: python3 compatibility
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
 <20191207010938.GA75094@generichostname>
 <CABvFv3+viMXJO0z5HAQbCya7MU9tWd7P_LxUhu66T74XGN99yA@mail.gmail.com>
 <b21d153a-02f9-b9a1-7388-59b5a882d4f2@gmail.com>
 <CABvFv3Jf9i06OmBqOC2zfS+7Sm88PRYa19_rB8rELtMoN2E8CQ@mail.gmail.com>
 <afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com>
 <ec301179-f9dc-4148-8634-2abc9263af5f@gmail.com>
 <nycvar.QRO.7.76.6.1912092043470.31080@tvgsbejvaqbjf.bet>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <caa4b235-8ec8-0b6f-49e5-3c95e3a5f5e3@gmail.com>
Date:   Tue, 10 Dec 2019 09:20:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1912092043470.31080@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/9/2019 2:48 PM, Johannes Schindelin wrote:
> Hi Ben,
>
> On Mon, 9 Dec 2019, Ben Keene wrote:
>
>> So, I just attempted to run a base case on windows: git p4 clone //depot and
>> I'm getting an error:
>>
>> Depot paths must start with "//": /depot
> You started this in a Bash, right?
No, I started it from a windows command cmd.exe prompt.  (I almost never 
use the bash prompt)
>
> The Git Bash has the very specific problem that many of Git's shell
> scripts assume that forward slashes are directory separators, not
> backslashes, and that absolute paths start with a single forward slash. In
> other words, they expect Unix paths.
>
> But we're on Windows! So the MSYS2 runtime (which is the POSIX emulation
> layer derived from Cygwin which allows us to build and run Bash on
> Windows) "translates" between the paths. For example, if you pass `/depot`
> as a parameter to a Git command, the MSYS2 runtime notices that `git.exe`
> is not an MSYS2 program (i.e. it does not understand pseudo-Unix paths),
> and translates the path to `C:/Program Files/Git/depot`.
That is good to know!
>
> However, your call has _two_ slashes, right? That is unfortunately MSYS2's
> trick to say "oh BTW keep the slash, this is not a Unix path".
>
> To avoid this, just set `MSYS_NO_PATHCONV`, like so:

When I first installed git, I didn't read the release notes. (Shame on 
me!) and I installed
python for windows and added an alias for git-p4.py against the windows 
version of
python, so when I run git, it's not performing that conversion.

> 	MSYS_NO_PATHCONV=1 git p4 clone //depot
>
> This behavior is documented in our release notes, by the way:
> https://github.com/git-for-windows/build-extra/blob/master/ReleaseNotes.md#known-issues
>
> Ciao,
> Johannes


I'm starting to run out of time at work, so I'll be slow to try and 
repro this.

Thanks for the info!

- Ben

