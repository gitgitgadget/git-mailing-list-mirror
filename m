From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Fri, 27 Jan 2012 15:21:34 -0800
Message-ID: <7vr4ykybnl.fsf@alter.siamese.dyndns.org>
References: <2443.1327701165@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Jason Dominus <mjd@plover.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 00:21:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqv6z-0003nk-Gw
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 00:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788Ab2A0XVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 18:21:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab2A0XVg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 18:21:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E69C87E62;
	Fri, 27 Jan 2012 18:21:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V85pDHwC0bSkniCnFVWf4lyYf68=; b=LEZcK9
	WLk5QtagboZ6xOH9AwM6zSyO85BYP6B9j15BCp501rDN89nt03RCmFUlB2NqoIf3
	hfufYx3tI0IU19qHULIl3+yOiachlD4Fc9LEArFTJ81ddCD8Fs7GnrDXzmFIfqmA
	9ySwOqQepPp/aeBPW0vhL60C8pjZjnah7Nmlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=onKej2AvXjiQ6stUajpy8PkrWUV04GRZ
	H2Y9XS7fAxAr3XC9cXbMGxXXVGwuHuCYJUKiAyKE1idebulfDSQI9fUCdq7rq66G
	j2ebOREeZFJuugfWfjHh8sAqskv4SXoiDnHKm8VfPnW492SgkJtoIjdb/MGwwM75
	5f1BoX2ajrw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD8447E61;
	Fri, 27 Jan 2012 18:21:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AD387E60; Fri, 27 Jan 2012
 18:21:35 -0500 (EST)
In-Reply-To: <2443.1327701165@plover.com> (Mark Jason Dominus's message of
 "Fri, 27 Jan 2012 16:52:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7C6C4A4-493D-11E1-8085-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189244>

Mark Jason Dominus <mjd@plover.com> writes:

> This should work, but doesn't:
>
>         % git branch
>         * master
>         % git branch  --edit-description  blarf
>         [Edit description and exit editor normally]
>         % cat .git/BRANCH_DESCRIPTION 
>         I like blarf
>         # Please edit the description for the branch
>         #   blarf
>         # Lines starting with '#' will be stripped.
>         % git branch -a
>         * master
>
> Where is branch blarf?

You haven't created one in that sequence yet.

This is more of a documentation bug. 

As the SYNOPSIS section makes it clear, the '--edit-description' is a
separate mode from showing (the first group), creating or repointing (the
second), or renaming (the third).

After that you should be able to say "git branch blarf" and view its
description.
