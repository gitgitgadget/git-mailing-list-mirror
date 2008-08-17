From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sun, 17 Aug 2008 09:07:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808170905540.3324@nehalem.linux-foundation.org>
References: <20080816205325.GD10729@mrq1.org> <alpine.LFD.1.10.0808161543160.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808161613520.3324@nehalem.linux-foundation.org> <7vr68obbpd.fsf@gitster.siamese.dyndns.org> <7vk5egbaft.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.10.0808162054050.3324@nehalem.linux-foundation.org> <7vljyw9pok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 18:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUkoP-0004m4-IC
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 18:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbYHQQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 12:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbYHQQHu
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 12:07:50 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57666 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751310AbYHQQHt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2008 12:07:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7HG7KbQ028505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 Aug 2008 09:07:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7HG7JXs011167;
	Sun, 17 Aug 2008 09:07:20 -0700
In-Reply-To: <7vljyw9pok.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.924 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92614>



On Sat, 16 Aug 2008, Junio C Hamano wrote:
> 
> Is this because we do not initialize tm fields to "unknown" in the
> beginning?  I admit I haven't bothered to look at this part of the code
> for a looong time.

Indeed. The _exact_ date handling initializes the date to -1 (and the 
time to 0), but the approxidate thing defaults to "now" and then modifies 
that. 

Which is why we'd need to have a separate flags field for "I have 
initialized this field".

		Linus
