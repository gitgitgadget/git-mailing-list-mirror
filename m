From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: remote branches
Date: Sun, 13 Feb 2011 10:17:48 +0100
Message-ID: <AANLkTi=WPAYXg1NCyO+XDw8Jk5v=QBH3nM78CEHytuVQ@mail.gmail.com>
References: <4D578B6D.9090803@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Imbert <matthieu.imbert@inria.fr>
X-From: git-owner@vger.kernel.org Sun Feb 13 10:17:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoY5d-0002Xr-03
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 10:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab1BMJRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 04:17:52 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33452 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab1BMJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 04:17:50 -0500
Received: by fxm20 with SMTP id 20so4131984fxm.19
        for <git@vger.kernel.org>; Sun, 13 Feb 2011 01:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=m7CAVPQUrkDjSKVaZakeyXqIo71GPuDrJ6jcXUSJsKQ=;
        b=SDpqysRRRrSePmrLTGEdd3g72BjVZIu4Bsh8gHtDFheUsA/he0sUZNrNS+j63smY3Z
         GFyafLSxwvre2/orKCTxgf9dLhWYgI313k7TU3fjFwRGtxSR1Cs5KZpQ/vc+ef52wjuM
         B2JwYOQkYZXbZfxtTXlMwnJQa8GMIHOoJN820=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YSrZskNtd87B8iuRqCprTmFch6qAZcX3bDUSYXdwJFTDr87RUnZVvx86NvRK36sfJy
         CsjQI4UfomzlJHoBRvSHa5KBr0b6j0wLEGQf3vfqHIXRqJGASZJXAaK8+xScAf5I9PH9
         oUKeNJ9vlk3D7oT5eLVKcJeU8ock1/hCKpOEA=
Received: by 10.223.111.137 with SMTP id s9mr2911393fap.98.1297588668157; Sun,
 13 Feb 2011 01:17:48 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Sun, 13 Feb 2011 01:17:48 -0800 (PST)
In-Reply-To: <4D578B6D.9090803@inria.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166647>

On Sun, Feb 13, 2011 at 08:42, Matthieu Imbert <matthieu.imbert@inria.fr> wrote:

> $ git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6.git
>
> - then i add a remote tracking branch:
>
> $ git remote add --tags drm-intel
> git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel.git

You're adding a remote repository and tracking branches and tags from
it.

> - Then i do git fetch or git fetch drm-intel, but nothing happens, and git
> branch -r still only show me origin/HEAD and origin/master, no drm-intel
> branches, though these branches do exist since i can see them with git
> remote -v show drm-intel

You didn't add any remote tracking *branch*, you added a remote and
gave it the name "drm-intel". You could just as well do:

    git remote add --tags some-random-name
git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel.git

Also because you specified --tags you're only getting the tags on "git
fetch", if you don't do that then:

    $ git fetch some-random-name
    remote: Counting objects: 567, done.
    remote: Compressing objects: 100% (377/377), done.
    remote: Total 488 (delta 371), reused 146 (delta 111)
    Receiving objects: 100% (488/488), 91.42 KiB, done.
    Resolving deltas: 100% (371/371), completed with 53 local objects.
    From git://git.kernel.org/pub/scm/linux/kernel/git/ickle/drm-intel
     * [new branch]      drm-intel-fixes -> some-random-name/drm-intel-fixes
     * [new branch]      drm-intel-fixes-2 -> some-random-name/drm-intel-fixes-2
     * [new branch]      drm-intel-next -> some-random-name/drm-intel-next
     * [new branch]      drm-intel-staging -> some-random-name/drm-intel-staging

Which allows you to do:

    $ git checkout --track some-random-name/drm-intel-fixes
    Branch drm-intel-fixes set up to track remote branch
drm-intel-fixes from some-random-name.
    Switched to a new branch 'drm-intel-fixes'
