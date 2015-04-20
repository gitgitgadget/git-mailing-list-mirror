From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3] config.c: split some variables to
 $GIT_DIR/config.worktree
Date: Mon, 20 Apr 2015 05:51:32 +0300
Message-ID: <20150420025110.GD786@wheezy.local>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com>
 <20150413233739.GA786@wheezy.local>
 <20150418111023.GA1496@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Max Kirillov <max@max630.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jens.Lehmann@web.de
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 04:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk1o3-0007PN-B1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 04:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbbDTCvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2015 22:51:20 -0400
Received: from p3plsmtpa08-06.prod.phx3.secureserver.net ([173.201.193.107]:32801
	"EHLO p3plsmtpa08-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751386AbbDTCvT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2015 22:51:19 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-06.prod.phx3.secureserver.net with 
	id J2rE1q00D5B68XE012rHZy; Sun, 19 Apr 2015 19:51:19 -0700
Content-Disposition: inline
In-Reply-To: <20150418111023.GA1496@lanh>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267447>

On Sat, Apr 18, 2015 at 06:10:23PM +0700, Duy Nguyen wrote:
> On Tue, Apr 14, 2015 at 02:37:39AM +0300, Max Kirillov wrote:
> > On Tue, Mar 31, 2015 at 07:14:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy wrote:
> > > core.worktree and core.bare, which are treated specially in 31e26=
eb [1],
> > > are now moved to info/core.worktree and the special treatment rev=
erted.
> > <...>
> > > -	if (get_common_dir(&sb, gitdir))
> > > -		fn =3D check_repo_format;
> > > -	else
> > > -		fn =3D check_repository_format_version;
> >=20
> > By the way, after this '$GIT_DIR/common overrides core.worktree'
> > from t1501 started failing. I don't know what would be
> > better to do with the case, just remove maybe?
>=20
> I think that test spots a real problem. In this function, I ignore th=
e
> config split when I pass NULL as worktree_config to git_config_early(=
).
> Something like this should fix it.

I just realized that the testcase does have
info/config.worktree with the variable included, because
any repository has it. Then, of course, the variable from
common directory should be ignored and the testcase is correct.

By the way, if checkout --to run on repository created
before the feaure added, the linked checkout will not be
able to use own variables. Should checkout --to check that
the file exists and create it in case it does not?
