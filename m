From: Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sun, 20 Mar 2011 16:44:54 -0700
Message-ID: <AANLkTikSDAuvq-Bbw4T8KaenXQu11+HyVs0oA8K=0q5r@mail.gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
	<dab08d0ff27b0f571a17ed4f1ab0f39b@localhost>
	<4D8681CF.3060005@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 00:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1SIv-0003Ql-Bc
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 00:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab1CTXo5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Mar 2011 19:44:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44194 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab1CTXoz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2011 19:44:55 -0400
Received: by fxm17 with SMTP id 17so5051414fxm.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 16:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PPbVM5ChznyE4DAdZd0oASNHDp1Oqp+wTgKo3S3kdIc=;
        b=iQ37YfKrDU1HKKWZ/jmDqxLEpAdQGbCJW+igU7oDHzPoClmYWaHtI7x5Zb+1dO3ZlT
         bRDRcTbcxgomAeoAx6vhBri6ppsrUehzna/0clAho+jZnXis2il2eeZ50VtynD+t+lQZ
         JWkRT11ASXdV+zOo9/4/bCpxvlSKoIYzX2rbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q3bMWuZOmrzdNuSYp4YOKHIgIsTGJ/x2Po9ENaKH1+RxgCa3zeP+3wnush/EEMunl6
         TvSXwFOTcCwTUwooRVWrUQRsLa1bx/J5s5v1BR02wLvn2onnYtwMJiYUqx93BoHrDUbg
         Osw9239iTK2fKCWiQtD7etvbcP3yjpOKZdd6A=
Received: by 10.223.7.73 with SMTP id c9mr447263fac.117.1300664694450; Sun, 20
 Mar 2011 16:44:54 -0700 (PDT)
Received: by 10.223.61.83 with HTTP; Sun, 20 Mar 2011 16:44:54 -0700 (PDT)
In-Reply-To: <4D8681CF.3060005@eaglescrag.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169535>

On Sun, Mar 20, 2011 at 3:38 PM, J.H. <warthog9@eaglescrag.net> wrote:
> I'd argue there are two types of "local" time that anyone using gitwe=
b
> would be looking for (particularly if this is called local time)
>
> 1) Time Local to the observer: =C2=A0Specifically I don't care where =
every
> other commit has taken place, I want to know what time it was in my
> preferred time zone (local time zone likely)
>
> 2) Time local to the project: =C2=A0There will be instances where a p=
roject
> is based in a specific time zone (home office perhaps?) and you will
> want to see the commits from that perspective.

That is probably true for distributed projects, but many software
projects are handled entirely at one location so there is only one
timezone of interest.  My goal was to make it easy to support this
case.

I have no particular objection to implementing a more comprehensive
solution, but my gut feeling is that it would be harder to push the
changes upstream (and would have no direct benefit for my local gitweb
installation).

I also figured that if nobody had done this by now, the demand is weak
and it maybe doesn't warrant a huge amount of effort.

>               - Local Time (could easily default to this and
>                 JavaScript can detect that from the browser)

In my case it would be best to have a way to default to the browser's
local time.  Would there be a way to set this default on the server
side?

My group has switched to Git, but most other groups in the company are
using other SCM systems.  I frequently send gitweb links to non-Git
users, and want to make their experience as intuitive as possible.
So, it would be best if the correct timezone was automatically
selected.

>       - Won't break bots / scripts that may be crawling the pages or
>         reading the rss feeds (because the timestamps will all be the
>         same assuming it doesn't try to render the javascript)

=46WIW, my latest patches did not change the format of the RSS/Atom fee=
ds.

If we are worried about breaking bots that scrape the regular HTML
pages, that ties our hands in a lot of other ways.

> If you are interested I can bang that out tomorrow (shouldn't take
> long), but I would *MUCH* rather see this done via JavaScript than to
> muddy up the backend with multiple timezones and such.

OK.  I can help test/improve the implementation if you post a prototype=
=2E

Thanks.
