From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Syncing Git Repositories
Date: Thu, 17 Jul 2014 09:35:24 -0700
Message-ID: <xmqq61iwq6yb.fsf@gitster.dls.corp.google.com>
References: <53C7343F.4090806@parikh.io> <vpqwqbcv5m0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sajan Parikh <sajan@parikh.io>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 17 18:35:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7oeg-0001KI-0h
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 18:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934672AbaGQQfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 12:35:34 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57591 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934444AbaGQQfd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 12:35:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E73C72891C;
	Thu, 17 Jul 2014 12:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xn2hwqOLi1KlcFVOBd6WiYeQUQw=; b=wi5gOV
	zzZNq4rFppTpXT36lODxvmBuI36f5GRkFTamMB6uBPNaPG5Y8xvvGBNcug9SdHwv
	xotr6qQCaZ57UQmNvSk+lZoN2l6VNmN0nA+x0RAvI3sJBog5DrB5Lp/rAA2x7Kak
	will2A5zbF2UVMTK1/ZMedKvtcEbrSBQBfvoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QcK+eeocsFzDeYKEz7rinIbgEobrmjPM
	W31FqRagcFQKFyybZ8jznEc5XS4rryi6Sk6yejR4gRChp+KFIOvO2NztBITEcYtm
	xAN9yTXanJJE9FpuVpT6Wwz/AoaNISo4a9xL+Tu4tWmf9EMXUkEWtfFhGDU7f6jN
	kkBJ5lK9AJk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC4712891A;
	Thu, 17 Jul 2014 12:35:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1432028913;
	Thu, 17 Jul 2014 12:35:26 -0400 (EDT)
In-Reply-To: <vpqwqbcv5m0.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	17 Jul 2014 08:53:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B1CD12A-0DD0-11E4-B12D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253759>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Sajan Parikh <sajan@parikh.io> writes:
>
>> By syncing my code folder and git repositories in this way, do I risk
>> borking any repositories?  I'm 99% confident I'm not, since everything
>> is in .git/, and there are not external databases or log files that
>> need to be updated.  Just making sure though.
>
> You're right that there are no external database, hence if you actually
> sync the whole worktree+.git/, you won't have any problem.
>
> I synchonize a bunch of Git repositories between machines with Unison
> (file transfer utility), it works great.
>
> One issue you may encounter is if you have either partial
> synchronization (e.g. network loss in the middle of a synchronization, I
> don't know how owncloud deals with it), or two way synchronization
> (there's a synchronization between your laptop and owncloud ongoing, and
> you start working on your desktop and trigger a synchronization.
>
> I sometimes encounter this situation with unison. The good news is that
> in 99,999% of cases where I'd encounter a problem, Unison shows a
> conflict on the index file (modified on both sides). So, in these cases,
> I just use Git normally to synchronize, decide that one side becomes the
> reference, and rsync to the other to resolve the Unison conflict.
>
> Also, you have to ensure that you synchronize both file
> additions/modifications, and file deletions. I often make the mistake of
> using rsync without --delete, and it confuses the branch storage format
> (I keep my local unpacked branch, and the packed branch is hidden by
> it).

All correct but .git/index may need to be refreshed, as your
cloudSync is unlikely to sync stat details across filesystems,
especially inum and possibly uid.
