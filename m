From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] status: do not depend on flaky reflog messages
Date: Fri, 14 Jun 2013 06:52:22 -0700
Message-ID: <7vppvosstl.fsf@alter.siamese.dyndns.org>
References: <1371130349-30651-1-git-send-email-artagnon@gmail.com>
	<1371130349-30651-6-git-send-email-artagnon@gmail.com>
	<7vvc5hubox.fsf@alter.siamese.dyndns.org>
	<CALkWK0kjxKFkrLArL1mLZYCMN1=sgnDSa3vaoJm6eSUp2E4Pyw@mail.gmail.com>
	<7vd2rpu3kf.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:52:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUQj-0002Bg-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab3FNNw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:52:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753116Ab3FNNwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:52:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 456A22564B;
	Fri, 14 Jun 2013 13:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a0FQ01t96/Gcujzy3VkyiIeV/3I=; b=cOVGrq
	hKlw7HXpEgaII/1f9Y6+ESRq823A1xU42sXTo2QqhDYYX5G8SiRqvkGJNcEkrk8Y
	iIiEtuu/H963IQEbnscoDrui2ym0UuG4cmn0v0N0S0UPaXGYsdbSQX1AkwsZZY/g
	v3QOd3h4RNly1EqGT44FsB/hp+K+ZaoR/g9V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NpXgypQinX3V3aLMHqPZcPABR/2+zi+c
	/b/A8WS5isD39W3sNHTUSz4qdq7Iu0PDq5skVUAygY/VUpeBtr9CkFTQtwLBcOJV
	b+KbqnVv3wcMo8TBOwjOs8+T67gTmYlqDUVcpoRtp7SqK/Q+sxs39AqvM8A/HZ1K
	qexIfHb4BeY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDED2564A;
	Fri, 14 Jun 2013 13:52:24 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EAC125647;
	Fri, 14 Jun 2013 13:52:23 +0000 (UTC)
In-Reply-To: <CALkWK0=NAiGDVWbwHXMmEffPF9wKXd23BdwOntfdvNCpVe8fiA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 14 Jun 2013 11:57:14 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3EB11D4-D4F9-11E2-BEA4-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227856>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>>> What is wrong with git describe?  Is this cheaper, or am I missing something?
>>
>> I think what you are missing is that the "detached from" is not
>> about your current HEAD after you flipped it around with many resets
>> and commits.  It is about what tag or what specific commit you
>> detached your HEAD at originally.
>
> No, it is about what tag of specific commit you detached your HEAD
> from, *without using checkout*.  If you used checkout, you'd get the
> "detached at" message, and I haven't changed that.

The part you stripped from your quote looked like this:

>> You were at 1.8.2 but no longer are, so in the following sequence:
>>
>>     $ git checkout v1.8.2
>>     $ git status
>>     $ git reset --hard HEAD^
>>     $ git status
>>
>> the former would say "detached at v1.8.2" while the latter should
>> *not*, because we are no longer at v1.8.2.  "detached from v1.8.2"
>> is too subtle a way to express the state, and is confusing, but I
>> would not be surprised if people find it useful to be able to learn
>> "v1.8.2" even after you strayed away.

And your justification to make the latter "git status" to say "Not
on any branch" instead of "detached from" was "what is wrong with
describe".

The user used "checkout" to detach the HEAD, and the user stayed in
that detached state and jumped around.  Where is this "without using
checkout" coming from?
