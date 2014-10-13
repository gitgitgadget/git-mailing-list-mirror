From: "Crabtree, Andrew" <andrew.crabtree@hp.com>
Subject: RE: Performance Issues with Git Rebase
Date: Mon, 13 Oct 2014 17:52:00 +0000
Message-ID: <B82B660D4887C042850326C2BC65FE035D56CD63@G4W3227.americas.hpqcorp.net>
References: <B82B660D4887C042850326C2BC65FE035D56CA14@G4W3227.americas.hpqcorp.net>
 <xmqqlhoj51bi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:53:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdjnz-0001La-1h
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 19:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbaJMRxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 13:53:06 -0400
Received: from g4t3427.houston.hp.com ([15.201.208.55]:14509 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532AbaJMRxE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Oct 2014 13:53:04 -0400
Received: from G4W6310.americas.hpqcorp.net (g4w6310.houston.hp.com [16.210.26.217])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g4t3427.houston.hp.com (Postfix) with ESMTPS id D50546A;
	Mon, 13 Oct 2014 17:53:03 +0000 (UTC)
Received: from G4W6303.americas.hpqcorp.net (16.210.26.228) by
 G4W6310.americas.hpqcorp.net (16.210.26.217) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Mon, 13 Oct 2014 17:52:00 +0000
Received: from G4W3227.americas.hpqcorp.net ([169.254.8.47]) by
 G4W6303.americas.hpqcorp.net ([16.210.26.228]) with mapi id 14.03.0169.001;
 Mon, 13 Oct 2014 17:52:00 +0000
Thread-Topic: Performance Issues with Git Rebase
Thread-Index: Ac/luPkE0ej5ZSZWTB2ZiCVGSSGHAABUcAySAACj81A=
In-Reply-To: <xmqqlhoj51bi.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [16.210.192.239]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ah gotcha.  That makes sense.

Default behavior is to do a patch-id check on all of them which is exactly what you would normally want to happen, and suppressing that speeds things up considerably at the risk of attempting to re-apply an already existing patch.

Thanks much for the explanation.   Perhaps I'll add a progress indicator since my organization will be doing a significant number of these types of rebases in the near future.

Regards,
-Andrew




> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Monday, October 13, 2014 10:26 AM
> To: Crabtree, Andrew
> Cc: git@vger.kernel.org
> Subject: Re: Performance Issues with Git Rebase
> 
> "Crabtree, Andrew" <andrew.crabtree@hp.com> writes:
> 
> > I'm getting the same output with both the triple and double dot for my
> > specific case, but I have no idea if that change makes sense for all
> > cases or not.  Any guidance?
> 
> The difference only matters if any of your 4 patches have been sent
> to your upstream and accepted and appear among the 4665 changes they
> have.
> 
> The --cherry-pick option is about cross checking the combinations of
> 4 x 4665 and filter out matching ones (if any).
> 
