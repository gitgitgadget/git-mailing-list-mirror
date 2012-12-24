From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 09:24:39 -0800
Message-ID: <CANiSa6iSYvLbp1s8h9pwi=P1m0QdZPqf06hAm+4muChgJUuj=g@mail.gmail.com>
References: <20121224035825.GA17203@zuhnb712>
	<201212240409.qBO49wkV020768@no.baka.org>
	<20121224073103.GA10793@zuhnb712>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Seth Robertson <in-gitvger@baka.org>, git <git@vger.kernel.org>
To: Woody Wu <narkewoody@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 18:25:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnBlr-0005lH-Ti
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 18:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2LXRYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 12:24:41 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:35179 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab2LXRYk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 12:24:40 -0500
Received: by mail-ia0-f172.google.com with SMTP id z13so6137942iaz.31
        for <git@vger.kernel.org>; Mon, 24 Dec 2012 09:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/YVuORffNIQzcKX2aY0AKSqzRtKLBf4KKdNs/HF0z9Q=;
        b=a3lZncit9idFzKUpEItxvvSEo4KbG4lDPKRLnweVd4oKGcufqInpooNOjH+IsGi6jT
         IRDL31+0GIXJlkvvGkIkv1WgpPiy8X5gDlf1TWVTj1NAM+/B70ZkNLIoXHvv4wg6BbGL
         7FRipvO+Aiii0Bxnx4+N0bKKcBFTbnhpxd7lM4htXVUnUiNKPNjOhKVLTZCb93d7D9RV
         vDkXEjp2XeFYziTYa/CmCbGHBgC3zzDAGr2acKpJk0AWkkc4oZHhIWN/XmXWii0HRP7I
         ixAcCE2cdJB8JyDU+/EeR6WIKiR0WfKWoZslldxdSeHpL3jiXyGqu3lvMpdBDVG7Xj6Q
         Vaxg==
Received: by 10.50.33.233 with SMTP id u9mr20162933igi.39.1356369879948; Mon,
 24 Dec 2012 09:24:39 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Mon, 24 Dec 2012 09:24:39 -0800 (PST)
In-Reply-To: <20121224073103.GA10793@zuhnb712>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212114>

On Sun, Dec 23, 2012 at 11:31 PM, Woody Wu <narkewoody@gmail.com> wrote:
> On Sun, Dec 23, 2012 at 11:09:58PM -0500, Seth Robertson wrote:
>>
>> In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:
>>
>>     How can I find out what's the staring reference point (a commit number
>>     or tag name) of a locally created branch? I can use gitk to find out it
>>     but this method is slow, I think there might be a command line to do it
>>     quickly.
>>
>> The answer is more complex than you probably suspected.
>>
>> Technically, `git log --oneline mybranch | tail -n 1` will tell you
>> the starting point of any branch.  But...I'm sure that isn't what you
>> want to know.
>>
>> You want to know "what commit was I at when I typed `git branch
>> mybranch`"?
>
> Yes, this is exactly I want to know.
>
>>The problem is git doesn't record this information and
>> doesn't have the slightest clue.
>>
>> But, you say, I can use `gitk` and see it.  See?  Right there.  That
>> isn't (necessarily) the "starting point" of the branch, it is the
>> place where your branch diverged from some other branch.  Git is
>> actually quite able to tell you when the last time your branch
>> diverged from some other branch.  `git merge-base mybranch master`
>> will tell you this, and is probably the answer you were looking for.
>
> This is not working to me since I have more than one local branch that
> diverged from the master, and in fact, the branch I have in question was
> diverged from another local branch.

As Jeff mentions in a later message, "git pull --rebase" would
probably do what you want. It works with local branches too.

I once tried to add the same cleverness that "git pull --rebase"
directly in "git rebase" [1], but there were several issues with those
patches, one of was regarding the performance ("git pull --rebase" can
be equally slow, but since it often involves network, users probably
rarely notice). I think it would be nice to at least add it as an
option to "git rebase" some day. Until then, "git pull --rebase" works
fine.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/166710
