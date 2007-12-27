From: adr3nald0s@gmail.com
Subject: Anomalous conflicts during git rebase
Date: Thu, 27 Dec 2007 16:42:57 -0600
Message-ID: <m3ir2ju5ce.fsf@euroclydon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 23:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J81NT-00019m-DQ
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 23:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbXL0Wif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 17:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXL0Wie
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 17:38:34 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:20377 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752151AbXL0Wie (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 17:38:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3001432rvb.1
        for <git@vger.kernel.org>; Thu, 27 Dec 2007 14:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:to:subject:user-agent:from:date:message-id:mime-version:content-type;
        bh=GGC018v5MB8NxGIMyeM38DrZy3UpdGVY7qBnuXeZey4=;
        b=qik+hBhDKlZpPS9nrbuM0UijZ7f3+mLuf+sOsihaYIuMrU3N29A5BkPbVnNEHAdB7DUadv/HbFKeaDqWDsF/748cyTcCSFS8LUliH6wHwYeqlnyUDqfgwk+twrip2EPhjAT/pebz4GMSUubMlLVIEtujdHl3vygOWqo0yiP3wHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:subject:user-agent:from:date:message-id:mime-version:content-type;
        b=ZSSOuIFPXpTNITfekuYWUzrQ9YrdL3CQ0nTK6zS2gkLWJsjMp3maWZNxKq/yr+QlsUyduYeCybSrzLAaEo4T5tJ+xA4wnzfB2JEwjVlS6wFCpOedEb14u8Zr5Y8bTpUPYBfQokcH5Q9cVACjRAZfJd4y5DsgN4paqVi+S7KCbCU=
Received: by 10.141.113.6 with SMTP id q6mr4385721rvm.36.1198795111463;
        Thu, 27 Dec 2007 14:38:31 -0800 (PST)
Received: from euroclydon.lan ( [66.148.187.210])
        by mx.google.com with ESMTPS id 35sm10826889wra.21.2007.12.27.14.38.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Dec 2007 14:38:30 -0800 (PST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69269>


On a clone of linux-2.6:

    git checkout -b topic/test v2.6.15
    touch drivers/a-file.c
    git add drivers/a-file.c
    git commit -m 'Add a file'
    git checkout -b temp0 v2.6.16
    git rebase topic/test

I get the following:

    Applying [ACPI] handle ACPICA 20050916's acpi_resource.type rename
  
    error: patch failed: drivers/acpi/glue.c:99
    error: drivers/acpi/glue.c: patch does not apply
    error: patch failed: drivers/char/hpet.c:897
    error: drivers/char/hpet.c: patch does not apply
    Using index info to reconstruct a base tree...
    Falling back to patching base and 3-way merge...
    Auto-merged drivers/acpi/glue.c
    Auto-merged drivers/acpi/pci_link.c
    Auto-merged drivers/char/hpet.c
    CONFLICT (content): Merge conflict in drivers/char/hpet.c
    Failed to merge in the changes.
    Patch failed at 0007.
  
    When you have resolved this problem run "git rebase --continue".
    If you would prefer to skip this patch, instead run "git rebase --skip".
    To restore the original branch and stop rebasing run "git rebase --abort".

Is this a bug, or is there a reason I am seeing conflicts in files
I've never touched?
