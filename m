From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] merge hook tests: use 'test_must_fail' instead of '!'
Date: Thu, 06 Mar 2014 16:35:47 -0800
Message-ID: <xmqqk3c6vo9o.fsf@gitster.dls.corp.google.com>
References: <1394117424-29780-1-git-send-email-benoit.pierre@gmail.com>
	<1394117424-29780-7-git-send-email-benoit.pierre@gmail.com>
	<xmqqiorrvwvh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 01:35:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLilZ-0005DL-I1
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 01:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbaCGAfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 19:35:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbaCGAfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 19:35:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01D86727A0;
	Thu,  6 Mar 2014 19:35:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KqZRHa54NFbT1rY4svSBdKLzaz8=; b=b+Quvy
	LFlafyLkUJaYYgeLWZP4kJ2REFfGDWABMH8zJXPk+aWrbVqV4aZ7byQpMUK2oPPX
	wHYhq3NeVh2kmE1se6A0zWZS5fZhhQEIU17DXp9oH+/X1wPxrMjAMGiumkn7HK4/
	nX8KCMUef2O+0BHj9tKW55JOv5Z/H90cTRDzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erVDIWsKCYT+QZb79ldV1fIaRAnPbSIW
	H08sTfDkzlRNUacvk/VEuRFVP06iexsBJW1LwGyGPnBohaVgWRsZGa376jRTTCUS
	1JAuipxSMFzg7ipatSXFz0KTqUZwy0SXRnTK/k6GOWG2btKHCwGGARs0BvOFR6mO
	aQAwUT/zZd4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EAD67279D;
	Thu,  6 Mar 2014 19:35:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 847767279B;
	Thu,  6 Mar 2014 19:35:49 -0500 (EST)
In-Reply-To: <xmqqiorrvwvh.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 06 Mar 2014 13:29:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E4B4BA8-A590-11E3-841C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243578>

Junio C Hamano <gitster@pobox.com> writes:

> Benoit Pierre <benoit.pierre@gmail.com> writes:
>
>> Signed-off-by: Benoit Pierre <benoit.pierre@gmail.com>
>> ---
>>  t/t7505-prepare-commit-msg-hook.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
>> index 604c06e..1be6cec 100755
>> --- a/t/t7505-prepare-commit-msg-hook.sh
>> +++ b/t/t7505-prepare-commit-msg-hook.sh
>> @@ -167,7 +167,7 @@ test_expect_success 'with failing hook' '
>>  	head=`git rev-parse HEAD` &&
>>  	echo "more" >> file &&
>>  	git add file &&
>> -	! GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
>> +	test_must_fail env GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit -c $head
>
> Thanks. It is good that you avoided the common pitfall of attempting
>
> 	GIT_EDITOR=... test_must_fail git commit -c $head    ;# WRONG
>
> but do we assume everybody has "env"?

It turns out that the answer to this question seems to be "yes, we
already do."; so the patch is probably OK as-is.

Thanks.

> To be portable, we can do this instead.
>
> 	(
> 		GIT_EDITOR=... &&
>         	export GIT_EDITOR &&
>                 test_must_fail git commit -c $head
> 	)
