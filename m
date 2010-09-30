From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-remote-ext
Date: Thu, 30 Sep 2010 13:03:22 -0700
Message-ID: <7vfwwrhud1.fsf@alter.siamese.dyndns.org>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-4-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100930134552.GF4850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 22:03:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1PLx-0005OZ-6k
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 22:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab0I3UDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 16:03:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab0I3UDd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 16:03:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B660EDA26C;
	Thu, 30 Sep 2010 16:03:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PQm32LnSFwal5rNxXqLWYTVOr5c=; b=JqMoOO
	9P0N6H0LFCKOOCR7U70dUUPvd4asygWn0FRHdj1eEVtlKVOFBi4g5CE8kX86M/5b
	H9nXIOC5q5aPRvy+m7xIsYiB0oWbxmteiQ1qehwoNXzY1x48BBzO/oFbLNjFDyQI
	Lz7pDV0DZM+fyH/C6EmOzKv4I9WlupZ7H8RUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7zktUqC4HwJYBI1v7zcSBOwyeQqCwfy
	2GLIghFD5C2RcqLQAopVk9SEotjZi7I2Wadod/F0+HHYhx3TW3yUWcHKBTmGKkcd
	Av2Ee6Z+F6nSM5IYBi4LJdFur83utSiFpBtbbCyROELnSGIjlERn4xnnz0KG5W5n
	E17uHuj9Aaw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80F43DA26B;
	Thu, 30 Sep 2010 16:03:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C967DA266; Thu, 30 Sep
 2010 16:03:24 -0400 (EDT)
In-Reply-To: <20100930134552.GF4850@burratino> (Jonathan Nieder's message of
 "Thu\, 30 Sep 2010 08\:45\:52 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CAAB8574-CCCD-11DF-A8B1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157706>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ilari Liusvaara wrote:
>
>> This remote helper invokes external command and passes raw smart transport
>> stream through it. This is useful for instance for invoking ssh with
>> one-off odd options, connecting to git services in unix domain
>> sockets, in abstract namespace, using TLS or other secure protocols,
>> etc...
>
> Tunneling, too (e.g., native git protocol passing through draconian
> firewall), right?
>
>>  Documentation/git-remote-ext.txt |   87 ++++++++++++++++++++++++++++++++++++++
>>  Makefile                         |    1 +
>>  builtin.h                        |    1 +
>>  git.c                            |    1 +
>>  4 files changed, 90 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/git-remote-ext.txt
>
> Where is the implementation?
>
>> +++ b/Documentation/git-remote-ext.txt
>> @@ -0,0 +1,87 @@
>> +git-remote-ext(1)
>> +=================
>> +
>> +NAME
>> +----
>> +git-remote-ext - Bridge smart transport to external command.

Is "remote-ext" a git subcommand that "git help --all" would want to show?

>> +SYNOPSIS
>> +--------
>> +"ext::<command>[ <arguments>...]" (as URL)
>
> Maybe:
>
> 	git remote add nick "ext::<program>[ <arguments>...]"
>
> as a concrete example.

Ahh.  I wasted minutes and hears scratching my head to figure out what
that "(as URL)" was about.

>> +
>> +DESCRIPTION
>> +-----------
>> +This command uses specified command to connect to remote git server.
>
>  - Most users won't invoke remote-ext directly, right?
>  - Missing articles ('the' and 'a').
>  - Missing formatting ('command' is passed on the command line).
>
> So maybe:
>
> 	This remote helper uses the specified 'program' to connect
> 	to a remote git server.
>
>> +
>> +Between <command> and <arguments> (if present) is space. Also space
>> +splits different arguments.
>
> 	Arguments should be separated by a single unescaped space.
>
> Do I understand correctly?
>
>> +
>> +The following sequences have special meaning:
>
> Missing article:
>
> 	... have a special meaning:
>
>> +
>> +'\ '::
>> +	Don't interpret the space as command/argument separator.

Is it just me who finds the placeholders with backslashes somewhat out of
place where most other placeholders in git are per-cent prefixed?
