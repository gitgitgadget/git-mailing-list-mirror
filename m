From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 08:14:23 +1000
Message-ID: <AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com>
References: <i3pdkj$hut$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Ralf Ebert <info@ralfebert.de>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:14:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiac3-0005QY-4g
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132Ab0HIWO0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 18:14:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63764 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039Ab0HIWOZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 18:14:25 -0400
Received: by wwj40 with SMTP id 40so12163029wwj.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rRC5go3PLS1usvTBV2lKpTGb/rXGP2RCNmWlMNuW+Fo=;
        b=NDM6N/xa2cbcfi/fqrO6L2KExKHT+55xxYSOFV+J9LinhiAnWdhzY0VPSW9fzAgYwh
         Y64uK9SMv2g28CvP+PCS3VblOPjRPSVWN6pFTi66t69Xn/oQtVE+8BHzgyw9dPlsitVL
         ktDpSXE+LHigWXbxJYa4Zj1ZkAcFUD9uKOAwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dn1krYA8IdH2eTGh7XkUkH0K6xorOqsOxPIu2jTeAYWMf11Cj6uUaqpP5Nk+48zfQN
         W4L/8toCiaxwOQdvNrgtKTSsmYqOI7L7qemR0gwAIABFG6rDPxpEKgzxu3lX2RPymijt
         /c4LWHL5UtFG/MzLTR88TlRl77V2Y415ginnE=
Received: by 10.216.180.200 with SMTP id j50mr3152785wem.36.1281392063752;
 Mon, 09 Aug 2010 15:14:23 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Mon, 9 Aug 2010 15:14:23 -0700 (PDT)
In-Reply-To: <i3pdkj$hut$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153037>

On Tue, Aug 10, 2010 at 3:24 AM, Ralf Ebert <info@ralfebert.de> wrote:
> Stating the folder concerned with the operation and wording the
> messages differently make them slightly more readable.
>
> old: Not a git repository (or any of the parent directories): .git
> new: Not in a git repository: /home/bob/somefolder
>
> old: Not a git repository (or any parent up to mount parent /home/bob=
)
> old: Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM=
 not
> set).
> new: Not in a git repository: /home/bob/somefolder
> new: (stopped searching at /home because GIT_DISCOVERY_ACROSS_FILESYS=
TEM is
> not set)
>
> Signed-off-by: Ralf Ebert <info@ralfebert.de>
> ---
> =C2=A0setup.c | =C2=A0 11 +++++++----
> =C2=A01 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 2769160..e27fbf1 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -321,6 +321,7 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *work_tree_env =3D getenv(GIT_W=
ORK_TREE_ENVIRONMENT);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *env_ceiling_dirs =3D
> getenv(CEILING_DIRECTORIES_ENVIRONMENT);
> + =C2=A0 =C2=A0 =C2=A0 char cwd_orig[PATH_MAX];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0static char cwd[PATH_MAX+1];
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *gitdirenv;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *gitfile_dir;
> @@ -376,8 +377,9 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die("Not a git=
 repository: '%s'", gitdirenv);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0- =C2=A0 =C2=A0 =C2=A0if (!getcwd(cwd, sizeof(cwd)-1))
> + =C2=A0 =C2=A0 =C2=A0 if (!getcwd(cwd_orig, sizeof(cwd_orig)))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die_errno("Una=
ble to read current working directory");
> + =C2=A0 =C2=A0 =C2=A0 strcpy(cwd, cwd_orig);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ceil_offset =3D longest_ancestor_length(cw=
d, env_ceiling_dirs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ceil_offset < 0 && has_dos_drive_prefi=
x(cwd))
> @@ -431,7 +433,7 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*nongit_ok =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Not a git repository (or any of the parent
> directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("Not in a git repository: %s", cwd_orig);

cwd can be used in this case.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (one_filesy=
stem) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (stat("..", &buf)) {
> @@ -446,8 +448,9 @@ const char *setup_git_directory_gently(int *nongi=
t_ok)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn NULL;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cwd[offset] =3D '\0';
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Not a git repository (or any p=
arent up
> to mount parent %s)\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "Stopping at filesystem boundary
> (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("Not in a git repository: %s\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "(stopped searching at %s because "
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "GIT_DISCOVERY_ACROSS_FILESYSTEM is=
 not
> set)", cwd_orig, cwd);

How about this and avoid adding cwd_orig?

-                               cwd[offset] =3D '\0';
-                               die("Not a git repository (or any
parent up to mount parent %s)\n"
-                               "Stopping at filesystem boundary
(GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
+                               die("Not in a git repository: %s\n"
+                               "(stopped searching at %.*s because "
+                               "GIT_DISCOVERY_ACROSS_FILESYSTEM is
not set)", cwd, offset, cwd);
--=20
Duy
