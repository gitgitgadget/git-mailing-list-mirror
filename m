From: John Arthorne <arthorne.eclipse@gmail.com>
Subject: receive.denyNonNonFastForwards not denying force update
Date: Mon, 20 Aug 2012 09:33:29 -0400
Message-ID: <CAHgXSooFj2PJtcOWqsVNHUzMBQnH0cYzPjfs1CkzVuufwRVrog@mail.gmail.com>
References: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3S7B-0000B1-Jw
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 15:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab2HTNdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 09:33:52 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53636 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755617Ab2HTNdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 09:33:50 -0400
Received: by ghrr11 with SMTP id r11so4990684ghr.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=MUJt99pN88VDNB30W5opbb5cJwNuw3vD6V8dHajm1mY=;
        b=AkQfN3mXJp/q0zG9w7NSPLhFtkxravkgwGWohlTefyPDWkGZimC4PyK3+6paP9x86r
         n7in5NDdxuyXyUJwn6S5AT7k5TNgVoM4CRcventf6T1/6yDOjOKNBL54rD0R42Bo6vIW
         2xWkUPM0iaEAKl+GpdZhmXA9cf0sn+WFwjknrh5GaQ3usI9YvJ+dFkCLv7dlVPyjy5l0
         zkASwWerkioqvuvu3fuO74IS7YuMBCr7kQIH33kOh08c2JbLb9rR8/67UGTyThgOG15Q
         8cMU9XgXHF9vQm7A7kIYltCGRn6CQg69LmNX6QMmrR100DbP5kKKS4sSFSEG5sBMXfGv
         EZog==
Received: by 10.60.19.195 with SMTP id h3mr10188339oee.102.1345469629766; Mon,
 20 Aug 2012 06:33:49 -0700 (PDT)
Received: by 10.182.144.66 with HTTP; Mon, 20 Aug 2012 06:33:29 -0700 (PDT)
In-Reply-To: <CAHgXSop42qWcAEGn6=og8Pistv_Jrwhgcnv3B_ORVtSMi1fCHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203840>

At eclipse.org we wanted all git repositories to disallow non-fastforward
commits by default. So, we set receive.denyNonFastForwards=true as a system
configuration setting. However, this does not prevent a non-fastforward
force push. If we set the same configuration setting in the local repository
configuration then it does prevent non-fastforward pushes.

For all the details see this bugzilla, particularly comment #59 where we
finally narrowed this down:

https://bugs.eclipse.org/bugs/show_bug.cgi?id=343150

This is on git version 1.7.4.1.

The Git book recommends setting this property at the system level:

http://git-scm.com/book/ch7-1.html (near the bottom)

Can someone confirm if this is intended behaviour or not. We ended up
using a script to set a local config property in each repository, but
with several hundred git repositories it would be much easier if the
system setting was honoured.

Thanks,
John Arthorne
