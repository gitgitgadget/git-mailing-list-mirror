From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Tue, 6 Apr 2010 07:19:31 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1004060713200.3487@i5.linux-foundation.org>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org> <4BBAE904.6010105@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 06 16:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz9ls-0002yM-3g
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 16:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab0DFO2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 10:28:47 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51051 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752779Ab0DFO2q (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 10:28:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o36ENCrv028583
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 6 Apr 2010 07:23:13 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o36ENBv9021207;
	Tue, 6 Apr 2010 07:23:12 -0700
In-Reply-To: <4BBAE904.6010105@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144144>



On Tue, 6 Apr 2010, Johannes Sixt wrote:
>
> Am 4/6/2010 1:00, schrieb Linus Torvalds:
> > I never use ':/', and part of it is that it's so horribly cumbersome. I'd 
> > _like_ to use it to do things like 
> > 
> > 	gitk :/slabh..
> 
> Rhethoric question: Do you mean history _starting_ at the commit that
> contains "slabh" or _ending_ at the commit that contains "slabh" followed
> by two arbitrary characters?

Ending in the commit that contains "slabh".

The last two dots are removed by the revision handling machinery, _before_ 
we even see the ':/' thing. See 'handle_revision_arg()', and notice how it 
searches for ".." and then does "*dotdot = 0".

So the regex is 'slabh'.

> If :/ is pattern-ized in some way, then IMO pattern matching syntax would
> be more use-friendly than (extended) regular expresssions, particluarly
> also because the single-character wildcard would be ? and avoid the
> otherwise overloaded dot.

I do agree that regex'es might contain the invalid sequence "..", but it's 
fairly unusual, and you can work around it, ie you can do

	gitk :/'slabh(.)(.)of'..

which now that I write it out admittedly looks like you are searching for 
titties, but hey, sex sells, so we can call it a _feature_.

			Linus
