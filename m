From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/4] replace unsinged long with time_t
Date: Thu, 6 Nov 2008 10:45:47 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811061042530.3419@nehalem.linux-foundation.org>
References: <1225993728-4779-1-git-send-email-david@statichacks.org> <alpine.LFD.2.00.0811061000430.3419@nehalem.linux-foundation.org> <20081106183722.GL10996@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Thu Nov 06 19:47:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky9tE-0003H1-D1
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 19:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbYKFSqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 13:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbYKFSqS
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 13:46:18 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56871 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750804AbYKFSqS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Nov 2008 13:46:18 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA6IjmZ9026551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Nov 2008 10:45:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA6IjlCq020606;
	Thu, 6 Nov 2008 10:45:47 -0800
In-Reply-To: <20081106183722.GL10996@eratosthenes.cryptobackpack.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100261>



On Thu, 6 Nov 2008, David Bryson wrote:
> 
> I have always thought that time_t and similar were braindead, but hey
> the Janitor page listed it as desireable so what do I know ?

It might be worth it to make the internal git time always be 64-bit.

It was kind of a long-term plan anyway: git doesn't really ever have to 
work with dates in the future (and things like "approxidate()" actually 
know that and use it to guess what date you must be talking about), so 
even a 32-bit "unsigned long" is expected to work well until 2038, but at 
_some_ point we'd need to guarantee 64-bit epoch times.

It just wasn't something I was in a huge hurry over. Others have to worry 
about dates from the future long before wrap-around, git really doesn't. 
But from a janitorial standpoint, I certainly wouldn't totally hate using 
a known 64-bit type for dates.

			Linus
