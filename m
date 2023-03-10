Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB575C6FD19
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjCJJ4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCJJ4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:56:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6FA10461E
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:56:31 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3047698wmo.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678442190;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nlJNLEa8V4MWBZF5hBIhpZFy0baXERUZXXPyTUdd9Vc=;
        b=esUk4Zlm0qQgK/NLZ5TeT3nCfPQQnVqMBy8fiiSwq5OWo/9XQ4/ff0SJW77jrfWww7
         hGep/iElikg/Qhm7p7o7szzQBdfVZGO5q+WbZjmJd0EUt59vN1qeszRTlBW2d/S2SQSp
         JlRkZpbB2/O8RE/WKP4/P4jtoPMHTMDjeMJNbaAXq522wLSkRuWZ7lerfR+uie9Ytbrr
         kA1SwGsNLnammmBJscwsCoJhgsysDayJwkBFAQIzgf32TAj2bT5144X3wqDJHr75TAXt
         3GYJYjf4U4xGLqf2D3BBsLmqNKXdYmOcru3wWQExMeFQ1YxAEyzLLKwuzTS3BAEA/oXM
         JG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678442190;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nlJNLEa8V4MWBZF5hBIhpZFy0baXERUZXXPyTUdd9Vc=;
        b=mM0aIx0PSdGkoQqoDW4LmLySjDFsdVfZvX6rLWbIBCXCN3KsvFzuEnVrxn/Dg2tK4s
         gaP4eg95Ar05glhmloen69OC67GlJ3PslzFBLLD0oY4l5lQw97xKGt5PWRxzsoRggo2d
         0tDSBO04VNichuS/S5EKY38F+km+BdRiWewCHA3vPB7BTD6lhdBRQD8+LL7GrgCpmLLK
         mr1FRpa2twHwm/W1xh+bYoYvmWt3uXugGFCrDKU3E+c8IK4Z+YIJFJlZCsVFYy6I7qT/
         HwyT6NVkeONMSW7OwARy+jtl6G4Xg4wsR9z1ZBpMGJTSW8KUQW1S4JYnHxH0udJ+eT+2
         ZTzg==
X-Gm-Message-State: AO0yUKXTmzAg3VOA9rmexbtF2TYFF25l34RX+QNEnJo7ggHelbzsF32p
        OBl0sHivIHUUB9nfX/oJXn1cZXaIbts=
X-Google-Smtp-Source: AK7set/z5qxf6Uid5oIIrbLM+I3Ig77H1RHWHinuXbG6uJQW7DJFDaDIUHNu2r4JlhRKE0VVrAGo+Q==
X-Received: by 2002:a05:600c:3ac9:b0:3eb:966f:5811 with SMTP id d9-20020a05600c3ac900b003eb966f5811mr2190786wms.3.1678442189893;
        Fri, 10 Mar 2023 01:56:29 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id s18-20020a05600c45d200b003e89e3284fasm2648293wmo.36.2023.03.10.01.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:56:29 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
Date:   Fri, 10 Mar 2023 09:56:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
In-Reply-To: <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 08/03/2023 19:02, Stefan Haller wrote:
> On 05.03.23 21:15, Phillip Wood wrote:
>> Hi Stefan
>>
>> On 05/03/2023 19:13, Stefan Haller wrote:
>>> On 05.03.23 17:59, Stefan Haller wrote:
>>>> On 05.03.23 15:31, Phillip Wood wrote:
>>>>> Hi Stefan
>>>>>
>>>>> On 02/03/2023 20:27, Stefan Haller wrote:
>>>>>> On 02.03.23 11:19, Phillip Wood wrote:
>>>>>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>>>>>> The reason why I am asking this is: I'm using lazygit, which, during
>>>>>>>> interactive rebases, shows a combined view of the real commits that
>>>>>>>> were
>>>>>>>> already applied, and the remaining commits that are yet to be
>>>>>>>> applied
>>>>>>>> (it gets these by parsing rebase-merge/git-rebase-todo);
>>>>>>>> something like
>>>>>>>> this, when I set the 2nd commit to "edit":
>>>>>>>>
>>>>>>>>       pick   4th commit
>>>>>>>>       pick   3rd commit
>>>>>>>>              2nd commit  <-- YOU ARE HERE
>>>>>>>>              1st commit
>>>>>>>>
>>>>>>>> This is great, but assuming that the 2nd commit conflicted,
>>>>>>>> currently
>>>>>>>> the display looks like this:
>>>>>>>>
>>>>>>>>       pick   4th commit
>>>>>>>>       pick   3rd commit
>>>>>>>>              1st commit  <-- YOU ARE HERE
>>>>>>>>
>>>>>>>> I would like to extend this to also show a "fake entry" for the
>>>>>>>> commit
>>>>>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>>>>>> except that I need a way to distinguish whether it was applied
>>>>>>>> already
>>>>>>>> or not.
> OK, I see. Sounds like a possible algorithm could be:
> 
> func commitNameToShowAsTheCurrentlyConflictingCommit() {

Going back to your original email, if all you want to do is show "YOU 
ARE HERE" against the correct commit then you can get that from the last 
entry in the "done" file irrespective of whether there were conflicts or 
not. If you also want to show whether it was picked cleanly or not then 
it is more complicated.

>      lastDone := last command of "done" file
>      if lastDone.command is "break" or "exec" {
>          return nil
>      }
> 
>      next := first command of "git-rebase-todo" file
>      if lastDone == next {
>          // Command was rescheduled and shows in remaining todos already
>          return nil
>      }

I don't know what your current implementation looks like but if I was 
starting from scratch I think it would be simpler to always use the last 
command from "done" and then suppress the first command from 
"git-rebase-todo" if it is the same. That way the "YOU ARE HERE" always 
marks the last command from "done"

>      if lastDone.command is "edit" {
>          if "amend" file exists {
>              // "edit" command was successful
>              return nil
>          }
>      }

If you need to know if the pick was successful or not then that should 
tell you, but if all you need to know is which commit the rebase stopped 
on then you don't need this.

Best Wishes

Phillip


>      return lastDone.commitName
> }
> 
> Does this sound reasonable?

