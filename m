From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add definitions for global variables to shell.c
Date: Mon, 18 Aug 2008 17:29:11 -0700
Message-ID: <7vy72tkfu0.fsf@gitster.siamese.dyndns.org>
References: <20080818123727.GB11842@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:30:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVF76-0000Bw-Ao
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYHSA3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYHSA3R
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:29:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYHSA3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:29:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AC0AD53C7C;
	Mon, 18 Aug 2008 20:29:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2374B53C7B; Mon, 18 Aug 2008 20:29:12 -0400 (EDT)
In-Reply-To: <20080818123727.GB11842@schiele.dyndns.org> (Robert Schiele's
 message of "Mon, 18 Aug 2008 14:37:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA9EFEE2-6D85-11DD-B679-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92793>

Robert Schiele <rschiele@gmail.com> writes:

> Commit 5b8e6f85 introduced stubs for three functions that make no sense
> for git-shell.  But those stubs defined libgit.a functions a second time
> so that a linker can complain.  While commit 78568448 fixes this problem
> it introduces a new issue on the affected systems: Some versions of the
> Sun compiler generate references to global variables when they see
> extern declarations for those, even when they are never used in the
> code.

Haven't looked at the real declarations but if the decl are "extern" and
nobody refers to them, why should the resulting object file require them
to be defined anywhere?  If the decl are not and in (fortran-ish) "common"
section, on the other hand, you shouldn't have to define them yourself
like this either.

This sounds like a compiler bug to me.
