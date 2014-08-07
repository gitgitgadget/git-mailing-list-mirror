From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Bug#757297: 'git status' output is confusing after 'git add -N'
Date: Thu, 7 Aug 2014 08:51:14 +0700
Message-ID: <CACsJy8DnWZfKqwjOjjU17YtN1Zqk0vy5nyfOBLjn-RiJkKCo6Q@mail.gmail.com>
References: <20140807003449.GC12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: submit@bugs.debian.org
To: Jonathan Nieder <jrnieder@gmail.com>, 757297@bugs.debian.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 03:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFCrt-000533-Uo
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 03:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbaHGBvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 21:51:46 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62954 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbaHGBvp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 21:51:45 -0400
Received: by mail-ie0-f177.google.com with SMTP id at20so3670713iec.8
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zSSa+76UBYbqbxsof9JwT3GXmUYvkoFErUASNANugQE=;
        b=H0je4t8xf6tFeKNA61wADN4N0eAyHxiepfD5p7LyvJJzLP5d3MCS6e3fWUsdSHBzMK
         ThlODiWMo/4VmyTAiByricwksBF4TVRp4CMpABSBZ/rRAcspjInDRnpbcftn4QURILr/
         hpVEFkmNyUY0zzPaMqMHZGz61yx8H3oo280Sx82WR61d+owk+xhclFA4w3wk36nqjr0z
         ItUEE+PBOdAQ5S84ENSRgQWYlB6dvYCS/kpY7jy2RAVkw2CuStyr5ahh6O/68tT7Gjje
         AOyselGqoD0qGA43KXR4n7FcXWNSBsVMlUDMPNwNhZku166hybspBWQ4sQ//FQQcwqSP
         4KMw==
X-Received: by 10.42.65.3 with SMTP id j3mr19959929ici.65.1407376304481; Wed,
 06 Aug 2014 18:51:44 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Wed, 6 Aug 2014 18:51:14 -0700 (PDT)
In-Reply-To: <20140807003449.GC12427@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254942>

On Thu, Aug 7, 2014 at 7:34 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Package: git
> Version: 1:2.0.0-1
> Tags: upstream
>
>   $ git init foo
>   Initialized empty Git repository in /tmp/t/foo/.git/
>   $ cd foo
>   $ echo hi >README
>   $ git add -N README
>   $ git status
>   On branch master
>
>   Initial commit
>
>   Changes to be committed:
>     (use "git rm --cached <file>..." to unstage)
>
>           new file:   README
>
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
>     (use "git checkout -- <file>..." to discard changes in working directory)
>
>           modified:   README
>
> If I then run "git commit", it does not actually commit the addition
> of the README file.

We used to reject such a commit operation before 3f6d56d (commit:
ignore intent-to-add entries instead of refusing - 2012-02-07) so it
was harder to misunderstand this case.

> It would be clearer to have a separate section,like so:
>
>   Tracked files not to be committed:
>     (use "git rm --cached <file>..." to stop tracking)
>
>            new file:   README
>

Or make the "Changes not staged for commit" part say "new file:
README" ("modified" is implied)
-- 
Duy
