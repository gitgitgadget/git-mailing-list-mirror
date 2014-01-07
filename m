From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Wed, 8 Jan 2014 02:55:04 +0530
Message-ID: <CALkWK0==wNMvjHmwnGaQi+RitXgros39+70zWH29=Q238Rkp5A@mail.gmail.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
 <1389028732-27760-3-git-send-email-artagnon@gmail.com> <xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
 <CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
 <xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com> <CALkWK0nSed9vvRvTR00_vV3tHL8mSQA=8JJ_Y7=pQchoVcvhzA@mail.gmail.com>
 <xmqqha9ghhrw.fsf@gitster.dls.corp.google.com> <CALkWK0=Km+a7NBm9ki5MN=R28HkzUZRqnBKcpuPZDrQKdsBesg@mail.gmail.com>
 <20140107210607.GB28102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0e9m-0002g3-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:25:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaAGVZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:25:47 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56018 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaAGVZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:25:46 -0500
Received: by mail-ie0-f171.google.com with SMTP id ar20so1102709iec.16
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 13:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XMv9GHT5TwgtM4qweM1wn7t+L5wvTEpzasXzivWemYI=;
        b=MFm95UxWkOIf0An3G79nVJhPIIwGCtvI4+kZEaje6RhyfXWIfW/N0YTOfXgti2Y8yg
         YFMGbI9yYpkFpev5GkgXjAUONUUI7pex4YGNK5W0gtOpo8h6YHnDIJRwR2DyI704o/KS
         +g2Fz/EAn8RElh3MARgGyYv6OYDwEUvrO2zAqAv/SPirfV5CpWwe6yW2HhR87WrAzt73
         z2+eky7qTXSruej0/ndriEkAI0EHgE91BIidz0s+prCiA1J6KfqyA1rM93U6qpjdACHc
         26xkKEHz6BTJocrnIrzxRP5ICWFfyLU5wEn0dsCTLpGl9AxxGV3c3WyTuYNTKuH+obvb
         zozA==
X-Received: by 10.50.20.67 with SMTP id l3mr5422979ige.16.1389129946019; Tue,
 07 Jan 2014 13:25:46 -0800 (PST)
Received: by 10.64.17.10 with HTTP; Tue, 7 Jan 2014 13:25:04 -0800 (PST)
In-Reply-To: <20140107210607.GB28102@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240158>

Jeff King wrote:
> My daily procedure is something like:
>
>   all_topics |
>   while read topic; do "echo $topic $(git rev-parse $topic@{u})"; done |
>   topo_sort |
>   while read topic upstream; do
>     git rebase $upstream $topic || exit 1
>   done

Ah, I was perhaps over-specializing for my own usecase, where
everything is based off 'master'. I never considered 'master' a "true
upstream" because I throw away topic branches after the maintainer
merges them. If you have long-running branches that you work on a
daily basis, the issue is somewhat different.

>> While doing respins, the prompt doesn't aid you in any way. Besides,
>> on several occasions, I found myself working on the same forked-branch
>> from two different machines; then the publish-point isn't necessarily
>> always a publish-point: it's just another "upstream" for the branch.
>
> Right, things get trickier then. But I don't think there is an automatic
> way around that. Sometimes the published one is more up to date, and
> sometimes the upstream thing is more up to date.  You have to manually
> tell git which you are currently basing your work on. I find in such a
> situation that it tends to resolve itself quickly, though, as the first
> step is to pull in the changes you pushed up from the other machine
> anyway (either via "git reset" or "git rebase").

My primary concern is that the proposed @{publish} should be a
first-class citizen; if it has everything that @{u} has, then we're
both good: you'd primarily use @{u}, while I'd primarily use
@{publish}.
