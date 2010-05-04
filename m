From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: Multiple SVN remote branches listed in "git branch -r" after 
	"git-svn fetch"
Date: Tue, 4 May 2010 12:29:16 -0400
Message-ID: <y2s2f0f6ced1005040929k7dc01731t5787dc8039031d73@mail.gmail.com>
References: <v2q2f0f6ced1004301159z21c3539av4983488df963ddf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 18:29:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9L02-0000iO-QQ
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab0EDQ3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 12:29:18 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43038 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab0EDQ3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 12:29:17 -0400
Received: by pwi5 with SMTP id 5so310632pwi.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:29:17 -0700 (PDT)
Received: by 10.114.187.7 with SMTP id k7mr224096waf.92.1272990557029; Tue, 04 
	May 2010 09:29:17 -0700 (PDT)
Received: by 10.114.159.7 with HTTP; Tue, 4 May 2010 09:29:16 -0700 (PDT)
In-Reply-To: <v2q2f0f6ced1004301159z21c3539av4983488df963ddf0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146323>

By the way, I figured this out if you ever run into the same thing.
When you fetch any SVN branches or tags that have ever been
moved/renamed, Git will create these other tags and branches with '@'
signs in them.

=46or example, these two branches:
=A0=A04.x/v4_0
=A0=A04.x/v4_0@8459
mean that in r8460 the 4.0 branch was moved to a different location or
renamed. Good news is that the base branch "4.x/v4_0" contains the
revision history of both: everything before and after the move -- so
it's the only one that matters when converting to git branches.

Just an FYI.

On Fri, Apr 30, 2010 at 2:59 PM, Bradley Wagner
<bradley.wagner@hannonhill.com> wrote:
>
> So I did a conversion to Git using git-svn.
>
> git init <svn_url>
> # updated the .git/config file to reference a few different locations
> for branches:
> [svn-remote "svn"]
> =A0 =A0 =A0 =A0url =3D <svn_url>
> =A0 =A0 =A0 =A0fetch =3D cascade/trunk:refs/remotes/trunk
> =A0 =A0 =A0 =A0branches =3D
> cascade/branches/{hibernate-upgrade,spring-upgrade}}:refs/remotes/*
> =A0 =A0 =A0 =A0branches =3D cascade/branches/{6.x,5.x,4.x,3.x}/*:refs=
/remotes/*
> =A0 =A0 =A0 =A0tags =3D cascade/tags/{3.7.x,4.x,5.x,6.x,old-releases}=
/*:refs/remotes/tags/*
> git svn fetch
>
> Now, I'm seeing branches/tags listed multiple times with: git branch =
-r
>
> =A06.x/6.0.2.1
> =A06.x/6.0.2.1@12401
> =A06.x/6.0.2.1@12422
> ....
> =A0tags/4.x/rel_4_22
> =A0tags/4.x/rel_4_22@4093
> =A0tags/4.x/rel_4_22@4384
>
> What do these other branches with the @ sign mean? Did I do something=
 wrong?
>
> Thanks,
> Bradley



--
Hannon Hill - Put Us to the Test
bradley.wagner@hannonhill.com | http://www.hannonhill.com
