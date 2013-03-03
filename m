From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Sat, 02 Mar 2013 22:22:46 -0800
Message-ID: <7vtxotc895.fsf@alter.siamese.dyndns.org>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
 <7v1ubyek9n.fsf@alter.siamese.dyndns.org>
 <20130302004120.GB14936@sigill.intra.peff.net> <m28v66198o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, William Giokas <1007380@gmail.com>,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 03 07:23:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC2KT-0002Zn-3V
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 07:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab3CCGWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 01:22:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61511 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123Ab3CCGWt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 01:22:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACED9445;
	Sun,  3 Mar 2013 01:22:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JgOH3HgIKwVnkMM04sl3AeJVXYY=; b=lXqAuS
	zLlYiNoJdEOLY5+RM3UxeqDmb7tAnKqbUWrZ5v9hgWQHuh/TGVxjrRFL0YMvnkMB
	Ra24BrYdYForEmekXT41gNQCQ91/oEsaSjqfxwsCOvCzqkEQYWfcmY0zBPa7izV6
	pPl5RtWlpjmoCjrWJp7vGydtM7sFYY5PNkTwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DqSmbGNVVVRU2IQQI0WaoNqoZPH2KT5/
	LEuv4orFpChQTKBe40x4aYom2EZe0q6Nxwjdm0HlEM1T9A8LQRs7mR9vacx66Xzy
	Ug752qXmG5Ddj7Ju4o8sH80IMCgw+VrVGoh0LcmNJesrrfQkhPPk2CKFTb9laDaN
	Vbs7HGhUDlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA8B9444;
	Sun,  3 Mar 2013 01:22:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13EE49442; Sun,  3 Mar 2013
 01:22:47 -0500 (EST)
In-Reply-To: <m28v66198o.fsf@igel.home> (Andreas Schwab's message of "Sat, 02
 Mar 2013 09:44:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4ADFEDE-83CA-11E2-9A88-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217335>

Andreas Schwab <schwab@linux-m68k.org> writes:

> You should always cast to unsigned char when determining the order of
> characters, to be consistent with strcmp/memcmp.

We treat runs of digits as numbers, so it is not even similar to
strcmp.  As long as it is internally consistent (i.e. the return
value inside the loop (*a - *b) must match the last return), it
should be OK, no?
