From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Insert ACTIVESTATE_STRING in Git.pm
Date: Mon, 22 Jan 2007 15:32:28 +0100
Message-ID: <81b0412b0701220632t50ad42c4ucb0ebae140a9706a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 15:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90Dv-0008Kk-8b
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 15:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbXAVOcc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 09:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXAVOcc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 09:32:32 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:46487 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbXAVOcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 09:32:31 -0500
Received: by wr-out-0506.google.com with SMTP id i22so669528wra
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 06:32:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SIIp3K/qP8kuknBlci31vwBCj4qFtOsTwXIm8gHEp2q/t6dwdr4ot8/FSIfanF5CF/Bny4e28RNTd6NxrTh6QdE3q6OJUzjzJLqyfqRM2N9E61MWL+CkqZEU25vM/T6NNtrVBOnLpyefRMuWxrqra7ITWMW66v8nSaJm39mbb/c=
Received: by 10.82.113.6 with SMTP id l6mr6787294buc.1169476348941;
        Mon, 22 Jan 2007 06:32:28 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 06:32:28 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37410>

Also add "git" to the pipe parameters, otherwise it does not work at all, as
no git commands are usable out of git context.

---

This is not enough to make it work on ActiveState. It's just to
fix obvious TODOs, which should help someone to get it going.
The other problems are:
 - tie refuses to bind a handle class activestate_pipe to a scalar $fh
   (a patch follows)
 - there are some unexplained warnings about uninitialized values
 - cygwin-windows pathname conversion (not fixable at all)

 perl/Git.pm |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)
