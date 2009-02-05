From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v3 7/9] write_entry(): use fstat() instead of lstat()
 when file is open
Date: Thu, 05 Feb 2009 09:45:06 -0800
Message-ID: <7veiyceq1p.fsf@gitster.siamese.dyndns.org>
References: <cover.1233751281.git.barvik@broadpark.no>
 <21073c1f3f6c2c81b26a632f495325f5e7a7de5a.1233751281.git.barvik@broadpark.no>
 <49899FA4.2020003@viscovery.net> <7vfxiut57t.fsf@gitster.siamese.dyndns.org>
 <86tz7ayo51.fsf_-_@broadpark.no> <498A9FD3.2020601@viscovery.net>
 <alpine.DEB.1.00.0902051202440.7491@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Kjetil Barvik <barvik@broadpark.no>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 05 18:46:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV8JF-0003Mc-Ic
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 18:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756101AbZBERpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 12:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755789AbZBERpR
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 12:45:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbZBERpP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 12:45:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F73B2A7F3;
	Thu,  5 Feb 2009 12:45:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2E3CA2A7C8; Thu, 
 5 Feb 2009 12:45:08 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BD984C4C-F3AC-11DD-8410-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108592>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Of course, what we _really_ would do is to provide a flag, say, 
> FSTAT_UNRELIABLE and test for _that_ (after defining it in the Makefile 
> for the appropriate platforms).

Sounds sensible.  POSIX of course requires write(), pwrite() and friends
to mark the mtime for update and fstat() to be reliable, but there may be
"not quite POSIX" systems.
