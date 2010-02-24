From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [GIT GUI PATCH] git-gui: fix open explorer window on Windows 7
Date: Wed, 24 Feb 2010 07:22:33 +0100
Message-ID: <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com>
References: <20100223225243.GC11271@book.hvoigt.net> <201002240114.11634.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 07:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkAeL-0000gz-Kd
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 07:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab0BXGWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 01:22:55 -0500
Received: from mail-ew0-f212.google.com ([209.85.219.212]:56005 "EHLO
	mail-ew0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0BXGWy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2010 01:22:54 -0500
Received: by ewy4 with SMTP id 4so674345ewy.28
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 22:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ibFFSAeXqC69tb6CUj5YVHw1Yc7Ys/M0vH6essyhU1Q=;
        b=uJFgFFYdzVhR6wRkaxPUjddmg2yP0/yP6xeFzryaQ+7bz2HvwOlcFmCajSk0hGuT9w
         RMo2HUKjx4QlCJBrwraZjrGQ3+YJ9zDO124R41EuJkd8bAeDsxy8lYqtmpfd7eRktSFN
         5jYT8WYzVOkUV311gh1PLVPUkU1GG87OaoS9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UP/qCrEI4waupKJOGP8M2GePc+OprurOedWp4KYxBaMkZ1DBEbBdmQpVd9MmQGMVWa
         mBSP3aJnKkMSKRJnLBJ0fNvdc3zEHweDYAWWRzpTIqCC7OJW/NgNlN7sUDosYskg78oj
         sqAzIKJ1MKyIlmoY64XY2lHMBj5w/UmiqTzAY=
Received: by 10.213.24.17 with SMTP id t17mr10931995ebb.19.1266992573125; Tue, 
	23 Feb 2010 22:22:53 -0800 (PST)
In-Reply-To: <201002240114.11634.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140902>

On Wed, Feb 24, 2010 at 1:14 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
>
> Ah, this doesn't look like what it looked like back then. Commit
> 21985a113 (git-gui: handle non-standard worktree locations) changed i=
t,
> removing the [file nativename]. I don't know if this was by accident,
> but there is another place, where it was changed in a different manne=
r:

My fault, and yes it was by accident.

> Compare
>
> - =A0 =A0 =A0 eval exec $explorer [list [file nativename [file dirnam=
e [gitdir]]]] &
> + =A0 =A0 =A0 eval exec $explorer $_gitworktree &
>
> with
>
> -wm title . "[appname] ([reponame]) [file normalize [file dirname [gi=
tdir]]]"
> +wm title . "[appname] ([reponame]) [file normalize $_gitworktree]"
>
> Maybe _gitworktree should be normalized or nativenamified when it is =
set
> and then will work everywhere it is used for every platform?

The only issue with that would be that GIT_DIR and GIT_WORK_TREE are
(re)inizialized
from _gitdir and _gitworktree, so it would not be safe if git on
Windows works better with unix-style rather than native paths. If git
on windows handles native paths fine, it should be no problem.

--=20
Giuseppe "Oblomov" Bilotta
