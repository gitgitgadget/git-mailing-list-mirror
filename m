From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] clone: regression in error messages in master
Date: Fri, 21 Jun 2013 10:11:39 -0700
Message-ID: <7vli63mlro.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n7S8s-ABQ1qV5JSsyhYo6=rmK1UT+uYW9hjjeWjambug@mail.gmail.com>
	<CAEBDL5UNNHnogHb2ztq2G8OxyCNMoLia7xYFNSy+kfHD3pS1pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: John Szakmeister <john@szakmeister.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 19:11:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4sF-0004zZ-05
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 19:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423478Ab3FURLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 13:11:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35947 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423404Ab3FURLm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 13:11:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBD362A080;
	Fri, 21 Jun 2013 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WylG7Dmo27APwrZNehmT+1Lw2fY=; b=hHv14S
	2p4cX4e62uLoziNuHUJAo0E5bbf7SZeLgnAuNiXmdEatRwXI9/CcQ9JM/dILRDrh
	3mLQjwQKX+r16+kKAJzBqzfHRXaE3EiZQ+wWbVRCnDMnDRXmHBeOg/+MHREOQkzX
	RTyhU5U1OpGBnfT6x3dq+a3HTvbD0EWBKX6UU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x/KKL0EtZa3dFXOi5dtKvV2GDCM3nHEe
	wvnuUix6MnzJwibkI4vPZYLwuLUTj7SIwvZ8zgKc3hHe7YcBz4dZs/C0CPjxymdi
	4Trz6EVv4H599P4TAWmYvofFrIJf7GkWhdFUE3CgJmcHrGBOS7dpQRRkCHOhUmUJ
	ZtpITJrtOGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFBB12A07F;
	Fri, 21 Jun 2013 17:11:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 127572A07B;
	Fri, 21 Jun 2013 17:11:40 +0000 (UTC)
In-Reply-To: <CAEBDL5UNNHnogHb2ztq2G8OxyCNMoLia7xYFNSy+kfHD3pS1pQ@mail.gmail.com>
	(John Szakmeister's message of "Fri, 21 Jun 2013 06:07:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3FE29C6-DA95-11E2-9B1E-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228635>

John Szakmeister <john@szakmeister.net> writes:

> On Thu, Jun 20, 2013 at 9:16 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Hi,
>>
>> So this should explain the problem:
>>
>>   # using v1.8.3.1
>>   $ git clone https://google.com
>>   Cloning into 'google.com'...
>>   fatal: repository 'https://google.com/' not found
>>
>>   # using master
>>   $ git clone https://google.com
>>   Cloning into 'google.com'...
>>   fatal: repository 'https://google.com/' not found
>>   fatal: Reading from helper 'git-remote-https' failed
>
> I can see where this is confusing, but can also see how it's useful
> information to have.  On clone, it's probably not that useful since
> you're looking right at the url, but I could see that information
> being more useful on a pull or push with the default arguments (when
> the source and destination aren't quite as obvious).

The "extra" error messages is not the first one, but the last one,
and the suggested revert is a proposal to remove the latter, not the
"repository $URL not found".
