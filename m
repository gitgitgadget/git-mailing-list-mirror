From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 15:36:29 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071531030.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <alpine.DEB.1.10.0905071521130.15782@asgard>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bevan Watkiss <bevan.watkiss@cloakware.com>,
	"'Alex Riesen'" <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri May 08 00:40:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2CGA-0001cf-6J
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 00:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbZEGWj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 18:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZEGWj7
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 18:39:59 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57346 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751119AbZEGWj6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 18:39:58 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47MaTkC018514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 15:37:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47MaTap017741;
	Thu, 7 May 2009 15:36:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.10.0905071521130.15782@asgard>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118532>



On Thu, 7 May 2009, david@lang.hm wrote:
> 
> his use case (as I understand it) is that the working tree is never updated by
> anything other than git. it never recieves patches or manual edits.

Well, you can certainly just use the CE_VALID bit in the index too (and 
this time I really mean CE_VALID). But it won't help anybody else, so it 
wouldn't be nearly as interesting. And I wonder how badly that code has 
rotted, thanks to not getting used.

But yes, one thing to do would be

	git update-index --assume-unchanged --refresh

which should hopefully set the bit, and then after that setting 
'core.ignoreStat' should hopefully keep it set.

Of course, you had then better _never_ make any mistakes and touch the 
files with non-git commands.

And hope that the code still works ;)

		Linus
