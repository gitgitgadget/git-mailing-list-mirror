From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git p4: any way to avoid rebasing all the time?
Date: Wed, 11 Apr 2012 18:22:59 +0100
Message-ID: <CAOpHH-Ufa7m8rEe+CTEGo-ChLOfFgyBkeiWrP92Sv=VLKgVmZA@mail.gmail.com>
References: <CAE5ih7_Fh0XA-XNNvtHnXhYwUvwmmg-Z+y-Mb5Wvra3Y83eFsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:23:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI1Gb-0000MV-9N
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 19:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760781Ab2DKRXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 13:23:31 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:51186 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760711Ab2DKRXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 13:23:30 -0400
Received: by eekc41 with SMTP id c41so298233eek.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 10:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=64uYRtnNdrtNgN/0Ntdds5BKePpfpnSxJmJIYHgEUo8=;
        b=YphNIPOtg6EEJHybGnod/qZSlVDJiuhXhlwmGYqEfeBNkyyZbo7bpsCv49CpSRrQq1
         Fk0dKFv3eCFbMpSVeYOvdK9JTWzZvzdxCowcqOWqKMj0ItJC3i4YrU7VtdAbvwHykG9y
         i9X25eynVnddWXu/ABY0WNi84o07hzJffMKtf1/uHNB3a4rFWJVHVUGpVlxV4XG47Rl4
         LryHv+uOA/WB1lzsSa61fysGQU8DqwUMf1hEqGan/j9hJ9qRHYFdaVbpA5NlL92WDiwA
         jTFi0EgEK/8mK7xOGLRecBU+vGJKWCU1x/M2yGljAVntvr/rae+E7LfBKBSsbqD1woO4
         +BvQ==
Received: by 10.213.6.195 with SMTP id a3mr1033560eba.78.1334165009316; Wed,
 11 Apr 2012 10:23:29 -0700 (PDT)
Received: by 10.213.31.68 with HTTP; Wed, 11 Apr 2012 10:22:59 -0700 (PDT)
In-Reply-To: <CAE5ih7_Fh0XA-XNNvtHnXhYwUvwmmg-Z+y-Mb5Wvra3Y83eFsw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195221>

On Wed, Apr 11, 2012 at 5:27 PM, Luke Diamand <luke@diamand.org> wrote:
> Is there a way to get "git p4" to not rebase all the time?
>
> Right now, git commits get discarded and replaced with new ones with
> the same contents and extra git-p4 metadata embedded in the comment.
>
> If we put this git-p4 metadata into a git note then we would not need
> to rewrite the commits, and so could perhaps avoid rebasing quite so
> much.
>
> However, if "git p4" won't rewrite commits, then it can't reorder them
> to match the ordering seen from p4.
>
> So you could end up with git users seeing OLDHEAD,G,P and p4 users
> seeing OLDHEAD,P,G, as there's a race to see who submits against
> OLDHEAD first, which p4 always wins.
>
> Would this matter (assuming the git and p4 commits are all reasonably
> independent) or is there a way to avoid it?
>
> Perhaps hook into the pre-receive hook? If the newest p4 changelist is
> not the same as the HEAD of the branch being pushed to, then reject
> the push, just as would happen if the branch could not be
> fast-forwarded in a normal git repo? (Even with this there is still a
> small window of opportunity).
>
> At that point, the "git p4 rebase" command would still be used, but
> would normally be a no-op.
>
> Or would that result in something far too complicated to have any
> chance of working?
>
> Thanks,
> Luke

Hi Luke,

This guy modified git-p4 to store information in notes:

https://github.com/ermshiperete/git-p4

Could you see if his implementation would fit your requirements?

Vitor
