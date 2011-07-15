From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: branch tracking: inherit upstream
Date: Fri, 15 Jul 2011 11:51:59 -0400
Message-ID: <CAG+J_DyxMJtzf2N90vgJjQL1SikUw__KECBhrJWC=SgpYNdG0A@mail.gmail.com>
References: <20110715110928.GA3425@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 17:52:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhkgT-0000Ia-F3
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 17:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab1GOPwD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jul 2011 11:52:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:38514 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1GOPwC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2011 11:52:02 -0400
Received: by gyh3 with SMTP id 3so591440gyh.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AMb7eHuAJO/SMV0JFmmRFxCSxfi+imrrLa/OlLZwwIw=;
        b=bAHFc3CVNl4I451zH/jRMZ9Ijed5vX4b2qfVqsOjXVix95dYePsHCIbxreQ7oihpnA
         kWfq9wGeNt+3/7uNmxMap0iQUQWtg36MDvEY4OC0uEH2md+YQXUbcoDvgBIG++Va0mfW
         XC36c6qhoSwZPISOvxtoK3nbAb3urlxaBLubQ=
Received: by 10.236.200.199 with SMTP id z47mr4393039yhn.407.1310745119889;
 Fri, 15 Jul 2011 08:51:59 -0700 (PDT)
Received: by 10.147.82.8 with HTTP; Fri, 15 Jul 2011 08:51:59 -0700 (PDT)
In-Reply-To: <20110715110928.GA3425@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177199>

On Fri, Jul 15, 2011 at 7:09 AM, Pete Wyckoff <pw@padd.com> wrote:
> At work, our primary SCM is perforce (p4), but many of us use git
> in front of that for day-to-day work. =C2=A0The build system requires
> information about what part of the P4 repository it is building.
> I've cobbled together changes to make this work with git, and
> have been using "git merge-base HEAD @{upstream}" to find the
> top-most git-p4 commit.
>
> But @{upstream} is not automatically inherited by branches. =C2=A0It
> is fine when a local branch is a normal tracking branch of
> origin/master, like:
>
> =C2=A0 =C2=A0$ git checkout master
> =C2=A0 =C2=A0$ git rev-parse --symbolic-full-name @{upstream}
> =C2=A0 =C2=A0refs/remotes/origin/master
>
> But I'd also like this to work:
>
> =C2=A0 =C2=A0$ git branch feature
> =C2=A0 =C2=A0$ git checkout feature
> =C2=A0 =C2=A0$ git rev-parse --symbolic-full-name @{upstream}
> =C2=A0 =C2=A0error: No upstream branch found for ''
> =C2=A0 =C2=A0@{upstream}
> =C2=A0 =C2=A0error: No upstream branch found for ''
> =C2=A0 =C2=A0fatal: ambiguous argument '@{upstream}': unknown revisio=
n or path not in the working tree.
> =C2=A0 =C2=A0Use '--' to separate paths from revisions
>
> I know I can do:
>
> =C2=A0 =C2=A0$ git branch --set-upstream feature origin/master
>
> but that is a pain. =C2=A0And I know I can track the local master, bu=
t
> that is not what I want.
>
> I'm looking for something like "branch.autosetupupstream" that
> would cause the upstream of new branches to be copied from the
> old branch (when it exists). =C2=A0Does this make sense?

Yeah, this is something I'd like to fix:

  http://thread.gmane.org/gmane.comp.version-control.git/168157

j.
