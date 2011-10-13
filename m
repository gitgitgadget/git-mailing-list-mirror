From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [CLOSED] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 12:01:23 -0700 (PDT)
Message-ID: <m3vcrs7m3v.fsf@localhost.localdomain>
References: <loom.20111013T094053-111@post.gmane.org>
	<CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>
	<20111013145924.2113c142@ashu.dyn.rarus.ru>
	<loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>
	<loom.20111013T144822-277@post.gmane.org>
	<1318514356.4646.16.camel@centaur.lab.cmartin.tk>
	<loom.20111013T181801-923@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 21:01:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REQX5-0003Qg-5r
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 21:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723Ab1JMTB0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 15:01:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34661 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1JMTBZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 15:01:25 -0400
Received: by eye27 with SMTP id 27so350553eye.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 12:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=1MImiCtbPd0LlPLBlTmvCu9fyRkvbYiwRFWbl0Hj6VM=;
        b=RdZmtOili18xjKWEWFqEVOaadapu03iGs49a9r8k0i2VL3MYxaZmlvfy2c7ZWZlaCl
         wuMjXWXqvQRmt/2tehGYloZoqs2aK5gdBp8687Mgt5i1gpPpnm40yw527Jq/vGqQicjV
         x+iVayMAQx1SJTMwmXypMGRWThDM8BJIkPVFw=
Received: by 10.223.61.211 with SMTP id u19mr7773550fah.29.1318532484143;
        Thu, 13 Oct 2011 12:01:24 -0700 (PDT)
Received: from localhost.localdomain (abvv157.neoplus.adsl.tpnet.pl. [83.8.219.157])
        by mx.google.com with ESMTPS id k26sm1295188fab.12.2011.10.13.12.01.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 12:01:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9DJ0rdI003660;
	Thu, 13 Oct 2011 21:01:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9DJ0bnw003655;
	Thu, 13 Oct 2011 21:00:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20111013T181801-923@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183516>

arQon <arqon@gmx.com> writes:

> (Though if someone can come up with a script / hook / whatever that i=
mproves
> the "visibility" of stash, that would be awesome. Or one that makes t=
he
> refusal to switch branches consistent).

Well, if you use __git_ps1 from contrib/completion/git-completion.bash
(installed with git-core package for some time), there is an option to
add '$' to branch name if stash is non-empty (though it doesn't actuall=
y
check if stash was on said branch).
=20
> Looking at the manpage for checkout in the hope that there might be a=
 "--safe"
> switch, I don't understand why
>
>   "-f  Proceed even if the index *or the working tree* differs from H=
EAD."
>
> even exists, since it proceeds under those conditions anyway.
> "--safe" appears to be exactly what the behavior should be if you DON=
'T
> specify -f, except that -f nukes the working tree outright rather tha=
n just
> bleeding it across. Hopefully it'll be clearer after some sleep.  :)
=20
Without '-f' git-checkout would switch branches only if uncomitted
changes (which do not belong to any branch) could be "floated" on top
of new branch.

If branch you are switching to has differences from current branch
that conflict with uncomitted changes, git would refuse switching
branches.  Now '-f' would get rid of your uncomitted changes, and '-m'
try to merge it with changes brought by new branch.

HTH
--=20
Jakub Nar=EAbski
