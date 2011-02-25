From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: error out for missing commit message template
Date: Fri, 25 Feb 2011 12:14:13 -0800
Message-ID: <7v1v2van3e.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-28-git-send-email-avarab@gmail.com>
 <20110225090756.GI23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt43j-0002E1-Aj
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852Ab1BYUOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 15:14:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932825Ab1BYUO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 15:14:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 767064F40;
	Fri, 25 Feb 2011 15:15:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TeOCr8EprYB6dJJxKgITOT0Hw1Y=; b=COggX/
	zeY2AuwKNp0/UsjFEkGB1h2JXg79Rz2/vvYndUt+fVYWyWs+YfMGGc0J8YyQY8rt
	x0nIdCmDqL2oOFGAzVepfTd908QsAxVSsgAbNQfDEEv4UKI94zgBX3cfhJt53DzW
	WTL2FBO09WXk8Lg/Sl6MTQoJjIuiqstybKcDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZZoIPLq5/4IjYngfMkvOySzh3hRF/W7U
	ekumrfa7ZP23xaFS2fNMGi6xn5sz1BTZa6tV0NOZHdobIgPUszsz1bH6/pVuIaxU
	ewjhQwUHiF00I0saVUbhzMmyVHkuLfyIXzZ8JY4FvVrlRAyHBYwbai1LqE5sqNkB
	NGkxH/UEL8Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2CA984F3E;
	Fri, 25 Feb 2011 15:15:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FE644F3C; Fri, 25 Feb 2011
 15:15:30 -0500 (EST)
In-Reply-To: <20110225090756.GI23037@elie> (Jonathan Nieder's message of
 "Fri\, 25 Feb 2011 03\:07\:57 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02B46842-411C-11E0-8C03-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167935>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -725,15 +725,15 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
> [...]
>> -				"%s"
>> -				"# Author:    %s\n",
>> +				_("%s"
>> +				"# Author:    %s\n"),
>
> The above change causes the commit message template to be nonempty,
> excluding comments, so bare "git commit" succeeds, exposing this
> longstanding bug.

Thanks; using "#" at the beginning of poison message sometimes has its
uses ;-)

Will queue.
