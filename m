From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 2/2] get_remote_merge_branch: Support for arbitrary 
	mapping
Date: Thu, 18 Jun 2009 11:27:31 +0200
Message-ID: <adf1fd3d0906180227t4da5c0cby3b0e71b132eae68@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <1245311834-5290-4-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 11:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHDv0-0005dU-6O
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 11:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760657AbZFRJ1c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 05:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760751AbZFRJ1b
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 05:27:31 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:57716 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760684AbZFRJ1a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 05:27:30 -0400
Received: by bwz9 with SMTP id 9so916561bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 02:27:31 -0700 (PDT)
Received: by 10.204.118.207 with SMTP id w15mr1143566bkq.126.1245317251128; 
	Thu, 18 Jun 2009 02:27:31 -0700 (PDT)
In-Reply-To: <1245311834-5290-4-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121825>

2009/6/18 Santi B=E9jar <santi@agolina.net>
>
> This function is used in "git pull --rebase" to know the tracking bra=
nch.
>
> Signed-off-by: Santi B=E9jar <santi@agolina.net>
> ---
>  git-parse-remote.sh |   21 ++++++++++++---------
>  1 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/git-parse-remote.sh b/git-parse-remote.sh
> index 5f47b18..1aa6ffe 100755
> --- a/git-parse-remote.sh
> +++ b/git-parse-remote.sh

[...]

> @@ -83,13 +81,18 @@ get_remote_merge_branch () {
>            esac
>            expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
>            remote=3D$(expr "z$ref" : 'z\([^:]*\):')
> -           case "$remote" in
> -           '' | HEAD ) remote=3DHEAD ;;
[...]
> +           while true ; do
> +               case "$remote" in
> +               '' | HEAD ) remote=3D;;

I forgot to say that I changed the HEAD behavior because the remote
HEAD and the local remote HEAD (origin/HEAD) can point to different
branches, as the local remote HEAD represents your preference for
which is the default remote branch.

Santi
