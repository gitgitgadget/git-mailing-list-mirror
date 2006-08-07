From: Erik Mouw <erik@harddisk-recovery.com>
Subject: Re: Problem with clone hanging
Date: Mon, 7 Aug 2006 19:12:40 +0200
Organization: Harddisk-recovery.com
Message-ID: <20060807171240.GA19907@harddisk-recovery.com>
References: <1154968942.26375.23.camel@sardonyx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tziporet Koren <tziporet@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Aug 07 19:13:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA8et-0005sK-Ko
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 19:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWHGRMn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 13:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWHGRMn
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 13:12:43 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:27446 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932232AbWHGRMm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 13:12:42 -0400
Received: (qmail 15137 invoked from network); 7 Aug 2006 19:12:40 +0200
Received: from unknown (HELO zurix.bitwizard.nl) (192.168.234.26)
  by abra2.bitwizard.nl with SMTP; 7 Aug 2006 19:12:40 +0200
Received: from erik by zurix.bitwizard.nl with local (Exim 3.36 #1 (Debian))
	id 1GA8ee-0005kl-00; Mon, 07 Aug 2006 19:12:40 +0200
To: Bryan O'Sullivan <bos@serpentine.com>
Content-Disposition: inline
In-Reply-To: <1154968942.26375.23.camel@sardonyx>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25020>

On Mon, Aug 07, 2006 at 09:42:22AM -0700, Bryan O'Sullivan wrote:
> I am trying to clone a repository as follows:
> 
>   git clone git://www.mellanox.co.il/~git/infiniband
> 
> This makes a tiny bit of progress, and then hangs, without ever printing
> any output.
> 
> Upon doing an strace to figure out what might be going on, I see this:
> 
>      <...much activity...>
>         28261 write(3, "0032want 8ba130df4b67fa40878ccf80d54615132d24bc68\n", 50) = 50
>         28261 write(3, "0032want 7df8ea909888d4856d3aff1c41192739d715a393\n", 50) = 50
>         28261 write(3, "0000", 4)               = 4
>         28261 write(3, "0009done\n", 9)         = 9
>         28261 read(3, "0008", 4)                = 4
>         28261 read(3, "NAK\n", 4)               = 4
>         28261 gettimeofday({1154968213, 166810}, NULL) = 0
>         28261 open("/home/bos/git/ofed_1_1/.git/objects/pack/tmp-ZbzARk", O_RDWR|O_CREAT
>         |O_EXCL, 0600) = 4
>         28261 gettimeofday({1154968213, 167511}, NULL) = 0
>         28261 read(3, ...
>      <...HANG>
> 
> >From which I conclude that the server is telling the client to go away,
> which the client is for some reason ignoring.
> 
> Not being a habitual git user, I don't know where to go from here.  I'm
> using the latest git, cloned and built as of today.  Help!

Looks like the same problem that kernel.org used to have. The other
side probably runs git-1.4.0, they should upgrade to 1.4.1. In the mean
time, you could clone using http and later on switch to git transport.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
