From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 19:50:30 +0700
Message-ID: <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino>
 <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com> <20101021033042.GA1891@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 14:50:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ubj-0007jU-9f
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab0JUMux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 08:50:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44104 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676Ab0JUMuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 08:50:52 -0400
Received: by wwf26 with SMTP id 26so2520653wwf.1
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 05:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=6EfuTpBxUoETF8hWL6+RCq3gfmk+w5cFnOamzlG1X/g=;
        b=M/Q+2z/3vNAOHg3sx1jCEwldRYolhO1CnhjKX9TBgb61DAzneMiEc73DldPx70D0ER
         3h6Iu+VO7jXUAXHzTWCubg9g4BdHj4SsLwV7xBDZkE7Yi/ygmWryhqToO8068nz7huc/
         VTF6QU/bnH0wR8vVjtOI8lP7P6DyGS+YxLSNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NiIouAtvk2cIDT7p2gmtZrUkksP+1eViPSSH0bom1U6YWjf+u/uRQ/mt/OanhX9hVg
         kzl8PGVs3etir+U7P75/h6lg3FZtyv6aRKvFpnrisU7i394fear/6Opnyik1n2RdGfB4
         5Pm/5kF21C4W9CRtbx72/jsWfKrGgK5Hwq/Us=
Received: by 10.227.145.135 with SMTP id d7mr1062380wbv.96.1287665451202; Thu,
 21 Oct 2010 05:50:51 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Thu, 21 Oct 2010 05:50:30 -0700 (PDT)
In-Reply-To: <20101021033042.GA1891@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159498>

On Thu, Oct 21, 2010 at 10:30 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguyen Thai Ngoc Duy wrote:
>> On Thu, Oct 21, 2010 at 2:07 AM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>
>>> =C2=A0- otherwise, if original cwd was under repository,
> [...]
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_WORK_TREE defau=
lts to unset.
>>
>> What do you mean by "under repository"? If the repo is /tmp/git/.git=
,
>> then cwd is at /tmp/git/.git?
>
> I meant if the original cwd lies within the repository.
>
> Example:
>
> =C2=A0repo =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /tmp/git/.git
> =C2=A0starting cwd =C2=A0 /tmp/git/.git/objects/pack

OK it's considered a bare repo, so no worktree.

>>> D. User-supplied relative paths.
>>>
>>> =C2=A0- path in .git file is relative to containing directory
>>> =C2=A0- path in GIT_DIR is relative to original cwd
>>> =C2=A0- paths in GIT_WORK_TREE and core.worktree are relative to
>>> =C2=A0 $GIT_DIR
>>
>> I think $GIT_WORK_TREE is relative to original cwd.
>
> git.txt is confusing, then. =C2=A0Actually it has some other insights=
:
>
> =C2=A0--work-tree=3D<path>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Set the path to the working tree. The valu=
e
> =C2=A0 =C2=A0 =C2=A0 =C2=A0will not be used in combination with
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repositories found automatically in a .git
> =C2=A0 =C2=A0 =C2=A0 =C2=A0directory (i.e. $GIT_DIR is not set).
>
> So GIT_WORK_TREE should be discarded or warned about when GIT_DIR is
> not set. (?)

Yeah. Junio reminded me in another mail. It should warn (at least, me).

> =C2=A0 =C2=A0 =C2=A0 =C2=A0This can also be controlled by setting the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0GIT_WORK_TREE environment variable and the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0core.worktree configuration variable. It c=
an be
> =C2=A0 =C2=A0 =C2=A0 =C2=A0an absolute path or relative path to the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0directory specified by --git-dir or GIT_DI=
R.
>
> This is where I got the impression about relative paths.

Hmm.. OK then. So worktree can be relative to gitdir, which in turn
can be relative to original cwd. Fun.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0Note: If --git-dir or GIT_DIR are specifie=
d but
> =C2=A0 =C2=A0 =C2=A0 =C2=A0none of --work-tree, GIT_WORK_TREE and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0core.worktree is specified, the current wo=
rking
> =C2=A0 =C2=A0 =C2=A0 =C2=A0directory is regarded as the top directory=
 of
> =C2=A0 =C2=A0 =C2=A0 =C2=A0your working tree.
>
> Nice to see this case is documented.
>
>> Yes, core.worktree
>> should be relative to $GIT_DIR.
>
> Speaking of which, it is not clear to me that core.worktree should
> fall under the forbidden case discussed above. =C2=A0If it does, what=
 is
> the point of making it configurable?

I was not the one who introduced core.worktree, so I can't really
tell. Maybe less keystrokes? You know, "GIT_DIR=3Dfoo.git git foo" is
shorter than "GIT_DIR=3Dfoo.git GIT_WORK_TREE=3D/path/to/somewhere git
foo". I tend to think that core.worktree is always effective
regardless $GIT_DIR env setting. But I was wrong.

Also the "relative to $GIT_DIR" may be confusing. If $GIT_DIR points
to a file that points to a true repo, then to which one it is
relative?
--=20
Duy
