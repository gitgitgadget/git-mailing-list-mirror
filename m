From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:44:36 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809111641110.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com> <48C9A9A4.8090703@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Paolo Bonzini <bonzini@gnu.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvsH-0002WA-Mz
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:46:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbYIKXpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754730AbYIKXpW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:45:22 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33000 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754213AbYIKXpV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 19:45:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BNibZc007573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Sep 2008 16:44:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8BNia6s022601;
	Thu, 11 Sep 2008 16:44:36 -0700
In-Reply-To: <48C9A9A4.8090703@vilain.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.939 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95671>



On Fri, 12 Sep 2008, Sam Vilain wrote:
> 
>  2. make git-cherry-pick have a similar option to '-x', but instead of
>     recording the original commit ID, record the original *patch* ID,
>     *if* there was a merge conflict for that cherry pick.

Actually, don't make it dependent on merge conflicts. Just make it depend 
on whether the patch ID is _different_.

It can happen even without any conflicts, just because the context 
changed. So it really isn't about merge conflicts per se, just the fact 
that a patch can change when it is applied in a new area with a three-way 
diff - or because it got applied with fuzz.

You could add it as a 

	Original-patch-id: <sha1>

or something. And then you just need to teach "git cherry/rebase" to take 
both the original ID and the new one into account when deciding whether it 
has already seen that patch.

			Linus
