From: Tait <git.git@t41t.com>
Subject: Re: [PATCH] Replace hard-coded path with one from <paths.h>
Date: Fri, 9 Apr 2010 16:54:55 -0700
Message-ID: <20100409235455.GI2480@ece.pdx.edu>
References: <186fa4afcc08ad6ba10906a231c437536fbdb8e9.1270412075.git.chris@arachsys.com> <7vk4sm7vao.fsf@alter.siamese.dyndns.org> <20100404222801.GB31315@arachsys.com> <20100406163525.GF15306@arachsys.com> <20100406163643.GG15306@arachsys.com> <n2u40aa078e1004070357m143cfaccvdc754a3bc5fe1ae1@mail.gmail.com> <20100408105850.GD2146@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, kusmabite@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 01:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0O2m-0003oz-UF
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab0DIXzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:55:09 -0400
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:47796 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0DIXzI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:55:08 -0400
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o39NsvV2012245
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Apr 2010 16:54:57 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o39NsuRi021248;
	Fri, 9 Apr 2010 16:54:56 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o39NstZc021233;
	Fri, 9 Apr 2010 16:54:55 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <20100408105850.GD2146@arachsys.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Fri, 09 Apr 2010 16:54:57 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144490>

> > > +#include <paths.h>
> >
> > This breaks on Windows due to missing paths.h. I guess you need some
> > guard to detect if the header is present or not.
>
> Is this true of all WIN32, or just __MINGW32__ / __CYGWIN__? Presumably
> /usr/local/bin:/usr/bin:/bin is the wrong default PATH on windows too, so
> perhaps I should sort that at the same point---what would a canonical
> default PATH be for Windows?

Paths.h is not found on my version of mingw/msys.

The "canonical" Windows path is usually the system directory, and system32
and system32\Wbem under the system directory. The system directory could
be anywhere. C:\WINDOWS is common, but the WINDOWS (or even the C:) are
subject to change on any given installation. So for example on my computer,
	C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem

is the path before adding in PowerShell, Resource Kits, GTK, etc. Windows
also assumes '.' is part of your path, even though it's not explicitly
present in %PATH%.

My version of mingw seems to prepend to the above,
	.:/usr/local/bin:/mingw/bin:/bin

besides also using : instead of ; as a separator.
