From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Unify subcommand structure; introduce double dashes for all subcommands?
Date: Sun, 10 Aug 2014 11:13:44 -0700
Message-ID: <xmqqha1k8b6v.fsf@gitster.dls.corp.google.com>
References: <53CFBA1A.8040600@gmail.com>
	<xmqqiomodkt9.fsf@gitster.dls.corp.google.com>
	<53E78F26.3000701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 20:13:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGXcz-0008WE-T9
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 20:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbaHJSNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 14:13:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55025 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750875AbaHJSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 14:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C57E230D32;
	Sun, 10 Aug 2014 14:13:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dEAWItESS5qkfg5Fyh9905ADD4I=; b=GongAf
	U8CqJ4eF7gX63UaM5pjpBQ8686nUfqAVMmlnc1f39WTGiGHgqavbukjB62pqjsY0
	IYzFDlvTfQVxD27Uh0sQKr87a1QgJQ0gRhjySNZ3YvlKktAIJbMm9+VlevnXQpye
	aiCBTmNmxLyGaLJvVvV+SS7jYgV8/TprB80qQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoHYUuYIv+n3ntm8h48JNAOUkp0lgdZh
	RDfh/1OU2300RRrWnKB5LLR4lRfBy7kpo6sS7Pu51cuuLV4FrbP4o68HNtNwrmf9
	8LeL6YjRMdTlCSvI2dy1BtkB0MjVfL8SB2aB0iBT991hheKrAdyFUMZYCIt7mV7L
	Y/nTMjsdoBk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BACB030D31;
	Sun, 10 Aug 2014 14:13:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF03330D27;
	Sun, 10 Aug 2014 14:13:45 -0400 (EDT)
In-Reply-To: <53E78F26.3000701@gmail.com> (Stefan Beller's message of "Sun, 10
	Aug 2014 17:26:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1199432E-20BA-11E4-A5DE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255099>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 23.07.2014 19:52, Junio C Hamano wrote:
>
>> Sounds familiar.  E.g. here is a similar thread about a year ago.
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
>> 
>> Further discussions to make the plan more concrete is very much
>> welcomed.
>> 
>> Thanks.
>> 
>
> So I'd want to add have the subcommands without double dashes ideally.

That is not ideal at all, I am afraid.  A command that started only
with its "primary operating mode", e.g. "git tag [-s|-a] tagname
[object]", may have to gain "I do not want to create, I just want to
list" and the way to signal that has to be an option that cannot be
mistaken as its valid first argument (to avoid "git tag list" that
cannot create a tag called "list", we use "git tag --list").  You
could add an entirely new command "git foo" that always takes the
command-mode word, i.e. "git foo mode$n args", but you will be
typing the operating mode name all the time only to save --mode$n
for 2<=$n, which may not be a good economy in the end.

Please do not go there.
