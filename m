From: Samuel Maftoul <samuel.maftoul@gmail.com>
Subject: Re: git clone submodules recursive and reference
Date: Mon, 23 Apr 2012 10:06:41 +0200
Message-ID: <CAFj+z05G_LLLc=OqZiqKCJPpTZ21Y4W6HTJ6ZitraVZXEQ50-A@mail.gmail.com>
References: <CAFj+z055ZZc-Am+pEMgjRvHgoxKSRBjnHhABCseC45+8YswKWg@mail.gmail.com>
	<4F91B22A.9000507@web.de>
	<CAFj+z04A5v7Cz=Wbqn_TBJQG88rPSfrs4T1=22x1N+v77ZXgYA@mail.gmail.com>
	<4F92BA0C.4030009@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 10:06:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMEIR-0000vV-F5
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 10:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752281Ab2DWIGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 04:06:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:59998 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab2DWIGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 04:06:42 -0400
Received: by qcro28 with SMTP id o28so6732010qcr.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2BUBP12uCig4W6yTQAkj33XSmfRpQUk2SK40X5mvSas=;
        b=0dk8yhN3p/Fnd+JtCIE9yUMazitfm5wUo4teVNwxhdyv3jHJM0lnVx9g2MMwXKxIcc
         f7++GmRxXBGd0k9jPEDg1A3TP/z/ItN1BkOY3Con5LCAPY/uqiI35L1Q4+W2qQS9z6uE
         SJc54XDkh2FI32LMfBAKlLLbBVaXuu+pfMj4IfvfnxPPeALhQCNk7lTfMpclT/B+zRdc
         /kuP9Qg3hPVNsN4WOYNmKa7Jd/yKwLiXsei6KActFDY6O9IbT6WlfjlaDXCD2vpeTJXf
         42saDUbH4rBFqL0kN0Sv6HK6QLEyKxK8g9jX+yhoTkylKZ6/oRrxvMLag941Rh/0lYkJ
         16ZA==
Received: by 10.224.31.202 with SMTP id z10mr12769230qac.31.1335168401207;
 Mon, 23 Apr 2012 01:06:41 -0700 (PDT)
Received: by 10.229.131.210 with HTTP; Mon, 23 Apr 2012 01:06:41 -0700 (PDT)
In-Reply-To: <4F92BA0C.4030009@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196098>

>> I'm sharing objects between repositories by creating a bare
>> repository, adding the remotes for the repositories and fetch them in
>> this bare repo.
>
> This sounds like a cool way to reduce the disk footprint of the
> repos on our Jenkins server.

I'm not using --reference for reducing disk footprint, but rather for
caching git repos and reducing the impact of slow networks !
Why would it reduce the disk footprint ?

>
>> So for me, it makes sense to pass the "--reference" to the submodules
>> clone, if submodules remotes are added to this reference bare repo and
>> objects are already fetched (and I'm in this case, as I use a lot of
>> different projects that shares the same set of submodules).
>
> How do you fetch then, do you fetch into the referenced repo first
> and then do a fetch in the clones afterwards to just update the refs
> there? Or is the bare repo just a starting point for the initial
> clone?

You need to fetch first in the bare repo, than in your clones. When
you use --reference, the reference leaves untouched, it's your job to
update the reference (would be nice to have options that allows to
update the reference at the same time that the clone updates, so no
need to connect twice to the remote repository).

> Hmm, me thinks we'd have to add a new option for that, and I'm not
> sure it is worth it.

Maybe it's not worth ...
