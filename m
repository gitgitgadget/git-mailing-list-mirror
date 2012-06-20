From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] submodule add + autocrlf + safecrlf
Date: Wed, 20 Jun 2012 10:49:31 -0700
Message-ID: <7vipelx49g.fsf@alter.siamese.dyndns.org>
References: <cover.1340202515.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 19:49:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShP2B-0007Iu-Ql
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 19:49:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab2FTRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 13:49:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756404Ab2FTRte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 13:49:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE09F9EDD;
	Wed, 20 Jun 2012 13:49:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KgVEDILPfS2TTnVKN5drFU01TEU=; b=oaxpGi
	PmntPmMzChbI/P3EXU7f0NBNLkONTnL5WzPTTpPzJJmS5fPR8R6eA/M6BVNDWtja
	wwh8HmEY+a+XBrFyOkftFtVM6HWpnxW6t6YickMWc3Of3gsEQgXcwZftBTgRNyzw
	uPUSd/XNN1+22vDOXHxeRllbIxw25renOA5kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enksP4/whLZcLjUPAP0WYJc/KkS6m6/S
	dbF9jbsQ3JkQylCj002gYDlJ2taeW57GAcy/GhYlgCq2BciiRTaanzZsBuMsvQpV
	eB0qezHmcMxfHVh9iUsQ0FIDhs97ckh1pI5J+fqYDxHkhkC8TUO9fq/xHN0HSzyM
	i+umNr0NJgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4A2A9EDC;
	Wed, 20 Jun 2012 13:49:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 413569EDB; Wed, 20 Jun 2012
 13:49:33 -0400 (EDT)
In-Reply-To: <cover.1340202515.git.brad.king@kitware.com> (Brad King's
 message of "Wed, 20 Jun 2012 10:43:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B22A1DE-BB00-11E1-B8F5-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200306>

Brad King <brad.king@kitware.com> writes:

> When 'git submodule add' uses 'git config' to create a
> '.gitmodules' file it gets LF newlines that the subsequent
> 'git add --force .gitmodules' rejects if autocrlf and
> safecrlf are both enabled.  This series adds a test and
> proposes a fix that simply uses '-c core.safecrlf=false'
> to disable safecrlf when adding '.gitmodules'.
>
> I'm not excited by allowing a LF file in work tree that
> has clearly been configured to prefer CRLF, but avoiding
> that for .gitmodules is probably a separate issue.

I have a suspicion that "git config" should be taught about this
kind of thing instead.

Shoudn't your .git/config file that is outside the revision control
also end with CRLF if your platform and project prefer CRLF over LF?
