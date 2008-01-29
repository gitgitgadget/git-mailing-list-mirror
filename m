From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 3/4] Teach new infrastructure to diff two trees
Date: Tue, 29 Jan 2008 15:40:55 +0100
Message-ID: <87y7a8k83s.fsf@lysator.liu.se>
References: <20080129031310.1177.83290.stgit@yoghurt>
	<20080129031558.1177.80102.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 15:41:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJreU-0001GA-2l
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 15:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbYA2Ok4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 09:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYA2Ok4
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 09:40:56 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:42833 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYA2Okz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 09:40:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id EE5A7200A253;
	Tue, 29 Jan 2008 15:40:53 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 09432-01-11; Tue, 29 Jan 2008 15:40:53 +0100 (CET)
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 6E652200A1F8;
	Tue, 29 Jan 2008 15:40:53 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 2DE4E7B4077; Tue, 29 Jan 2008 15:40:55 +0100 (CET)
In-Reply-To: <20080129031558.1177.80102.stgit@yoghurt> ("Karl =?utf-8?Q?Ha?=
 =?utf-8?Q?sselstr=C3=B6m=22's?= message of "Tue\, 29 Jan 2008 04\:16\:19
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71979>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> Nothing uses this yet, but "stg edit" will soon.
>
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>
> ---
>
>  stgit/lib/git.py |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
>
> diff --git a/stgit/lib/git.py b/stgit/lib/git.py
> index 9cb2521..d75f724 100644
> --- a/stgit/lib/git.py
> +++ b/stgit/lib/git.py
> @@ -1,5 +1,6 @@
>  import os, os.path, re
>  from stgit import exception, run, utils
> +from stgit.config import config

But "config" isn't used in this patch.

>  class RepositoryException(exception.StgException):
>      pass
> @@ -355,6 +356,11 @@ class Repository(RunWithEnv):
>                  return None
>          finally:
>              index.delete()
> +    def diff_tree(self, t1, t2, diff_opts):
> +        assert isinstance(t1, Tree)
> +        assert isinstance(t2, Tree)
> +        return self.run(['git', 'diff-tree', '-p'] + list(diff_opts)
> +                        + [t1.sha1, t2.sha1]).raw_output()
> =20
>  class MergeException(exception.StgException):
>      pass
>

--=20
David K=C3=A5gedal
