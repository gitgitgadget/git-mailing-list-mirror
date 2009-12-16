From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: How do I show only log messages for commits on a specific branch?
Date: Thu, 17 Dec 2009 00:58:47 +0100
Message-ID: <adf1fd3d0912161558u36d9674eid36e3042d181ed8f@mail.gmail.com>
References: <20091216101647.GB27373@bc-bd.org>
	 <51419b2c0912161005n1596d4a1n92ed555c98aee4c6@mail.gmail.com>
	 <20091216232641.GK25474@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, bd@bc-bd.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:59:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NL3lj-0007ij-IO
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 00:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763397AbZLPX6z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Dec 2009 18:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763387AbZLPX6y
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Dec 2009 18:58:54 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:57014 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762708AbZLPX6t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2009 18:58:49 -0500
Received: by fxm21 with SMTP id 21so1469261fxm.21
        for <git@vger.kernel.org>; Wed, 16 Dec 2009 15:58:48 -0800 (PST)
Received: by 10.103.80.20 with SMTP id h20mr818941mul.130.1261007927932; Wed, 
	16 Dec 2009 15:58:47 -0800 (PST)
In-Reply-To: <20091216232641.GK25474@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135345>

On Thu, Dec 17, 2009 at 12:26 AM, Miklos Vajna <vmiklos@frugalware.org>=
 wrote:
> On Wed, Dec 16, 2009 at 11:05:52AM -0700, Elijah Newren <newren@gmail=
=2Ecom> wrote:
>> =A0 git log new@{30.years.ago}..new
>> (You'll get a warning that 'new' hasn't existed for 30 years but it
>> doesn't hurt anything)
>
> That's the same as "git log new", if I'm not mistaken.
>
> What Stefan wants to do is to let git log show the commits which are
> only in the "new" branch, but I don't think there is an out-of-the-bo=
x
> solution for that.

Not out-of-the-box but this does exactly what you said, print all
commits only reachable from the "new" branch:

git log new --not $(git for-each-ref --format=3D'%(refname)'
'refs/heads/*' | grep -v refs/heads/new)

=46or the original question, I think what makes most sense in this case
is asking for the commits since the upstream branch. Some time ago
there was a discussion about a syntax for the tracking branch and
there was even a patch:

Subject: [PATCH v2] Introduce <branch>@{upstream} as shortcut to the
tracked branch
Date: 2009-09-10 15:25:57 GMT

http://news.gmane.org/find-root.php?message_id=3D%3calpine.DEB.1.00.090=
9101724520.8306%40pacific.mpi%2dcbg.de%3e

but it's not in git.git.

HTH,
Santi
