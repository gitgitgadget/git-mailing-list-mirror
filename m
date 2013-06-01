From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: can we prevent reflog deletion when branch is deleted?
Date: Sat, 1 Jun 2013 22:55:37 +0530
Message-ID: <CAMK1S_hPups3SCwxhHRYWBJzpPreNVUfNdx1+_Hjy2_d0MMpaA@mail.gmail.com>
References: <CAMK1S_jY1tDCkyOamX8XNW9g8Dzf6yN9znwN6he-EVcOkBM1fQ@mail.gmail.com>
	<51A963B7.6060002@alum.mit.edu>
	<20130601050355.GA23408@sigill.intra.peff.net>
	<CALkWK0kcJH0t4i0BAPmMkNWwNzeJNdmg_wbt3ao-=R31kJ5noA@mail.gmail.com>
	<20130601090934.GA13904@sigill.intra.peff.net>
	<CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Elijah Newren <newren@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 19:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UipYl-0003gZ-Dd
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632Ab3FARZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:25:40 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38539 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab3FARZj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:25:39 -0400
Received: by mail-wi0-f171.google.com with SMTP id hq7so1548123wib.10
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 10:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qH/M5T2fZNRLH4sZ1I7CcVtJE1zQMJRpFsYizNgdz/Y=;
        b=H3ew9oBNHkeig+IJBTab9zE8XIP75XOhWUrut3j3ZDi0r55ereidwnwF0PZswd4TGX
         VE/IzUQMZY1efRcUNnvfwuY24ojZGOdHeDYF931Upbh+fgdGVu8wWETThhY+FU2vLFBa
         DgGoM+WC5Ng7DxDGbrZYUjK7A40/7JQQriDueDnFTwlhsX1MPzBdivVJ5v4vhLhMoQn3
         jf+5uT7EDMpfupnBnxfwmfOMZFXlA2+yYZz5NjwG48SE4oB/M/kjID+Dl3JHE0XdRU4Z
         34KHLqq5atbtY9g+B7k8+HK/kEW9SuOzClBPdIA2v1EiCvmZ4OZxxgwQr7uvdssYQhL+
         qVTA==
X-Received: by 10.180.74.10 with SMTP id p10mr7273125wiv.39.1370107537682;
 Sat, 01 Jun 2013 10:25:37 -0700 (PDT)
Received: by 10.194.170.65 with HTTP; Sat, 1 Jun 2013 10:25:37 -0700 (PDT)
In-Reply-To: <CALkWK0mwAc0bFon7B7nw1Nbvcwdf8m2_531qtrN-r28r9F+70Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226142>

On Sat, Jun 1, 2013 at 3:17 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Jeff King wrote:
>> Why don't the branch names have significance? If I deleted branch "foo"
>> yesterday evening, wouldn't I want to be able to say "show me foo from
>> 2pm yesterday" or even "show me all logs for foo, so that I can pick the
>> useful bit from the list"?
>
> Oh, I misunderstood then.  I didn't realize that your usecase was actually
>
>     git log foo@{yesterday}
>
> where foo is a deleted branch.  Just to give some perspective, so we
> don't limit our problem space:
>
> I only ever batch-delete "cold" branches: if I haven't touched a
> branch in ~2 months, I consider the work abandoned (due to disinterest
> or otherwise) and remove it.  Most of my branches are short-lived, and
> I don't remember branch names, much less of the names of the cold
> branches I deleted.  My usecase for a graveyeard is "I lost something,
> and I need to find it": I don't want to have to remember the original
> branch name "foo"; if you can tell everything I deleted yesterday, I
> can spot foo and the commit I was looking for.  The HEAD reflog is
> almost good enough for me.

I think I'd have to be playing with *several* branches simultaneously
before I got to the point of forgetting the branch name!

More to the point, your use case may be relevant for a non-bare repo
where "work" is being done, but for a bare repo on a server, I think
the branch name *does* have significance, because it's what people are
collaborating on.

(Imagine someone accidentally nukes a branch, and then someone else
tries to "git pull" and finds it gone.  Any recovery at that point
must necessarily use the branch name).

PS: I am assuming core.logAllRefUpdates is on
