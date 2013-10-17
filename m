From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Thu, 17 Oct 2013 13:50:25 -0700
Message-ID: <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley>
	<xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com>
	<3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 22:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWuWe-0007Y5-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762467Ab3JQUu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Oct 2013 16:50:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757861Ab3JQUu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Oct 2013 16:50:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E308B4B339;
	Thu, 17 Oct 2013 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o11M87n4P6uwpKUoENHvKrESf1Y=; b=b4QzgU
	mAJyg5xZZlDku0XWZ5Bc1UJFt4guh5d8uvGGLVH2z+JdTyPCan9geW2BG32JqXAK
	e5kxRgGQIXl1oBaXmbc22H8AoewUZZuvWcM38LqdN7vmCdqVXVQJ2lSMIEKLIPhQ
	FCJvuZLhxyVA2Q6GaquNVGoKQ9+3wyRbtVuuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfZA2aoiEdMSlk6OfuqmieKHLmpvX1zu
	jizqSp4LxcuPvR9xgEnqWgrTtx+slqbGyqT/yy9Ir9v7+d2u/YnGb99Wj5a58Ckv
	synH2ZW6kyi2x3dkGrzYfxZkdxnPPefgKuRz32K4kbFAM8N145fLuu5eRfyQ1bih
	TVdwI96Uv8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C574B336;
	Thu, 17 Oct 2013 20:50:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 349FF4B330;
	Thu, 17 Oct 2013 20:50:27 +0000 (UTC)
In-Reply-To: <3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley> (Philip Oakley's
	message of "Thu, 17 Oct 2013 21:11:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C0866C18-376D-11E3-9892-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236319>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> "Philip Oakley" <philipoakley@iee.org> writes:
>>
>>> ... and the detection process for 'toplevel' may not work
>>> properly when in a separated work-tree environment.
>>
>> Without GIT_WORK_TREE exported to point at the top-level, there is
>> nothing that lets us "detect" it, as the working tree does not have
>> ".git" directory to tell us to stop, no?
>>
>
> "No", but not in that way.
>
> My point (to Dale) was, as you state, that the "cd to top level" was
> (IIUC) the probable causes of the fault, and that a documentation
> update would probably be appropriate for the discussion on exporting
> GIT_WORK_TREE, and that it would specifically mention those git
> commands that needed to "cd to top level", and hence would not work in
> such an environment. (I wasn't sure where the appropriate "cd to top
> level" function was)
>
> An explanation here on the list wouldn't solve the problems for others
> who are yet to make the same mistake, hence the implied suggestion.

I understand what you mean by these last two lines. It was unclear
to me which part of our documentation needs updating and how, and
that was (and still is) what I was primarily interested in finding
out.
