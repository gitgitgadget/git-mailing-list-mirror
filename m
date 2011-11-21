From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run-command.c: Accept EACCES as command not found
Date: Mon, 21 Nov 2011 14:13:58 -0800
Message-ID: <7vbos5f7ix.fsf@alter.siamese.dyndns.org>
References: <1321912387-4569-1-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 23:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSc7r-0004t3-Ge
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 23:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756450Ab1KUWOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 17:14:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753692Ab1KUWOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 17:14:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5646A56AA;
	Mon, 21 Nov 2011 17:14:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIaM7KkmKjEeOUmsRhHm3r+uvD0=; b=FOTO6i
	HWydsePumygzLDeCn7ISNQz1yfsecWiQqwk/oufT4gGT6joqYTdFX9YzB5Ej7sYj
	JRZolBt9M6Tl/MjPwAt0SYgZSGhz/x/DHh+n4whKSb3ssIgWs3QyeNXJpJAlLtCS
	yhZHSYrEgloiWDiSnBnctqETZguG3NECeGr5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GcidWgMbAgBrypKMVHCh7EUx18z/JzYj
	OWei+vkgmbS+owLRBJMNA0FMrFIajCqp3S/fKUrUZ8vTdYOcxsxy5gX9fST1Q6J7
	xDgSKM7a5K2NqRBYS6wS+v6CLrweL0FNs5QmXzDQV7jiIk7OChvrbm0ACb1rUJ8y
	4sv9pO86grY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9E056A9;
	Mon, 21 Nov 2011 17:14:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AFA756A8; Mon, 21 Nov 2011
 17:13:59 -0500 (EST)
In-Reply-To: <1321912387-4569-1-git-send-email-fransklaver@gmail.com> (Frans
 Klaver's message of "Mon, 21 Nov 2011 22:53:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C89145C-148E-11E1-BA0D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185765>

Frans Klaver <fransklaver@gmail.com> writes:

> execvp returns ENOENT if a command was not found after searching PATH.
> If path contains a directory that current user has insufficient
> privileges to, EACCES is returned. This may still mean the program
> wasn't found.
>
> If the latter case is encountered, git errors out without giving aliases
> a try,...

Isn't that a *good* thing in general, though, so that the user can
diagnose the breakage in the $PATH and fix it?
