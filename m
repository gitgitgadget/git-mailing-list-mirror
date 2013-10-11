From: Stefan Zager <szager@google.com>
Subject: Re: Windows performance / threading file access
Date: Thu, 10 Oct 2013 22:35:47 -0700
Message-ID: <CAHOQ7J_sNnajm9M+QUd-QwkQGP2vOidzAW5_5EzsdwBGTDCnSA@mail.gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
	<52570BC1.2040208@gmail.com>
	<52574B90.3070309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 11 07:35:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUVOD-000819-OE
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 07:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752272Ab3JKFft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 01:35:49 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:65078 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab3JKFfs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 01:35:48 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so2335038vbg.25
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 22:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ri7N6BerCC22gtiFx9CFmA4tbZ+kI1c9yxnGVJiQJc4=;
        b=jEsG63X5lmj/jB6DvaLm1k6RCJJ5N4UMXPxmcDM9hWcYtxfyu5+ngx0yWztIBzsYdv
         EIf5MR6gKy00n9BuOHM2gWgDy2K/3Rp5Gyd4ySxIRIseDIthPTucSF1Gtv3BeOLfz3/d
         JBRokz/mJ9bQahQr5Ed6kXTnCwWenh4dhT3k+czk19yuEdpBLuR/cHgOEqYU/gsxj3HE
         ib/Af1Otw6knvGVTR/HyM0/DO+tUQheYkJIhEzC/Kld9BD7AmbA4DHlNQSVltx9+4BIw
         UpmjCs/wJLS+0lmxvye6RKfFrQZluIj+slo+XE4czbt5td4WsxLg2pZQjiX7qFes+0+0
         yWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ri7N6BerCC22gtiFx9CFmA4tbZ+kI1c9yxnGVJiQJc4=;
        b=FkVMlmEMk1nDy2Vj3OwZTS4MVCEDfuEee6vWY6cx8O6kbNq+7EwWJazVaP5iUrxp9Y
         iD1LNyrW6FRThvSTQomMiSwjMjBxPexvH66mempMbn7hUOPc80p+ltHj48J3TdpgZ/HD
         6HcY4GY/3nGDbrB3nr5w4Kxn9UjDBA9AUMu997hY/tggV84lRmfT7gkw2Avf/3P7TK/h
         y3zg2fS21EmqETvIU5UYaQx0najQ5JN0mtXmu83VUnDX+moMycvpHKQzUcluDnNSelTK
         Ho/m00jUtdrDdNtgVSrMl/N27jD93MHXGj+SAa7IXTWXLzs8ll4paiJJAsh2OTwngSML
         1k9w==
X-Gm-Message-State: ALoCoQkeExLe9AUloazq8f4PCe+tW0zvS+ZfvqQhaVkpw9lEm3pE9pJGxof+2vWZrNF4UG62pLDQXDsHfnTvHh3u39+Pr+MuE/TtpxKnPVFE1SE9sIj0RIWtaIbMNZteBMRJkyQSXr98Muf28+4T9kzJexMXSWglbKzAPfTg2Xu0AMJOyP7Cn2yzGH40vNLNu3de/1f0Bm6w
X-Received: by 10.220.181.136 with SMTP id by8mr20046876vcb.11.1381469748039;
 Thu, 10 Oct 2013 22:35:48 -0700 (PDT)
Received: by 10.52.115.165 with HTTP; Thu, 10 Oct 2013 22:35:47 -0700 (PDT)
In-Reply-To: <52574B90.3070309@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235893>

On Thu, Oct 10, 2013 at 5:51 PM, Karsten Blees <karsten.blees@gmail.com>wrote:

> >> I've noticed that when working with a very large repository using msys
> >> git, the initial checkout of a cloned repository is excruciatingly
> >> slow (80%+ of total clone time).  The root cause, I think, is that git
> >> does all the file access serially, and that's really slow on Windows.
> >>
>
> What exactly do you mean by "excruciatingly slow"?
>
> I just ran a few tests with a big repo (WebKit, ~2GB, ~200k files). A full
> checkout with git 1.8.4 on my SSD took 52s on Linux and 81s on Windows.
> Xcopy /s took ~4 minutes (so xcopy is much slower than git). On a 'real' HD
> (WD Caviar Green) the Windows checkout took ~9 minutes.

I'm using blink for my test, which should be more or less indistinguishable
from WebKit.  I'm using a standard spinning disk, no SSD.  For my purposes,
I need to optimize this for "standard"-ish hardware, not best-in-class.

For my test, I first run 'git clone -n <repo>', and then measure the
running time of 'git checkout --force HEAD'.  On linux, the checkout
command runs in 0:12; on Windows, it's about 3:30.

> If your numbers are much slower, check for overeager virus scanners and
> probably the infamous "User Account Control" (On Vista/7 (8?), the
> luafv.sys driver slows down things on the system drive even with UAC turned
> off in control panel. The driver can be disabled with "sc config luafv
> start= disabled" + reboot. Reenable with "sc config luafv start= auto").

I confess that I am pretty ignorant about Windows, so I'll have to research
these.

>> Has anyone considered threading file access to speed this up?  In
> >> particular, I've got my eye on this loop in unpack-trees.c:
> >>
>
> Its probably worth a try, however, in my experience, doing disk IO in
> parallel tends to slow things down due to more disk seeks.

> I'd rather try to minimize seeks, ...
>

In my experience, modern disk controllers are very very good at this; it
rarely, if ever, makes sense to try and outsmart them.

But, from talking to Windows-savvy people, I believe the issue is not disk
seek time, but rather the fact that Windows doesn't cache file stat
information.  Instead, it goes all the way to the source of truth (i.e.,
the physical disk) every time it stats a file or directory.  That's what
causes the checkout to be so slow: all those file stats run serially.

Does that sound right?  I'm prepared to be wrong about this; but if no one
has tried it, then it's probably at least worth an experiment.

Thanks,

Stefan
