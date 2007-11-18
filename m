From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] fetch-pack: Prepare for a side-band demultiplexer in a thread.
Date: Sun, 18 Nov 2007 13:23:35 +0100
Message-ID: <200711181323.35219.johannes.sixt@telecom.at>
References: <200711172309.28364.johannes.sixt@telecom.at> <200711181036.14565.johannes.sixt@telecom.at> <7v3av3yi1x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 13:24:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItjCB-0001fZ-9p
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 13:24:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXKRMX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 07:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbXKRMX5
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 07:23:57 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:51863 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbXKRMX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 07:23:57 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id A128DBF31A;
	Sun, 18 Nov 2007 13:23:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 746A85933E;
	Sun, 18 Nov 2007 13:23:35 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <7v3av3yi1x.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65369>

On Sunday 18 November 2007 11:16, Junio C Hamano wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> >> If the rationale was "running in a thread is more natural on the
> >> platform", I would understand it.
> >
> > Please take it as such.
> >
> >> But "_must_ run because there is no fork(2)" solicits a "Huh?
> >> How does Cygwin does it then?" from me.
> >
> > Alex has answered this. We are not going to copy Cygwin's fork() into
> > git.
>
> Wholeheartedly agree, and I feel dirty after looking at that
> thing.  Nothing against Cygwin folks, of course.
>
> The reason I wanted to close pipes as early as possible was
> because I did not want to get bitten by "read() waiting forever
> for EOF due to an extra unclosed fd on the writer end of the
> pipe() without the writer not writing anything to it" problem,
> which is an often-seen mistake.

That was my concern, too, and I spent quite a few brain cycles to verify that 
this is not the case here.

-- Hannes
