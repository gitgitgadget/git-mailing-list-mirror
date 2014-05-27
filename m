From: Junio C Hamano <gitster@pobox.com>
Subject: Re: commit: support commit.verbose and --no-verbose
Date: Tue, 27 May 2014 11:10:52 -0700
Message-ID: <xmqq4n0bgkib.fsf@gitster.dls.corp.google.com>
References: <20140523212222.GA10412@sirius.local>
	<20140524075219.GA17093@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Caleb Thompson <cjaysson@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:11:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpLq2-00034P-Lt
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbaE0SK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2014 14:10:59 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63676 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751652AbaE0SK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2014 14:10:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6C3119CC6;
	Tue, 27 May 2014 14:10:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c5brs4DTIMjuYcXV7QRAWnDGodA=; b=o0Rg8N
	laHESD0nDGfKI/eRZbysstZ+y4xZgxXUkd/EKn+2T9ID2lrh+SLG8OrutFxPEl4t
	Zsa4/2Slfm5NX42Z7but+iDxN7Qgit9kjCC+uCmOQ+mabPHUvdqPt9WQRiOCXNSA
	ntrXyDn8uvMtZqeuqv0ClxJvprGX4Xirac1cE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LLPpho4rGi77AewUxdXC3cRQ8vC2Oz9q
	cCi7mBQR3uF6u6OeSjsNcjdR3ooESdaCl++ekSvLYInGBB52+rnbjEvnLTFFwNX9
	4VocdYaOaFcldSG7Y6ythZTo5y/3bZ3xTjiBZL+DNtGmHxNZ6jt3KtHGTotOW2Kl
	qR99NS0zQJk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCBBB19CC5;
	Tue, 27 May 2014 14:10:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7044D19CC1;
	Tue, 27 May 2014 14:10:54 -0400 (EDT)
In-Reply-To: <20140524075219.GA17093@hudson.localdomain> (Jeremiah Mahler's
	message of "Sat, 24 May 2014 00:52:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E6D7940-E5CA-11E3-98CB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250180>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> On Fri, May 23, 2014 at 04:22:22PM -0500, Caleb Thompson wrote:
>> This patch allows people to set `commit.verbose` to implicitly send `--verbose`
> ...
>>  
>> +cat >check-for-no-diff <<EOF
>> +#!$SHELL_PATH
>> +exec grep -v '^diff --git' "\$1"
>> +EOF
>> +chmod +x check-for-no-diff
>> +
>
> For new tests, commands like this should be placed inside a
> test_expect_success structure.  However, I can see why you did it this
> way since the code just above it does it this way.
> Perhaps others will have some recommendations.
>
> Also, <<\-EOF is used instead of <<EOF to remove the tabs.
>
> test_expect_success 'commit verbose setup' '
> 	cat >check-for-no-diff <<\-EOF &&
> 	#!SHELL_PATH
> 	exec grep -v '^diff --git' "\$1"
> 	EOF
> 	chmod +x check-for-no-diff
> '

Also tests use write_script these days to do this kind of thing.
