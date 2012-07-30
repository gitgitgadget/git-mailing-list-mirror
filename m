From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cannot delete weirdly named branch
Date: Mon, 30 Jul 2012 10:55:20 -0700
Message-ID: <7vk3xlqgl3.fsf@alter.siamese.dyndns.org>
References: <CAGhmpEFg2ZcwqO=wDNPLfPCnrobq4oOcwvFCm27vrEuiES2XbQ@mail.gmail.com>
 <CAGhmpEGEZchXc4DqZ21BAKxf6_mHRp=TOUH8s=GG0vPscz1kfg@mail.gmail.com>
 <7vsjcil3o5.fsf@alter.siamese.dyndns.org> <5016C2C9.5050904@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "abhisekpan\@gmail.com" <abhisekpan@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 19:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvuBk-0000gg-EE
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 19:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab2G3RzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 13:55:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754457Ab2G3RzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 13:55:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6749B9F06;
	Mon, 30 Jul 2012 13:55:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dh/zku8sNdHbU1bOrhCJv7h0cuw=; b=fvmMff
	6Qb/PwdIB2Kj/R2XZMvuk1CpncHEx3tpWCAyC/8kxda4AbPUC3/EgBoDPgRmiEUJ
	GXlGWgmIFfLgU7nrGNmxxODCZ7KXSVOATijR3YU8yt2McarUMF6ur1r/lq15bOQx
	45EQpbKCg0WyJqNj4E4lMRIQ/LEpxOR1B185c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzKozb0lGOfa/FbPO48NmWRLpQ2grs0c
	GZAnussxcRoIPJ3Lwvdc9bsdCTDqcB9weyG7MVFx1FT80PGIdaT1l8OZ+Ag2BrYs
	0mP3pjG2fwp5fNcL7Mi5xTrHgAY3C+MywKUJmkKJP9kt5QkYRpFSLlvp73XmSgc2
	trI6gGch1HY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5544F9F05;
	Mon, 30 Jul 2012 13:55:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C36999F04; Mon, 30 Jul 2012
 13:55:21 -0400 (EDT)
In-Reply-To: <5016C2C9.5050904@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 30 Jul 2012 19:22:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB662964-DA6F-11E1-9EDD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202597>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 07/23/2012 08:42 PM, Junio C Hamano wrote:
>> "abhisekpan@gmail.com" <abhisekpan@gmail.com> writes:
>>
>>> Now I cannot delete this branch. Running:
>>> git branch -d --tracking
>>> gives an error: unknown option `tracking'
>>
>> I do not think this is supposed to work, but it does by accident.
>>
>>      $ git branch -d -- --tracking
>>      Deleted branch --tracking (was 8670e20).
>
> The plumbing command "git update-ref -d refs/heads/--tracking" can
> also be used to delete such a branch.

Note that once you started using the plumbing you are assumed to
know what you are doing.  "update-ref -d" does not offer the "you
will be losing these commits" safety, and it will not remove
configuration items for "branch.--tracking.*" keys.  You would want
to remove them yourself if you want to emulate "git branch -d".
