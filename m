From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Thu, 27 Dec 2012 22:38:25 -0800
Message-ID: <CANiSa6iuiuDxjTdn9-DD3y2-OA=jffxGM0ibVrZB1ixLy0i+Gg@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712>
	<201212240409.qBO49wkV020768@no.baka.org>
	<20121224073103.GA10793@zuhnb712>
	<CANiSa6iSYvLbp1s8h9pwi=P1m0QdZPqf06hAm+4muChgJUuj=g@mail.gmail.com>
	<20121228051514.GA4028@zuhnb712.ap.bm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 07:43:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToTfD-0004JX-3n
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 07:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092Ab2L1Gi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 01:38:27 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:43653 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953Ab2L1Gi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 01:38:26 -0500
Received: by mail-ie0-f175.google.com with SMTP id qd14so12240463ieb.6
        for <git@vger.kernel.org>; Thu, 27 Dec 2012 22:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ly6zYJXf9hqg2yncKfL6ZaUgqGEKXctkUxyDdgZZUc4=;
        b=quyagu/NR9oncn78FOcZDw0M7opuGbBKNWe/eDz49FWr2HQgbuy6vdoK6mGCgwbEa5
         iLTjLORB6/CdvaM4ykGU0d1YkLeRaX9FellqdAEuL3XYEUPYmpAlpApfOvqn3310Dujd
         UzVWc3HU7QgokP2qWsGF4n2fxSsVQS6v0Oj1ockY0WXtXOdCcJNvQBqW6ucDIGAoB2Qv
         IZOZ4W5077yizHmf2tkfw2oIPrAyu4rZIz5XsH10kg26l4+6o8UQMEoWrVGGbuRvJ1Qo
         kTHZ2iiHZSisbl/gtSAX2t/D80KKuyJfPjtHNBBilbVeg6txOpM/tLbPqjy9YHKTlqf4
         FLxA==
Received: by 10.50.12.165 with SMTP id z5mr28924205igb.17.1356676705894; Thu,
 27 Dec 2012 22:38:25 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Thu, 27 Dec 2012 22:38:25 -0800 (PST)
In-Reply-To: <20121228051514.GA4028@zuhnb712.ap.bm.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212236>

On Thu, Dec 27, 2012 at 9:15 PM, Woody Wu <narkewoody@gmail.com> wrote:
> On Mon, Dec 24, 2012 at 09:24:39AM -0800, Martin von Zweigbergk wrote:
>> On Sun, Dec 23, 2012 at 11:31 PM, Woody Wu <narkewoody@gmail.com> wrote:
>> >
>> > This is not working to me since I have more than one local branch that
>> > diverged from the master, and in fact, the branch I have in question was
>> > diverged from another local branch.
>>
>> As Jeff mentions in a later message, "git pull --rebase" would
>> probably do what you want. It works with local branches too.
>>
>
> I think what 'git pull --rebase' would do is to fetch from the origin
> and do a 'git rebase'.

Not if the configured upstream is a local branch (see the
"branch.<name>.*" configuration variables). In that case it will just
rebase the local branch onto the new position of its upstream. If the
upstream is not configured, I believe you can still do "git pull
--rebase . <upstream branch>".

> On one hand, I don't understand 'git rebase' so
> much from the manual, ont the other hand, I did not get the point why
> 'git rebase' has something to do with the thing I want to do (what I
> want is just query some kind of history information).

I may have misunderstood or assumed things incorrectly that you wanted
to rebase the commits on your branch. So why do you want to know?
(Please ignore me if this was answered elsewhere in the thread that I
might have missed.)

Anyway, to answer your question, you could use a method similar to
what "git pull --rebase" uses internally to figure out the branch
point:

git merge-base $(git rev-parse <branch>) $(git rev-list -g <upstream branch>)

Hope that helps
