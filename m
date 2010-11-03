From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: rebase not honoring core.worktree pointing elsewhere
Date: Wed, 3 Nov 2010 07:13:58 +0700
Message-ID: <AANLkTi=T5kHfgNOpOtCDCoq7epEgwUrVayaUCbf35dSU@mail.gmail.com>
References: <loom.20101101T182113-378@post.gmane.org> <AANLkTi=ejRcnz+83zc2Z-6etUGMsBSw1FFUY0JNFRFGB@mail.gmail.com>
 <loom.20101102T165800-486@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Drews <paul.drews@intel.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 01:14:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDQzi-00009h-UH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 01:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab0KCAOV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 20:14:21 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38767 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0KCAOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 20:14:20 -0400
Received: by wwe15 with SMTP id 15so58884wwe.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 17:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0rDUCogycoxqlpmww6ADyevsaMpkmF3P2dtIWJGUAcQ=;
        b=DjdvX4hqBuqs0S+tF6LUZSwZzLqjwmmsMZhedMCCl4zhstujBmwLTzvqcT+iFJzqPu
         A5sPwGOBmJZliHQsbJ8bcrJMP71rimJuxF6kKhNzcnmbiE6K25/6vbpaWv5+J9Jnpgt+
         GDjvLUCjCJXaHto+nn1MQx/t3eZw7zaCldKNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Jw1/Y/cPid/BOYpPk9X+o2yGBUUBYc/HILtTLoJ27ovjTIamZNIqnZy78Aqhmqot9h
         WCreTDCY0CGYrEGDis9GWAcmZYF5vDUTFPeHszKUWszazY6yvh0XAkP6H0Dk9HOU7QSC
         RMEC64774diukz18MYhsPg+zTksK5Ptz/K+mw=
Received: by 10.227.151.202 with SMTP id d10mr1766563wbw.146.1288743258692;
 Tue, 02 Nov 2010 17:14:18 -0700 (PDT)
Received: by 10.216.172.199 with HTTP; Tue, 2 Nov 2010 17:13:58 -0700 (PDT)
In-Reply-To: <loom.20101102T165800-486@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160567>

On Tue, Nov 2, 2010 at 11:26 PM, Paul Drews <paul.drews@intel.com> wrot=
e:
> BTW, the impetus for this is a big integrated cross-compilation build=
 system
> that has a nasty habit of deleting and re-creating a chroot environme=
nt
> containing the directory structures including the work tree. =C2=A0If=
 the ".git"
> dir is at the "normal" place "inside" the work tree, it gets deleted =
along
> with all the work I have done. =C2=A0Not good, which is why I want to=
 keep the
> ".git" somewhere else that's safe. =C2=A0Solutions to this:
>
> (preferred) core.worktree pointing into worktree elsewhere, run all g=
it
> commands from GIT_DIR. =C2=A0Would be great if rebase worked under th=
ese
> circumstances.
>
> (best fallback) no core.worktree, export GIT_DIR pointing elsewhere, =
run all
> git commands from unmarked root of worktree.
>
> (complex) A complex scenario pushing and pulling stuff between a git =
repo
> inside the worktree and another git clone outside the worktree.
>
> (implementation dependent) Having the ".git" dir inside the worktree =
be a
> symbolic link to a dir somewhere outside the work tree. =C2=A0Keeps t=
he actual ".git"
> contents safe from deletion. =C2=A0Works so far, but this is Tamperin=
g With The
> Implementation in a way that is likely to fail down the road somewher=
e,
> e.g., if an internal script does cd to the GIT_DIR, then cd relative =
to
> that to try to get back into somewhere else in the work tree.

Another one: create a .git file with this line and put it in worktree's=
 topdir

gitdir: /path/to/real/git.dir

See gitrepository-layout.txt.
--=20
Duy
