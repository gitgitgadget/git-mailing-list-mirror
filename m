From: Dave O <cxreg@pobox.com>
Subject: Re: [PATCH] Fix segfault in merge-recursive
Date: Fri, 8 May 2009 14:41:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 23:41:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Xp0-00054g-Ju
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 23:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875AbZEHVlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 17:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbZEHVlZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 17:41:25 -0400
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:35533 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751141AbZEHVlZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 17:41:25 -0400
X-Envelope-From: cxreg@pobox.com
Received: from localhost (count@narbuckle [127.0.0.1])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.13.8/8.13.8/Debian-3) with ESMTP id n48LfLxn011819
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 8 May 2009 16:41:21 -0500
X-X-Sender: count@narbuckle.genericorp.net
In-Reply-To: <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118631>

On Fri, 8 May 2009, Johannes Schindelin wrote:

>
> When there is no "common" tree (for whatever reason), we must not
> throw a segmentation fault.
>
> Noticed by Dave O.

While this patch does prevent a segfault, it totally fails to recognize
any conflicts in the merge.  Reverting 36e3b5e produces an ordinary
merge conflict with some rename/delete conflicts, and others including
content related conflicts.  I'm not sure I wouldn't rather have the
segfault than the grossly incorrect automerge.

I'll continue debugging the triggering condition to see if I can
understand why the index is left dirty, leading to this NULL tree.

Thanks!

     Dave
