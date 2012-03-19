From: Junio C Hamano <gitster@pobox.com>
Subject: Re: link user-name with ssh-login
Date: Mon, 19 Mar 2012 12:15:07 -0700
Message-ID: <7v7gygbdxg.fsf@alter.siamese.dyndns.org>
References: <4F6765D0.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roberto <mrgreiner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 20:15:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9i35-0004kp-Hf
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 20:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032605Ab2CSTPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 15:15:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58299 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032559Ab2CSTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 15:15:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C0EF7F7A;
	Mon, 19 Mar 2012 15:15:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gbijbRgxY1BKJwZiLn/OOmMJkGo=; b=cJTK35
	6U7E3aNxAgBN5b4XEdEJ4bbaSZwNlXXUKGNXVHekPdyYnPkviGx6xDRR/GoVySqn
	va4FBUTpJQ/ho8HDM2VHkZ/8KrGZagg741tzvS12K6G4TMwmmaspi8Z5QPavx3jQ
	xFhCeL/E/eGy92voDi0CmyWObRld8Z9efCFy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YhZTPzUFa3ZWwdPmtZT16KKyqDYe/YBf
	PCiLm+9Q+THTPi9rYFRAheBKda44Wcqvjme5i3aLlnbbzaFQD1FxEZGz90Vg2sh4
	8naDxnQ/hs9yu8NAACCBVmvVARAktA/Xuy97ybmx6FyDRsEhaakQmPTzuxl0riXD
	MpXBjtc72sI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 833D87F79;
	Mon, 19 Mar 2012 15:15:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 218367F78; Mon, 19 Mar 2012
 15:15:09 -0400 (EDT)
In-Reply-To: <4F6765D0.5060706@gmail.com> (Roberto's message of "Mon, 19 Mar
 2012 13:58:56 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7EF71E8-71F7-11E1-A49A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193449>

Roberto <mrgreiner@gmail.com> writes:

> I have small ssh-based git server used for insite code
> development. But there is one thing I can't find how to set.
>
> In the server, each developer has a valid ssh account (I switched the
> shell to git-shell). The problem is that when a developer commit's
> some code, he can freely set in his local .git/config file the user
> name he want's to appear in the commit logs. Is there any way to
> link/force a certain ssh login to a name?

A pre-receive hook that lists the author names of the commits, along the
lines of "git log --format='%an <%ae>' $OLD_HEAD..$NEW_HEAD" and compares
against the name of the user authenticated against your SSH server would
be a way to do this.

But that would mean you are forbidding people to accept patches from
others, inspect the patches for validity and vouch for them, while giving
the credit to them by recoding the author names of the patch authors.

Perhaps checking the committer name would suit your situation better.  I
dunno.
