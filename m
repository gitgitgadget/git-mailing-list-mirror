From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 11:54:37 -0700
Message-ID: <xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 20:54:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWVEf-00046Y-AM
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 20:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbaIWSyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 14:54:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59872 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751307AbaIWSyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 14:54:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F0F83BB44;
	Tue, 23 Sep 2014 14:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yVKy3JGn2KZ6Oi6q/iEOv6aRT9k=; b=ntpylv
	Fa8572JEZDTe6ShoWP56Zb4JsVEWYMkanJxEpEKwi/aE/ei0FIJALb1nue3mWcvl
	zbhNk6vyFfy0pUGQv30+VBGawIj5bY3Dk6MYVQIqGVPx9fn7vSCSNhkB7iIIQSDk
	MzB93yRYDwEqKDnz4u9mKbtasI9BfqgVYX1+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rSahTpp90TVHbo0YuINx6e4MKxiq/nBc
	a0yzy7QQRoclAymiGTqwZsIeHpagdLz0E2/cYpddKZrkwO8eYkFUZKRt1dyxM6Nh
	u67M5WZBZVd3l4oLM2/twihun0ZpnFYR/L1pLaUmhO7jyb1j+3SproLvoUYUNgV2
	E3os/LdkB+c=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0DF23BB43;
	Tue, 23 Sep 2014 14:54:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D3BCB3BB41;
	Tue, 23 Sep 2014 14:54:39 -0400 (EDT)
In-Reply-To: <1411434583-27692-1-git-send-email-lersek@redhat.com> (Laszlo
	Ersek's message of "Tue, 23 Sep 2014 03:09:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12732574-4353-11E4-B4B4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257431>

Laszlo Ersek <lersek@redhat.com> writes:

>   git format-patch master..branch1

The output from this has these (excerpt from "od -xc" output):

0000360       f   2  \n  \n   d   i   f   f       -   -   g   i   t
           6620    0a32    640a    6669    2066    2d2d    6967    2074
0000400   a   /   f   2       b   /   f   2  \n   n   e   w       f   i
           2f61    3266    6220    662f    0a32    656e    2077    6966
0000420   l   e       m   o   d   e       1   0   0   6   4   4  \n   i
           656c    6d20    646f    2065    3031    3630    3434    690a
0000440   n   d   e   x       0   0   0   0   0   0   0   .   .   f   3
           646e    7865    3020    3030    3030    3030    2e2e    3366
0000460   5   d   3   e   6  \n   -   -   -       /   d   e   v   /   n
           6435    6533    0a36    2d2d    202d    642f    7665    6e2f
0000500   u   l   l  \n   +   +   +       b   /   f   2  \n   @   @
           6c75    0a6c    2b2b    202b    2f62    3266    400a    2040
0000520   -   0   ,   0       +   1       @   @  \n   +   h   e   l   l
           302d    302c    2b20    2031    4040    2b0a    6568    6c6c
0000540   o       w   o   r   l   d  \r  \n   -   -      \n   2   .   1
           206f    6f77    6c72    0d64    2d0a    202d    320a    312e

The structural parts of the diff, including "--- /dev/null" line,
are all terminated by "\n" (as they should be), and the only CR
appears in the message is at the end of "+hello world" line.

So I do not think apply should need to loosen its sanity check and
take a random whitespace after the "/dev/null" as a valid "this is a
creation event for the path" marker (e.g. "--- /dev/null whoa"?).

is_dev_null() is used to in the fallback code path that parses
traditional patch output (e.g. GNU diff) which throws random cruft
(e.g. timestamp) after the /dev/null marker, e.g.

    $ diff -u /dev/null f2
    --- /dev/null   2014-09-17 18:22:57.995111003 -0700
    +++ f2  2014-09-23 11:37:09.000000000 -0700
    @@ -0,0 +1 @@
    +hello world

and we'd be hesitant to allow that kind of looseness for Git patches
where we know we end the line after the "/dev/null" marker.

> 3. In the reviewer / tester / maintainer role, save the patch from your
> email client to a local file. Assume that your email client does not
> corrupt the patch when saving it.

Perhaps compare this saved file with the output from the above
format-patch to see where things got broken?

SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
turn out that what you are trying to do might be an equilvalent of

	git format-patch ... |
        # first lose all \r\n
        dos2unix | 
	# then make everything \r\n
        unix2dos |
        # and apply
        git am

which is not workable in the first place.  I dunno.
