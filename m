From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: [BUG?] Patches created with 'diff.noprefix=true' don't 'git apply'.
Date: Wed, 7 May 2014 16:39:45 -0700
Message-ID: <CAO8RVvfzP_nc9=nwr6JSK9s6u7DEctMpdn_5yca9h7G4TOd2Bw@mail.gmail.com>
References: <CAO8RVvdgN3U5hUEsJjYY9urfeVUDWwHiEur4NQp=H93W37RRnw@mail.gmail.com>
 <20140501024042.GX9218@google.com> <CAO8RVveV4SgXmJzWpYnyB3rnQALQkrrLNtLL5Ej5Y9Mjjekmmw@mail.gmail.com>
 <xmqqa9aug4my.fsf@gitster.dls.corp.google.com> <CAO8RVvfHVBG6QZ5M1DJK4kOX8GMDrvEw4_L=LsEc4G6E0pP7ug@mail.gmail.com>
 <xmqqbnvaehm3.fsf@gitster.dls.corp.google.com> <CAO8RVveF6Oh0mqqyiVRHmnqQ+vXX7riDW_=zn0g=t88cQjCVrg@mail.gmail.com>
 <xmqqzjita0sn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 01:40:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiBRx-0001TL-V7
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 01:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbaEGXka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 19:40:30 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:50820 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbaEGXk0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 19:40:26 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so1982474qcy.22
        for <git@vger.kernel.org>; Wed, 07 May 2014 16:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=w3/8/42m4NL1C2+MoHfy7svFJSOOqowntCpluwCUQ5o=;
        b=FwdFcZnfPvR9/dvqGiAlHcchQo+TVNQnVAnMl75sJ8yvA4LmPWz/11zkJu2q3K5wHu
         QYKYAg0Pyq3C4zg0ln4xBmCX/slafCuH5ysScL+4x9Tr2v9jFvtU+6vs2+TOXHtSEJmu
         fEIGbAj4YlOLZzQyzTYILVgs/8EJl3F6Cub8bv4vo4zkMI5jk8NqO5LE7ojVKQ9R0+qM
         dKyPc4TTPYqRWF5uf9ElDA8V2si02MhUWbS83B/k3ZpSPzWAUZUXL+Jq6vNnPab+iZAc
         48NtQPkuS1Ht+XA7IYn3fP/lgunHgJ5F8/jjul47BunDuL+TAsUHA9vszuVFfYyY0vhi
         DIrg==
X-Received: by 10.140.88.241 with SMTP id t104mr107745qgd.29.1399506025913;
 Wed, 07 May 2014 16:40:25 -0700 (PDT)
Received: by 10.229.150.208 with HTTP; Wed, 7 May 2014 16:39:45 -0700 (PDT)
In-Reply-To: <xmqqzjita0sn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248389>

On Wed, May 7, 2014 at 11:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nathan Collins <nathan.collins@gmail.com> writes:

>> For (2), the solution may be to add a separate
>> 'diff.add-clickable-paths' option (probably there is a better name?
>> 'diff.add-copyable-paths'? ...),...
>> ...
>> Concretely, if 'diff.add-clickable-paths' is set, then instead of e.g.
>>
>>   diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>> b/src/Data/Function/Decorator/Memoizer
>>   index 3ef17da..a0586d3 100644
>>   --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>>   +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>
> If you do something along that line, perhaps
>
>         Index: src/Data/Function/Decorator/Memoizer/Unsafe.hs
>         diff --git a/src/Data/Function/Decorator/Memoizer/Unsafe.hs ...
>         index 3ef17da..a0586d3 100644
>         --- a/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>         +++ b/src/Data/Function/Decorator/Memoizer/Unsafe.hs
>
> to imitate what "cvs diff" does may be more familar to people.
>
> What would you propose to make clickable in a renaming diff, though?

Your 'Index' header looks good, and I would expect a renaming diff to
have something like

  Index: foo -> bar

as in 'git status', but I just realized that a "clickable paths"
option already exists in some sense! There is a '--patch-with-raw'
option (which is "short" for '--patch' and '--raw', hahaha) which
inserts clickable file names in the patch, above each diff.  Moreover,
it respects the '--relative' option, so you can get relative or
absolute (relative repo root) clickable paths. It handles renaming by
inserting the old and new paths separated by space.

So then, having a way to make '--patch-with-raw' the default for all
non-plumbing patch-producing commands would solve the clickable paths
problem.

In a summary, a possible complete solution:

1. improve Git apply error message: mention '-p$n' and '-p1' default,
   and report if path in patch makes sense for some non-default '-p'
   value.

2. improve 'diff.noprefix' documentation: tell user that this option
   is for producing '-p0' patches, and that using it to produce
   clickable paths is insane and may cause problems with generated
   patches.  Suggest the user use '--patch-with-raw', and possibly
   '--relative', instead, or refer to (3).

3. add a Git config for making '--patch-with-raw' and optionally
   '--relative' the default for non-plumbing patch-producing commands.

Cheers,

-nathan
