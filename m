From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/2] Submodule shallow recommendation [WAS: Submodules:
 have a depth field in the .gitmodules file]
Date: Thu, 26 May 2016 11:54:45 -0700
Message-ID: <CAGZ79kZKSC-vdUXg0uzb_u022TNVY-JHXuXLAc2LOT7OvpYckQ@mail.gmail.com>
References: <20160526000633.27223-1-sbeller@google.com> <xmqq1t4owuue.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 20:54:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b60Qq-0004hb-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 20:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755065AbcEZSys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 14:54:48 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:33954 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755035AbcEZSyr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 14:54:47 -0400
Received: by mail-io0-f181.google.com with SMTP id 190so58780199iow.1
        for <git@vger.kernel.org>; Thu, 26 May 2016 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cKP6oLVsOxxJHRk2RR73pHDnDANqFsxTFTZjfrCzSiM=;
        b=IJtnlKClN/zStJ/2EZv/Awd28W30RI50MV9WvrT1IXDAa5XscUiM3e24th815ZYAkL
         VxKNmnkbHDxxUakZdKWKMmFdLeXqKdQojcoPmcURb4/Eyc7y8F7qtTZXuXY4CBcP6BlH
         w6oZbhbGodDKCn11iS5CpkTz2eXvWLdbWca/Y5mPsglX490X4JFNEiK5cCw9jnt9DdiP
         rkjjrR0vRmibQn+aHUtlqj3QjFTO8zrQokHdchBlDM+d3LP+179hAEf6A9WvBTRtRP0g
         DDouxtD/pv1TpT3FdDBV7mKxM05krkVvw78a3vsGjrWG3zBmA/9GXP5VMK6mWjJXrOad
         JmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cKP6oLVsOxxJHRk2RR73pHDnDANqFsxTFTZjfrCzSiM=;
        b=ZvVkVOC1GS7cnNmpDDbIV8PR0m8ixrvK3IpHax8naqS2oDyCOBg47jxDcqQkTLTlKa
         qOiF73NzyemvPWw5WmAfHPngKh7CZ7guOHIkrgTgywivntoKxYxY/nhJJjcZOTyLEJEn
         kdhFOCtrcGYhKi906T7eZnbdviRaQ3scvNrp+B4R4D5AaLl89UH/MhkivzkEpkCZbUeW
         K0a+6nCDbV6zS9AixDxFOnfy2d/ktMha6ahzSUrrfyOXvvbsrLw2Cld9kpsH5d4bmvg8
         fv7tCQ/hDwmK8P9dPaXGA7esO07Yo6fSn/09hZg52Rj+f4yolvarMn7YSbvhQ7TzQb1V
         6XGw==
X-Gm-Message-State: ALyK8tKGfgBAK9wqeyXCXwUJ/Z/7+WAd/Nuyc2uYyXZpDNGz8p5dMUkWOC/s6HOT4NqRXzz7XxjCgxS67YRqhqT1
X-Received: by 10.107.173.20 with SMTP id w20mr11245591ioe.110.1464288886193;
 Thu, 26 May 2016 11:54:46 -0700 (PDT)
Received: by 10.107.136.19 with HTTP; Thu, 26 May 2016 11:54:45 -0700 (PDT)
In-Reply-To: <xmqq1t4owuue.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295684>

On Thu, May 26, 2016 at 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Sometimes the history of a submodule is not considered important by
>> the projects upstream. To make it easier for downstream users, allow
>> a field 'submodule.<name>.depth' in .gitmodules, which can be used
>> to indicate the recommended depth.
>
> I have a design-level question.
>
> If your project consists of 600 submodules, among which 40 of them
> you would recommend making a shallow clone, are there traits, other
> than "most people would not care about its history", that are shared
> across these 40 subprojects?

>From my understanding these 40 subprojects are a large file storage
done different than Git LFS. In the repo world this was choosen to be
a separate repository, such that you had versioning available as the
large files change a few times (like a precompiled kernel for special
hardware, etc). And this is one of the missing pieces to translate the
current repo-tool workflow to submodules.

>
> What I am trying to get at is that after adding .shallow annotation
> to these 40 submodules in .gitmodules, the project may need to add a
> different annotation for the same 40 submodules to control another
> operation.  Which would be cumbersome, and a level of redirection
> might be a good way to solve it.
>
> IIRC, earlier you had talked about a vision where you can just say
> 'submodule init --group=framework' to prepare your top-level project
> tree with its submodules in a state suitable to work on 'the
> framework part of the project', and the 'app' folks can substitute
> 'framework' with 'app' in that command.  I thought the earlier
> defaultGroup work (and the attribute limited pathspec work that lays
> groundwork for it) was part of that effort.
>
> Perhaps when a user says "submodule init --group=framework", that
> "framework" can choose some "developer profile" that indirectly
> specifies things like which group of submodules to initialize, which
> group of submodules can be shallow, etc.?

So you are proposing another layer of indirection, i.e. instead of giving
a pathspec with ":(attr:label-framework)" we would want to give a profile
which then has the pathspec plus additional information on shallowness
an such.

>
> Just a strawman (without worrying about details and expressiveness
> of the syntax), I am wondering if you want something like this in
> your .gitmodules:
>
>     [profile "framework"]
>         initialize = $submodule_spec
>         shallow = $submodule_spec
>         ...

There could be more operations here, like update strategies.

>
>     [submodule "kernel"]
>         url = ...
>         path = ...

instead here we could also put a (no-)init recommendation additionally
to the shallow recommendation.

>
>     ...
>
> where $submodule_spec would be a way to choose modules by various
> means.  You may name them by their names.  You may name them by
> their paths.  With the submodule-pathspec topic graduated, you may
> use ":(attr:framework)*" to choose them by attribute limited
> pathspec.
>

And you reinvented submodule groups. ;)
IIRC we had a discussion if we want to have the submodule groups
stored at each submodule or at a central "profile/group" setting.
The advantage of putting the setting to each submodule is that it
is easier to organize, i.e. it produces better locality for the settings.

It is easier to know for the [submodule "kernel"] what to set for flags or
labels when looking at that submodule as you're likely to have knowledge
about it. However adding a new group/profile is cumbersome, so we'd want a

    git config --add multi-set
submodule.<pathspec-matching-many-submodules>.label "initialize"

Another idea for having profiles would be to add conditional recommendations

     [submodule "kernel"]
         url = ...
         path = ...
         shallow = true if selected via :(attr:framework)

I have a worse feeling about these conditionals than about the profile, though

I think the profiles are selected using different repo manifest files, i.e. that
would be different .gitmodules/.gitattributes files on different branches.
However in each of these branches we would want to have a way to
recommend which submodules to initialize/checkout/shallow and such.

If keeping these different settings in different branches, we may desire better
merge support for .gitattributes, though (adjacent lines do not influence each
other, like in source code. So if one branch had a change like
     submodule0 ...
    - /submodule1 label-foo
    + /submodule1 label-foo label-bar
     submodule2 ...

and andother branch had

     submodule1 label-foo
    - /submodule2 label-baz
    + /submodule2 label-baz label-bar
     submodule3 ...

we would not want to see the merge conflict as we would with todays merge
strategy.)

Thanks,
Stefan
