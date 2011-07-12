From: John Szakmeister <john@szakmeister.net>
Subject: Nesting a submodule inside of another...
Date: Tue, 12 Jul 2011 08:01:09 -0400
Message-ID: <CAEBDL5XQDehUyqKoazxy+YVHh_2iAyt9aE-77H1jZg4oujMJgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 12 14:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgbeV-0002NM-E3
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 14:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327Ab1GLMBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 08:01:12 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:46304 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753144Ab1GLMBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 08:01:11 -0400
Received: by fxd18 with SMTP id 18so4913816fxd.11
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 05:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=W69Pbqp487P8rmAKZIElqApwVvfr+IuUhSWhx+fIoRg=;
        b=Fllnb+HTnXbCYh8WoF7ExpVymoDczMjrxLzPsOnEwtzEwzJMqXJxdPjA4YaRRh7Hw0
         Ul92bS1DIWqIAPPLQTMdrOSbIxXZZgZnO4+oKyVx8BZRQJHpZ61hByYs8kwUPNNE8OvU
         q7WRW4o+Pv6bQFSIILsdTA/vVBGijN3p0+TO4=
Received: by 10.223.30.87 with SMTP id t23mr5480986fac.51.1310472069391; Tue,
 12 Jul 2011 05:01:09 -0700 (PDT)
Received: by 10.223.30.68 with HTTP; Tue, 12 Jul 2011 05:01:09 -0700 (PDT)
X-Google-Sender-Auth: Mv0XpzCs5GSYd0iOfxpTbsaKPK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176938>

Hi all,

I've got a project where we have several frameworks involved, and
external modules we want to pull into the framework tree.  We'd like
to make use of submodules and have something like this:
    top-level/            <-- .gitmodules lives here
        src/
        framework1/   <-- a submodule
            module/     <-- another submodule
        framework2/   <-- a submodule
            module2/    <-- another submodule

Currently, git fails trying to do this.  It's not happy about
.gitmodules living at the top-level and nesting a submodule inside of
another[1].  Is there a technical reason that this is not allowed?
Limiting the traversal up the tree, etc.?  I've worked around the lack
of support to do this for now, but it would be really nice if we could
do such a thing.

Thanks!

-John

[1]  I may generate a patch for the error message, as the current
implementation obscures the real error message.  When I try this, git
says:
    The following path is ignored by one of your .gitignore files:
    framework1/module
    Use -f if you really want to add it.

    After some careful debugging, I found out the real error message
was about this sort of nesting being disallowed.
