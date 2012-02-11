From: Serhat Sevki Dincer <jfcgauss@gmail.com>
Subject: Re: git svn problem
Date: Sat, 11 Feb 2012 02:52:50 +0200
Message-ID: <CAPqC6xSJ7pfUQJz8FQ743mJMNmZyfJfWxutOnt+FVkP76eXOGw@mail.gmail.com>
References: <CAPqC6xRtZXwv+U6AKRUXDz=m-G4AjgWksbwqeMD_qzS8YC=DoQ@mail.gmail.com>
	<4F358A53.8010409@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Feb 11 01:59:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw1JF-0005gV-BQ
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 01:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab2BKA6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 19:58:52 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35356 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab2BKA6v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 19:58:51 -0500
Received: by qadc10 with SMTP id c10so652856qad.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 16:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=US/BCVV7gqNzKAOvENydPhI1O4zirlPevHMpdwSRbO0=;
        b=kpatlCu22TCt1HVuyBwECDFEDtbLrLdplxWiemsrxl5k0bEDiQjpBZQtztoDzwvaRL
         +z4lzXgaPztyEAI7GaSXLFbMNG471mqMBqU5CkOUUqalDhHs3blEtZQgLjKDNXD/eOB/
         aDgV1y0PUPqNwvV2oEtVjqsyupZM5tgsfGmX0=
Received: by 10.224.30.206 with SMTP id v14mr1394664qac.18.1328921570214; Fri,
 10 Feb 2012 16:52:50 -0800 (PST)
Received: by 10.229.144.196 with HTTP; Fri, 10 Feb 2012 16:52:50 -0800 (PST)
In-Reply-To: <4F358A53.8010409@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190474>

On Fri, Feb 10, 2012 at 11:21 PM, Sam Vilain <sam@vilain.net> wrote:
> Import them separately to different git-svn remotes, and once they ar=
e in
> the same repository you can graft them together using .git/info/graft=
s (see
> man gitrepository-layout). =C2=A0Once it looks right (check using 'gi=
tk' etc),
> make it permanent using git filter-branch. You'll also want to remove=
 the
> .git/svn directory, and re=E2=80=93run 'git svn fetch' so that git sv=
n's revision
> database is recomputed. =C2=A0Don't forget the -A option to 'git svn =
fetch'!

That sounds too complicated. There should be an easier way (i hope:)
I have the following at the moment:

rm -rf plone.app.locales ; mkdir plone.app.locales ; cd plone.app.local=
es
git svn init -T trunk http://svn.plone.org/svn/plone/plone.app.locales
touch start ; git add start ; git commit -m start
git svn fetch -r49624:HEAD
git rebase --onto master --root trunk --preserve-merges
git checkout -b plone

plone branch looks good, now I would like to do the same with
collective/plone.app.locales. I tried a couple of things but ended up
getting errors like:

Rebuilding .git/svn/refs/remotes/trunk/.rev_map.db7f04ef-aaf3-0310-a811=
-c281ed44c4ad
=2E..
Done rebuilding
=2Egit/svn/refs/remotes/trunk/.rev_map.db7f04ef-aaf3-0310-a811-c281ed44=
c4ad
RA layer request failed: REPORT of '/svn/collective/!svn/vcc/default':
Could not read chunk size: connection was closed by server
(http://svn.plone.org) at /usr/lib/git-core/git-svn line 5131

Is there some way around these errors?

Thanks..
Serhat
