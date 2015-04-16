From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] first line truncated with `git log --oneline --decorate --graph`
Date: Thu, 16 Apr 2015 08:28:43 -0700
Message-ID: <xmqqwq1chz2s.fsf@gitster.dls.corp.google.com>
References: <552F8B85.2000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Robin Moussu <robin.moussu@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 17:29:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yilj0-0004S6-EG
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 17:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbbDPP3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 11:29:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751888AbbDPP2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 11:28:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6214448038;
	Thu, 16 Apr 2015 11:28:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8BjmEbrIpRAYu1NbUkzzZkqx6M=; b=bqlGAL
	gJDh952ZcsTibWaJAE6tfn2Qw5BYDQJOz4FD8HBRxxIk0JAH8aDtBrvpkZrqD8bI
	/6XYA+yrsnKicpODhsHOa9G2MEnjzDzFTzbnnrwM1+H5LDCWuP5pn5z9lQNwMID6
	ZIMfsryjZjqkdWunhZS5k9GoQnfuiO7urgPW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJKtTL9cIj/dQU1m8YT3qIHfAh9y1pYH
	03qAdQkNG5HDEWJ1RTnnug3/wFvqINciGh4OjPy6A1u6rFU/T+jgRDd7E8gnOkcX
	sfpJWFIzsxpEqkcDj6snIpZPtdnk6Jaq4SWA5GgnQZ83tBAeo1LqFTqvMhAZMr7y
	91FoVH5jqkI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 59ACA48036;
	Thu, 16 Apr 2015 11:28:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7ACB48034;
	Thu, 16 Apr 2015 11:28:44 -0400 (EDT)
In-Reply-To: <552F8B85.2000908@gmail.com> (Robin Moussu's message of "Thu, 16
	Apr 2015 12:14:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44FC6168-E44D-11E4-9B7F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267297>

Robin Moussu <robin.moussu@gmail.com> writes:

> I have a bug using the following command:
>
>     git log --oneline --decorate --graph
>
> In short, the first line of the log is often truncated.
> ...
> # How to reproduce
>
> Open a small terminal windows (4*100)
>
>     mkdir tmp
>     cd tmp
>     git init
>     git commit --allow-empty -m 'Lorem ipsum dolor sit amet, consectetur
> adipiscing elit. Donec a diam lectus.'
>     git checkout -b long_branch_name_and_long_commit_name
>     git commit --allow-empty -m 'Maecenas congue ligula ac quam viverra
> nec consectetur ante hendrerit.'
>     git commit --allow-empty -m 'Praesent et diam eget libero egestas
> mattis sit amet vitae augue.'
>     git checkout master
>     git merge --no-ff long_branch_name_and_long_commit_name -m 'merge
> with a long commit message'
>     git checkout long_branch_name_and_long_commit_name
>     git merge master
>     git log --oneline  --decorate --graph
>
> I hope it is clear. The English is not my mother tongue.

It is clear and it does not reproduce for me.  I see

--------
*   5eff3a3 (HEAD -> long_branch_name_and_long_commit_name, master) merge with a long commit message
|\  
| * 61e21f3 Praesent et diam eget libero egestas mattis sit amet vitae augue.
:
--------

which looks perfectly sensible (my terminal is a "screen" running
on a Ubuntu machine, displaying to a SecureShell terminal on a
Chromebook).

Can you try running that problematic "git log" with its standard
output redirected to a file (i.e. "git log ... >output") and then
run your pager in that wide-but-short terminal (i.e. "less output"),
to see if the same problem is observed?  And then run "cat output"
in a taller terminal with the same width to see if it is the output
from "git log" that is causing you the problem?
