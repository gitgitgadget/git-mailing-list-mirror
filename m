From: Phil Hord <phil.hord@gmail.com>
Subject: Re: git reset respect remote repo (make git idiot proof)
Date: Wed, 3 Oct 2012 12:40:00 -0400
Message-ID: <CABURp0qVWg2PvD4PcjJ9q45x9WxJCuJEQL8Rze=qerWXg72Txw@mail.gmail.com>
References: <k4hj91$4tt$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Geoffrey De Smet <ge0ffrey.spam@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJRzv-0002Lp-El
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 18:40:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab2JCQkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 12:40:23 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40126 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab2JCQkW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 12:40:22 -0400
Received: by lbon3 with SMTP id n3so6390687lbo.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 09:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xxSksscs4KPEtFhF0PFJBVK9oUVJ4rcJ/eiNBisZC44=;
        b=oHexh8xfUDH7LbPyKZX42h/LLkSf56XQ5I5Gk7WBuRKFCPI7eRGF3JOFyHVqPv7tYM
         +ArI21LbgFK8BysBPDBfD2ppWwG2qjupzyRDDT3zP0bGrF+74epmKS3wevKy7f0RCtuJ
         6BN5T/QYi9u+f1KK1zFg3rKkTs4l0FOE6y9xijfcbZZmhBlU7+5kRkn9cB+e5FoSx+uw
         irk+8JMZzMEHjhWK4v8f5yveBAmFhKoZVxPDr3wj//ut2gK+WmOw73RQVqeYD6vDJaAu
         Bc7NL3l6bxP90zpwbEb7EzLw6D42bJb7jy7QUNZnR60ixUfvCHBTIpWuWwSYeOnfy1TW
         16kw==
Received: by 10.112.36.2 with SMTP id m2mr1916878lbj.108.1349282420811; Wed,
 03 Oct 2012 09:40:20 -0700 (PDT)
Received: by 10.114.17.225 with HTTP; Wed, 3 Oct 2012 09:40:00 -0700 (PDT)
In-Reply-To: <k4hj91$4tt$4@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206911>

On Wed, Oct 3, 2012 at 10:49 AM, Geoffrey De Smet
<ge0ffrey.spam@gmail.com> wrote:
> Suppose this case:
>
> git clone .../blessedRepo.git
> // do changes
> git commit -m"bad1"
> // do changes
> git commit -m"bad2"
> git reset --hard HEAD^4 // Why does it let me do this?
>
> // I just "broke" my local repository, because if I continue
>
> // do changes
> git commit -m"good1"
> git push origin master // fails because the history disrespects the remote
> repo's history
>
> The following commands are ok to do (because I have 2 unpushed commits):
>  git reset --hard^1
>  git reset --hard^2
> but these are not and should be prevented (unless forced):
>  git reset --hard^3
>  git reset --hard^4
>
>
> Is there any way to make git idiot proof by enabling that the local repo
> should always respect the history of the remote repo (unless forced)?
> Is there any way to make this a default for anyone who clones our blessed
> repo?

I suppose if we go down this path we must also prevent users from
having any local branches whose names match those used on the remote
unless the remote branches are also ancestors of our local branch.
But then we may get into trouble when we pull new branches which now
conflict but previously did not.

I'm afraid this is a Pandora's box of woes.

But I feel your pain.  I think the solution lies in relegating 'reset'
to the plumbing or the power-user realm of commands since I feel it is
quite overloaded and sometimes dangerous.  There was a thread some
months back heading in this direction, but I failed to keep it going.

    http://comments.gmane.org/gmane.comp.version-control.git/185825


Phil
