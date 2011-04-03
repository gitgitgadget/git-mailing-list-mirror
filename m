From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Background processes in post-receive hook
Date: Sat, 02 Apr 2011 17:35:23 -0700
Message-ID: <7v8vvsgoj8.fsf@alter.siamese.dyndns.org>
References: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 02:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6BIF-0007F5-G0
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 02:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757541Ab1DCAff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2011 20:35:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54610 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757523Ab1DCAfe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2011 20:35:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A12D14D23;
	Sat,  2 Apr 2011 20:37:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fMAsX+LwYEz6MAasvzeD3qmPhdM=; b=plqh3n
	0J6YNyC1pbImxJtdF0f6yOxU5kt/jizjJT2oBUIoQ3dt3MrgNSvctQHaiA9jFHzH
	uYMi6DSNYZLlBFX2N7Q5Dwl66LzCtaJn6nNFgtgmcTWRDzgV+99GF9ZIAt87u0Nm
	RnTMMQqPmaBBD/xwHgKMDGZ7XzIw5L0sn4Nr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Foz7etT3VBqu+yRNe4xpjuVOFHy7m6/N
	pSzskulJ7iR+hxs85xRGJop6s2TrJdGV9W6cQt2oWShEcWG+YKdm+eyym09oMj02
	ypwb6UTi07Afm2KGZXyVygNBAc20GMZFYjs0goKpEM6hoFfKKFZsbOP8+f0RwOrU
	ZAhJ1EOStrA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F4274D21;
	Sat,  2 Apr 2011 20:37:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 98F644D1E; Sat,  2 Apr 2011
 20:37:17 -0400 (EDT)
In-Reply-To: <AANLkTinrEt6DkwhknpDZ0iV9PR+7bBd3DAaPRJOgNFTG@mail.gmail.com>
 (James Pickens's message of "Sat, 2 Apr 2011 16:03:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E019A4-5D8A-11E0-A438-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170669>

James Pickens <jepicken@gmail.com> writes:

> I have a post-receive hook (bash script) that launches several background
> processes and exits immediately.  I do that so I don't have to wait for the
> background processes to finish every time I push to the repository, but Git
> seems to wait for them to finish anyways, even though the post-receive hook
> itself already exited.  Is there any way to stop Git from waiting and let the
> push finish immediately?

An easy way to do that is to run whatever lengthy process you do not want
to wait for using

	echo "that command" | at now

in the hook ;-).
