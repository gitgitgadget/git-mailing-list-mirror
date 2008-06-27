From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 12/13] Build in merge
Date: Fri, 27 Jun 2008 13:03:20 +0200
Message-ID: <4864C8F8.9020501@free.fr>
References: <cover.1214066798.git.vmiklos@frugalware.org> <0b7ea424b3d5ea18a5a8660c6aead51adcc6a40f.1214066799.git.vmiklos@frugalware.org> <57d8a308fae0012174ed4388baccf1bde8515f2f.1214066799.git.vmiklos@frugalware.org> <5cae08d3bf2852a8bbd8dc8cdf741cb4bdfa237e.1214066799.git.vmiklos@frugalware.org> <d5d80c5a068c76810edfa9c0c68de500f02780a0.1214066799.git.vmiklos@frugalware.org> <486270D5.5050204@free.fr> <20080627010609.GJ29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 13:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCBkI-0004sb-2T
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 13:04:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbYF0LDC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 07:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbYF0LDB
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 07:03:01 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:55558 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866AbYF0LDA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 07:03:00 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id AD2E412B6FD;
	Fri, 27 Jun 2008 13:02:59 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 5174D12B6FB;
	Fri, 27 Jun 2008 13:02:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <20080627010609.GJ29404@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86539>

Miklos Vajna a =E9crit :
>=20
> This should respect diff.color:

Absolutely. And also color.ui. The following patch should do the trick:

diff --git a/builtin-merge.c b/builtin-merge.c
index 98adca5..cf557f7 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -7,6 +7,7 @@
  */
=20
 #include "cache.h"
+#include "color.h"
 #include "parse-options.h"
 #include "builtin.h"
 #include "run-command.h"
@@ -712,6 +713,9 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
        git_config(git_merge_config, NULL);
        git_config(git_diff_ui_config, NULL);
=20
+       if (diff_use_color_default =3D=3D -1)
+               diff_use_color_default =3D git_use_color_default;
+
        argc =3D parse_options(argc, argv, builtin_merge_options,
                        builtin_merge_usage, 0);
=20

Olivier.
