From: Cory Fields <FOSS@AtlasTechnologiesInc.com>
Subject: 'git replace' and pushing
Date: Tue, 23 Nov 2010 23:33:59 -0500
Message-ID: <AANLkTinzPCeCJ486cysmk981HE61=dv9MS7E8Ap4rQ5r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 05:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PL73a-0001Fk-GR
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 05:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab0KXEeB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 23:34:01 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64334 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0KXEeA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 23:34:00 -0500
Received: by wyb28 with SMTP id 28so9061606wyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 20:33:59 -0800 (PST)
Received: by 10.227.145.139 with SMTP id d11mr8692611wbv.11.1290573239151;
 Tue, 23 Nov 2010 20:33:59 -0800 (PST)
Received: by 10.227.154.10 with HTTP; Tue, 23 Nov 2010 20:33:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162043>

I am having some trouble understanding how a replaced object (commit)
should behave when pushed to a remote repo. Here's my scenario:

We are moving from svn to git. Our svn repo is huge, and most of the
history is useless. To save space, I would like to do a 50/50 split so
that when the repo is cloned, 50% is seen by default, and the
historical 50% can be seen by fetching the replacement history. I've
done this by creating a phony snapshot at 3 then using a 'replace' to
put the others on top. The history is purely linear.

1---2---3---4---5
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \---4---5

When the replacement is in place, the repo is half size (commit-wise)
as expected. The problem is that 'git push' does not honor the
replace. So when I push, all objects go with it, which defeats the
purpose. The only way that seams to work is doing a filter-branch and
replacing the other way.

Is this by design? I would really like a way to split the repo without
breaking hashes for the developers that have already begun using git
svn.

Thanks,
Cory
