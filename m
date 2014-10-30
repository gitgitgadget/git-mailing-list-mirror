From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Thu, 30 Oct 2014 10:24:48 -0700
Message-ID: <xmqqr3xpwjvj.fsf@gitster.dls.corp.google.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Peter Vojtek <peter.vojtek@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 18:25:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjtT3-00058S-Qy
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 18:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760141AbaJ3RYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 13:24:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759077AbaJ3RYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 13:24:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0877F18E42;
	Thu, 30 Oct 2014 13:24:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K7jQnfIfg0IunFP8cvAJ9XCXxvw=; b=EvnSC+
	BCZ4NMsRAmwX+4iCiWD/tszEz+WgCFzDI8Je6fZSd+4CegVr+jvb53/yrrnbVgKG
	4w1A01eeUiGJLy/BAdslyFu7zC5Q1o+R/XjhedaMVwoL3ZDyYu8FqADxYaMfPuqV
	GO9ds+VKH1v3AQ02jsPnj8yAQk49bBFphkkiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PAEMLjROXeFLxvyH0fmQPVUo1JGdAp5P
	Kdu0aeUFueZbpWnW/399b/M3VL+eFjZaeb0cUoU1/ouzqj6eGZfSa42hIIWOBXA0
	UYsTPijSENVD5Gj1/lzkr9JZWW6wirASpsv/Im8CDeJ+6np5J0bL5pP2ZgXVXuMY
	GzmXJuBS6h0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 000D218E40;
	Thu, 30 Oct 2014 13:24:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7219E18E3D;
	Thu, 30 Oct 2014 13:24:50 -0400 (EDT)
In-Reply-To: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
	(Peter Vojtek's message of "Wed, 29 Oct 2014 19:49:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A765DD7A-6059-11E4-BEB5-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Vojtek <peter.vojtek@gmail.com> writes:

> It seems the commit date can be between 1970 and 2100 (on my 32bit
> linux), however man git (section DATE FORMATS) claims ISO 8601
> standard is supported.

The date formats section of "git log" only talks about the output
format (I do not see in "man git" any section about date formats, by
the way), once Git understands and records the timestamp in its
internal representation (which is "seconds since the epoch"; as I
already said, theoretically it should be possible to record negative
number of seconds there, the current code does not allow it).

The documentation may need to be clarified, independent from what
the implementation does on the input side.  The current text from
"git log" reads like so:

       --date=(relative|local|default|iso|iso-strict|rfc|short|raw)
           Only takes effect for dates shown in human-readable
           format, such as when using --pretty.  log.date config
           variable sets a default value for the log command’s
           --date option.

The word "shown" is meant to stress that this description is about
output side, but apparently it was misread as if somehow a user can
affect the input by giving --date=iso or something, so perhaps you
would want to suggest a better phrasing?

Thanks.
