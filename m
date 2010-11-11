From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git blame --reverse: it's all a bit mysterious
Date: Thu, 11 Nov 2010 23:15:04 +0100
Message-ID: <201011112315.04299.trast@student.ethz.ch>
References: <87hbfnabax.wl%greenrd@greenrd.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Robin Green <greenrd@greenrd.org>
X-From: git-owner@vger.kernel.org Thu Nov 11 23:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGfQJ-0001K6-23
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 23:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830Ab0KKWPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 17:15:08 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:39224 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756625Ab0KKWPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 17:15:07 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Thu, 11 Nov
 2010 23:15:04 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Thu, 11 Nov
 2010 23:15:04 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.36-90-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <87hbfnabax.wl%greenrd@greenrd.org>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161306>

Robin Green wrote:
> greenrd@cspcnh /var/db/paludis/repositories/arbor $ strace -f -e trace=file git blame --reverse 48d96ce0e486eedea9fda0f8e480ba3c6caffc90..HEAD exlibs/eutils.exlib
[...]
> I notice from the strace output that it's looking for the specified filename first, which of course
> no longer exists in HEAD.

This can be fixed by saying

  git blame --reverse 48d96ce0e486eedea9fda0f8e480ba3c6caffc90..HEAD -- exlibs/eutils.exlib

i.e., you need to supply the -- to explicitly tell it that the stuff
after it is a filename.

It's probably a code (not documentation) bug since blame takes only a
single revision range anyway, so everything after that should be
assumed to be a filename, but maybe I'm missing something.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
