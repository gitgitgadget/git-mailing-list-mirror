From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation update for 'git branch --list'
Date: Tue, 22 Nov 2011 10:04:21 -0800
Message-ID: <7vobw4doey.fsf@alter.siamese.dyndns.org>
References: <1321886000-4163-1-git-send-email-vfr@lyx.org>
 <7v7h2tgyw6.fsf@alter.siamese.dyndns.org> <4ECB43E4.7030607@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 19:04:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSuhs-0001mB-2b
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 19:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab1KVSE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Nov 2011 13:04:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34328 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752749Ab1KVSE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2011 13:04:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F5F94FB3;
	Tue, 22 Nov 2011 13:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KK3ivkImF3iq1s1Vd8YtUbPkKNw=; b=O5AdIF
	B2XHFv7jKpLvdV3npiZwFK5BQmeLpJXISvDBi3O2zZWaH4Yx9i8P6pSll/n/FIcU
	tGfVc8uksGYNo8sVCq8dCLIhDBIz5mOfnNxiPXdLTj6aX5RZUIwhBqN4bcTs3A3z
	MMBOHuwk3d9yDy0wBJ0yacL10XNcrseemNHLI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d2tIBRjTxunWN6arSvHqM9JElgfe9jLc
	T+nvWOTrQcwvLaYYmPL0SCA8Srogu5Dm4QcPAlF+/4ZcI6I7BDpmlHb3yWyaW3ZQ
	zglKyZ7fN1g26g+SH5fdrQ8QHaywamm/wp/44PPjDk1UqlgTnzPAh8rLV7EMBNXc
	AOaom8a3ocg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06D484FB2;
	Tue, 22 Nov 2011 13:04:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 049004FA9; Tue, 22 Nov 2011
 13:04:22 -0500 (EST)
In-Reply-To: <4ECB43E4.7030607@lyx.org> (Vincent van Ravesteijn's message of
 "Tue, 22 Nov 2011 07:40:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 684EC3C2-1534-11E1-93DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185804>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Op 21-11-2011 18:37, Junio C Hamano schreef:
> ...
>> It is natural to expect "git branch --merged pu vr/\*" to list branches
>> that are contained in 'pu' whose names match the given pattern, but it
>> seems to try creating a branch called "vr/*" and fails, for example.
>
> If this is what you naturally would expect, I would expect the
> following "git branch vr/*" to work as well.
> What would you say if we try to interpret the argument as a pattern
> when the argument is not a valid ref name?

We don't, as that is inviting mistakes. "git branch vr/*" if you have a
vr/ directory in your working tree may create vr/a branch from where the
tip of vr/b points at by mistake.

The "--merged" option is an explicit clue that the user is not interested
in creating new branch, and the string being a pattern is additional clue.
The "--list" option was recently added for the explicit purpose of giving
such a clue as safety measure.
