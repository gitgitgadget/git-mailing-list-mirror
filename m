From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Is there some way to suppress Cc email only to stable?
Date: Mon, 9 Feb 2015 13:43:12 -0800
Message-ID: <20150209214312.GC4166@linux.vnet.ibm.com>
References: <20150209194224.GA27482@linux.vnet.ibm.com>
 <xmqq386eby6w.fsf@gitster.dls.corp.google.com>
 <20150209211021.GB4166@linux.vnet.ibm.com>
 <xmqqtwyuaipa.fsf@gitster.dls.corp.google.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mingo@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKw6z-0006uK-LZ
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 22:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761248AbbBIVnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 16:43:17 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:55576 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760442AbbBIVnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 16:43:16 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 9 Feb 2015 14:43:16 -0700
Received: from d03dlp03.boulder.ibm.com (9.17.202.179)
	by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Mon, 9 Feb 2015 14:43:14 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1672219D803F
	for <git@vger.kernel.org>; Mon,  9 Feb 2015 14:34:24 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t19LhZJh42795038
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 14:43:35 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t19LhD1O003904
	for <git@vger.kernel.org>; Mon, 9 Feb 2015 14:43:14 -0700
Received: from paulmck-ThinkPad-W500 (sig-9-65-236-19.ibm.com [9.65.236.19])
	by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id t19LhDet003885;
	Mon, 9 Feb 2015 14:43:13 -0700
Received: by paulmck-ThinkPad-W500 (Postfix, from userid 1000)
	id 9AE2538BAA2; Mon,  9 Feb 2015 13:43:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqtwyuaipa.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 15020921-0013-0000-0000-0000089A0615
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263607>

On Mon, Feb 09, 2015 at 01:17:05PM -0800, Junio C Hamano wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> 
> > On Mon, Feb 09, 2015 at 12:57:11PM -0800, Junio C Hamano wrote:
> >> No, I do not think we have a way to blacklist certain recipient
> >> addresses from getting passed to the MTA, and I do not object to
> >> addition of such a mechanism if there is a valid need to do so.
> >> 
> >> It feels a bit too convoluted to say "Cc: to this address" in the
> >> log message and then "nonono, I do not want to send there", though.
> >> Why do you want to have Cc: in the log message if you do not want to
> >> send e-mail to that address in the first place?  Allowing the
> >> behaviour you are asking for would mean that those who see that the
> >> commit appeared on a branch would not be able to assume that the
> >> patch has already been sent to the stable review address, no?
> >
> > I could see where it might seem a bit strange.  ;-)
> >
> > The reason behind this is that you are not supposed to actually send
> > email to the stable lists until after the patch has been accepted into
> > mainline.  One way to make this work is of course to leave the stable
> > Cc tags out of the commit log, and to manually send an email when the
> > commit has been accepted.  However, this is subject to human error,
> > and more specifically in this case, -my- human error.
> >
> > Hence the desire to have a Cc that doesn't actually send any email,
> > but that is visible in mainline for the benefit of the scripts that
> > handle the stable workflow.
> 
> So a configuration variable that you can set once and forget, e.g.
> 
>     [sendemail]
> 	blacklistedRecipients = stable@vger.kernel.org
> 
> would not cut it, as you would _later_ want to send the e-mail once
> the commit hits the mainline.  Am I reading you correctly?

This would actually work for me.  Once the patch is accepted into
mainline, I am done with it.  So I should -never- send email to
stable@vger.kernel.org, unless I am doing so manually, for example because
I forgot to add the stable tag to a given commit.  But in that case,
I would just use mutt to forward the patch to stable@vger.kernel.org,
and git would not be involved.

So as far as I can see, yes, it would be perfectly OK to unconditionally
blacklist stable@vger.kernel.org within my git tree.  That would be nice!

> Or is it that nobody actually sends to stable@vger.kernel.org address
> manually, but some automated process scans new commits that hit the
> mainline and the string "Cc: stable@vger.kernel.org" is used as a cue
> for that process to pick them up?

I belive that something like this happens, but I don't know the details. 
I do know that it does not involve any of my local git trees.  ;-)

							Thanx, Paul
