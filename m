From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 11:04:06 -0700
Message-ID: <7vk3my6bu1.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<7v61yi9arl.fsf@alter.siamese.dyndns.org>
	<CAMP44s14TSGtQ7kvWUgrOQvT1uKciSV5fd5pQvy1ven8Z=qVcg@mail.gmail.com>
	<7v8v3e7udi.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 20:04:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud2XH-00027x-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 20:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab3EPSEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 14:04:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118Ab3EPSEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 14:04:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D6D51F5BB;
	Thu, 16 May 2013 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D81T57muN4biI8M+UEwDQDkBzZ8=; b=cLpbI2
	ertBPdIIo6z+o/xtIQo1tO3UPpa4mv18JcMIAH2CMLC8xWCi+yVMwpkIjv4rkJBO
	pyhNJFbjYhuGiEqgC6qqFJDSReE7Lz4KCBgjt+tXekXucXvL54j65HuzeLH8TY+i
	t063RWLR2ORQUYF/1+N/AZDUHKITvwfPCf+I0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=msz5Cjdv8ZWmKd+UgtXUxmvNr5ya2muH
	qY7vjaxhZEhTD9xoSA6H/doRRcEfzGfCnrDgo/BfcC83MwrhpaMU+DXM9HbMSqcF
	rLniXDKwhZ+rg5o/5rPrQwGViV8qeUB5Lfi8R3r8P7wV13mfkXani+3XKEvxbkep
	WsPUCshf36I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 117101F5BA;
	Thu, 16 May 2013 18:04:09 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E8F61F5B8;
	Thu, 16 May 2013 18:04:08 +0000 (UTC)
In-Reply-To: <CAMP44s0Szu8oHBKMapZ6dQ1K67MXDcACuUF-+Y-jC+EgHs2QEA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 11:52:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01065B70-BE53-11E2-A25D-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224605>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> If you come from "git pull" is "git fetch" + "git merge",
>> and if your current branch is integrating with your local branch,
>
> How many times do I have to say that 'git pull' is not 'git fetch' +
> 'git merge'?
>
> You must think everybody has 'merge.defaulttoupstream=true'.

I am confused.  What does that have anything to do with this topic?
It only affects what a lazy "git merge" (without any other parameter
on the command line) does, doesn't it?

In the above "git fetch" + "git merge", I did not mean "git merge"
is literally what the command line of the command invoked
internally.  "git pull" of course chooses what is to be merged.

But that does not change the fact that before merging (or rebasing,
if you are running "git pull --rebase"), "git fetch" is done in
order to make sure the history you are merging with (or rebasing on
top of) is available locally and FETCH_HEAD is prepared so that "git
pull" can decide what to merge with (or rebase on).  

The merge.defaultToUpstream configuration does not change that, does
it?
