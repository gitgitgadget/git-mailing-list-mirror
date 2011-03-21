From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git rm" is not a valid merge resolution?
Date: Mon, 21 Mar 2011 12:32:08 -0700
Message-ID: <7vvczcp8w7.fsf@alter.siamese.dyndns.org>
References: <4D879882.4070608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:32:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1kpx-0008Ly-CV
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab1CUTcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:32:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541Ab1CUTcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:32:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B56C40E8;
	Mon, 21 Mar 2011 15:33:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V3ine9lKUeHC53u75J6SLIWtL1o=; b=oaVyt3
	Cddl3wrd/VV3riJnwQma7dk5x6OYQrA/Tfzw9au0M/eVLb8iJtBW9FnUGNT2bEta
	h3Jpd3QvAhoqcCuMA9LvHUdi2t15B2CrdCdm99P//yXivKEi459xGnM9HfJ7UX5v
	KBu2mHc+oLEafW8Ky2T2TjJKb79RJjTuHARLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i7j1+6C2UPRSYqr+a8LBD/vBRNAwUFRd
	PnEfBWph3SwG47irkQGIGmcQoNaXEQkfLdZknFOQGPkyn6PFvx4PvUk68y207Jaa
	oy0lOtf0EgFFeZShRe7B0oEJNVMQ4yvzXfR62k/KvoQqydzpFddb4MKMJyinxi+e
	hZowFjU/H6E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 18E3940E7;
	Mon, 21 Mar 2011 15:33:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3890E40E3; Mon, 21 Mar 2011
 15:33:48 -0400 (EDT)
In-Reply-To: <4D879882.4070608@gmail.com> (Piotr Krukowiecki's message of
 "Mon, 21 Mar 2011 19:27:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26DB982E-53F2-11E0-8557-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169646>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> git-status shows a hint that says
>     use "git add/rm <file>..." as appropriate to mark resolution
>  
> But if I "git rm file" the file gets deleted. Is this really the 
> appropriate merge resolution?
>
> I would expect "git rm" to maybe reset all the merge changes but
> it seems to just delete the file.

Yes, if your side has a commit that updates a path since branches forked
(e.g. fixing a minor bug in an implementation of a function defined
there), and the other branch you are merging removed the path (e.g. fixing
a higher level callers and made that buggy function no longer necessary),
taking their removal can be a valid conflict resolution.
