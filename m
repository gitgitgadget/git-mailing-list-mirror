From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge/pull: verify GPG signatures of commits being
 merged
Date: Fri, 22 Mar 2013 20:08:53 -0700
Message-ID: <7vvc8i4xtm.fsf@alter.siamese.dyndns.org>
References: <514CD26C.2070702@physik.tu-berlin.de>
 <20130322231430.GK12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian =?utf-8?Q?G=C3=B6tte?= <jaseg@physik.tu-berlin.de>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 04:09:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJEph-00086P-48
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 04:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754942Ab3CWDI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 23:08:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab3CWDI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 23:08:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A9CDA3AA;
	Fri, 22 Mar 2013 23:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6PEhGkcWXCl5oRmPvs3Q0gFz5kc=; b=UsggQl
	crT6KssebTkUzRFeipY+3GQrIxHUigVPcVRZNPr5sWWnmk9BcLPxW6aV/QwIpc1W
	k1KWWHsHlns+gSQys0iRFF4fCxFVZLfTIinb0Exq+lA+6eNVUaOmTkkCc7+/Wh8m
	SZOPzD4ZsY7JZTNcoB4Mab8lx8vVOB5rKnak4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgVVnsfZGBlyJ0cebaHL10PFlOv61uOO
	VyEPzvwL3dStMigvHkrkIuMRDMIvSeAOZjR7PLtSUgcqHRXIcTX+M6fbzCO+MVRL
	mQV/FFp9/nUFDyvUVD1hWNN7Awhu7nyem0uSFASe5gMOJjmGePOOF/KJ0AbVJb9X
	9vXZk+wo0HY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D807A3A8;
	Fri, 22 Mar 2013 23:08:55 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5CE4A3A6; Fri, 22 Mar 2013
 23:08:54 -0400 (EDT)
In-Reply-To: <20130322231430.GK12223@google.com> (Jonathan Nieder's message
 of "Fri, 22 Mar 2013 16:14:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FEE4972E-9366-11E2-8E60-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218878>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> git merge/pull:
>> When --verify-signatures is specified on the command-line of git-merge
>> or git-pull, check whether the commits being merged have good gpg
>> signatures and abort the merge in case they do not. This allows e.g.
>> auto-deployment from untrusted repo hosts.
>
> This leaves me pretty nervous.  Is there an argument to pass in to
> specify a keyring with public keys to trust?  Without that, it is
> presumably using ~/.gnupg/trustdb.gpg, which is about trust of
> identity rather than trust to provide code to run on my machine. :(

I think people who create a real merge via "git pull" and use that
as "auto-deployment" mechanism is insane, but presumably that "auto"
tells us some other things, like it will be done by non-human account,
its $HOME/.gnupg would contain only the keyring that is for the auto
deployer, or the cronscript that runs "git pull" can set GNUPGHOME
and export it before doing so.

So, I wouldn't be worried about it too much.
