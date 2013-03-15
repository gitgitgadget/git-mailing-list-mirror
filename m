From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: hint the user about -uno if read_directory takes
 too long
Date: Fri, 15 Mar 2013 14:59:18 -0700
Message-ID: <7vzjy4tjd5.fsf@alter.siamese.dyndns.org>
References: <CACsJy8DZm153Tu_3GTOnxF8bFrYPh7_DP6Rn6rr3n6tfuVuv2Q@mail.gmail.com>
 <1363179556-4144-1-git-send-email-pclouds@gmail.com>
 <7vehfj46mu.fsf@alter.siamese.dyndns.org>
 <CACsJy8BixM-9bPB3G_WO+W3cTHBFxLQ=YCU2NDEzHmCYW73ZPQ@mail.gmail.com>
 <7vmwu6yqbd.fsf@alter.siamese.dyndns.org>
 <CACsJy8BruzR=EGnwA5nc_aCJ5pO4FHyQKxd-9_36U48Ci_FFew@mail.gmail.com>
 <514343BA.3030405@web.de> <7vvc8svc2r.fsf@alter.siamese.dyndns.org>
 <51435D49.6040005@web.de> <7v4ngcv35l.fsf@alter.siamese.dyndns.org>
 <51438F33.3080607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
	artagnon@gmail.com, robert.allan.zeh@gmail.com, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 15 22:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGcfF-0007ia-8d
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 22:59:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab3COV7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 17:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406Ab3COV7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 17:59:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C975BB0E;
	Fri, 15 Mar 2013 17:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V51HlrCYke5u
	bn3HnrSU1ZEr1eQ=; b=dFI9W/YhBfkw2jqYXJHaz9s4SMpeokawmP1dIz8Zhg+D
	XsrHSn0nicqoimz7vmIP9YAkDCgcBXKI2VQnPOVpX2YhbR2/0GdstOlld47m0fN3
	a09oHmFu5dQWD5IXmUOQWcZ3enKjyt9+8OHLAyKPpWXK/RONkyIRkF6CQSuwpEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=na3fkv
	tZjTHfIudxFl11TCOyIkHwvLoJWzfHJfGCKl9dwCh5eFmsI6+OXnqrStvamBSwI1
	Da47XmjqO33Epn81IAuxp2yOze5R7jXKhPqFDRYNqAxELdMuFbznNaY4zMBKDKQX
	TrdggppNapm3l34zvA/9CkfKH7L5vrscYcsaQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E735BB0D;
	Fri, 15 Mar 2013 17:59:20 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D56A2BB0C; Fri, 15 Mar 2013
 17:59:19 -0400 (EDT)
In-Reply-To: <51438F33.3080607@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Fri, 15 Mar 2013 22:14:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 968E1548-8DBB-11E2-A608-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218263>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks, that looks good to me:
>
> # It took 2.58 seconds to enumerate untracked files.
> # Consider the -u option for a possible speed-up?
>
> But:
> If I follow the advice as is given and use "git status -u", the resul=
t is the same.

Yeah, that was taken from

    http://thread.gmane.org/gmane.comp.version-control.git/215820/focus=
=3D218125

to which I said something about "more levels of indirections".  This
episode shows that even a user who was very well aware of the issue
did not follow a single level of indirection.

> If I think loud, would it be better to say:
>
> # It took 2.58 seconds to search for untracked files.
> # Consider the -uno option for a possible speed-up?
>
> or
>
> # It took 2.58 seconds to search for untracked files.
> # Consider the -u option for a possible speed-up?
> # Please see git help status

The former actively hurts the users, but the latter would be good,
given that your documentation updates clarifies the trade off.

Or we can be more explicit and say

# It took 2.58 seconds to search for untracked files.  'status -uno'
# may speed it up, but you have to be careful not to forget to add
# new files yourself (see 'git help status').

or something.
