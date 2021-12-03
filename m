Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5025C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383433AbhLCWoE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359632AbhLCWoD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:44:03 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC42C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 14:40:39 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kl8so4201532qvb.3
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 14:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cvQGWdJTCLkFiWeTamxFHpNT3AmHjoBKbHo+vWlMEk=;
        b=n5N+MjdGxCh+x3AX4Tpi52crhK5DFa5VRBHoS9K9R0W0Z7XCNcHVHA/MdigBL9HasJ
         xGh/+PNNXYW2teMDGwc3kai/T25gkP35atPMAH4FnYWK2BmviZlFn832mCcrac0T7fTS
         /aDqMi5HTJnUCD/SpcKBGzIX1ZlePPxuYVe2K6zzdfEZTuh+tMkunXoJo9Rp9G5Pqit6
         gJpfsdSQx+eycNusl1sF0wiIfh1mX14Ba2s8ZqTQiKE9p3/K0Hm9VX3GxK0e8ygIXeJL
         0aOn54EobSt80z0gcUOHf1jGFsGTsKs1b7edxt0qP6PpZIfMBecHIZmOBY8NMfp0Q64l
         7KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cvQGWdJTCLkFiWeTamxFHpNT3AmHjoBKbHo+vWlMEk=;
        b=jSNp/4j7Rez2Q2qF2kzdcwiPO8XLQUCKw9G7O9IEkYNU5pf/S8hm5/M+RirbLmHAGk
         bCzihmqz3lywYk31ySoeZlmiy4YatsMMyVR2gHWWEQnLmSfnGHJdoZBU4DYZyuvLxGW0
         TDi61SwX+K7gErwtstKTHQHmFb4xVhExdLbUOVLzCgyjfyCbJxmyp1FqcvH/WCbkM/Ja
         xmVCK3wJCd0YnlA9FyAZ5PD9uKs8S/X5drrXqnKSX7iYxJszCTBLbYo4E0k0e3+3XIdj
         fiGqXQRDK6eNbbVCMFNn5dR+Vhn43sfOJevw8RLAqdac0ngFM2L2NotVteh5xck37Y/C
         WZug==
X-Gm-Message-State: AOAM533mqy/VfsTxCijYkaBESpELY8D2EcIkEd50JJYtSZlurIxQCjyu
        8PImAA3WJI3OaJoFFMzuVJVERkFxKFg=
X-Google-Smtp-Source: ABdhPJyscgnan9NgDHLKCVwvfxjqkQ2Ww3n5AarpAJvyqVETi+YOa5ySyojfQ/jAYibmQGIb85LoZQ==
X-Received: by 2002:a05:6214:20a1:: with SMTP id 1mr21888836qvd.29.1638571238495;
        Fri, 03 Dec 2021 14:40:38 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id a10sm2773486qkc.92.2021.12.03.14.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 14:40:38 -0800 (PST)
Subject: Re: t7900 failures when $HOME is symlinked
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <4cf14040-c8e1-0f75-0ec4-fd8cf6bed0a5@gmail.com>
 <xmqq1r2tty13.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <837581db-b3d7-2a73-9a61-7c40f77f264b@gmail.com>
Date:   Fri, 3 Dec 2021 17:40:37 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq1r2tty13.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2021-12-03 à 12:10, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> Hi Stolee,
>>
>> I noticed two failures, t7900.32 and t7900.36, on a system where
>> $HOME is symlinked, i.e.
>>
>>      $ cd $HOME && pwd
>>      /home/me
>>      $ pwd -P
>>      /some/other/path/me
>>
>> These two tests use 'pfx = $(cd $HOME && pwd)', so $pfx is '/home/me',
>> but the actual path that gets written by Git is canonicalized, i.e.
>> '/some/other/path/me'. I think a simple fix would be to use 'pwd -P'
>> instead, which fixes it for me.
> 
> Curious.  Your personal HOME shouldn't have much to do with the
> tests, but obviously it can indirectly affect the outcome because it
> affects where you place your repository.

Indeed, the source code was cloned somewhere in my HOME.

> HOME during tests is set in t/test-lib.sh, based on where
> TRASH_DIRECTORY is, and the latter is often derived from
> TEST_OUTPUT_DIRECTORY (unless --root is given), which comes from
> TEST_DIRECTORY and it is set like so:
> 
>      # Test the binaries we have just built.  The tests are kept in
>      # t/ subdirectory and are run in 'trash directory' subdirectory.
>      if test -z "$TEST_DIRECTORY"
>      then
>              # We allow tests to override this, in case they want to run tests
>              # outside of t/, e.g. for running tests on the test library
>              # itself.
>              TEST_DIRECTORY=$(pwd)
>      else
>              # ensure that TEST_DIRECTORY is an absolute path so that it
>              # is valid even if the current working directory is changed
>              TEST_DIRECTORY=$(cd "$TEST_DIRECTORY" && pwd) || exit 1
>      fi
>      if test -z "$TEST_OUTPUT_DIRECTORY"
>      then
>              # Similarly, override this to store the test-results subdir
>              # elsewhere
>              TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
>      fi
>      GIT_BUILD_DIR="$TEST_DIRECTORY"/..
> 
> If you want to do $(pwd -P) somewhere, isn't it that one you want to
> change to avoid similar problems in any code, including the ones
> that are not yet written, that uses $(pwd)?

Indeed, that works and it looks like a more robust fix.

Thanks,

Philippe.
