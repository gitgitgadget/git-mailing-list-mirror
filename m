From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 14:58:04 -0700
Message-ID: <20080801145804.85041bbd.akpm@linux-foundation.org>
References: <20080731194042.a1534b4d.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org>
	<20080801124550.26b9efc0.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org>
	<20080801131127.20b3acfd.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org>
	<20080801132415.0b0314e4.akpm@linux-foundation.org>
	<alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org>
	<20080801135421.5ca0f6af.akpm@linux-foundation.org>
	<7vvdykqub6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@linux-foundation.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 00:00:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP2fY-0000Jy-Hp
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 00:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756358AbYHAV7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752238AbYHAV7K
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 17:59:10 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56567 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756497AbYHAV7J (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 17:59:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71Lw4sT009303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 14:58:05 -0700
Received: from akpm.corp.google.com (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m71Lw4wg005737;
	Fri, 1 Aug 2008 14:58:04 -0700
In-Reply-To: <7vvdykqub6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
X-Spam-Status: No, hits=-2.824 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91105>

On Fri, 01 Aug 2008 14:50:05 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> >> The part _you_ don't seem to understand is that my point is
> >> 
> >>  - git changed that "From:" line to an "Author:" line
> >> 
> >>  - "git log" isn't an email system. It's a human-readable (and 
> >>    machine-parseable, for that matter) log.
> >
> > What you're describing here is some explicit or implicit git design
> > decision and then telling me how it's implemented.
> >
> > Well, what I'm saying is that it was an incorrect design decision.
> 
> What is the objective of your statement in this discussion?  Further add
> fuel to flame, or to seek avenues that lead to some improvement in a
> constructive way?

Well initially it was to work out why the heck my git-log output had
stripped the quotes from that person's name, making it unusable for
email purposes.  I'd actually assumed that it was a bug.

> The thing is, I do not think reverting that design decision is an option
> at this point.  People's repositories record <Name, Email> pair already in
> "human readable" form, and people's scripts are assuming that.
> 
> I misspoke about git-send-email earlier; it already has sanitize_address()
> that massages the addresses on From: To: and Cc: lines.  In fact, it even
> seems to have logic to avoid double-quoting, so it would be Ok if you
> changed the design decision this late in the game for that particular
> script, but that does not mean it is a good change --- other scripts
> people may have built around git would need to change.
> 
> So the earlier patch from Dscho (Johannes) may be a step in the right
> direction, but if we are going to rewrite the author information, (1) it
> has to be an option, and (2) when rewriting, it should not be just From:;
> but Signed-off-by:, Cc: and other <Name, Email> pairs at the end of the
> log message would need similar treatment, so that you can cut and paste
> any of them to your MUA.

I preserve the quotes (when present) in signoffs for this exact reason.
