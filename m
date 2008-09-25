From: Yann Dirson <ydirson@altern.org>
Subject: Re: stg 0.14.3 breakage on push after moving hunk
Date: Thu, 25 Sep 2008 09:57:32 +0200
Message-ID: <20080925075732.GA17458@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20080924232654.GY4985@nan92-1-81-57-214-146.fbx.proxad.net> <20080925072322.GA27632@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Sep 25 09:57:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kilih-0000XA-9r
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 09:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537AbYIYHzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 03:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752462AbYIYHzy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 03:55:54 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:36983 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbYIYHzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 03:55:54 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 611FB12B752;
	Thu, 25 Sep 2008 09:55:52 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 2C21612B74D;
	Thu, 25 Sep 2008 09:55:52 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 544E51F0C2; Thu, 25 Sep 2008 09:57:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080925072322.GA27632@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96732>

On Thu, Sep 25, 2008 at 09:23:22AM +0200, Karl Hasselstr=F6m wrote:
> > TypeError: not all arguments converted during string formatting
>=20
> No, but try this ...

Thanks, it does fix the exception - I feel a bit ashamed of not having
looked at the code myself ;)

Nevertheless, that error was only hiding another more annoying problem:

$ ../stgit/stg push
Checking for changes in the working directory ... done
Pushing patch "factorize" ...
  Error: File "t/t4030-diff-rename-factorize.sh" added in both, permiss=
ions conflict
  Error: The merge failed during "push". =20
         Use "refresh" after fixing the conflicts or revert the operati=
on with "push --undo".
  stg push: GIT index merging failed (possible conflicts)
$ md5sum t/t4030-diff-rename-factorize.sh*
cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh
cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.curr=
ent
cc313acd2824036556128b3e0879dd07  t/t4030-diff-rename-factorize.sh.patc=
hed

AFAICT, adding the same file in 2 branches used not to produce a
conflict at all.  Is that intended ?

Best regards,
--=20
Yann
