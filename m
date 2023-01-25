Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D44C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 21:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjAYVN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjAYVNY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 16:13:24 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DCB5B59D
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 13:12:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v13so94328eda.11
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 13:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a+i40GZrFzSUTxS20DJWKfwS1ZO/XKHo5Q72IwbR1tg=;
        b=JOZlaIHLiyEuCm9SW35+WGdOXZybMFlkJ57RgUN88GHr0TllMid7/XGdA8MGc9nYIU
         enRZ7eDjE5Gbk6Qqq9AnRlHFw91AVDMmjaKnyZMTBKAbYe7NY5yvtHri30gKtcxUxU1d
         7fGtZ20XKN4yhAKclJphgZoe3NAnS/Cq62LETqCa8cxxoEb1kYAVrTzhHarQkO9MaGZu
         PLfTWLRYe9edU3U6TpwNQGvdN0LOx3g5WMoTzMjzCzAGF4im7q9MeeLuo+rqV1NACT+Q
         vRg3/Xabx9vFceDwXNjspfVZLZkAy6nVzAt0DcHaCA56CFoan/8Gu58btc5/1U5yhMYs
         aRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+i40GZrFzSUTxS20DJWKfwS1ZO/XKHo5Q72IwbR1tg=;
        b=RUnkMhQOTczSY/8HIZ+v38lQKGqurcyP0wcPlthn6ukxW7cdmV3ygqhn882A2mwTxt
         I7cg/JLMy2gmDdJ8vS52np1UNrkKxGsaWMN8jeL9uXHfHA6ERJibZu1aUj+Ia4l9b8wE
         aceCwB5zfy91Xve7G/C3dHfPeBJwYzEWexS3dX8lPmebbm7Q/Tjjk/nMG9EDRqhLBE5I
         nxNGMBLyk0xw5dG6n0cmxSW/75NwVNFPAN5TLh+Fy8R9Q0ncztBLofnVq8DqHZUOZTBa
         ipHsO1vvk8SyPAM9a1T+xyX/72ZcichFt//euOcBNCWJYT6n5DFzdWnGT7/LjS6FslmR
         NOYA==
X-Gm-Message-State: AO0yUKX1H4cO64p7o7+xltKCQKe9UrL+2od/53yoTxayQI9xuW+6NhYd
        XYTlK+RR5zHedZ/3goPDhBeQmUo8dxgnJg==
X-Google-Smtp-Source: AMrXdXtTFhSbIDETeSbXMMGeolt1pu2R5FgdJRT0BeO8UQDhvUV59XygHfyw0xr9UfwUZ3uBrTZ0DQ==
X-Received: by 2002:a05:6402:f04:b0:480:cbe7:9ee2 with SMTP id i4-20020a0564020f0400b00480cbe79ee2mr47634723eda.22.1674681167167;
        Wed, 25 Jan 2023 13:12:47 -0800 (PST)
Received: from localhost (62-165-236-34.pool.digikabel.hu. [62.165.236.34])
        by smtp.gmail.com with ESMTPSA id u20-20020a05640207d400b0045b4b67156fsm2833244edy.45.2023.01.25.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:12:46 -0800 (PST)
Date:   Wed, 25 Jan 2023 22:12:44 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhostetler@github.com>,
        edecosta@mathworks.com, git@vger.kernel.org
Subject: Re: [CI]: Is t7527 known to be flakey?
Message-ID: <20230125211244.GC2155@szeder.dev>
References: <xmqqtu0lzzn2.fsf@gitster.g>
 <20230121102355.GA2155@szeder.dev>
 <f7449e73-7f50-67ea-2be4-2037f98a69f3@jeffhostetler.com>
 <20230123181216.GB2155@szeder.dev>
 <7fa84280-db1d-8618-571a-ce0ac7a26135@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fa84280-db1d-8618-571a-ce0ac7a26135@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2023 at 02:02:40PM -0500, Jeff Hostetler wrote:
> Can you tell from your stess test whether the fsmonitor-daemon
> is crashing?  (It might be subtle since the daemon is auto-started
> if necessary, so it might be crashing and silently getting restarted
> by the next command.)
> 
> I ask because a SIGPIPE in the client would make me think that the
> server suddenly closed the connection unexpectedly, like if it had
> SIGSEGV'd or something.

Last time around I only looked at the failing test case, and didn't
notice anything that might have indicated the cause of the SIGPIPE.
This time I chanced to look a bit further up in the test log, and:

  expecting success of 7527.55 'Matrix[uc:true][fsm:true] move_directory_contents_deeper':
                  matrix_clean_up_repo &&
                  $fn &&
                  if test $uc = false && test $fsm = false
                  then
                          git status --porcelain=v1 >.git/expect.$fn
                  else
                          git status --porcelain=v1 >.git/actual.$fn &&
                          test_cmp .git/expect.$fn .git/actual.$fn
                  fi
  
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  + move_directory_contents_deeper
  + mkdir T1/_new_
  + mv T1/F1 T1/F2 T1/T2 T1/_new_
  + test true = false
  + git status --porcelain=v1
  error: read error: Connection reset by peer
  error: could not read IPC response
  + test_cmp .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
  + test 2 -ne 2
  + eval diff -u "$@"
  + diff -u .git/expect.move_directory_contents_deeper .git/actual.move_directory_contents_deeper
  ok 55 - Matrix[uc:true][fsm:true] move_directory_contents_deeper
  
  expecting success of 7527.56 'Matrix[uc:true][fsm:true] move_directory_up':
                  matrix_clean_up_repo &&
                  $fn &&
                  if test $uc = false && test $fsm = false
                  then
                          git status --porcelain=v1 >.git/expect.$fn
                  else
                          git status --porcelain=v1 >.git/actual.$fn &&
                          test_cmp .git/expect.$fn .git/actual.$fn
                  fi
  
  + matrix_clean_up_repo
  + git reset --hard HEAD
  HEAD is now at 1d1edcb initial
  + git clean -fd
  Removing T1/_new_/
  + move_directory_up
  + mv T1/T2/T3 T1
  + test true = false
  + git status --porcelain=v1
  error: last command exited with $?=141
  not ok 56 - Matrix[uc:true][fsm:true] move_directory_up

Notice that "error: read error: Connection reset by peer" in the
previous, still successful test case!  I ran it a couple of times, and
saw the same error message in the still successful '42 -
Matrix[uc:false][fsm:true] move_directory_contents_deeper' followed by
a SIGPIPE caused failure in the next test case.  And now that I knew
what to look for, I noticed this error message in the very first test
failure I reported the other day, which didn't fail because of
SIGPIPE, and in that case the error message was printed in the failed
test case.

And there were a few cases that failed because of SIGPIPE but there
were no error messages at all.

I can't say what caused these errors, but I doubt that anything
segfaulted, because segfaults are logged in syslog, and I haven't
found any such syslog entries coinciding with stress testing.


