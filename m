From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible --boundary bug
Date: Thu, 30 Mar 2006 20:34:19 +0200
Message-ID: <e5bfff550603301034r58b38500ie5897ed06fce6e9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 20:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP1yS-0007ds-TF
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 20:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWC3SeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 13:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWC3SeW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 13:34:22 -0500
Received: from wproxy.gmail.com ([64.233.184.234]:57050 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751316AbWC3SeW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 13:34:22 -0500
Received: by wproxy.gmail.com with SMTP id 58so73460wri
        for <git@vger.kernel.org>; Thu, 30 Mar 2006 10:34:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b/1ElVwvVb7bCjLKisN6u/hMEopag4QCNU9q7bt9LcYBFPn+YZw9X9UPB5OIiwALcs51+VjMeNVUdPoFoJWUg2Al45OI/R1/L7OdFba2ZpAeNmAU1K1lgWHtZKYFUQBzRyArmQ9K2csAPS6qSNRuSr5uL786xV8yehDKBSm4taM=
Received: by 10.65.216.18 with SMTP id t18mr541333qbq;
        Thu, 30 Mar 2006 10:34:21 -0800 (PST)
Received: by 10.65.163.20 with HTTP; Thu, 30 Mar 2006 10:34:19 -0800 (PST)
To: junkio@cox.net
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18203>

Trying to convert qgit to use the new and cool --boundary option I
found this one:

>From git tree

$ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
grep eb38cc689e8
-e646de0d14bac20ef6e156c1742b9e62fb0b9020
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4
4b953cdc04fec8783e2c654a671005492fda9b01
5ca5396c9ecba947c8faac7673195d309a6ba2ea
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4

and also

$ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
grep c64965750
8c0db2f5193153ea8a51bb45b0512c5a3889023b
21a02335f821c89a989cf0b533d2ae0adb6da16e
c649657501bada28794a30102d9c13cc28ca0e5e

But perhaps correct output should be:

$ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
grep eb38cc689e8
-e646de0d14bac20ef6e156c1742b9e62fb0b9020
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4
-4b953cdc04fec8783e2c654a671005492fda9b01
5ca5396c9ecba947c8faac7673195d309a6ba2ea
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4

and

$ git-rev-list --boundary --topo-order --parents 5aa44d5..ab57c8d |
grep c64965750
-8c0db2f5193153ea8a51bb45b0512c5a3889023b
21a02335f821c89a989cf0b533d2ae0adb6da16e
c649657501bada28794a30102d9c13cc28ca0e5e

It seems the '-' flag is mistakenly missing because of boundary  revs:

c649657501bada28794a30102d9c13cc28ca0e5e and
eb38cc689e84a8fd01c1856e889fe8d3b4f1bfb4


Marco
