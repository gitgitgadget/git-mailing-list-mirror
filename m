From: skillzero@gmail.com
Subject: git cherry to find equivalent commit IDs?
Date: Thu, 13 Aug 2009 14:13:24 -0700
Message-ID: <2729632a0908131413w1a2efca8t31ac8cc43e1d6888@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 23:13:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbhcB-0002mA-Km
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 23:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118AbZHMVNa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 17:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754738AbZHMVN3
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 17:13:29 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:33271 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbZHMVN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 17:13:29 -0400
Received: by qyk34 with SMTP id 34so850357qyk.33
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 14:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=OOLqyP6ICfPDoZB5qtslimOWiDl9pgkwf7vzsuTl6nw=;
        b=OKg29DRkYTpj9gCSDSwe6q5OYDwJJUzraUnYApq2U6CXCifKyKDLdWL5i6tn7sHW6B
         c10dayBGy0x4BbAenLoCe4JYhLEMO1qDURLhjz9ZZIXjIsRrmZswEmGSsUuWdZjyHESD
         P+59mlIg402vYPz+wgw5LFykvVqOZL6nqFQLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=pdWQGTlH8BHVjioXtXjOqebJ222RB8bueoz7pl2Xq7JkNWgE2Ftp4/1rjVjASYMweG
         vhG1xW4E77suJIrStEHFf14wlQEtqZaxN3A/Lkhz4rkjrdJXBCGdpjKIbE5WUsClzueT
         mvMQdI32zU6YF+h3kH1M26ZvzJN4iFAF7yMuM=
Received: by 10.224.22.132 with SMTP id n4mr1774936qab.176.1250198007662; Thu, 
	13 Aug 2009 14:13:27 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125876>

Is there a way to get the commit ID of a patch that was cherry picked
(or via a manually applied patch)? I'm trying to get an equivalent to
git branch --contains, but instead of comparing the commit ID, it
compares patch IDs so it works for cherry picks and manual patches. It
seems like git cherry almost does what I want, but it only seems to
show the commit ID of the commit on the other branch rather than the
branch I specify to git cherry. I may just be using git cherry
incorrectly though.

For example, commit 3642151 on branch A was a cherry pick of a commit
460050c on master:

$ git branch -a --contains 3642151
  A

$ git branch -a --contains 460050c
* master

$ git cherry -v master 3642151
- 3642151435ce5737debc1213de46dd556475bfad1 fixed bug

I assume that means an equivalent change to 3642151 is already in
master (which it is, as commit 460050c). But I want to find out the
commit ID on master that's equivalent to 3642151 (i.e. something that
tells me it's 460050c).

I'm basically looking for something like git branch --contains, but
that searches by patch ID so it can find cherry picked or manually
applied patches:

$ git branch -a --contains-equivalent 3642151
* master (via commit 460050c)
  A (via commit 3642151)

Is there a way to do that?
