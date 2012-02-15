From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Wed, 15 Feb 2012 18:01:45 +0700
Message-ID: <CACsJy8DBG2A91=ppCOC6Hf6aYM2soUXXdsY0GU9hr2xqjj4RYA@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CAA01Csp6_9fP2rg4104UWUXwOxZmUVdQNDAaBe6fRou6agBz6g@mail.gmail.com>
 <8762f9k5sg.fsf@thomas.inf.ethz.ch> <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 15 12:02:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxccv-0004wY-Rd
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 12:02:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757153Ab2BOLCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Feb 2012 06:02:17 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60233 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755604Ab2BOLCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 06:02:16 -0500
Received: by wgbdt10 with SMTP id dt10so813455wgb.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 03:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2jcRH84tsh8uYX1JYPQNLlhBSJbAqD5SMcsmWLaWvQA=;
        b=eslSf3Nw24F5ly9V3EhnS5D+J7Y8WaeaWy2xNS9MlMZWXJmFCGy4aFkoa2IiK6j+ZH
         MISR/pPXe6kvD772I7JVwe+Pwh8fjHcmLhxdKp+jIeDDc98kF/WVXxLEbzm4MXrFjmOV
         Wa0vGu4hwGrdTqgYwlxv7vMh98ooGIk7U+Vx4=
Received: by 10.181.13.113 with SMTP id ex17mr34793616wid.15.1329303735239;
 Wed, 15 Feb 2012 03:02:15 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Wed, 15 Feb 2012 03:01:45 -0800 (PST)
In-Reply-To: <CAA01Cso_8=159UDMFUHiYz1X=gYtpbqRO4h3TMw7N=4YMV8YNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190823>

On Wed, Feb 15, 2012 at 3:57 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Indeed, after gc the times went down:
> 10s -> 2.3s (subdirectory)
> 17s -> 9.5s (whole repo)
>
> 2 seconds is much better and I'd say acceptable for me. But my questions are:
> - why is it so slow with not packed repo?
> - can it be faster without repacking?

gc does more than just repacking. If you still have the un-gc'd repo,
Try these commands one by one, and time "git status" after each:

 - git pack-refs --all --prune
 - git reflog expire --all
 - git repack -d -l
 - git prune --expire
 - git rerere gc

I'd be more interested in why auto-gc does not kick in (or whther it should).

> - even with packed repo, the time on small subdirectory is much higher
> than I'd expect given time on whole repo and subdirectory size - why?

Hard to say without measuring. I just notice that I missed your mail
with profiling results. I will have a look, but just in case, is the
repository publicly available?
-- 
Duy
