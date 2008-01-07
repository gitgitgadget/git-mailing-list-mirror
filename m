From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STG PATCH] refresh: add a --index option which takes the contents of the index as the new commit
Date: Mon, 7 Jan 2008 11:56:12 +0100
Message-ID: <20080107105612.GA20981@diana.vm.bytemark.co.uk>
References: <200712302003.33478.kumbayo84@arcor.de> <200801022039.27611.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 13:15:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBqsv-0007G2-15
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 13:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286AbYAGMOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2008 07:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753997AbYAGMOc
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 07:14:32 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4152 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbYAGMOb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 07:14:31 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JBpeO-0005Tv-00; Mon, 07 Jan 2008 10:56:12 +0000
Content-Disposition: inline
In-Reply-To: <200801022039.27611.kumbayo84@arcor.de>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69784>

On 2008-01-02 20:39:27 +0100, Peter Oberndorfer wrote:

> On Sonntag 30 Dezember 2007, Peter Oberndorfer wrote:
>
> > Do you think this would be a useful/good idea? Or do we want a
> > separate command for removing files from a patch anyway?
>
> The question is still open if this is useful for somebody else.

I think it's a useful addition. Thanks!

> diff --git a/stgit/stack.py b/stgit/stack.py
> index 4203931..7d14261 100644
> --- a/stgit/stack.py
> +++ b/stgit/stack.py
> @@ -668,6 +668,7 @@ class Series(PatchSet):
>          config.remove_section('branch.%s.stgit' % self.get_name())
> =20
>      def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
> +                      use_index =3D False,
>                        empty =3D False,
>                        show_patch =3D False,
>                        cache_update =3D True,
> @@ -717,6 +718,11 @@ class Series(PatchSet):
>          else:
>              tree_id =3D None
> =20
> +        if use_index:
> +            tree_id =3D None
> +            files =3D None
> +            cache_update =3D False
> +
>          commit_id =3D git.commit(files =3D files,
>                                 message =3D descr, parents =3D [botto=
m],
>                                 cache_update =3D cache_update,

So the use_index parameter to refresh_patch is actually not necessary?
In that case I'd rather you didn't add it, since the functions in
stgit/stack.py have quite enough parameters already.

> diff --git a/t/t2700-refresh.sh b/t/t2700-refresh.sh
> index 2e7901c..9eae85d 100755
> --- a/t/t2700-refresh.sh
> +++ b/t/t2700-refresh.sh

Bonus points for adding a test case!

I still haven't rebased my patch stack since Catalin accepted most of
it just before Christmas. Once I've gotten around to that, I'll take
your patch -- hopefully by then updated to not add the exra argument
to refresh_patch(). :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
