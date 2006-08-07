From: Bryan O'Sullivan <bos@serpentine.com>
Subject: Problem with clone hanging
Date: Mon, 07 Aug 2006 09:42:22 -0700
Message-ID: <1154968942.26375.23.camel@sardonyx>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Tziporet Koren <tziporet@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Aug 07 18:42:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA8Ay-00081i-Uv
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 18:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHGQl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 12:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWHGQl3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 12:41:29 -0400
Received: from hierophant.serpentine.com ([64.81.58.173]:981 "EHLO
	demesne.serpentine.com") by vger.kernel.org with ESMTP
	id S932119AbWHGQl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 12:41:28 -0400
Received: from [127.0.0.1] (demesne.serpentine.com [192.168.16.11])
	by demesne.serpentine.com (Postfix) with ESMTP id EE79120B541;
	Mon,  7 Aug 2006 09:41:24 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Evolution 2.7.3 (2.7.3-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25018>

I am trying to clone a repository as follows:

  git clone git://www.mellanox.co.il/~git/infiniband

This makes a tiny bit of progress, and then hangs, without ever printing
any output.

Upon doing an strace to figure out what might be going on, I see this:

     <...much activity...>
        28261 write(3, "0032want 8ba130df4b67fa40878ccf80d54615132d24bc68\n", 50) = 50
        28261 write(3, "0032want 7df8ea909888d4856d3aff1c41192739d715a393\n", 50) = 50
        28261 write(3, "0000", 4)               = 4
        28261 write(3, "0009done\n", 9)         = 9
        28261 read(3, "0008", 4)                = 4
        28261 read(3, "NAK\n", 4)               = 4
        28261 gettimeofday({1154968213, 166810}, NULL) = 0
        28261 open("/home/bos/git/ofed_1_1/.git/objects/pack/tmp-ZbzARk", O_RDWR|O_CREAT
        |O_EXCL, 0600) = 4
        28261 gettimeofday({1154968213, 167511}, NULL) = 0
        28261 read(3, ...
     <...HANG>

>From which I conclude that the server is telling the client to go away,
which the client is for some reason ignoring.

Not being a habitual git user, I don't know where to go from here.  I'm
using the latest git, cloned and built as of today.  Help!

	<b
