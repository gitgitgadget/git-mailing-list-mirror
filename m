From: Troy Telford <ttelford.groups@gmail.com>
Subject: git-fast-import question
Date: Wed, 29 Jul 2009 16:36:33 -0600
Message-ID: <1e30a6d10907291536y3ec68caq8788aef2b7c34a6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWHlK-0007lE-Co
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbZG2Wge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbZG2Wge
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:36:34 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:61769 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZG2Wgd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:36:33 -0400
Received: by qyk34 with SMTP id 34so345533qyk.33
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 15:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=1P7q/vv3UilTPXUK5OZ8kGOZDJ0ZcIzBalkVWk4LNeU=;
        b=a/EeNkLxRxCuWXJ1xhTBHFrUukbbfDrjjsJ/nj0NWL7HnQgxHiSDh1V2EI7ylb+07K
         ZaGMmKldQ4nAkcYz9G5MMaWjRj/qmRseFKpV8XpMwG2Vpm0VFPwg3k9U755c2KLW4Cij
         +QV2lOP0YhwvyN/tryv2tlvn/3EBeEE8uFGi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=bnalwil/DCmxeRqqGcsvwOg+DbYXURa5ozdX9RDMjU8EW5QEZO9bF/niuNSlepqt89
         xrvDblgig3HgX62tKPNpsWJkO+KOJKGrSyf2zYQGGc7LDHgnLxix/j8Y+OwGvxRWl5Vy
         3WsWYMboh4Gp+2a8QBrUy/mjdKH/xf6GLX3Mo=
Received: by 10.229.99.130 with SMTP id u2mr71919qcn.29.1248906993451; Wed, 29 
	Jul 2009 15:36:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124400>

I've been writing an importer from an older SCM into git.  I'm getting
the following behavior with using git-fast-import:

The file I'm importing has something along the lines of:

commit refs/heads/foo
<various metadata>
M 100644 :mark path/to/some/file

Then, later on, there's another commit:

commit refs/heads/foo
<various metadata>
R path/to/some/file new/path/to/some/file

As far as I've been able to see, the :from tag points to the correct
commit (which is also in the correct branch).  There are no instances
of 'reset <branch>' being called anywhere.  The file isn't deleted
anywhere.

But when I run fast-import, I receive an error to the extent of:
fatal:  Path path/to/some/file not in branch

So to me, it looks like the file that I'm renaming should exist in the
branch - it's not being renamed anywhere, not being deleted, and the
branch isn't reset.  Yet fast-import doesn't seem to think the file
exists.

I'm using git 1.6.3.3
