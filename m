From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git log - filter missing changesets
Date: Thu, 17 Aug 2006 11:25:58 +0300
Message-ID: <20060817082558.GB2630@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 17 10:27:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDdDQ-0002xW-Pi
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 10:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWHQI00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 04:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHQI00
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 04:26:26 -0400
Received: from mxl145v67.mxlogic.net ([208.65.145.67]:43733 "EHLO
	p02c11o144.mxlogic.net") by vger.kernel.org with ESMTP
	id S932305AbWHQI0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Aug 2006 04:26:25 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 03824e44.2638146480.9301.00-005.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Thu, 17 Aug 2006 02:26:24 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 17 Aug 2006 11:32:30 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu, 17 Aug 2006 11:25:58 +0300
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 17 Aug 2006 08:32:30.0859 (UTC) FILETIME=[AE08F5B0:01C6C1D7]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25557>

Hi!
git log with -- parameter seems to sometimes miss changesets that
affect a specific directory:

>git  log -p vofed-1.1-rc1.. -- drivers/infiniband/ulp/sdp/ | \
  grep drivers/infiniband/ulp/sdp
diff --git a/drivers/infiniband/ulp/sdp/sdp.h b/drivers/infiniband/ulp/sdp/sdp.h
--- a/drivers/infiniband/ulp/sdp/sdp.h
+++ b/drivers/infiniband/ulp/sdp/sdp.h
diff --git a/drivers/infiniband/ulp/sdp/sdp_bcopy.c
b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
--- a/drivers/infiniband/ulp/sdp/sdp_bcopy.c
+++ b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
diff --git a/drivers/infiniband/ulp/sdp/sdp_main.c
b/drivers/infiniband/ulp/sdp/sdp_main.c
--- a/drivers/infiniband/ulp/sdp/sdp_main.c
+++ b/drivers/infiniband/ulp/sdp/sdp_main.c


but without a filter:

>git  log -p vofed-1.1-rc1.. | \
      grep drivers/infiniband/ulp/sdp drivers/infiniband/ulp/sdp/sdp_main.c
diff --git a/drivers/infiniband/ulp/sdp/sdp.h b/drivers/infiniband/ulp/sdp/sdp.h
--- a/drivers/infiniband/ulp/sdp/sdp.h
+++ b/drivers/infiniband/ulp/sdp/sdp.h
diff --git a/drivers/infiniband/ulp/sdp/sdp_bcopy.c b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
--- a/drivers/infiniband/ulp/sdp/sdp_bcopy.c
+++ b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
diff --git a/drivers/infiniband/ulp/sdp/sdp_main.c b/drivers/infiniband/ulp/sdp/sdp_main.c
--- a/drivers/infiniband/ulp/sdp/sdp_main.c
+++ b/drivers/infiniband/ulp/sdp/sdp_main.c
diff --git a/drivers/infiniband/ulp/sdp/sdp.h b/drivers/infiniband/ulp/sdp/sdp.h
--- a/drivers/infiniband/ulp/sdp/sdp.h
+++ b/drivers/infiniband/ulp/sdp/sdp.h
diff --git a/drivers/infiniband/ulp/sdp/sdp_bcopy.c b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
--- a/drivers/infiniband/ulp/sdp/sdp_bcopy.c
+++ b/drivers/infiniband/ulp/sdp/sdp_bcopy.c
diff --git a/drivers/infiniband/ulp/sdp/sdp_main.c b/drivers/infiniband/ulp/sdp/sdp_main.c
--- a/drivers/infiniband/ulp/sdp/sdp_main.c
+++ b/drivers/infiniband/ulp/sdp/sdp_main.c

what gives?

-- 
MST
