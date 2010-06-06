From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Sun, 6 Jun 2010 08:45:13 +0200
Message-ID: <AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<m27hmdn704.fsf@igel.home>
	<4C0A9615.4090307@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 08:45:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL9bo-0002Yr-5A
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 08:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab0FFGpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 02:45:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33593 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842Ab0FFGpQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 02:45:16 -0400
Received: by gwb15 with SMTP id 15so614607gwb.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pDwbsQlH6DWwb1Sj0aB4CmIhZD2hU49RjhUGJHXjQeI=;
        b=V/e7VX+0YF3amQ3JeT1Ht1+Ecw3pxs4ys7yHSwhwz0RQVm0Q7xU5dlDHayhlYf/jUG
         H+p831gAvI4E9HFoEGouToxU2097KF+bbECIpryKuCT1Hb2E0dYHVg60MTOZnxUyncP3
         0U9EjMtTa8K8uA/3nDA8xZE/YOTy1BtODyTIc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KMh99zJzqqCEjRk3mqaDjFuyQZzJnOY2TwXgioNXmIjh3WnSunrFF3UVxOBbxESGK4
         EVJ1jVo0hQIE5+w4GJrzJiL73qfHsx4dgZJwBt2jhBW+fOVTDXL/gRPLtTfB2/wgRL5H
         uZxqBmkbK6Brfk6oWqokrMepR4GtM/uQrCoVA=
Received: by 10.101.172.1 with SMTP id z1mr13924180ano.235.1275806713742; Sat, 
	05 Jun 2010 23:45:13 -0700 (PDT)
Received: by 10.100.123.13 with HTTP; Sat, 5 Jun 2010 23:45:13 -0700 (PDT)
In-Reply-To: <4C0A9615.4090307@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148508>

On Sat, Jun 5, 2010 at 20:23, William Pursell <bill.pursell@gmail.com> =
wrote:
> fatal: Not a git repository (or any of the parent directories): .git
>
> That's just weird. =C2=A0And if there is a git repository in a
> directory above, there may be great confusion, weeping
> and gnashing of teeth.

How about just this? (I assume cwd does hold current working directory)=
=2E

diff --git a/setup.c b/setup.c
index 5a083fa..561f3ab 100644
--- a/setup.c
+++ b/setup.c
@@ -428,7 +428,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
 				*nongit_ok =3D 1;
 				return NULL;
 			}
-			die("Not a git repository (or any of the parent directories): %s",
DEFAULT_GIT_DIR_ENVIRONMENT);
+			die("Not a git repository (or any of the parent directories): %s
(in %s)", DEFAULT_GIT_DIR_ENVIRONMENT, cwd);
 		}
 		if (one_filesystem) {
 			if (stat("..", &buf)) {
