From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Does git have "Path-Based Authorization"?
Date: Sun, 2 Oct 2011 06:57:57 +0530
Message-ID: <CAMK1S_icdpCyA8SBcNu8CbCk3N-h8yEYZ9+6N=JVPAeayuzSPw@mail.gmail.com>
References: <CAN0CFw0QXkNSF8+qGu+pCrv5dgy1OEvtq-53f23GRd4RrZ1GcQ@mail.gmail.com>
	<m3lit4oo9q.fsf@localhost.localdomain>
	<CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Grant <emailgrant@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 03:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAAqk-00089B-Dd
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 03:28:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618Ab1JBB17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Oct 2011 21:27:59 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58621 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab1JBB16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Oct 2011 21:27:58 -0400
Received: by qadb15 with SMTP id b15so945078qad.19
        for <git@vger.kernel.org>; Sat, 01 Oct 2011 18:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=RLN/6y97pxEnt68RmJEEzCH2kufOBSiPqxyJqWYuIx4=;
        b=H7OWDlKLv3becmSM26PaXm0LpWqJW0dmQvKoSycvR1n8m96us7IVrwtIlI3lT2Ns1U
         hau6R19QoUpeyrQxMgJYgckJCADcxtD7/jZTZO76ZHLFwbQlbJL9XZjTQ8aFryr5Vnl5
         uZOwNvFUk+8SaUCOTd9gTdM1pnlHjupSE5BR0=
Received: by 10.224.203.69 with SMTP id fh5mr9356066qab.271.1317518877844;
 Sat, 01 Oct 2011 18:27:57 -0700 (PDT)
Received: by 10.224.54.71 with HTTP; Sat, 1 Oct 2011 18:27:57 -0700 (PDT)
In-Reply-To: <CAN0CFw3kzAgaVBKNHE5ttJgYnc_csjeHjOLq=EBjLizW=RPUkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182587>

On Sun, Oct 2, 2011 at 5:30 AM, Grant <emailgrant@gmail.com> wrote:
>>> Hello, I'm trying to decide between git and subversion. =C2=A0Subve=
rsion
>>> has "Path-Based Authorization" so I can give a developer access to
>>> only specific files instead of everything. =C2=A0Does git have some=
thing
>>> similar?
>>>
>>> http://svnbook.red-bean.com/en/1.5/svn.serverconfig.pathbasedauthz.=
html
>>
>> In distributed version control systems each developers gets full cop=
y
>> (a clone) of a repository (separate repository instance). =C2=A0This=
 means that
>> if you want for developer to see only specified subset of repository
>> (specific subdirectories) you would have to split repository into
>> submodules, and control access on (sub)repository basis.
>
> I do want to prevent reading of all but one or a few specified files
> at a time. =C2=A0I did some reading on the differences between centra=
lized
> and distributed version control systems, and I can see how a
> distributed system may be better for open source projects, but a
> business project like mine may work better with centralized control.
> Would you guys agree in general? =C2=A0Easier read/write control of
> individual files in the repository is one benefit of the centralized
> model I will put to use.
>
>> However if you want only to prevent developer from making changes ou=
tside
>> specific subdirectory or specified files, you can do that on publish=
 time
>> via update / pre-receive hook (like contrib/hooks/update-paranoid), =
or git
>> repository management tool such as Gitolite. =C2=A0That would preven=
t a push if
>> any of commits being published touches files that it shouldn't.
>>
>> P.S. Karl Fogel in "Producing Open Source Software" (http://producin=
goss.com)
>> writes that social solutions wrt. restricting contributors to given =
area
>> are better than technical solutions such as (overly-)strict access
>> control.
>
> When I started this thread, I didn't realize the fact that my project
> is not open-source would help decide which version control system to
> use. =C2=A0Now I see that it does factor into the decision so I apolo=
gize
> for not mentioning it previously.

I'm afraid I did not follow the full thread, but I can assure you we
have several "secret secret" type projects at work, both mine as well
as many others.

There are a few occasions when they need the kind of stuff you seem to
want more regularly, (the only one I can really recall is one of our
largest customers has a custom version of one of our product for
themselves and do not want people working on the generic version to
see those changes in case they propagate to their competitors).  We
just do that by using a different repo entirely, and making sure
changes to common code migrate only one way.

Git has too many advantages over legacy VCSs like SVN for people to
throw it over for something as simple as this.
