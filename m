From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone --mirror: avoid storing repeated tags
Date: Thu, 07 Aug 2008 21:57:08 -0700
Message-ID: <7vej50gl3v.fsf@gitster.siamese.dyndns.org>
References: <489B9A8B.9050807@cesarb.net>
 <alpine.DEB.1.00.0808080428520.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Cesar Eduardo Barros <cesarb@cesarb.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 08 06:58:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRK3Q-0004U8-CR
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 06:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbYHHE5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 00:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbYHHE5S
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 00:57:18 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56278 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYHHE5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 00:57:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C26450F8F;
	Fri,  8 Aug 2008 00:57:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4498C50F8C; Fri,  8 Aug 2008 00:57:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808080428520.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 8 Aug 2008 04:29:35 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78459EEA-6506-11DD-BF0C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91619>

Thanks for reporting and a quick fix.

This made me wonder if this relatively new "pack cloned refs" codepath has
funny interaction with --reference which is another user of add_extra_refs(),
but I think it is safe (we clear the real "extra" ones used during the
object transfer before calling write_remote_refs()).
