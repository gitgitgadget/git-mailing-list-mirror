From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] completion: handle unstuck form of base git options
Date: Sat, 22 Jun 2013 14:30:33 +0200
Message-ID: <20130622123033.GI20052@goldbirke>
References: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Jun 22 14:30:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqMxo-0008Dk-2a
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 14:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341Ab3FVMak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 08:30:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:50670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169Ab3FVMaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 08:30:39 -0400
Received: from localhost6.localdomain6 (f051195150.adsl.alicedsl.de [78.51.195.150])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0Mb5Ch-1UbJBJ0Sip-00K520; Sat, 22 Jun 2013 14:30:34 +0200
Content-Disposition: inline
In-Reply-To: <adafd1a0c0d7d059d215d9fd1ea68579525efe6e.1371900318.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:2OojMbPXgZ9A4G5zfJvpyoyEoEfzVwEh7RXizyfX3pr
 5em6bFSEG5MLvLbaJ8i7lkBaVlXyYniAgzgBqJPaIXClPQQ8PZ
 6nEMKFjGCEJvVBNZjMcCnzjmXNwi1ftrq08L+cwHsRDFBNdakR
 Zdp1pQIzt6t13RiCEKjrhMWn5UrDs3yG6csKATHfxDE3Wptf2v
 WnYmBxS/hydcqqoCD/9jcYjNhNasp3RXgH6X5QeIKbcGin8q6J
 AJ0CONWfpDSsANPI6Y95J9lOXLyfudtMkfCUOozONaGyM3syv6
 rTeGJXlavXJ3RBn+YcTom5QE339tSl3/FtJbkJz6HBUAKe4ihr
 SxFcPTopfeYheqI+/o2ICdM/l5vzqQa6lc8c/nSwv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228702>

Hi,

On Sat, Jun 22, 2013 at 12:25:17PM +0100, John Keeping wrote:
> git-completion.bash's parsing of the command name relies on everythin=
g
> preceding it starting with '-' unless it is the "-c" option.  This
> allows users to use the stuck form of "--work-tree=3D<path>" and
> "--namespace=3D<path>" but not the unstuck forms "--work-tree <path>"=
 and
> "--namespace <path>".  Fix this.

I never use these commands, so I looked up what --namespace means.
While doing so I noticed that --exec-path takes a path just like these
options, so that option should be handled similarly as well.

Otherwise it makes sense.


G=E1bor


> Similarly, the completion only handles the stuck form "--git-dir=3D<p=
ath>"
> and not "--git-dir <path>", so fix this as well.
>=20
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  contrib/completion/git-completion.bash | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index 6c3bafe..8fbf941 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2492,9 +2492,10 @@ __git_main ()
>  		i=3D"${words[c]}"
>  		case "$i" in
>  		--git-dir=3D*) __git_dir=3D"${i#--git-dir=3D}" ;;
> +		--git-dir)   ((c++)) ; __git_dir=3D"${words[c]}" ;;
>  		--bare)      __git_dir=3D"." ;;
>  		--help) command=3D"help"; break ;;
> -		-c) c=3D$((++c)) ;;
> +		-c|--work-tree|--namespace) ((c++)) ;;
>  		-*) ;;
>  		*) command=3D"$i"; break ;;
>  		esac
> --=20
> 1.8.3.1.676.gaae6535
>=20
