From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: separate-git-dir doesn't work with mapped drive
Date: Sat, 19 Oct 2013 16:17:13 +0700
Message-ID: <CACsJy8BReiuw346FT7-jve=UX-i55mAsWm_e=QAMy0XVTBEYZQ@mail.gmail.com>
References: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Ain Valtin <ain.valtin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 11:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXSfS-0004U0-0w
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 11:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab3JSJRq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 05:17:46 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:53902 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978Ab3JSJRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 05:17:45 -0400
Received: by mail-ob0-f176.google.com with SMTP id uy5so1983946obc.21
        for <git@vger.kernel.org>; Sat, 19 Oct 2013 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wqFh9UGzDkoUABsDyxOkQ/6sizxlaIEjhfB7V9de+W0=;
        b=qjdCzvcQtm0hQOUSCIyYg3NTjcDQB7SuFsJlldzoJDwdX+W64KLQycTUUyCKKczCth
         CV0cSlnVQjdaUk8K65oHhHl7UZfPn2+Y3G09mYPQzTtbANHIDZWsDcwhnDrKL9lV1KBq
         vVg8khdQL3LjI+ukR0Q9NzBmSbAGLyZburs6//dXKPZq/6N1+Rd4bJqiANKGwYHDEYXI
         kTawe77Z9gFE9KsZqFDP1j0Lwf1BeUnTLE4ZUFeCDorXtqLp0Ls2n671tpkPywZbrhIX
         675S9RzHCuWcPckMyWfZZoc83BxH8fySDPNeMxw8lu0GsRNwPaHP6j+mTeAaQkjP2gSP
         CUUw==
X-Received: by 10.182.114.231 with SMTP id jj7mr10393908obb.33.1382174265008;
 Sat, 19 Oct 2013 02:17:45 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Sat, 19 Oct 2013 02:17:13 -0700 (PDT)
In-Reply-To: <CADgy815BJAJrbW0JJ2a9vZ4NwzGersceg6b96TPAey_pR+mOiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236392>

There seems to be some regression fixes regarding dos drives. The one
that caught my eyes is 7fbd422 (relative_path should honor
dos-drive-prefix - 2013-10-14) but it's not released yet. And I'm not
sure if msys branch picks it up yet even if you want to rebuild and
test it yourself. Copying Jiang Xin, maybe he can tell if that commit
should fix what you describe here, or it's a new bug.
-- 
Duy

On Sat, Oct 19, 2013 at 3:49 PM, Ain Valtin <ain.valtin@gmail.com> wrote:
> Hi
>
> I want to use git in a VirtualBox guest so that the repository is on
> the host drive. So in the VB settings for the guest I set up a shared
> folder "gitRepos" to /home/ain with full access rights. Then in the
> guest OS (Windows XP) I map this shared folder as G drive. Now in the
> project dir I execute
>
> C:\...\TPP>git init --separate-git-dir g:/TPP
> Initialized empty Git repository in g:/TPP/
>
> Checked, the repo structure is in the "g:/TPP/" (thus the guest OS can
> write to the mapped dir) and in the .git file created to the project
> dir there is line
>
> gitdir: g:/TPP
>
> However when tring to use the repo it fails to recognise the g:/TPP path, ie
>
> C:\...\TPP>git add .
> fatal: unable to access '../../../../../../g:/TPP/config': Invalid argument
>
> Also tryed "gitdir: //VBOXSVR/gitRepos/TPP" but this fails too:
>
> C:\...\TPP>git add .
> fatal: Unable to create 'C:/Documents and
> Settings/Ain/prog/AVT/TPP/../../../../../..///VBOXSVR/gitRepos/TPP/index.lock':
> No such file or directory
>
> Am I doing something wrong or is it a bug? Any idea how to get it to work?
>
> BTW the VB is 3.0.14 ie rather old version but it seems that this
> isn't the problem as the git init recognises the mapped drive but
> other commands fail.
> git version is 1.8.4.msysgit.0
