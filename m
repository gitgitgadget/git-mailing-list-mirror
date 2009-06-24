From: Emmanuel Puerto <emmanuel.puerto@maxim-ic.com>
Subject: RE: [BUG] malloc error when using large file.
Date: Wed, 24 Jun 2009 01:35:58 -0700
Message-ID: <B03A893ADFE80748942D13AFAF2845190C2D5D3FB0@ITSVLEX06.it.maxim-ic.internal>
References: <B03A893ADFE80748942D13AFAF2845190C2D5D388A@ITSVLEX06.it.maxim-ic.internal>
 <20090622211542.GA19364@coredump.intra.peff.net>
 <B03A893ADFE80748942D13AFAF2845190C2D5D3BDC@ITSVLEX06.it.maxim-ic.internal>
 <alpine.LFD.2.01.0906231412070.3240@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:37:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJNyv-0004hk-07
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 10:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZFXIhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 04:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753065AbZFXIhM
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 04:37:12 -0400
Received: from antispam02.maxim-ic.com ([205.153.101.183]:55303 "EHLO
	antispam02.maxim-ic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbZFXIhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Jun 2009 04:37:10 -0400
X-ASG-Debug-ID: 1245832131-2dad02360000-QuoKaX
X-Barracuda-URL: http://AntiSpam02:8000/cgi-bin/mark.cgi
Received: from terlingua.dalsemi.com (localhost [127.0.0.1])
	by antispam02.maxim-ic.com (Spam Firewall) with ESMTP
	id B303221E921; Wed, 24 Jun 2009 03:28:51 -0500 (CDT)
Received: from terlingua.dalsemi.com (terlingua.dalsemi.com [180.0.34.46]) by antispam02.maxim-ic.com with ESMTP id Wd491uwhvZY2PgU8; Wed, 24 Jun 2009 03:28:51 -0500 (CDT)
Received: from itdalex01.it.maxim-ic.internal (itdalex01.it.maxim-ic.internal [10.16.15.6])
	by terlingua.dalsemi.com (8.10.2/8.10.2) with ESMTP id n5O8bC805489;
	Wed, 24 Jun 2009 03:37:12 -0500 (CDT)
Received: from itdalias01.it.maxim-ic.internal ([10.16.15.60]) by itdalex01.it.maxim-ic.internal with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 24 Jun 2009 03:37:25 -0500
Received: from maxdalex01.maxim-ic.internal (10.16.15.103) by
 itdalias01.it.maxim-ic.internal (10.16.15.60) with Microsoft SMTP Server
 (TLS) id 8.1.358.0; Wed, 24 Jun 2009 03:37:25 -0500
Received: from maxsvlex02.maxim-ic.internal (172.18.47.215) by
 maxdalex01.maxim-ic.internal (10.16.15.101) with Microsoft SMTP Server (TLS)
 id 8.1.358.0; Wed, 24 Jun 2009 03:37:24 -0500
Received: from ITSVLEX06.it.maxim-ic.internal ([172.18.41.168]) by
 maxsvlex02.maxim-ic.internal ([::1]) with mapi; Wed, 24 Jun 2009 01:37:23
 -0700
X-ASG-Orig-Subj: RE: [BUG] malloc error when using large file.
Thread-Topic: [BUG] malloc error when using large file.
Thread-Index: Acn0R8MDoc4cwYpTS/+SUr/wllEEMQAXWh3w
In-Reply-To: <alpine.LFD.2.01.0906231412070.3240@localhost.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: fr-FR, en-US
X-OriginalArrivalTime: 24 Jun 2009 08:37:25.0262 (UTC) FILETIME=[FFF2CAE0:01C9F4A6]
X-Barracuda-Connect: terlingua.dalsemi.com[180.0.34.46]
X-Barracuda-Start-Time: 1245832131
X-Barracuda-Virus-Scanned: by Barracuda Spam Firewall at maxim-ic.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122132>

Hi Linus,

> > 
> > 
> > > Many operations in git assume that a whole file can be held in memory at
> > > once. Do you actually have 2G available on the machine? Are there any OS
> > > limits that might be a problem?
> > 
> > Thanks for your answer Jeff, 
> > 
> > Yes I have more that 2 Go available when a do it, and after this 
> > allocation error if I try to do a 'git add' with a 9Go file, I did not 
> > have any issue.
>
> Can you add the 2GB files individually, using
>
>	for i in All-f00?.vmdk; do git add $i; done
>
> or similar?
>
> It does sound like an unlucky malloc VM space fragmentation issue, 
> although since the files you add are the same size I'd have not really 
> expected that with any normal malloc library. But with some mixed small 
> and large allocations, I could imagine that the fragmentation happens, and 
> you end up having huge areas that aren't _quite_ useful for the next file 
> due to having some small allocation taking part of it.
>
>		Linus

Sorry, But I have already made this without any success. I really think that the issue is the size of this file. But we never know so I redo it again and here you have the result:

$ free
             total       used       free     shared    buffers     cached
Mem:       3954752     662264    3292488          0      17304     233092
-/+ buffers/cache:     411868    3542884
Swap:      8385920          0    8385920
[epuerto@epuerto-FC10 My_Ubuntu_8.04.2]$ for i in All-f00?.vmdk; do git add $i; done
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
fatal: Out of memory, malloc failed
[epuerto@epuerto-FC10 My_Ubuntu_8.04.2]$ free
             total       used       free     shared    buffers     cached
Mem:       3954752    3928772      25980          0       6052    3510268
-/+ buffers/cache:     412452    3542300
Swap:      8385920         88    8385832
[epuerto@epuerto-FC10 My_Ubuntu_8.04.2]$

I do nothing else, only a top to know the memory use and I see that just before this 'malloc failed', I have something like this:

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND            
  4323 epuerto   20   0 2115m 2.0g 2.0g D 20.2 51.7   0:24.64 git                

And you can see that it appear some memory allocation is not free after this 'malloc failed' error.

If you have any suggestion, any test (or beta version with more debug message) I can do, you are welcome.

Best regards,
Emmanuel.
