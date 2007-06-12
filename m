From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Watchpoints
Date: Tue, 12 Jun 2007 15:51:16 +0200
Message-ID: <19f34abd0706120651m2cfab331te0976eddb479b88c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 15:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy6mj-00060B-Mq
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 15:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbXFLNvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 09:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756399AbXFLNvS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 09:51:18 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:12030 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbXFLNvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 09:51:17 -0400
Received: by nz-out-0506.google.com with SMTP id n1so1655004nzf
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 06:51:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Xru7oUPhoM6twBAEqVpoufSSuUc7VQi+yLBKU4bMFZo+bQOwhQDZPus3YbNdbmcKdLq7GLAgHaGxxzjrh4puotQ4m9SC9rlGmAMRSbmqqHpsLX3XB53bQSXmFrGyLzAuLq/8+273g5RynfzBnXZEWFGxvRSCuRoBlAA0UQzKzcs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iDAyG+Rtf6sMuw8wGEO3aQa2uz0UyD8qT2MRRmTKF5Shlg0uWzctcj2XdTISYaBXB/kIoaKQEFgC/A9Qq/dGZ0ncQNVv5RHhL7qehLgGMkKXV05PTgolftbl5G3g7EI47heMTG5Ns7yVpbFazED5MElJtO18x2+BwSxuJUz01lM=
Received: by 10.115.60.1 with SMTP id n1mr6675622wak.1181656276066;
        Tue, 12 Jun 2007 06:51:16 -0700 (PDT)
Received: by 10.115.60.8 with HTTP; Tue, 12 Jun 2007 06:51:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49962>

Hello,

A lot of kernel developers consider purely-syntactic changes (ie.
fixing whitespace issues) to be noisy/disruptive. Therefore, even when
such changes are for the better (according to the coding style, etc),
they do not usually make it to the "mainline".

It has been suggested that such syntactic changes be performed and
submitted only when related (nearby) semantic changes are performed at
the same time. This is hard to do, however; the developers who want to
make semantic changes are not necesarily the same as those who want to
make syntactic changes, and thus they may not even realize their
opportunity to fix, for example, whitespace issues which exist the
function they are changing.

I introduce the concept of watchpoints. In this particular case, a
watchpoint is the record of a line (or lines) in a file which has some
issue that is not serious enough to warrant a change on its own, but
could be changed in the future if a nearby change was made. More
generally, a watchpoint can "watch" a specific part of a file for
changes in the future.

The point is that git can track a set of watchpoints so that
watchpoint line-numbers stay in sync with the actual file contents.
Adding a line to the beginning a file should probably jump up all the
watchpoint line-numbers for that file. Now, git may also check
to-be-applied patches for changes that touch a watched line.

Does this sound like a viable or even useful idea for a file tracker?

Kind regards,
Vegard Nossum
