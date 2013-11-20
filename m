From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: defaulting git stash to "--keep-index"
Date: Tue, 19 Nov 2013 21:10:25 -0500
Message-ID: <CAEjxke_FNoj__J0y6JoXiFTAYY7WGDP4ntwJXcJO8=gxASbQCQ@mail.gmail.com>
References: <20131119195009.6d4e183b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 03:10:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VixFj-0000Xy-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 03:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288Ab3KTCKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 21:10:47 -0500
Received: from mailhub249.itcs.purdue.edu ([128.210.5.249]:59825 "EHLO
	mailhub249.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752423Ab3KTCKq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 21:10:46 -0500
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com [209.85.216.174])
	(authenticated bits=0)
	by mailhub249.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAK2AjTh009314
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 19 Nov 2013 21:10:46 -0500
Received: by mail-qc0-f174.google.com with SMTP id r5so1588497qcx.33
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 18:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PpgSi0akD0vUF6KALKzKqSL0i8vG1cPNE4WkuZnnqUk=;
        b=I6XRiTTzuMzXvSP/nMxHxWJViTzX0KCU408ZFrEBIIo2v63M8BjklvRCMvM3CkU2qt
         j3dHvdHwEufgbzTQuC6S1rChlqcjg7jv3uylvPf0GicRs49pQBXD44jasPD4zeMWw/rU
         /X2SNoiBLIG7m30/nJY4lo5IsEMnc1UEzTBxs9/SD94chRXxXsJbSMW08iTEco8/UQ31
         4Vzjdq/bTH+6n2JFEcXdXYDE0EWrBnpq6OsblE3t0rGSQoMzeDDqo9VsZsGZfFZDiMh2
         51/j2n4Cvftp9y6YDrhlXLeu4vjCnUGh5v9sa1iSs1QR+63d71i6WKirCCBSFyrRNsPH
         xI/g==
X-Received: by 10.49.1.230 with SMTP id 6mr48834399qep.48.1384913445389; Tue,
 19 Nov 2013 18:10:45 -0800 (PST)
Received: by 10.224.127.131 with HTTP; Tue, 19 Nov 2013 18:10:25 -0800 (PST)
In-Reply-To: <20131119195009.6d4e183b@bigbox.christie.dr>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238065>

On Tue, Nov 19, 2013 at 8:50 PM, Tim Chase <git@tim.thechases.com> wrote:
> Having lost "add -p" work enough times when stashing, I finally
> dug into the docs to see how to prevent it, discovering that
> "--keep-index" does exactly what I want.  However, now I have trouble
> remembering to add the "--keep-index" until after I've shot myself in
> the foot.  How do I go about getting "git stash" to default to
> "--keep-index"?  I've played around a little with aliases, but
> haven't found the right incantation.
>
> The existence of "--no-keep-index" suggests there's some way to make
> "--keep-index" the default, but I'm missing it.
>
> Thanks,
>
> -tkc
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

git-config(1) states that you cannot hide existing Git commands. In
other words, aliasing "git stash" to "git stash --keep-index" is not
possible. You could try playing around with the exclamation point
version (e.g. `git config "alias.stash = !git stash --keep-index"`),
but I suspect that Git will still not allow you to hide the existing
command.

If you are willing to switch to a new command, you can fix this
easily. For example, either of these would do what you want whenever
you run `git stsh` (note the missing "a" in "stash") or `git stashki`:
    `git config "alias.stsh = stash --keep-index"`
    `git config "alias.stashki = stash --keep-index"`

Jason
