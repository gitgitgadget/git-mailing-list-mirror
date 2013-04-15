From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase-am: fix regression with new cover-letter config
Date: Sun, 14 Apr 2013 19:51:02 -0700
Message-ID: <7v1uac4icp.fsf@alter.siamese.dyndns.org>
References: <1365978424-11841-1-git-send-email-felipe.contreras@gmail.com>
 <7vhaj84l8m.fsf@alter.siamese.dyndns.org>
 <CAMP44s0GbocoBrONYdiN6f=qd58xbX0Y4neGSVRmCiLRr_f8Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 04:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZVg-0002yt-UI
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450Ab3DOCvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:51:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118Ab3DOCvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:51:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBFE7F439;
	Mon, 15 Apr 2013 02:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TeWIRwYgZ0w9p8trSzOwvW7SCVk=; b=q2spqO
	+cXayk9XYlloF3S+dJZiGMMEHIIQUJDB9h61csiaGxFXLs8SgepwT6Mkhdmaa9RZ
	n6p4jyF6sAYBmqQGTq4okOLhSLHKvzoE7Ku0spig7gidbct1gVBvlKK441aoxkDG
	VsjDLrPrJ9qLmHCJT6toWOpQeMfk+7ZdiM3JM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KGMX5nTqMzm0NDG4Pn3ZOd6m1OvUZcsr
	/6QfrhcVBeSv+kY9P3qA/oDd03055L6f5reQDmo7tUOXk+i0t2ECWXPAdwPBrnGP
	lU1dzJD8MGeDsP62vG2Z1yIhNdTtirGIriuTDSREz1Xww8WpnOj71vj2upbv/Gfx
	WMLvik1LZ6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4141F438;
	Mon, 15 Apr 2013 02:51:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2B6DF430; Mon, 15 Apr 2013
 02:51:03 +0000 (UTC)
In-Reply-To: <CAMP44s0GbocoBrONYdiN6f=qd58xbX0Y4neGSVRmCiLRr_f8Jw@mail.gmail.com> (Felipe
 Contreras's message of "Sun, 14 Apr 2013 21:31:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 500EE600-A577-11E2-AF57-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221187>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> You are mean to say "fix regression", which gave me a small heart
>> attack ;-).  I was worried if we had already merged it to 'next'.
>>
>> As I already wrote in the recent "What's cooking", the series looks
>> good to me.  I am inclined to say that we should merge it (together
>> with this update) to 'next'.
>
> Yeah, after thinking about it, it's not even really a regression,
> because people don't have format.coverletter=auto in their configs
> (yet), so the bug can't can possibly affect them.

Here is what I tentatively queued.

    rebase-am: explicitly disable cover-letter
    
    If the user has a cover-letter configuration set to anything
    other than 'false', 'git format-patch' may generate a cover
    letter, which has no place in "format-patch | am" pipeline.
    
    The internal invocatoin of format-patch must explicitly override
    the configuration from the command line, just like --src-prefix
    and other options already do.
    
    Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
