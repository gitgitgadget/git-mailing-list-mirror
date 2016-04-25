From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Mon, 25 Apr 2016 11:29:46 -0700
Message-ID: <xmqqmvohlexx.fsf@gitster.mtv.corp.google.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
	<1461529229-15222-2-git-send-email-avarab@gmail.com>
	<CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 20:29:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aulGe-00053L-5h
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 20:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933337AbcDYS3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 14:29:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933040AbcDYS3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 14:29:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 721B515464;
	Mon, 25 Apr 2016 14:29:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FjZ1l/eG4YWFyNDTW388d2rn1Ms=; b=s/svMx
	o1/p64+SIqPECEccxpFFADOn9RYHnhZR3cqq1Zh0PQLmdfe6DpjkS2TKtdiK+MJO
	1As9eP9kHb3ju4a21reKXBqoAG3IjTfnejZBtzQPdIHVzgeBcv9eH/qyXSiaIFRl
	0+0AeUAHtQu0EjlG3Vn33tCIGD61UtTjvQQN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mh9GIbwK0aUdE3sR7lKECn1e2OUO1lIH
	PHZErRTy47gnS9ojE+BtQOhKSsJu4swqHpkl9gn6QJ0KG2D5demi/UdYnTV31e7j
	L5SQzTBWrPdcQfuEywoJlbenfn19fAuUdwGjy2i8xicJ/Yl39pd2+dXAXqkKGE60
	Y+cSXjlb7Ck=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6956C15463;
	Mon, 25 Apr 2016 14:29:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB84115461;
	Mon, 25 Apr 2016 14:29:47 -0400 (EDT)
In-Reply-To: <CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
	(Jacob Keller's message of "Sun, 24 Apr 2016 13:32:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B0B839C0-0B13-11E6-9D96-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292538>

Jacob Keller <jacob.keller@gmail.com> writes:

>> -Another use suggested on the mailing list is to use this hook to
>> -implement access control which is finer grained than the one
>> -based on filesystem group.
>> +Another use for this hook to implement access control which is finer
>> +grained than the one based on filesystem group. Note that if the user
>> +pushing has a normal login shell on the machine receiving the push
>> +implementing access control like this can be trivially bypassed by
>> +just using not executing the hook. In those cases consider using
>
> "by just using not executing the hook."
>
> This grammar doesn't make sense. It doesn't quite match what you said
> in the commit message either.
>
>> +e.g. linkgit:git-shell[1] as the login shell to restrict the user's
>> +access.

While there is nothing technically wrong in what it says, I wonder
if it is worth to state the obvious.  If one can bypass update hook,
one can bypass any other hook, so the information does not even
belong here.

Instead of saying "acl can be implemented on top of update hook, but
not quite because you can bypass it", it may be more useful to say
"in an environment that restricts the users' access only to git
commands over the wire, this hook can be used to access control
without relying on filesystem ownership and group membership",
perhaps?
