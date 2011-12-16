From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adding hooks.directory config option; wiring into
 run_hook
Date: Fri, 16 Dec 2011 11:23:28 -0800
Message-ID: <7viplgiamn.fsf@alter.siamese.dyndns.org>
References: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
 <7vmxasie6k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Dale <chrelad@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:23:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbdNe-0002Ej-MQ
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760591Ab1LPTXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:23:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54638 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760589Ab1LPTXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:23:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9AA741C;
	Fri, 16 Dec 2011 14:23:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEeaXvxI8DvEEggW6ibbCoV0EUU=; b=u/Lcnb
	e5BJZyJ6j9NIEPE5JRmiq7FenVXQA9YorHyqjTrLhlEywTAz0F4mDwrdRloWAPWd
	YRV7kB1zZkEGU4P9HRq10/aNwVJiyJXi+5h4dLHURszTBwDRXfkT5/HZzNaaO7mv
	YcCEDCmdX9MBWZLjDp/fH1rM4P97Exd7x9qXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b3K/UziNFoEYlACLLr6KFnRXTJ7hXymQ
	Oe4CFjRI+r0aBjXUNVN7slNilXP/hpqnbNnE6mXdqYfvER93nVWgs1m4pRVbH/3r
	e+v0BlKghXeLSMLzxC/00uAATim4mQ3aaOWK8hem5P6tyWDx68ZZNqpTG2jXBFkf
	mXJZc/hjHQc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9226F741B;
	Fri, 16 Dec 2011 14:23:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B2F741A; Fri, 16 Dec 2011
 14:23:30 -0500 (EST)
In-Reply-To: <7vmxasie6k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 16 Dec 2011 10:06:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6FBD57F0-281B-11E1-8F32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187303>

Junio C Hamano <gitster@pobox.com> writes:

> Christopher Dale <chrelad@gmail.com> writes:
>
>> ...
>> trusted path execution policies. These systems require that any file
>> that can be executed exhibit at least the following characteristics:
>>
>>   * The executable, it's directory, and each directory above it are
>>     not writable.
>> 
>> Since the hooks directory is within a directory that by it's very nature
>> requires write permissions,...
>
> Sorry, but I am not interested at all. If you can write into $GIT_DIR/config
> then you can point at any directory with hooks.directory and that would mean
> it would defeat your "trusted path execution policies".

I was about to follow-up with "the only option that may make sense in such
an environment may be to disable hooks", but after thinking about it more,
if somebody enables hooks, the environment will make sure that they will
fail to execute, and it would be an incentive enough for people to disable
them. IOW, no need to have such an option, even.
