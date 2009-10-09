From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix the exit code of MSVC build scripts on cygwin
Date: Thu, 08 Oct 2009 23:49:03 -0700
Message-ID: <7vy6nl5ag0.fsf@alter.siamese.dyndns.org>
References: <4ACE064B.5020909@ramsay1.demon.co.uk>
 <81b0412b0910081313x31f72916p6fddd1a23df154df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>, mstormo@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:51:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9Ji-0005Ea-MC
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbZJIGt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756565AbZJIGt6
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:49:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756858AbZJIGt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:49:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 940F751B0E;
	Fri,  9 Oct 2009 02:49:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxVa5EgA4jUh0mIE1eIgdKkcHjc=; b=PS3l3G
	YaLU4fjR1ByxzGaguTVfVSjwVHQ9XvbKZ7mB9QZ1OUpQd6YeX9x2zJM7TnUvtqur
	sz/bwYbFQEmnQ0R+xXMUQJ+tU9PrI1Pvkuf2bzVb5xlHMnen3RM7dEwTs//df4fh
	O7N4bJQ4lDvqV0HPU5ALyDGhjSJ4mLsTo5GJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ty8l6qNQHy5emHuMLkb87AvUMLMLe/t4
	Vix+wL8Y72Xdf2DA4r4nvz6D05kXP9uJirEp/KGwOIHOTfqEC5bEoxBtMaswnPC3
	q9h8Pe1DSLPe6YgWj18i1FVXn7VSQyuOfkivqBsy0gQ2EZBxgpiYNqUmyhnrfigJ
	pQ6m6MXey9c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 537CC51B0D;
	Fri,  9 Oct 2009 02:49:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70D7651B0C; Fri,  9 Oct
 2009 02:49:04 -0400 (EDT)
In-Reply-To: <81b0412b0910081313x31f72916p6fddd1a23df154df@mail.gmail.com>
 (Alex Riesen's message of "Thu\, 8 Oct 2009 22\:13\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D91CFDBE-B49F-11DE-AC09-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129742>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Thu, Oct 8, 2009 at 17:33, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>> diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
>> index 0ffd59f..26aec61 100644
>> --- a/compat/vcbuild/scripts/clink.pl
>> +++ b/compat/vcbuild/scripts/clink.pl
>> @@ -45,4 +45,6 @@ if ($is_linking) {
>>        push(@args, @cflags);
>>  }
>>  #printf("**** @args\n");
>> -exit system(@args);
>> +system(@args) == 0
>> +       or exit 1;
>> +exit 0;
>
> exit(system(@args) != 0);
>
> Yours looks a little verbose...

Thanks, will queue with a fixup.
