From: JP Sugarbroad <jpsugar@google.com>
Subject: Re: git fetch origin $SHA1 doesn't work as often as it could
Date: Wed, 18 May 2016 18:40:37 -0400
Message-ID: <CAD0oC4wezb8svOW5KHONLi5wQN+H_3xqPLoU_EZbtL5zAkdv_Q@mail.gmail.com>
References: <CAD0oC4yQzvAH=6a6Xgy6xOPoYCaO2zsDg5mDySkb6VJ6FdeeEQ@mail.gmail.com>
 <xmqq8tz7qb7d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 00:41:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A9R-00008E-Kg
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbcERWlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:41:09 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35606 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcERWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:41:07 -0400
Received: by mail-qk0-f170.google.com with SMTP id n62so32763836qkc.2
        for <git@vger.kernel.org>; Wed, 18 May 2016 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8D1dtXgb014YPWiDV4XVTKfUptPT/m8krzxQD1ntHcY=;
        b=DP09K92xhDZkKZYqWnHX5wq1yszYUAlhK73V2yvTKnsfBilkJvf2OpnHyz+k3U/jS2
         cn9vXo9YZQbVCeCPYWkr7DV1VVqYyXZKH74y1m1bCRMZkHPa/CnRAxpKeniWSNWrTKGM
         ymI5+YGcLO+Ko1LtK7KT3CHDHszYNxhJrEJPhvIHXfCwWhgp7ceudbiZe8ObZuwoBqQ3
         2hwwRK8OXVWw8g8fjP55E9bBP4vlUMAh7vuxjsKouHQ6KfZsPzjqGBl6+MGIEzao2w6H
         vGbEaVSQ87Lgd7qAG7N+b6ntXNeFWUau5iCRzZuX/6NjdoUVJumkc4fSVjBdmlRfl/e0
         MjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8D1dtXgb014YPWiDV4XVTKfUptPT/m8krzxQD1ntHcY=;
        b=Oqgs7ff8AmMfKMW1jN1m5tcXKyp5yiJEDf0bhNjuwcH8z2TBV6ahWaLXg/3TW27NMJ
         j6wiPvyCG8eJuUsYGhjpu+f72FndRAR0Og4mXK41kKgSbocPmV/kyvW142KO9QyPy4TH
         bQ/Nt5sXdF03w7yHutNvgInEvutX5bIG/KAUpInKpyvw9V82JI2h70lpnvY6HUTVtW6d
         nqpq+jHmBCvbaE136nkc227uX8itlbFCrs8aetOMRNkH8OHe9zmDE8cdIMA5rXnOJv62
         TMx4WKI2Go+4NQAq1WgQHXPSomZM+HT55lhDV/Ry7E9waM8RCiEZ2shkAsV14BJadWzm
         dXxQ==
X-Gm-Message-State: AOPr4FVqCjVUIK6A1WfnOZM2PiRqoob0m4W6JWCMi9fcVNY6rPxrYMdAvqCD2aetBum0MpmaOQYtCPXbPlm7ab3N
X-Received: by 10.129.80.11 with SMTP id e11mr5878860ywb.197.1463611266584;
 Wed, 18 May 2016 15:41:06 -0700 (PDT)
Received: by 10.37.116.197 with HTTP; Wed, 18 May 2016 15:40:37 -0700 (PDT)
In-Reply-To: <xmqq8tz7qb7d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295020>

On Wed, May 18, 2016 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The commit from the submodule that is bound to the superproject may
> no longer be sitting at the tip of any branch in the submodule.  The
> hack you are outlining here would not help, and invites "the feature
> works some of the time (i.e. the commit happens to be at the tip of
> one of the refs) but fails most of the time" bug reports.

Sure, that's a reasonable fear. In this case the branches don't move,
but if one were concerned about that one could use tags instead. It is
quite reasonable to point a submodule to a tag and not expect that to
go away.

> So I am not enthused, even though at the technical level, I agree
> that it is a good "solution" to pretend as if one of the refs were
> requested after the fetch-pack discovers the refs advertised by the
> upload-pack.

It could also lead to allowing "git clone -b $SHA".

It's possible to implement this today by manually doing the conversion
via git ls-remote. This is a significant streamlining that would
interact well with the recent change to submodules to attempt "git
fetch origin $SHA1".

> I just fear that it is a wrong approach to solve the real issue and
> instead make it worse by relieving the pressure from the project and
> hosting site to configure their repository to support their users
> properly.

Unfortunately I don't see the likes of github or bitbucket adding
allow-reachable-sha1-in-want any time soon, as it is an expensive
operation server-side.

This is a significant boost to utility of shallow submodules (a flag
for which was just recently added to clone), without requiring any
significant changes to repository configuration.

- JP
