From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 7 Jan 2009 17:29:16 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071726020.3283@localhost.localdomain>
References: <20081209093627.77039a1f@perceptron>  <1231282320.8870.52.camel@starfruit>  <alpine.LFD.2.00.0901062005290.26118@xanadu.home>  <1231292360.8870.61.camel@starfruit>  <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>
  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>  <1231368935.8870.584.camel@starfruit>  <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>  <1231374514.8870.621.camel@starfruit>  <alpine.LFD.2.00.0901071644330.3283@localhost.localdomain>
 <1231376259.8870.633.camel@starfruit> <alpine.LFD.2.00.0901071702190.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 02:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKjk2-000394-T0
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 02:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756310AbZAHB36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 20:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756249AbZAHB35
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 20:29:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57395 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755856AbZAHB34 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 20:29:56 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n081TJY0020775
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 17:29:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n081THwu012698;
	Wed, 7 Jan 2009 17:29:17 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0901071702190.3283@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104868>



On Wed, 7 Jan 2009, Linus Torvalds wrote:
> 
> So there's a few rules to packedgitwindowsize:
> 
>  - we need to be able to have at least two windows open at a time, in 
>    addition to all the "normal" memory git needs just for objects, of 
>    course. And quite frankly, you'd be better off with a few more windows, 
>    even if that obviously implies smaller windows.

Btw, I'm not 100% certain of this. Somebody should double-check me. Maybe 
there are cases where we want more than two windows alive. And maybe there 
aren't even that, and we can always make do with just one.

So I will _not_ guarantee that "at least two pack windows" is necessarily 
the right answer. The windowing code was mostly other people doing it. I 
think Shawn and Nico.

			Linus
