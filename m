From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Sat, 17 Jan 2009 11:13:18 -0800
Message-ID: <7vljt97nld.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 20:14:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOGdA-0004X5-Tf
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 20:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761431AbZAQTN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 14:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761062AbZAQTN2
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 14:13:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759186AbZAQTN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 14:13:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4BEF991F3B;
	Sat, 17 Jan 2009 14:13:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33DBB91F37; Sat,
 17 Jan 2009 14:13:20 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sat, 17 Jan 2009 16:04:08 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EAB12D20-E4CA-11DD-8F78-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106093>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Instead of traversing them twice, we just build a list of branch switches,
> pick the one we're interested in, and free the list again.

Isn't the code keeping them all in core, or am I reading the patch wrong?

If you know that you are interested in the nth-from-the-last switch, and
if you are reading from the beginning, you would need to keep at most n 
last switches you have seen in core, wouldn't you?  
