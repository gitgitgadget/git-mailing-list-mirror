From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Thu, 27 Nov 2008 03:05:16 +0100
Message-ID: <85b5c3130811261805n5628ee7agcff3d6ed7dea10bb@mail.gmail.com>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>
	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>
	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>
	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>
	 <492D6CC3.2050408@drmicha.warpmail.net>
	 <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>
	 <492D7AEF.5030908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Fabian Seoane" <fabian@fseoane.net>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 27 03:07:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5WHV-0004Or-OU
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 03:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbYK0CFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 21:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYK0CFT
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 21:05:19 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:43483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbYK0CFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 21:05:18 -0500
Received: by fg-out-1718.google.com with SMTP id 19so490800fgg.17
        for <git@vger.kernel.org>; Wed, 26 Nov 2008 18:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=mmxjr5xZZT0vjjWcDfCg9QxzlVlV9JfKSD+H5eke3ww=;
        b=HP/GHl/TnGnPJ8NofczA3/xtX+aQZSpq2k0GPS10Kq/M8sLmZ/B6J9q+k4i4ptS1J1
         qwpXViz9jYbVAAw6Cv+jjOIKoSkGjkkgMCQX96eLvj+utOwnmER5iQCJ7lnvJ9j67IN3
         rwl2vRiyUQWGgBLkNjY8Bvqkjso30rS9Q5Nls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mPfXZ5opLksR1bzVRGNBLgltMU+B9AT2U6zQ5vlxTCWNfO1lf4UTCZODnc3yiGkhUU
         /gTtX9uTYfD0ped2m9fv8YDWOvd/njtblvWTXE7XliwxXx01qt8nZGtK8HYYTL+R1hVB
         kVsvrElC+H8wEaFSTyLf7mzc9/xZuHBjT1mxo=
Received: by 10.86.72.15 with SMTP id u15mr4262559fga.45.1227751516886;
        Wed, 26 Nov 2008 18:05:16 -0800 (PST)
Received: by 10.86.33.8 with HTTP; Wed, 26 Nov 2008 18:05:16 -0800 (PST)
In-Reply-To: <492D7AEF.5030908@viscovery.net>
Content-Disposition: inline
X-Google-Sender-Auth: bf02eadd24dc9952
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101786>

Hi Johannes!

On Wed, Nov 26, 2008 at 5:35 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ondrej Certik schrieb:
>> I am also trying to make the example simpler. I tried to squash the
>> first uninteresting ~1500 commits into one, but "git rebase -i"
>> uterrly fails after squashing about 600 commits. Still investigating.
>
> Don't use rebase. Set a graft and rewrite the history:
>
>   $ echo $(git rev-parse HEAD) $(git rev-parse HEAD~1500) >> \
>                .git/info/grafts
>
> Assuming "first 1500" means the "most recent 1500" commits. But you get
> the idea. You can truncate history as well by omitting the second SHA1.
> It's very convenient to keep gitk open and File->Reload after each graft
> that you set.
>
> When you're done with setting grafts:
>
>   $ git filter-branch -f --tag-name-filter cat -- --all

Indeed, this seems to be working robustly. Thanks!

>
> (You are doing this on a copy of your repository, don't you?)

Yes.


I spent the whole today trying to isolate the bug, but so far I
haven't succeeded. Unfortunately, I need to work on other things now,
so I am postponing this to some later time. The repository that
reproduces it will stay online, so anyone feel free to produce a nice
and simple (failing) test for the bug.

Thanks,
Ondrej
