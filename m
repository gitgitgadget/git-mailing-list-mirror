From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] init-db: remove unused #includes
Date: Wed, 14 Jan 2015 12:14:09 -0800
Message-ID: <xmqqwq4p86i6.fsf@gitster.dls.corp.google.com>
References: <1421258367-8483-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq61c99o25.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 21:14:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBUKY-0003Na-1T
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 21:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbbANUOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 15:14:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750968AbbANUOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 15:14:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D10B2C4F3;
	Wed, 14 Jan 2015 15:14:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AKdXeJpNL+sS83ZspK7gYqWxBzk=; b=GsSU81
	knAmepETNKG0bcXsk/CcNs+4meq6e/Wgi1iBnR12uniYVmewIoGQ56LFXPNt0c8P
	ipht6JgEfFWfSkSzdEGjuFD9BJT0eg36o8gjJO0Tt0+qiGKYUlsS1mQMcHwv6oPs
	o+pVK8YTogXDsO/TnevmOfj2eij37pGszWQXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lNtivcHgznSOuRpF04AeackncpBHfO6P
	SCd5edS/NBdjbm097qeL9vXQz9uIPetOdJ8LDQrI/qSZZXZqtH6oYWSfK/riIRJx
	h4Umm03SKG9Af9uY6VvsI2gTP8rsSXqA3Q/QDI7y39csCxW1BgT9uGn0Bx3j2M1L
	yG1mRApudlM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 23BD92C4F2;
	Wed, 14 Jan 2015 15:14:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E57D2C4F1;
	Wed, 14 Jan 2015 15:14:10 -0500 (EST)
In-Reply-To: <xmqq61c99o25.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 14 Jan 2015 11:09:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E6BB2046-9C29-11E4-8785-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262419>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander Kuleshov <kuleshovmail@gmail.com> writes:
>
>> * "cache.h" - is unnecessary because it already included at "builtin.h"
>>
>> * "exec_cmd.h" - was added at a47d1813 (Allow a relative builtin template
>> directory., 15 Nov 2007). init-db used 'git_exec_path' routine from
>> "exec_cmd.h", but later it was removed at 2de9de5e (Move code interpreting
>> path relative to exec-dir to new function system_path()., 14 Jul 2008). So
>> we no need in it anymore.
>>
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>
> Makes sense. Thanks.

Actually, not.  2de9de5e does make it unnecessary to refer to
git_exec_path(), but in order to reference the newly introduced
system_path(), which is declared in exec_cmd.h, the file still would
have needed to include the header, so the justification for the
latter does not make sense.

And indeed, we still need exec_cmd.h in today's code.
