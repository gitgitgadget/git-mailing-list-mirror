From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE:
Date: Thu, 7 May 2009 13:20:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "'Alex Riesen'" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bevan Watkiss <bevan.watkiss@cloakware.com>
X-From: git-owner@vger.kernel.org Thu May 07 22:22:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2A7D-0003Nv-Pz
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 22:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbZEGUWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 16:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZEGUWi
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 16:22:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42081 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845AbZEGUWi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2009 16:22:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47KKTkD022533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 7 May 2009 13:21:05 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n47KKSHZ028542;
	Thu, 7 May 2009 13:20:29 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118520>



On Thu, 7 May 2009, Linus Torvalds wrote:
>
> The patch is TOTALLY UNTESTED. It also worries me that 'git checkout' 
> seems to do _two_ 'lstat()' calls per file. I didn't look any more 
> closely, but there may be other issues here.

Hmm. The second pass comes from 

	show_local_changes(&new->commit->object);

(this is the "git checkout" without actual filenames), and is suppressed 
if we ask for a quiet checkout. But it's sad how it re-loads the index. I 
wonder where the CE_VALID bit got dropped.

			Linus
