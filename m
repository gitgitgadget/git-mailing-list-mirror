From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Introduce commit.verbose config option
Date: Sun, 6 Nov 2011 13:52:29 +0100
Message-ID: <20111106125229.GA32270@goldbirke>
References: <20111105182339.27C069004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>
X-From: git-owner@vger.kernel.org Sun Nov 06 13:54:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN2F1-0007Au-K7
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 13:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab1KFMwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 07:52:32 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:52579 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab1KFMwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2011 07:52:31 -0500
Received: from localhost6.localdomain6 (p5B1305BE.dip0.t-ipconnect.de [91.19.5.190])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Md04s-1Re9OA3IXK-00IRnC; Sun, 06 Nov 2011 13:52:29 +0100
Content-Disposition: inline
In-Reply-To: <20111105182339.27C069004A@inscatolati.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:ccUMBZ8tlDnZMbU6jxNehtQ+bx39HujJLiIiRmzPLlQ
 wFT2wAiL/W3HpGgwaBFVGvTQamWl+7hppROAzrS3YAEuVpYUxJ
 EuzKT/VsEPfoelXTjqKTb7gcVnIrO+qTjdWY2r6sxb1Gn+g10D
 WKN96OIDUf+wLSP68kIKNzvQH/pnXty83zHZXOuzDVvkesS8q0
 XaT92/NeZa03k1ZKSPmD6PE96FPajFdDqioH6zj+RTbeZI6eRq
 v3xS/1+UrfW4IU702Kmkp2Cyq/2epdszyV3WcygSAGaKJnkSzE
 irz+DMoCKUGzkDYE8LPalb33D/ee3CEzhcG+/aOcs5XhMSrBPa
 Kc50CNlmhgCqoYm29STs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184913>

On Sat, Nov 05, 2011 at 07:07:35PM +0100, Fernando Vezzosi wrote:
> Enabling commit.verbose will make git commit behave as if --verbose w=
as
> passed on the command line.
>=20
> Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Fernando Vezzosi <buccia@repnz.net>
> ---
>  Documentation/config.txt |    3 +++
>  builtin/commit.c         |    4 ++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5a841da..6826788 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -832,6 +832,9 @@ commit.template::
>  	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" t=
o the
>  	specified user's home directory.
> =20
> +commit.verbose::
> +	A boolean to enable verbose mode like the --verbose flag does.
> +

I just tried out this patch, and found that setting commit.verbose to
true also affects git commit's behavior when invoked from scripts
where you can't pass --verbose to git commit.  I.e. the diff to be
committed is shown for git revert, interactive rebase's reword or
squash commands, or during 'git rebase --continue' after resolving a
conflict.  I think this should be mentioned both in the commit message
and in the documentation.

Anyway, I like this change because I have a somewhat convoluted and
flaky combination of hooks and editor scripts to do the same, and now
I can finally get rid of them.


Best,
G=E1bor
