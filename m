Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE24C1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 19:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdFSTL4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 15:11:56 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33215 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdFSTLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 15:11:54 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so52172120pgc.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a0HfEUlUzwmPSBbBN55VQIy3CyqG8kMm0aX5WBiC3TI=;
        b=JMfWukPU2BH9tk1i9U4ADl80Xr2WXWzWNuI6Ndd+sWeMkJ4culw8IPFQFeEeXLoQbb
         /5Ta8Jac/nFaItjwdCepKCjzgL8uTI2ghsb93n6ULGrZSrOnJUDdqwewFCg/+77bm3Na
         qB3ZUFC5D7CkL1HwlB7mOeZYwZEtwEfNASAiukM2pCoqnCHdwQDi3/Ruh3CT4vXHU99H
         psm4qYk9rups3RAK1DxnkQTZBJRJrT2UDaniBW1MA16BcDOaBhJ7rUSQSZ2qq0flr7fE
         g6yuJg7jebEr2zC36Tq7HEfL+dcK4UQGnXaCzNA9oIoA2uF+C9SnwDagNZQ5pwFz8c98
         rLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a0HfEUlUzwmPSBbBN55VQIy3CyqG8kMm0aX5WBiC3TI=;
        b=sYtaS3EmiqQh+Y8a8X6FmTrmmp3sKscuTg38BDroxUoHhOLXLzoKaXFnuZ/K9se4KI
         oZHuJdzT4LYCGdaX54uCKF/OMzvoiBkFMq4m2mk45bxDNXU2+BvdrfirWr+yhipcDBp4
         ZNlCa+9KkZZAPJh5v83z+byy1ZDfzMWzINx3lUd4RHBnY9R6DBSIDvz6ze/wuDyH2UfJ
         Qwl4cAUFG7aATKgGLP+iPBbufkqB9/BcHJ+GVNMttZZvkpSh+EYWxrda98BH3f6bajnQ
         jfmOcCoupRD41tpL6jbN0FP7sMl9lVqiqD48zLD6QDOQTOC04bBHpx1Rfg10WwhryO3y
         rgug==
X-Gm-Message-State: AKS2vOwJbOLliamREOm/S8gDgxyisJDDHSv6XR7Ef54MjZV/upU4u1C2
        kapKSMtoAkOIKnPiWUuIr6Ti7COt9Zmx
X-Received: by 10.99.186.81 with SMTP id l17mr8316385pgu.87.1497899508127;
 Mon, 19 Jun 2017 12:11:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Mon, 19 Jun 2017 12:11:47 -0700 (PDT)
In-Reply-To: <xmqqefufuakk.fsf@gitster.mtv.corp.google.com>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com> <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
 <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com> <xmqqefufuakk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Jun 2017 12:11:47 -0700
Message-ID: <CAGZ79kYrEexbn1j46DQTNWhksFeU=WbvnP7gqiUoj4Uynduvkw@mail.gmail.com>
Subject: Re: Restoring detached HEADs after Git operations
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 10:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Jun 19, 2017 at 2:52 AM, Patrick Lehmann
>> <Patrick.Lehmann@plc2.de> wrote:
>>> Hello Lars,
>>>
>>> for your questions:
>>>> If there are multiple branches with the same hash then your script would pick the first one. Can you imagine a situation where this would be a problem?
>>>
>>> I can't think of a good solution to resolve it automatically. Maybe a script could print that there are multiple possibilities and it choose the first branch in the list.
>>>
>>>
>>>> Plus, you are looking only at local branches. Wouldn't it make sense to look at remote branches, too?
>>>
>>> This is also related to restoring tags. If we go this way, we should have this priority list:
>>> - local branches
>>> - remote branches
>>
>> For remote branches you would create a local branch of the same name
>> (if such a branch would not exist, possibly setting it up to track that remote
>> branch)?
>>
>>> - tags
>>
>> as said in the other email and similar to remote branches, we'd not want to have
>> HEAD pointing to them directly but somehow have a local branch.
>
> Let's step back a bit.  We detach the HEAD for a good reason, no?

And the 'good reason' being that at the time git-submodule was written
we did not know what would be best, and having a detached HEAD
would be (a) easy to implement, and (b) removing one moving thing
from the whole construction, hence making it a bit safer,
(c) it sort of follows the mental model:

    the superproject said it had the submodule at X
        (and not at branch Y!)
    the submodule itself is a whole repo on its own
        (it doesn't need to be aware of the superproject)

so in this world detaching at X is the best we can do.

> Why is it a good idea to move them back on to a branch picked among
> multiple ones that all happen to be pointing at the same commit?

This (rhetorical?) question reads like 2 questions actually:
(a) "Why is it a good idea to move them back on to a branch?"
It makes working easier as the submodule is not detached,
but on a proper branch
(b) "picked among multiple ones that all ..."
I think this is a bad idea and we'd rather want to follow
some configuration instead of wild-guessing by Git.

> The user may build on a history of a submodule, and then may push
> the result out to a particular branch at the other side; that is
> when being on a named branch in the submodule becomes useful, but
> even then I do not think randomly picking one branch and be on it
> is a good thing to do.

so you provide one reason why it is useful, but then claiming it is
'not a good thing' (yet). Can you give a reason why this is a 'bad thing'?

> I would understand the workflow would go more like so:
>
>  - You do something at the superproject (e.g. create a new branch X
>    from an existing commit and check it out), which results in
>    submodules' HEADs getting detached at the commits bound to the
>    superproject's tree.

And here we'd want to discuss if we *really* want to detach the HEADs
or rather have a symbolic ref "following the superproject".

>  - Because you want to make changes to both submodules and the
>    superproject in a consistent way, you'd want to commit changes to
>    all of these repositories and the push the result out in an
>    atomic way.

Committing and pushing are different things. You should not care if
I commit atomically as you (in the general "upstream" sense)
cannot observe my local commits.

For pushing we would want to have an atomic push, but that is
not the scope of this discussion. (As a Gerrit user, we implemented
the submodule atomicity serverside, but in plain Git server you'd
not need the atomicity either:

    git commit -a -m "update submodule pointers"
    git submodule foreach git push
    git push

should be fine w.r.t. any non-atomic race condition.)

>  - Hence you tell "Hey, Git, I want all the submodules that I
>    modified to be on branch X" from the superproject.
>
>    - This may succeed in a submodule where X is a new name, or the
>      current tip of branch X is an ancestor of the detached HEAD.

so we'd allow fast forward for X. This seems arbitrary to me. I could
also say "If X exists I allow a merge to be made between old X and
the object name given by the superproject". (maybe as a config option)

>    - This may fail in a submodule where there is branch X that does
>      not want to move to the detached HEAD's state.  In this latter
>      case, the user needs to deal with the situation (perhaps the
>      old X is expendable; perhaps the HEAD's commit may need to be
>      merged to old X; perhaps there are other cases).

makes sense.

>
> though.
