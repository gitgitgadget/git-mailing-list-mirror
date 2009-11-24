From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Mon, 23 Nov 2009 17:45:54 -0700
Message-ID: <20091124004554.GA27643@ldl.fc.hp.com>
References: <20091123221628.GE26810@ldl.fc.hp.com> <7v6390sqhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:46:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjXd-0006uR-1P
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 01:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475AbZKXApt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 19:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757398AbZKXApt
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 19:45:49 -0500
Received: from g1t0028.austin.hp.com ([15.216.28.35]:31205 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754739AbZKXAps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 19:45:48 -0500
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0028.austin.hp.com (Postfix) with ESMTP id EC2EF1C0A2;
	Tue, 24 Nov 2009 00:45:54 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g5t0030.atlanta.hp.com (Postfix) with ESMTP id B1C7614121;
	Tue, 24 Nov 2009 00:45:54 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id 67207CF000C;
	Mon, 23 Nov 2009 17:45:54 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6U7MsNS2MZCg; Mon, 23 Nov 2009 17:45:54 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id 5235CCF0007; Mon, 23 Nov 2009 17:45:54 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <7v6390sqhz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133548>

* Junio C Hamano <gitster@pobox.com>:
> Alex Chiang <achiang@hp.com> writes:
> 
> > I'm an StGit user, and while StGit has its own 'stg mail'
> > feature, it doesn't know how to expand email aliases (yet).
> >
> > Certainly, one way to solve that problem would be to hack stgit
> > so that it can parse alias files, but to me, that seems silly
> > when git-send-email can already do that.
> >
> > This patch teaches git-send-email to only expand email addresses
> > so that other git porcelains don't have to roll their own mail
> > alias parsers.
> 
> Certainly, one way to solve that would be to hack _both_ stgit and
> send-email so that the former runs the latter _only_ to ask for the
> expansion and then send the message out, but to me, that seems silly
> when git-send-email can already do both expanding aliases and sending
> the message ;-)
> 
> If you are changing StGit to call git-send-email anyway, why not arrange
> stgit to call git-send-email to send the message out instead, instead of
> sending messages on its own?

Yeah, I thought about that as I was poking around further in
StGit to figure out how it would be calling git-send-email. ;)

> > I imagine the internal implementation of stg mail to work
> > something like:
> >
> > 	call git-send-email --expand-aliases repeatedly, once for
> > 	all the combined --to= args, then for all the combined --cc= args,
> > 	and finally for all the combined --bcc= args (all passed
> > 	to stg mail), read from stdout until EOF
> 
> I imagine the internal implementation of stg mail would work something
> like:
> 
>     prepare messages to send out
>     call git-send-email and have it send them
> 
> What am I missing?

My lack of familiarity with StGit internals. ;)

Your suggestion is much better. I'll take a closer look at StGit
and see how feasible it is.

Unless Catalin has strong objections?

Thanks,
/ac
