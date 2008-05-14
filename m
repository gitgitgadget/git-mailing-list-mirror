From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 2/2] let pack-objects do the writing of unreachable objects as
 loose objects
Date: Wed, 14 May 2008 11:12:08 +0200
Message-ID: <18474.44264.479000.403927@lapjr.intranet.kiel.bmiag.de>
References: <alpine.LFD.1.10.0805140132500.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 14 11:36:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwDPd-0004as-EN
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 11:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757496AbYENJfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 05:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757197AbYENJfh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 05:35:37 -0400
Received: from bilbo.bmiag.de ([62.154.210.131]:34501 "EHLO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757162AbYENJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 05:35:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bilbo.bmiag.de (Postfix) with ESMTP id 233A53B624;
	Wed, 14 May 2008 11:12:19 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at bilbo.bmiag.de
Received: from bilbo.bmiag.de ([127.0.0.1])
	by localhost (bilbo.bmiag.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VwxLYNww3hMG; Wed, 14 May 2008 11:12:18 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.bmiag.de (Postfix) with ESMTP id 9FDDE3B623;
	Wed, 14 May 2008 11:12:15 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 86A263B7F2;
	Wed, 14 May 2008 11:12:15 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at
	eorl.intranet.kiel.bmiag.de
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl.intranet.kiel.bmiag.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FRbWA21wERgj; Wed, 14 May 2008 11:12:11 +0200 (CEST)
Received: from LAPJR (client174.vpn3.kiel.bmiag.de [10.1.3.174])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 97BC63B787;
	Wed, 14 May 2008 11:12:08 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0805140132500.23581@xanadu.home>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82091>

Nicolas Pitre writes:
 > 
 > Commit ccc1297226b184c40459e9d373cc9eebfb7bd898 changed the behavior
 > of 'git repack -A' so unreachable objects are stored as loose objects.
 > However it did so in a naive and inn efficient way by making packs
 > about to be deleted inaccessible and feeding their content through
 > 'git unpack-objects'.  While this works, there are major flaws with
 > this approach:

Doesn't this make git gc --auto a dangerous operation?
