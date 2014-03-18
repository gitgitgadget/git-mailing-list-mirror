From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC14][RFC] Is there any interest in adding a port of checkpatch.pl to contrib/?
Date: Tue, 18 Mar 2014 12:39:42 -0700
Message-ID: <xmqqa9cn8fep.fsf@gitster.dls.corp.google.com>
References: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
	<CAPig+cQPZrHf_Bm_s_qmP6nX2dKcFNi+EUKoPObXHn1novuaHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 20:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPzrc-0003Cx-TK
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 20:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757645AbaCRTjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 15:39:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757515AbaCRTjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 15:39:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3348972747;
	Tue, 18 Mar 2014 15:39:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6tuD7OBiyWpINH7xf8pGkAXRyJY=; b=w1MtGV
	nTmzmyvPiEEXlnqLvjzHpoHZg1rE60JbsNF7cOXOFmTBx2DeRWODs/zzn1U0D8a+
	QZxHZlR5FUJpwNjbcSVPYGyxZ5dU8gPFE7odfbHMmOEYifqOON3s4ThIFqELNOMW
	D9fzxsECu1m00KFI/1cVWQXwJIhpS/cmOm47s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lG9UEQpm1YqYi4HHyk4qVeg0nWQmDxsG
	eqXLR2oMIpUHzNBMqOPH5ctszCBLhJbiXwi/y3PWu9dOFu26wAWF9JVtmUWSQqZx
	Y7fJWyICgS3rjC3YOcqCqcpoD6UZO9t4ywf6ksrE3YeZa5YnxpeDWcR92hYVMNFw
	EyJWTRTSURM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0C872746;
	Tue, 18 Mar 2014 15:39:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30DCC72744;
	Tue, 18 Mar 2014 15:39:45 -0400 (EDT)
In-Reply-To: <CAPig+cQPZrHf_Bm_s_qmP6nX2dKcFNi+EUKoPObXHn1novuaHw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 18 Mar 2014 00:40:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0EE0278A-AED5-11E3-A36A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244373>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> 1. Git style guidelines are somewhat different and less strict than
>> their Linux equivalents.
>
> Are checkpatch.pl's customization options, such as --ignore,
> insufficient to make it behave in the desired fashion for git?

If we are to officially encourage the use of checkpatch.pl, we
should stress that mechanically adhering to its check is *not* the
goal.  As long as people view it as a tool to _help_ them spot
obvious problems before sending their patches out, but the final
responsibility to produce readable code is upon themselves, not the
script, I am personally fine.  Oftentimes we find an occasional long
line that is slightly longer than 80-column limit a lot easier to
read than chopping it artificially in the middle, for example.

>> 2. Several patch threads bounce back and forth because of style fixes.
>> A checkpatch script added as a hook could help reduce these and use
>> more efficiently our time.
>> 3. As far as I can tell, checkpatch needs to be run from the root
>> folder of a linux repository clone. Cloning several hundred MBs for a
>> single perl script looks a little foolish to me.
>
> No need to clone the kernel. checkpatch.pl runs fine standalone with
> the --no-tree option.
>
>> So, is there any interest in adding a port of checkpatch.pl to
>> contrib/?

Not really.  Maintaining the forked version is an additional pain we
do not necessarily need.  Are we going to carry a port of gcc and
others?

I would rather prefer to add a paragraph in CodingGuidelines that
points at the canonical location to obtain the script, e.g.

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl

and a procedure to run the script over their patch.  I am too lazy
to check myself, but there must be somewhere we mention the use of
format-patch and send-email in the document, and use of the script
to check would fall naturally between these two steps, I would
think.
