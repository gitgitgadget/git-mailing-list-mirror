From: Ben Willard <benwillard@gmail.com>
Subject: [PATCH 0/2] git-blame bug
Date: Tue, 2 Jun 2009 15:28:39 -0400
Message-ID: <cover.1243969358.git.benwillard@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 21:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBZfL-00078Z-H7
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 21:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbZFBT2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 15:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbZFBT2p
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 15:28:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:38512 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZFBT2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 15:28:44 -0400
Received: by fg-out-1718.google.com with SMTP id d23so919736fga.17
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=AqqaOgCZhnNF2HUH303VKvapKJYaYlRQSuq/0XDaBYM=;
        b=GYuwuIwz0Z4FLPsynBGu2LlAs9DJc/g7We+0a2EkAICJeMQDj86JpXm0ylVm4Q3Msq
         rg/ZowVnFkocGgFcTPT3qQ+p1fUeQ+tajFCpHd1eX3eJeBPQ++hkvNFBAxfl421YbYJa
         Me/iQ/gFYnefjcNLt02Q8JvFb68t7XDHNUzEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=xyyA1aPnkb2RVhV81kkZemWOAkTgDN2vOcacgVprs7sMeZdTpnUviSEHlAPhx4hWd6
         ZTA8Iiq53qTVNMbc3aGeV3lrsxLMn6pvS30vMIWELF0e4NL/owlMB5eUKS/V9VmvWkdZ
         SqMmNqf6LLet+L2FkL5qlx/pkvkdNg8VSaRjs=
Received: by 10.86.91.3 with SMTP id o3mr189021fgb.29.1243970925532;
        Tue, 02 Jun 2009 12:28:45 -0700 (PDT)
Received: from ben-laptop (rn--cgr-1-1-a38.uwaterloo.ca [129.97.253.234])
        by mx.google.com with ESMTPS id d4sm600582fga.14.2009.06.02.12.28.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Jun 2009 12:28:44 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120535>

Hi,

I ran across this git-blame failure the other day: if a directory is deleted
and a file is created with the same name in a single commit, then git blame
will fail on it with this error:
	fatal: internal error in blame::find_origin
	
Anyway, patch 1/2 shows this failure with a test, and 2/2 is a possible fix.
They should apply on maint. 

Thanks,
--
Ben

Ben Willard (2):
  t8006: Add test to show blame failure
  blame: Fix corner case when a directory becomes a file

 builtin-blame.c  |   12 ++++++++----
 t/t8006-blame.sh |   21 +++++++++++++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)
 create mode 100755 t/t8006-blame.sh
