From: Erez Zilber <erezzi.list@gmail.com>
Subject: How to handle a git repository with multiple branches
Date: Thu, 26 Aug 2010 14:53:49 +0300
Message-ID: <AANLkTimW-SQi1eprxTPXxF85SBO4d5MU13=dsboNNrzd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 26 13:54:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oob1v-00043P-B1
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 13:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0HZLxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 07:53:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59843 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0HZLxv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 07:53:51 -0400
Received: by bwz11 with SMTP id 11so1005869bwz.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 04:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9nNASc2qKNIySJOrNWnhItu+3Bp4byLRHIUelDlHvIg=;
        b=OO7d9EnecqpjQK6B4Uk0RQzVM9NhRVrm9Z1ygUmCHbge8JPZJnqzqDlKCjYeBFSKrp
         WWWDB+pVlGDc1eXaRoKquPIcGH+FZVy3HdWpa5keKwtQLWmMlosBG3Le6hQ3F2hnbpj+
         PbmEdQhBitemNlNnpkbWvKBHotQ5G1AiZHOUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vFOmGxLdJxDG1I6ErZ21l+2v+z39ejusfLMz4koj0QfOeVTLKv39KT5t8CWFrDSZPO
         0yb6HDzX9lXSu3/doKwmeAi3r6zi5UQGMta39Inuefd5/JnPgF2bB9yBrotP62m0ENgA
         1BsDhJghjh6vuSZqRrB1lEd/ZW5lDOVe+NfNw=
Received: by 10.204.49.22 with SMTP id t22mr6054234bkf.188.1282823629737; Thu,
 26 Aug 2010 04:53:49 -0700 (PDT)
Received: by 10.204.69.136 with HTTP; Thu, 26 Aug 2010 04:53:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154537>

Hi,

My repository has several branches. Each branch is for a separate code
release. Let's assume that I have a branch for V1.0 (branch_1) and a
branch for V2.0 (branch_2).

Some commits are relevant only for branch_1, some are relevant only
for branch_2 and some are relevant for both. For the commits that are
relevant for both branches, I thought about the following solutions:
1. Put these common commits in branch_1 and merge branch_1 into
branch_2. This is bad because it will also merge commits that are
relevant only for branch_1.
2. Cherry-pick the common commits from branch_1 to branch_2. This is
also bad because the commit ID changes, and in case of conflicts, git
is unable to tell that these 2 commits are actually the same commit.
This makes it very difficult to track the changes between branches.

Since there are several other developers and sub-maintainers in this
project which are rebased on both these branches, I don't want to
change the git history of my branches because when I do that,
sub-maintainers and developers lose the reference to their base.

I'm looking for a better solution. Is there any best-practice solution?

Thanks,
Erez
