From: Dmitry Oksenchuk <oksenchuk89@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Fri, 31 Oct 2014 18:47:40 +0300
Message-ID: <CA+POfmt9cQcKshc3LgGpBqHdbsgjoN7Ou7eN3sGqJcDeXwgPyA@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
	<CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
	<CA+POfmvXEjDV9Vap6NDX7HvOMjEVG4mVe1uWFSTQy5g_c+vJnw@mail.gmail.com>
	<CAP8UFD0ZN1Dq3kAs=nQE3fY8RydqUhSDvYksy7J2igTpt9p5WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 16:47:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkEQX-0000Lb-N6
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 16:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbaJaPrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 11:47:42 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:36692 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbaJaPrk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 11:47:40 -0400
Received: by mail-yk0-f182.google.com with SMTP id q200so3442520ykb.13
        for <git@vger.kernel.org>; Fri, 31 Oct 2014 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PliRzCbq1/xytRHtyAy3DvK4ztdivlz+MZiNlZRdTIY=;
        b=u/O5N/7LaXZqfY7T5x5YA4ag3OEUGs3XFoCWujX47vi+EMiGW8to+zlRp23wuQ2OJ7
         nvJbT8uS01QJsZ9TyrchknC0/zeRds123zYy9872JA7stYqwdBXHJAd3B9IijQjjZSgj
         jtP9IljWuSuWOMqcHeE8Uz/Ib6OllVTsMhOZ4ObnqWKsioLUpfxbo+3v7pxRFnFlz+Np
         oCkc5Bs0KwWPnAcwV1AscfdQdb5nRPOJ5essHI84lWpIeRS+zCOr2q8/FefjTBUn6u6D
         73/rRBYGvLmy2aBsF+du61BzKVy2s2FD+ISHV08Mtxlf0abtxOrk3lTUcXA0uvrL7EP0
         1FsA==
X-Received: by 10.170.186.74 with SMTP id c71mr25065840yke.39.1414770460227;
 Fri, 31 Oct 2014 08:47:40 -0700 (PDT)
Received: by 10.170.155.11 with HTTP; Fri, 31 Oct 2014 08:47:40 -0700 (PDT)
In-Reply-To: <CAP8UFD0ZN1Dq3kAs=nQE3fY8RydqUhSDvYksy7J2igTpt9p5WQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

> On Thu, Oct 30, 2014 at 6:41 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
>> 2014-10-30 19:54 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
>>>
>>> This might be a good idea. Did you already test that the small
>>> repository is really faster than the full repository?
>>
>> Yes, because of such amount of refs, push in "historical" repository
>> takes 12 sec, push in "working" repository takes 0.4 sec, push in
>> "joined" repository takes 2 sec. Local operations with history like
>> log and blame work with the same speed in "joined" repository as in
>> "historical" repository.
>
> What does "joined" mean? Does it mean joined using grafts? Or joined
> using replace refs? Or just the unsplit full repository?

It's joined using grafts or replace. In both cases performance is the same.

> Also what is interesting is if local operations work with the same
> speed in the small "working" repository as in the unsplit full
> repository.

Speed of operations like git diff, git add, git commit is exactly the
same in both repositories.
Operations like git log and git blame work much faster in repository
without history (not surprisingly :)
For example, git log in small repository takes 0.2 sec, in full
repository - 0.8 sec. git blame in full repository can take up to 9
sec for large files with long history.

Regards,
Dmitry
