From: Dmitry Oksenchuk <oksenchuk89@gmail.com>
Subject: Re: Joining historical repository using grafts or replace
Date: Thu, 30 Oct 2014 20:41:37 +0300
Message-ID: <CA+POfmvXEjDV9Vap6NDX7HvOMjEVG4mVe1uWFSTQy5g_c+vJnw@mail.gmail.com>
References: <CA+POfmvCiNBF=P-OvQBTROVhaLtOdgNTDgPNyS=97bupSGk=4g@mail.gmail.com>
	<CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:42:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjtjg-0007l4-Da
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 18:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbaJ3RmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 13:42:06 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:60672 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760782AbaJ3Rlj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 13:41:39 -0400
Received: by mail-yk0-f178.google.com with SMTP id 9so2540968ykp.9
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NGqYCyu5nl4XQ4LgAkDVRVcZBBlo2u7BwF/iT2tNa/o=;
        b=pJUSrqjP02Us7Dvw87oo4aUBXyfX+X1J5HtgY7TMbAMQrICBcbp/Gl9hdZVFlLrglP
         ZFgKKwxXF64Zt4HZimGAe04s6ibvrdkAtUbGEJk2nuLPCVSuoXGLTijQsBYCwImGf+Nm
         k5WiD0zGPc4wrtImWCUNkp7zZ6YQBZJm960rX9YQhsU+SPNFlkL/gu1GtuaTB+HbhHiB
         4aN9NkGwQbEaVtW1pQD0pFMGbdgwey2VU/b+h7E73GhBLOGgVEC1lWlh1pfVWoi054Xh
         8vu+DUt7I03ZN0B+wE2AK3t47H+OgpmI+WgTBA+lFmydL7ULQMZHbCzAB4miel1R9YQb
         Vmkg==
X-Received: by 10.170.147.2 with SMTP id o2mr19076998ykc.81.1414690898021;
 Thu, 30 Oct 2014 10:41:38 -0700 (PDT)
Received: by 10.170.141.194 with HTTP; Thu, 30 Oct 2014 10:41:37 -0700 (PDT)
In-Reply-To: <CAP8UFD3_fAWRdxQgAbfxYZSzrmy1Aza=nuZh-uSJsKOdRj+LVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Thanks for your reply.

2014-10-30 19:54 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Thu, Oct 30, 2014 at 4:39 PM, Dmitry Oksenchuk <oksenchuk89@gmail.com> wrote:
>> We're in the middle of conversion of a large CVS repository (20 years,
>> 70K commits, 1K branches, 10K tags) to Git and considering two
>> separate Git repositories: "historical" with CVS history and "working"
>> created without history from heads of active branches (10 active
>> branches). This allows us to have small fast "working" repository for
>> developers who don't want to have full history locally and ability to
>> rewrite history in "historical" repository (for example, to add
>> parents to merge commits or to fix conversion mistakes) without
>> affecting commit hashes in "working" repository (the hashes can be
>> stored in bug tracker or in the code).
>
> This might be a good idea. Did you already test that the small
> repository is really faster than the full repository?

Yes, because of such amount of refs, push in "historical" repository
takes 12 sec, push in "working" repository takes 0.4 sec, push in
"joined" repository takes 2 sec. Local operations with history like
log and blame work with the same speed in "joined" repository as in
"historical" repository.

>> Are there any disadvantages of using grafts and replace? Will both of
>> them be supported in future versions of Git?
>
> My opinion is that grafts have no advantage compared to replace refs.
>
> Once you have created your replace refs, they can be managed like
> other git refs, so they are easier to distribute.
>
> Basically if you want to get the full history on a computer you just need to do:
>
> git fetch 'refs/replace/*:refs/replace/*'

That's true but you still need to have another remote with full
history because it has lots of tags and branches that will be cloned
by initial clone.

Regards,
Dmitry
