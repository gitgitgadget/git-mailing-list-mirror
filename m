From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: need help with syncing two bare repos
Date: Sat, 4 Aug 2012 00:44:18 +0530
Message-ID: <CAMK1S_jmML56ef2EVZqEX6i+_y-NyaoazZdXQQ+N88GWL4X2Qg@mail.gmail.com>
References: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 21:14:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxNKl-0001Ov-EF
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 21:14:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877Ab2HCTOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 15:14:20 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34610 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527Ab2HCTOU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 15:14:20 -0400
Received: by lahd3 with SMTP id d3so562270lah.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UiUWJ5Qyl2dymcerGhPuTiEwPFHrtZlO3rNCSDustuQ=;
        b=pH5j+Bn9cPPM6Mkk1SOAhCr+xrpSm6eoDqtJVRv7V0ZigpE75dfMHar2wWgga3HHQR
         a1N0equ7b88PO/Rv4q5toXck/rG47ClQK4iRIiIxZ7YUF02XAnjZ8jkz0/0EszVMMAux
         k/HmqZrHtZes/sS8dM2Ij+sTUHQPIFh5OY2CEwmCtOIb1QOcBHBey/F1wGiUfhfMGVjb
         9RMAPa19xHtWb1xohxUHxsCgNby4h5pkE/yVbWioJd7du5NJclhcI0FEmCaj9FushLsV
         OihFRQYLQfVr+SnjnMJRmNrkQcAQkdrXULKXbkmdgHBNeHm/hcPVH9qAlsycgH6/7ygJ
         cx9Q==
Received: by 10.152.148.195 with SMTP id tu3mr2536024lab.16.1344021258374;
 Fri, 03 Aug 2012 12:14:18 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Fri, 3 Aug 2012 12:14:18 -0700 (PDT)
In-Reply-To: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202849>

On Fri, Aug 3, 2012 at 11:59 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Hi,
>
> Could somebody please advise about how to address the following:
>
> I have a bare repo (bareA) on one server in network1 and i have a
> mirror of it on another server (bareB) in network2
> BareB is updated periodically - no problem here
> If bareA dies users are supposed to move seamlessly to bareB.
> When bareA goes back up users are moved back but before it starts
> serving repos (before git-daemon starts) it updates from bareB.
>
> Now the problem i have is if bareA doesn't actually die, but the
> connection between two networks drops.
> In this case users from network2 will stop seeing bareA, they will
> start working with bareB, while users in netwrok1 will continue
> to work with bareA.
>
> What would be the best way of syncing the bareB back to bareA when
> connection is restored?
>
> I think the best variant would be to do something like:
>
> $ git pull --rebase /refs/heads/*:/refs/heads/*
> $ git push origin /refs/heads/*:/refs/heads/*
>
> but pull will not work on bare repos as i understand and there might
> be conflicts that will lead to unknown (for me) state of bare repos
>
> May be I'm looking into wrong direction? May be simple two way rsync
> will do the job? But I'm a bit reluctant to rely on rsync because I'm
> afraid it may screw up the repository information.

The way I solve this is to insist that I *manually* specify which is
the push destination and not make it automated.  The other one is a
read-only mirror until something is manually switched.

Might not be ideal for every situation; your call...
