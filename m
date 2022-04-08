Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779B3C433EF
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiDHXe2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 8 Apr 2022 19:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiDHXe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 19:34:26 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D0E140BD
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 16:32:19 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 238NW8qA099124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Apr 2022 19:32:08 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        <jurgen_gjoncari@icloud.com>
Cc:     <git@vger.kernel.org>
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com> <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
In-Reply-To: <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
Subject: RE: Make commit messages optional
Date:   Fri, 8 Apr 2022 19:32:03 -0400
Organization: Nexbridge Inc.
Message-ID: <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ+1NMvkwKGNzc/71+8xIhD/VDquAGOScQnq40iUIA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 8, 2022 6:30 PM, brian m. carlson wrote:
>On 2022-04-08 at 03:35:04, jurgen_gjoncari@icloud.com wrote:
>> I think that often commit messages are unnecessary. I propose that by
>> default a user should be able to commit without a message.
>
>This topic comes up from time to time and you can see the previous discussion in
>the archives.  The reasons we haven't done this are roughly as follows.
>
>First, writing commit messages is a way of communicating to others about your
>changes, as well as to future you.  In my experience, it is substantially more
>important in software engineering to communicate clearly and effectively than it is
>to write code.  The computer will accept anything that runs, but when you write
>code others must read it and change it, and they must have the appropriate
>context behind those changes to evaluate your changes and to make their own in
>the future.
>We want to encourage good software engineering practices.
>
>Tools like git log use the commit message, and empty commit messages mean that
>viewing the list of commits is completely useless without viewing a diff.  This
>means that functionality such as `git log --graph` is just completely broken.  Writing
>even one line in the commit summary makes a massive difference in the usability
>of these tools.
>
>Users who want this behaviour can use --allow-empty-message or create an alias
>with that option.  The functionality already exists.  I use aliases extensively in my
>development and I know others do as well, so this shouldn't be an impediment if
>you're working on projects where this is acceptable.
>
>> I don't think this would be a problem from the UX point of view,
>> because a user could get a lot of information about a change, from the
>> history of the GitHub repository, such as from the time of change, and
>> seeing the diff.
>
>I certainly hope when you are writing code that you explain your changes
>somewhere.  I know some people who use pull requests prefer to do so in the pull
>request rather than the commit message, but I for one would never accept a
>change that doesn't contain some sort of explanation about why it's valuable or
>relevant somewhere.  I am, unfortunately, not omniscient, so I need people to
>communicate their intentions and decisions to me, and the best way to do that is
>with words.
>
>I should also point out that the GitHub UI is specifically designed to show the
>commit summary in the history view, so GitHub intends for you to write at least
>one line of helpful text (the summary) in this context.
>
>Overall, I don't believe your proposal is likely to gain traction here for the reasons I
>mentioned above, and I personally don't support it.

The commit message is an essential part of why a change was made, in particular for forensics when something goes wrong, or when you are trying to figure out why you did something. Without a commit message, you are saying, "yeah, ok, something happened." It's up there with reporting a bug saying, "It doesn't work", with no additional details - I have customers who do that, and it is not helpful. To be harsh about it, if someone commits something with no or a useless message, I will reject the change with impunity. Not explaining yourself is not helpful to those who come after. It's up there with "Why did you not document your code, when you used single letter variables and strung the whole program on one line because C (or APL) allows it," with an answer along the lines of "Any decent developer should be able to figure out the code." Sorry, but I feel very strongly on the subject that this is not a good idea. If you want to put junk in your commit, that is your business, but expect a significant segment of the population looking at your repo on GitHub to judge harshly. This sounds more like "I don't want to use a version control system, but I have to for some reason, like HR metrics." I know I am being harsh on this, and I apologize in advance for it if I offended anyone, but I would want a way to disable (potentially at build time) this if it ever went forward.

My $0.04
--Randall

