From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/3] gitweb: Faster project search
Date: Thu, 23 Feb 2012 16:54:45 +0100
Message-ID: <1330012488-7970-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 16:55:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0b0X-0000q1-8E
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 16:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab2BWPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 10:54:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:48492 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab2BWPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 10:54:56 -0500
Received: by bkcjm19 with SMTP id jm19so1176822bkc.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 07:54:55 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.204.148.79 as permitted sender) client-ip=10.204.148.79;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.204.148.79 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.204.148.79])
        by 10.204.148.79 with SMTP id o15mr1033705bkv.33.1330012495138 (num_hops = 1);
        Thu, 23 Feb 2012 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kCEb9asTLOUoBwpVO/ozwaMIs74yyROoWYvgxYSvUBI=;
        b=lw2mMOYmJ28yEiZOK9CaXW+5AsLrwFfsy0Ir6bESu85YwOvRImMBU2yRCgNhjCyZ6f
         td/WGe95upfmP3AOHwgwSyysHbL4EQuZfZQW13DZ1mCbbYwCxe7Dy3b2EIUhObgIA+uT
         0G/nxJbQhCIr40XVbyRk31yJsWc4OXkJzOunU=
Received: by 10.204.148.79 with SMTP id o15mr858740bkv.33.1330012495039;
        Thu, 23 Feb 2012 07:54:55 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id i2sm3550051bkd.10.2012.02.23.07.54.53
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 07:54:54 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191373>

[Cc-ing Junio because of his involvement in discussion]

These patches are separated from first part of previous version of
this series

  "[PATCHv2 0/8] gitweb: Faster and improved project search"
  http://thread.gmane.org/gmane.comp.version-control.git/190852

It is meant to replace 'jn/gitweb-search-optim' in pu

The intent of this series is to make project search faster by reducing
number of git commands (and I/O).  This is done by first searching
projects, then filling all project info, rather than the reverse.


Jakub Narebski (3):
  gitweb: Refactor checking if part of project info need filling
  gitweb: Option for filling only specified info in
    fill_project_list_info
  gitweb: Faster project search

 gitweb/gitweb.perl |   66 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 53 insertions(+), 13 deletions(-)

-- 
1.7.9
