From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git status --porcelain` disagrees with documentation about
 quoting filenames with spaces
Date: Thu, 28 Oct 2010 16:41:59 -0700
Message-ID: <7vocad996g.fsf@alter.siamese.dyndns.org>
References: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org>
 <7v39rqb1ji.fsf@alter.siamese.dyndns.org>
 <EFFE2D68-BBA3-4EF4-B56A-AA4882EDE1E4@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Oct 29 01:42:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBc6q-0002tk-NV
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 01:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758717Ab0J1XmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 19:42:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49123 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab0J1XmL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 19:42:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E68A71630;
	Thu, 28 Oct 2010 19:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ivU1mkNhA/FXwzUXo5GNijsIxKs=; b=L60Jj/
	m9VnhOCO+JTCofnFaqHh3SJv5LDcpoCr809AS9BXjHO8rg+a9mpVs2dNOw8UBet4
	f1unciTAWh/N/bUDQaWtAnxhCnnKRQy5+lukzzFQ3xyuCoejCdZEjZZViSLOxLyn
	Il5WTn/ksCQyyEZ/yD4OKymTWAjb4qvDz0YzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXXdD4VU0FCYOOoIMPatoXC3nJDGLfb6
	ZjtHMFjuPazadYh3Ecua++Qqx1oE7elu8JNV1WRBgrJKQUdiL3i76Ln2uMs4YoRb
	AWaOTTy1zwuJrXoYNLOD1ysP7A4anvxhQdEWev+DOqe0rGxAZ0PxrxXdrhjKQ2bf
	zAtxat8Yp+w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE1E162F;
	Thu, 28 Oct 2010 19:42:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04C91162E; Thu, 28 Oct
 2010 19:42:00 -0400 (EDT)
In-Reply-To: <EFFE2D68-BBA3-4EF4-B56A-AA4882EDE1E4@sb.org> (Kevin Ballard's
 message of "Thu\, 28 Oct 2010 14\:17\:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F786E22A-E2EC-11DF-AB4B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160250>

Kevin Ballard <kevin@sb.org> writes:

> On Oct 28, 2010, at 11:44 AM, Junio C Hamano wrote:
>
>> Kevin Ballard <kevin@sb.org> writes:
>> 
>> [jc: why do you send messages with toooooooooooo loooooong lines sometimes
>> and normal line lengths some other times...?]
>
> I use a GUI mail client to write email. Anything I copy&paste is hard-wrapped,
> anything I write directly tends to not include hard linebreaks at all. Would it
> be better if I hard-wrapped my lines?

It is not better vs worse but is acceptable vs unacceptable, as hard
wrapped messages have been the norm around here from day one.  As far as I
remember you only recently started sending messages with long lines, so I
suspected perhaps you changed your environment and are doing so without
realizing the pain you are causing to others.

> ... Granted, having " -> " in your pathname is also pretty
> insane, but my motivation here is just ensuring that the --porcelain format
> is parseable even if you are insane.

It is not just "also" but order of magnitude more insane ;-)

Just in case you misunderstood me, even though I think SP in path is
already insane, I am sympathetic enough to them to stand behind 28fba29
(Do not quote SP., 2005-10-17); they were the ones who complained when
they saw

    diff --git "a/My Documents/hello.txt" "b/My Documents/hello.txt"

and complained.  As 

    diff --git a/My Documents/hello.txt b/My Documents/hello.txt

is perfectly parsable (and no, don't worry about renames---we have extra
headers to keep them unambiguous), it is easier on their eyes if we did
not quote these paths that are "normal" to them ;-)

>> The best would probably be to special case SP (which is normally not to be
>> quoted) _only_ in the context of "something" -> "something".
>
> That's what I was thinking. I'll look into doing just that.

Yeah, if we wanted to be perfect, it would be better to do so without
causing unnecessary pain.
