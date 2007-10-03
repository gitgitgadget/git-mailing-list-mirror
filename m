From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Must not modify the_index.cache as it may be passed to realloc at some point.
Date: Tue, 02 Oct 2007 22:55:57 -0700
Message-ID: <7vtzp8g2s2.fsf@gitster.siamese.dyndns.org>
References: <1191390255.16292.2.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Keith Packard <keithp@keithp.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcxDR-0000lN-KW
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXJCF4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbXJCF4F
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:56:05 -0400
Received: from rune.pobox.com ([208.210.124.79]:36951 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbXJCF4E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:56:04 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 9CE72140ACE;
	Wed,  3 Oct 2007 01:56:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DCD8C140AD0;
	Wed,  3 Oct 2007 01:56:20 -0400 (EDT)
In-Reply-To: <1191390255.16292.2.camel@koto.keithp.com> (Keith Packard's
	message of "Tue, 02 Oct 2007 22:44:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59793>

Keith Packard <keithp@keithp.com> writes:

> The index cache is not static, growing as new entries are added. If entries
> are added after prune_cache is called, cache will no longer point at the
> base of the allocation, and realloc will not be happy.

Thanks for catching this.  This code originally was perfectly
Ok, but I broke it with the overlay_tree() change.
