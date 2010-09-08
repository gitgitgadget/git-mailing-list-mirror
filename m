From: Tor Arntsen <tor@spacetec.no>
Subject: Re: git log for a merged branch
Date: Wed, 8 Sep 2010 16:23:47 +0200
Message-ID: <AANLkTimSHrmQgcrx-CqMgvkcBdgBG9icqw934+7qP7kg@mail.gmail.com>
References: <22744209.230141.1283954076245.JavaMail.root@mail.hq.genarts.com>
	<14267801.230161.1283954674012.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 16:23:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtLZ8-0005C7-Kb
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 16:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0IHOXv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Sep 2010 10:23:51 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56189 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab0IHOXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Sep 2010 10:23:49 -0400
Received: by qwh6 with SMTP id 6so38148qwh.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=h9OTm5E2WX7aqxpDCEOZqkX+A8assSTCEtA9cAWb8Qs=;
        b=XAt6oJ/Qf26vPNiUEGOk1gDdv8aYqW6JoNV3tP1a6rwSWTbrLGua2JMyLXzn2AwDxP
         TArl7h7w2gobFC7/e5UqYgAQVKfqnddjpxcy3LzzX5NxhOOsk946sfMKPd0sAo1yamaI
         rdu6swOMCgMYU1eW9Ml+aUVtW7TOgjvPLTk70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=FG5+io7X750nzcRE2KfIoWw2QCcQD2exc0Iqx5BOqJlJVGagbfdVRBlc24I5w6AC2b
         9ci+YYPpbcLp6TCZGdS6NUJH8ar/veUtRENlKH4SGYts2qzCJ3uS6JT0OYGa0Klc+sgd
         2IeZsLZ++dyvgyGdTbUU1fynzWVZRmFx+oq1A=
Received: by 10.224.60.213 with SMTP id q21mr181179qah.139.1283955827905; Wed,
 08 Sep 2010 07:23:47 -0700 (PDT)
Received: by 10.229.100.18 with HTTP; Wed, 8 Sep 2010 07:23:47 -0700 (PDT)
In-Reply-To: <14267801.230161.1283954674012.JavaMail.root@mail.hq.genarts.com>
X-Google-Sender-Auth: DK8Sh0UjCQ0dDbO5ZR8tl4tNLSc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155786>

On Wed, Sep 8, 2010 at 16:04, Stephen Bash <bash@genarts.com> wrote:
> Hi everyone-
>
> A coworker asked me a Git question yesterday that I can't answer, so =
I thought I'd pass it along:
>
> Assume I have a release branch with bug fixes that is tagged at the e=
nd of the release cycle (let's call the tag tagFoo). =A0The release bra=
nch then gets merged back into mainline development (call the branch ma=
inline), and the release branch is deleted. =A0If I want to see the com=
mits (bug fixes) performed on the release branch, how do I do it?
[..]

Maybe not exactly what you ask for, but the way I do it is simply to
use a non-ff merge with additional logging, i.e. git merge --no-ff
--log <branchname-with-fixes>
which will give me a merge commit which includes one-liners for each
of those commits merged into mainline. And I include problem report
ID's in the first line of my commits I get a nice list of fixes, in a
commit looking something like this:

commit <sha1>
Author:
Date:
   Merge branch 'fixes'
  * fixes:
     Fix for PR#23
     Fix for PR#1
     Fix for PR#288
=2E.
and so on. Those 'Fix for' are just the git log --oneline of what got m=
erged.
(Obviously what you don't see in the above is the actual sha1 of each
of those commits that got merged, but at least it's easy enough to
figure out what to put in the release notes :-)
