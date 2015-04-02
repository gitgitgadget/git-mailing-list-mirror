From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] systemd socket activation support
Date: Thu, 02 Apr 2015 08:47:04 -0700
Message-ID: <xmqq4moyleh3.fsf@gitster.dls.corp.google.com>
References: <1427937796-10060-1-git-send-email-shawn@churchofgit.com>
	<CAPig+cQVLGAYKNJf2dZGpnZbU-GBzeVKpQG48cpFtX8uYZ_LPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Shawn Landden <shawnlandden@gmail.com>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 17:48:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdhKw-0008QT-GW
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 17:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128AbbDBPrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 11:47:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752400AbbDBPrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 11:47:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAF4420E1;
	Thu,  2 Apr 2015 11:47:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qz4gvSUDt9aTHDOwMT4rQzsaN+Q=; b=h0dX+Y
	zFNLiBLBy4ttkvoMI8dfYHyyIOcC82UieyhRnrSWJ4ktBYu8QC2aV4zHlwEiiDlw
	bcsaw+vnKRytIG5OeOdEuGSRe7YtZkqfqoGFfj16y7UrpkYncqj13o+iL0/4qz/p
	i5h8XC2SzC6uHkM6kh5RUyH9QSrIx/Qsynoic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDqvW7afFvfO32B71Ew7fUbtDTl6LvJv
	bsO66efzrDioSeJBVUgttERYFjVflgdeWyfu6Z+xHsEf7N/9HMwspwJiYSI9wXe6
	/5gdICm4caDNOTDe05QlxX5kkDYdE55Qt80YmF6estE/i/yi3KCy0n7ovCgddJgB
	AfsHMP3Rdfk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76FF0420E0;
	Thu,  2 Apr 2015 11:47:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB3E1420DB;
	Thu,  2 Apr 2015 11:47:05 -0400 (EDT)
In-Reply-To: <CAPig+cQVLGAYKNJf2dZGpnZbU-GBzeVKpQG48cpFtX8uYZ_LPQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 2 Apr 2015 01:59:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 837FBB82-D94F-11E4-8C8D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266643>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 1, 2015 at 9:23 PM, Shawn Landden <shawn@churchofgit.com> wrote:
>> From: Shawn Landden <shawnlandden@gmail.com>
>>
>> [PATCH] systemd socket activation support
>
> This patch feels like an RFC rather than a properly fleshed-out
> submission. If so, indicate such in the subject. Also, mention the
> area you're touching, followed by a colon, followed by the summary of
> the change:
>
>     [PATCH/RFC] daemon: add systemd support
> ...

Everything Eric said ;-)

Another thing is that this must be a build-time conditional.  Not
all platforms can use systemd in the first place, and some people
may choose not to use it even if the platform is capable of.

I was somewhat surprised that sd-daemon.c needed to be built on our
side, not used from systemd support library, as what it did looked
very common and not specific to our needs. I would have expected to
see inclusion of "sd-daemon.h" with -lsystemd-daemon or something on
the command line.
