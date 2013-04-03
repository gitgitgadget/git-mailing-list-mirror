From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Wed, 3 Apr 2013 11:23:51 +0200
Message-ID: <CALWbr2w2jjBmO9pTrw12UGKGC94MQqg6mZynLACLT7B3eoz8VQ@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 11:24:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNJvc-0007aa-4H
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 11:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762169Ab3DCJXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 05:23:54 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:41911 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761292Ab3DCJXw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 05:23:52 -0400
Received: by mail-qa0-f44.google.com with SMTP id o13so1937375qaj.3
        for <git@vger.kernel.org>; Wed, 03 Apr 2013 02:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=AlV1PcIaM02klsYykfUk+L/LyqyY/VwMPaE5PphqTsw=;
        b=JFmkUR8zAobETaZDPqDglC3KpnHLxXTu86qriY/BeTw0sGWAzJI5CKoW677vMwlLhn
         Onf4elq+E0ZrlHiIlAV2qAX/Fq1x65IdWwAhDYG0iGu5ZeVnhT+MpmrqdMgAgYkAnE4b
         J98Z6y/NWlNz+mqyoIQCYNCvpglgl4S6NH2d2Uonog4DKwGRZxubRMqv1PnRHi3Jvrq8
         6y5TKXuy1e9+DZ5zZoyFsjZeSypTLbzZQq2Ad6Asb1PtHrSsrLn1zuSV8plYZuCvAXKz
         Ihuuzx+TfoEtw2bTsL8EC/F9nDtdtPOoVR7Q796y+Su+R9JbqHBbU9jgI9hNniaIrscu
         3JdQ==
X-Received: by 10.49.61.226 with SMTP id t2mr745031qer.40.1364981031946; Wed,
 03 Apr 2013 02:23:51 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Wed, 3 Apr 2013 02:23:51 -0700 (PDT)
In-Reply-To: <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219929>

>> * internally, the marks are using the hg sha1s instead of the hg rev ids. The latter are not necessarily invariant, and using the sha1s makes it much easier to recover from semi-broken states.
>
> I doubt this makes any difference (except for more wasted space).

I think this is definitely wrong. If you happen to strip a changeset
from the mercurial repository, and redo a completely different commit
on top of it, the new commit will never be seen on git end (because it
will have the same rev id and will thus be identified as identical
from git point of view).
