From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 15:54:34 -0400
Message-ID: <CANoM8SUy_MGbLzaLrkaaNxbXYiisiu8cwnWuy6QDtGvw6HCf9w@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
 <1440961839-40575-2-git-send-email-rappazzo@gmail.com> <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
 <CANoM8SUoJAPBwEO=udhaR0WcUkZropEJ5G_SESnkHVtAQHxJQQ@mail.gmail.com> <CAPig+cSweTu=t4vekV6ihAYSzdDHZMQdx-PRt9_+rYr9SrujPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:55:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVAR-0001Zx-8r
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbHaTyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:54:55 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35930 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbbHaTyz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:54:55 -0400
Received: by obkg7 with SMTP id g7so100077001obk.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 12:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ULjj6oNAC0SA00jdCj2f+kgT0LatEby68uB6Qywdb/o=;
        b=EwNz5IronlOiiJXlmyHC4miTLLJV4FYTz2Q4frU1HN8htBlQcdljWk7McHVoqZ/Vjh
         RjczV9d5+lR3ob8HwwhSz5hMEH09QDw53SQnW6EznAe20ifc+9SwpsbtAlrPxjdqW3iG
         D67Wg8rnO60jNHXP42TZ4cY58sOCjiA4fCg6DTGDgSEjPKwjG+5vEepHQOykaJBuhUbM
         RqI9HsMskmK/A+lEu9MBZpfFR5p/Dc1px9M1Vuf4XzWbIEokIEhX5/0t1NrpXh38utgR
         +kLJ/EgjFemea3/d83ndmjCdpofS+yMTMbWzcNWTRMPu4zCC/87OQFYZPigsCzsAqeUP
         lMCQ==
X-Received: by 10.182.60.196 with SMTP id j4mr14504693obr.10.1441050894295;
 Mon, 31 Aug 2015 12:54:54 -0700 (PDT)
Received: by 10.202.174.147 with HTTP; Mon, 31 Aug 2015 12:54:34 -0700 (PDT)
In-Reply-To: <CAPig+cSweTu=t4vekV6ihAYSzdDHZMQdx-PRt9_+rYr9SrujPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276927>

On Mon, Aug 31, 2015 at 3:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Aug 31, 2015 at 2:57 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>> I wasn't sure that a bare repo would be considered a worktree.  I
>> don't think that it would be
>> a good idea to include it.  In the same vein that I can't checkout a
>> branch in a bare repo, it
>> figure that it shouldn't be in the list.
>
> I forgot to mention in my previous response that I have the opposite
> view, and think that a bare repo should be included in the output of
> "git worktree list". The reason is that the intention of "git worktree
> list" is to give the user a consolidated view of the locations of all
> components of his "workspace". By "workspace", I mean the repository
> (bare or not) and its worktrees.
>
> In the typical case, the .git directory resides within the main
> worktree (the first item output by "git worktree list"), thus is
> easily found, however, if "git worktree list" hides bare repos, then
> the user will have no way to easily locate the repository (without
> resorting to lower-level commands or peeking at configuration files).

This makes sense, but would we also want to decorate it in the `git
worktree list`
command?  Would porcelain list output be able to differentiate it?
