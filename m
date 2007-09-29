From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the actions
Date: Fri, 28 Sep 2007 19:12:51 -0700
Message-ID: <7vfy0ymd7g.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 29 04:13:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbRpM-0001tU-02
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 04:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbXI2CNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 22:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752518AbXI2CNA
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 22:13:00 -0400
Received: from rune.pobox.com ([208.210.124.79]:32900 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752322AbXI2CM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 22:12:59 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8533E13DD66;
	Fri, 28 Sep 2007 22:13:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CF73313DD5B;
	Fri, 28 Sep 2007 22:13:16 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709290231300.28395@racer.site> (Johannes
	Schindelin's message of "Sat, 29 Sep 2007 02:31:48 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59439>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When you do many rebases, you can get annoyed by having to type out
> the actions "edit" or "squash" in total.
>
> This commit helps that, by allowing you to enter "e" instead of "edit",
> or "s" instead of "squash", and it also plays nice with "merge" or "amend"
> as synonyms to "squash".

I am not sure if we want to taint the words merge and amend like
this.  I was hoping someday you would allow people to reorder
something like this...

          e
           \     
 ---a---b---c---d

into something like this:

      e
       \     
 ---b'--c'--a'+d'

The insn sequence you prepare for the user to edit would be:

	pick	a	
	pick	b
	merge   c
        pick    d

and then the user would rewrite that to:

	pick	b
        merge   c
        pick    a
        squash  d

I do not think making 'amend' a synonym to 'squash' is correct
either; isn't it closer to 'edit'?

I however do agree that giving short-hand would be a good idea.
 
