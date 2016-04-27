From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] trailer: load config to handle core.commentChar
Date: Wed, 27 Apr 2016 13:31:07 -0700
Message-ID: <xmqqlh3y94l0.fsf@gitster.mtv.corp.google.com>
References: <1461785062-23523-1-git-send-email-rafalklys@wp.pl>
	<CAP8UFD1O+V64dr-j9bu7D1mrLxEy3zG017zdJahJTx-MUYv5Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rafal Klys <rafalklys@wp.pl>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:31:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avW7A-00030y-H8
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbcD0UbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 16:31:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62153 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752249AbcD0UbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:31:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1247D161D1;
	Wed, 27 Apr 2016 16:31:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=43WVtZgEhgsKqe4FKOciLS0utTk=; b=K/pGC5
	30T1XEqlTZxDUxRQXwcQr9W7NJGBtS0pQL7cuhP7GR+m3hSbM70u3rWp+qlh6IAB
	0ACRYJXMTpLPYLFAElN6h9ivkuulw4QWP9cG+FRIy3AmOv34ujOZy7eu5SYWGHr/
	sAaC5rXkozlyRY5DtlTuCS2SnuyKVKkPMD32k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R6QrVNwGwmweWAd1Z69+OvjUMWgK2/A9
	feeJ3vmSBy0dr7ajKJu7uQ9r369+LhbGYRqlvCKd7hh7UsIOxIJNybmbg8YhfGuk
	ODcXmi7BlzMgL7Ksj3EeN1ineaZLJJkPUlruam43067s3JP08JOEw0kuT/IoMjB8
	Fm0mowqudAM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0AE3D161D0;
	Wed, 27 Apr 2016 16:31:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5F5D1161CB;
	Wed, 27 Apr 2016 16:31:09 -0400 (EDT)
In-Reply-To: <CAP8UFD1O+V64dr-j9bu7D1mrLxEy3zG017zdJahJTx-MUYv5Pg@mail.gmail.com>
	(Christian Couder's message of "Wed, 27 Apr 2016 22:13:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F9B0067C-0CB6-11E6-8908-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292816>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Apr 27, 2016 at 9:24 PM, Rafal Klys <rafalklys@wp.pl> wrote:
>> Add call to git_config(git_default_config, NULL) to update the
>> comment_char_line from default '#' to possible different value set in
>> core.commentChar.
>
> It is "comment_line_char" not "comment_char_line", but otherwise you
> can add "Reviewed-by: Christian Couder <chriscool@tuxfamily.org>".
>
> Thanks!
>
>> Signed-off-by: Rafal Klys <rafalklys@wp.pl>
>> ---
>>  trailer.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/trailer.c b/trailer.c
>> index 8e48a5c..a3700b4 100644
>> --- a/trailer.c
>> +++ b/trailer.c
>> @@ -888,6 +888,9 @@ void process_trailers(const char *file, int in_place, int trim_empty, struct str
>>         git_config(git_trailer_default_config, NULL);
>>         git_config(git_trailer_config, NULL);
>>
>> +       /* for core.commentChar */
>> +       git_config(git_default_config, NULL);
>> +

I can sort-of see why the original (logically) reads the
configuration files twice by making two separate calls to
git_config(), but I do not think we should add a third round like
this patch does.  Shouldn't git-trailer-default-config have a
fallthru call to git-default-config instead?

>>         lines = read_input_file(file);
>>
>>         if (in_place)
>> --
>> 2.8.1.68.g625efa9.dirty
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
