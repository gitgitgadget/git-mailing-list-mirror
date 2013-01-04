From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal for git stash rename
Date: Fri, 04 Jan 2013 13:40:22 -0800
Message-ID: <7vbod4tynt.fsf@alter.siamese.dyndns.org>
References: <20100620093142.GF24805@occam.hewgill.net>
 <AANLkTimjEksHI4nlefqmNzdNiseVyMQcw312g2AHFQDZ@mail.gmail.com>
 <20100620111112.GH24805@occam.hewgill.net>
 <loom.20130104T192132-16@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Micheil Smith <micheil@brandedcode.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 22:40:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrF0S-0000aH-JB
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 22:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab3ADVk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 16:40:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754618Ab3ADVkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 16:40:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91D8BA1E;
	Fri,  4 Jan 2013 16:40:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MGtyeXLvfwA88/igZ4IHqAAemAE=; b=gnA6bJ
	W09A36KNHqCFrMVDEC8fUWKEss3HCxi2p6MR3cFYaIx4crrvMYNHd4NZW8zDnC6M
	10RM8dGV0MkRniecHAd/oUrs0u5/EDn+AOPke7nkpWUG8lm7bSJwxVYtEVsQ/PGJ
	no6eervV8BNCvuMEOOdJ/LokZU1y6k2EEE8HU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qms97AI4pGMuo1V8WMJDHBZ03mpQT0ZN
	CAd65RgnuLj4dgaFZqwyW/3YOl6f1HPBB+08a2mlZUIlVwkf0UljNvixxi2DpXjg
	69M+DKtc395ReplchT/IsFav/X0YJxtRmUSqQQlXkd1/rSFjMCHWLfxcuOPujNjk
	HrZk8gN12R8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C3FDBA1D;
	Fri,  4 Jan 2013 16:40:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A293BA1C; Fri,  4 Jan 2013
 16:40:24 -0500 (EST)
In-Reply-To: <loom.20130104T192132-16@post.gmane.org> (Micheil Smith's
 message of "Fri, 4 Jan 2013 18:25:07 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58AB09C4-56B7-11E2-97A1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212645>

Micheil Smith <micheil@brandedcode.com> writes:

>> This patch implements a "git stash rename" using a new
>> "git reflog update" command that updates the message associated
>> with a reflog entry.
> ...
> I note that this proposal is now two years old. A work in progress patch was 
> requested, however, after one was given this thread ended. I'm also finding 
> a need for this feature;

The whole point of reflog is that it is a mechanism to let users to
go safely back to the previous state, by using a file that is pretty
much append-only.  It feels that a mechanism to "rewrite" one goes
completely against that principle, at least to me.

I have a feeling that "need" in "need for this feature" is a
misspelt "want", that occasional misspelling of the stash message
may give users awkward feelings when viewing "git stash list" output
but not severe enough to make them unable to identify which stash
entry holds which change, and that it is sufficient to pop and then
restash if a user *really* cares.
