Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0838211B4
	for <e@80x24.org>; Tue, 15 Jan 2019 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbfAOPnd convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 15 Jan 2019 10:43:33 -0500
Received: from derailer.org ([23.253.20.95]:43192 "EHLO mail.derailer.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbfAOPnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 10:43:33 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 10:43:33 EST
Received: from [192.168.0.235] (unknown [97.112.38.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.derailer.org (Postfix) with ESMTPSA id 55428E025A;
        Tue, 15 Jan 2019 15:35:53 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [Bug report] Git incorrectly selects language in macos
From:   Nate Weaver <wevah@derailer.org>
In-Reply-To: <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
Date:   Tue, 15 Jan 2019 09:35:52 -0600
Cc:     primenico@gmail.com, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <BF7AD597-5C05-4A7A-8DB6-0FEA2F95AF72@derailer.org>
References: <CAKd-JgStGb4Ka9Rs6G2e4ADQKZVrsJMsNGz1sRP_4Ej4=FtxtA@mail.gmail.com>
 <CAKd-JgS3omKbN+OzQL2dUun6Seg9CjDNk8KEj9m83xdTZE=7FA@mail.gmail.com>
 <CAPig+cQWW9kibWYKu5oRDgo_Pt4wVmzkqzbTG=YGvwqRCXcNXw@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Sep 16, 2018, at 02:15:33, Eric Sunshine <sunshine@sunshineco.com> wrote:
> 
> On Fri, Sep 14, 2018 at 10:20 PM Niko Dzhus <primenico@gmail.com> wrote:
>> Looks like the issue appeared after updating git from brew.
>> 
>> A quick search revealed that brew changed how it builds git recently.
>> I think, it just didn't include i18n by default before, so I never
>> noticed this.
>> 
>> Anybody here familiar enough with the build process and dependencies
>> of git to pinpoint what exactly is causing this and how to fix it?...
> 
> This problem is not specific to Git. Earlier in the thread, Ævar
> asked[1] if the problem also occurs with other command-line programs,
> and indeed it does. For instance, I tried with 'wget' installed via
> brew, and it exhibits the same odd behavior. Ævar suggested that there
> might be some magic special-casing English, which makes me wonder if
> brew builds such magic into gettext(?) or if the magic is part of
> MacOS itself.
> 
> [1]: https://public-inbox.org/git/87a7ojlp31.fsf@evledraar.gmail.com/

I discovered that moving/renaming /usr/local/share/locale made this
issue go away for me. While 'de' and 'fr' have a git.mo file in their
LC_MESSAGES subdirectory, there is no 'en' directory.

If I copy the 'fr' version to a newly-created 'en' directory, then all my
git output is in French; my language order in System Preferences is
English (US) -> German -> Japanese.

Not sure if this is gettext's or macOS's issue.

--Nate Weaver (Wevah)
