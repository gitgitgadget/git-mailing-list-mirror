From: David Woodhouse <dwmw2@infradead.org>
Subject: git-daemon memory usage, disconnection.
Date: Wed, 19 Apr 2006 14:22:46 +0100
Message-ID: <1145452967.13200.92.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Apr 19 15:23:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWCe0-0007X0-8Q
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 15:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDSNWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 09:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWDSNWx
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 09:22:53 -0400
Received: from canuck.infradead.org ([205.233.218.70]:20934 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750748AbWDSNWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 09:22:52 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.61 #1 (Red Hat Linux))
	id 1FWCdt-00074R-V8
	for git@vger.kernel.org; Wed, 19 Apr 2006 09:22:50 -0400
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18923>

I'm running git-daemon from xinetd and it seems a little greedy...

Cpu(s):  2.7% us,  6.4% sy,  0.0% ni,  1.7% id, 87.7% wa,  1.4% hi,  0.0% si
Mem:    253680k total,   250076k used,     3604k free,      568k buffers
Swap:   500960k total,   500864k used,       96k free,    24696k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
31232 nobody    18   0  155m  29m 7224 D  1.3 11.9   0:25.56 git-rev-list
30743 nobody    18   0  179m  29m 9480 D  0.7 11.9   0:42.60 git-rev-list
31277 nobody    18   0  147m  28m 7476 D  2.6 11.4   0:20.90 git-rev-list
30314 nobody    18   0  233m  26m 7696 D  0.0 10.6   1:20.24 git-rev-list
30612 nobody    18   0  204m  23m 7432 D  1.3  9.4   0:59.19 git-rev-list
30574 nobody    18   0  190m  20m 7608 D  0.3  8.3   0:50.77 git-rev-list
30208 nobody    18   0  140m  14m 7632 D  0.3  5.9   0:15.23 git-pack-object

Now, this wouldn't be _so_ bad if there were only two of them running.
The clients for the other four have actually given up and disconnected
long ago, but git-daemon doesn't seem to have reacted to that.

-- 
dwmw2
