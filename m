Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D1F207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031176AbdDTW2G (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:28:06 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36176 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S947984AbdDTW2F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:28:05 -0400
Received: by mail-io0-f180.google.com with SMTP id o22so98772042iod.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6+Un64w2AT7KnkRQFbrrLXuc3Cv2IKcOKbljRgcRIUE=;
        b=Mhh9+94PqXQjG933CRRQ0/HbbZ2EFbc1SdvduDtEvbhZ4jYKqNwjnuXnMhNF17nQLR
         7d+jeCRsRIg68LOFn1nV0Zye4YSvrG3doN+q+NJcRGjW7rQNxRJLjiq/kHxeRYz+1x3y
         lAF5RvV0/5bPwZdMzuTXjoYuiwHvlvo9uuYww80AQWRJzWutlO3ow+5ZgHOewDwqMaqB
         U9CH0M/y5K0MjgTOJhiBYrEyH5ToWkfWL3Ekz3YVavS+yIxqAXoeMRHcLFnJQN5lDB0/
         +cBB+H9eg5sy1PZW6cJ2U81Bf19E1EwNobpa5ajVKeJzunjmlK13v5/gpttKByzuzjr4
         x2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6+Un64w2AT7KnkRQFbrrLXuc3Cv2IKcOKbljRgcRIUE=;
        b=bEaa0ek89skPqw9nI9X9cR3RuDP/XLgq4Lph35VNy6bCVpi+I7Hb6dZ/j8Q0puuLXB
         HIr1KAiIBNtwewD4bYkRFvZ+HlDCRZJF+qO8A8PJbWH7AuabcL3LEUrnvGGFZM61AQsk
         k509drNleZL8ojKsdX9KMHlobSmRgEv4Gh9TWY5BrXaJPC25LqfGrAK6xrHy0cCZwsvB
         fFUnRkDbOT/Ovd0K2Y771XamcKI1qKXWSA/xXYqpYiJeNBgNBUcuvSyxPd2KKTcsiCmB
         gDl+t0KKVNlW5xTUKEHinKhyqBxjixLB2D8iJtRdQjiFZsm8CA7IO+67tQcTxzHlTILc
         H6Ew==
X-Gm-Message-State: AN3rC/4johW5wsQXAzwxlU0KmrOPkWtz66rAuT1aNysPopJepszM31c8
        gh5vrCfmDSuOFIcAnkyO+a4hPkwFydeZSgn4Dw==
X-Received: by 10.99.107.198 with SMTP id g189mr9333193pgc.162.1492727284078;
 Thu, 20 Apr 2017 15:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Thu, 20 Apr 2017 15:28:03 -0700 (PDT)
In-Reply-To: <20170420221255.GI142567@google.com>
References: <20170411194616.4963-1-sbeller@google.com> <20170411194616.4963-3-sbeller@google.com>
 <20170420221255.GI142567@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Apr 2017 15:28:03 -0700
Message-ID: <CAGZ79kYug=5vggaU9qruKK=N7efrMm7B98xjn-hNgghZUzsAiQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clone: remember references for submodules even when
 not recursing
To:     Brandon Williams <bmwill@google.com>
Cc:     Maxime Viargues <maxime.viargues@serato.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 3:12 PM, Brandon Williams <bmwill@google.com> wrote:
> On 04/11, Stefan Beller wrote:
>> The commit 31224cbdc7 (clone: recursive and reference option triggers
>> submodule alternates, 2016-08-17) argued for any further `submodule update`
>> to respect the initial setup. This is not the case if you only pass
>> '--reference[-if-able]' to the initial clone without instructing to
>> recurse into submodules.
>>
>> If there are submodules however the user is likely to later run
>> a 'submodule update --init' to obtain the submodules. In this case we
>> also want to have the references available.
>>
>
> So the idea is to keep the references around even if the user doesn't
> want to recurse immediately?

Yes. This patch is a bug fix response for
https://public-inbox.org/git/35343b75-0aa7-3477-888b-3af5024ae7dd@serato.com/

Note that this breaks the test suite
t7407-submodule-foreach.sh
  15: test "update --recursive" with a flag with spaces
because the reference is recorded but not all submodules can
be referenced; the nested submodules are not populated.

A couple of thoughts on that
* A test for "update --recursive" ought to live in a test other than
  t7407-submodule-foreach.sh (Maybe in t7406-submodule-update.sh?)
* The test checks for white space issues in path names and the breakage
  shows an unintentional side effect of --reference: it may error out in
  more cases (not all submodules populated -> error)
* Maybe "git submodule update" should learn the --reference-if-able
  flag, just like git-clone did, to improve the submodule situation?
  (I put it on my todo list)

Thanks,
Stefan
