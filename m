From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/4] submodule: add more tests for recursive submodule behavior
Date: Thu, 24 Mar 2016 17:33:42 -0700
Message-ID: <CAGZ79ka9eRbqCEhE3FXpg+i6XJ03azaHYzUeJnOZGHZf_dJH=Q@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-5-git-send-email-sbeller@google.com>
	<CAPig+cS8NSDb=apvtLHQL-Ph=RB0CTashhZMnQ3DkcLfnzB9ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 01:33:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFhH-0004na-I4
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbcCYAdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:33:44 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:33389 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbcCYAdn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:33:43 -0400
Received: by mail-io0-f179.google.com with SMTP id c63so103469254iof.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 17:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=1E4ZxH6DbRhH8tnC1f53YADbYSZUFS++huHFN2nJ3AI=;
        b=Yx6Wc8UBfn5zUiUya/L6iV/R+JJtek1nobSqBJiFvSOI4wOY1zAqeUWNAKi8lOVVrL
         xasxOOMOnNEMzMvZZP0zsejRwL1tkRW3ZFy+uvTnv55SXz174fu3M3l/R5GwItEKMzG+
         /mSQRF5sKF7yZCMSCAq2ehAPhpmNJ8ZgpqPpY9fDjw3XW5KrlMae9NQSMVeO5iz5D1YM
         TQPiYGncH773sDU86MLdFv4W11eLmNBCpW0ntTWgc+fyYoZlAAkKf9LjrgI0iQ9sDj2G
         N00XjfO8b5tIhnafUyMU1/RNlX2BJ9p3YRxl48NsRgOq7Jn/e1NGK2TAMwDseOs+IO2Z
         3Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=1E4ZxH6DbRhH8tnC1f53YADbYSZUFS++huHFN2nJ3AI=;
        b=ZvdCnpiEE2LazHHOT07ZOz3x9yuGK6MRXwSzL4OQh7Us5JizeORcyNSXzCzue+IO7T
         ys3xYoiNPr/UeLZb1RCJpqtrrjU+IlEEmTu+XxobvwG8speiQtC9HrVoDKC8UeMitHg5
         69jZzjy1LFzE4U0PizWw5MtfY9OT2Ds2O0af5SgpcnhHen0LdjVwrX55fBTuIw+8o/pt
         +BW8CoXTifsR3ZbLfCuWV4xQ17lFhbaDNVwUleUFprUiihKTHNkR1tcbbdyqrkagapd7
         LsOrRQ7et+XPuXR8kMQinICcJMefWFChzG3pZ2gwvUnczMDdVguyvrN8R/p35I7t+KfD
         cn7Q==
X-Gm-Message-State: AD7BkJIqAkNxzbIjptsbIW0+2HRxtNkbdgN65D4b/p9VFasPNdm724kTtgZkm4tHDG7b+l5ui/NbX1jEpCuOtSsJ
X-Received: by 10.107.135.96 with SMTP id j93mr11735498iod.96.1458866022506;
 Thu, 24 Mar 2016 17:33:42 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Thu, 24 Mar 2016 17:33:42 -0700 (PDT)
In-Reply-To: <CAPig+cS8NSDb=apvtLHQL-Ph=RB0CTashhZMnQ3DkcLfnzB9ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289835>

On Thu, Mar 24, 2016 at 5:25 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Mar 24, 2016 at 7:34 PM, Stefan Beller <sbeller@google.com> wrote:
>> This adds a test for "submodule update", wich calls "submodule update"
>
> s/wich/which/
>
>> from an untracked repository in the superproject. When doing creating
>
> Grammo: "doing creating"
>
>> the parent patch a similar test failed for "submodule sync", but
>> all tests passed for "submodule update". It took me a long time
>> to figure out this was a difference in test coverage instead of
>> commands behaving differently. Let's improve the test coverage such
>> to make it a better place.
>>
>> When trying to fix the issue in the parent patch I could get
>> the test suite passing when removing the $@ argument from module_list
>> in the sync command. This also indicates a low test coverage, so
>> fix that.
>
> These two paragraphs are almost entirely commentary, thus probably
> belong below the "---" line. I'm having a difficult time trying to
> decipher from this commit message what this patch is actually about.
> Perhaps the commit message could do a better job explaining exactly
> what shortcoming(s) it's addressing.

The tests on submodule commands executed not from the top level are very sparse.
I had a hard time to developing patches 1 and 2.
And I felt

    "This patch adds more test coverage."

is not a sufficient commit message.

The current tests have found issues, which
lead to fixing them in patch 1,2, but I think only by accident, as one command
(sync) was testing from the non root. By having more test coverage it
is easier to
have a guess what is wrong with the code.

Any hint on how to write that into a commit message without being commentatory
would be great!

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
>> @@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
>> +test_expect_success 'submodule update --recursive works from subdirectory' '
>> +       (cd super2 &&
>> +        (cd deeper/submodule/subsubmodule &&
>> +         git checkout HEAD^
>> +        ) &&
>
> Maybe use -C and drop the sub-subshell:
>
>     git -C deeper/submodule/subsubmodule checkout HEAD^

ok

>
>> +        mkdir untracked &&
>> +        cd untracked &&
>> +        git submodule update --recursive >actual &&
>> +        test_i18ngrep "Submodule path .../deeper/submodule/subsubmodule.: checked out" actual
>> +       )
>> +'
