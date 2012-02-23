From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv3 0/3] gitweb: Faster project search
Date: Thu, 23 Feb 2012 16:42:56 +0100
Message-ID: <1330011779-7803-1-git-send-email-jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 16:43:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0apK-0000aA-Sl
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 16:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164Ab2BWPnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 10:43:19 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46592 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab2BWPnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 10:43:18 -0500
Received: by wgbdt10 with SMTP id dt10so1212328wgb.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 07:43:17 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.180.101.165 as permitted sender) client-ip=10.180.101.165;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.180.101.165 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.180.101.165])
        by 10.180.101.165 with SMTP id fh5mr4586035wib.10.1330011797356 (num_hops = 1);
        Thu, 23 Feb 2012 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=kCEb9asTLOUoBwpVO/ozwaMIs74yyROoWYvgxYSvUBI=;
        b=nB2PHIAcMzRutKptT2KznN/zOOdkBBNZsz3JMQbD4FblPAHi3XS5+06359zZ48wK/g
         GbO3DF/juyTeTruH7/hD0A/Dq6Lbw6OBxVJrhSEiNM4VEJIF9VeMgRqHc5t1I+IdGH1k
         CKnBXfYpMGHliu+/qf09Qm2w6YnRDdAc9aY+4=
Received: by 10.180.101.165 with SMTP id fh5mr3733310wib.10.1330011797301;
        Thu, 23 Feb 2012 07:43:17 -0800 (PST)
Received: from localhost.localdomain (abvx74.neoplus.adsl.tpnet.pl. [83.8.221.74])
        by mx.google.com with ESMTPS id fl2sm8194821wib.4.2012.02.23.07.43.15
        (version=SSLv3 cipher=OTHER);
        Thu, 23 Feb 2012 07:43:16 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191370>

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
