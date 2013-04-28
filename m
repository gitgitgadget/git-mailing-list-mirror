From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.3-rc0
Date: Sun, 28 Apr 2013 14:12:39 -0700
Message-ID: <7vvc76pdfc.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<CAH_OBievcf-_z_AX9UrmWL_HVFT2vSQTu+wXAjAFeQBM8iFSGw@mail.gmail.com>
	<517B62D8.5020006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: shawn wilson <ag4ve.us@gmail.com>, git@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: linux-kernel-owner@vger.kernel.org Sun Apr 28 23:12:55 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UWYtx-0007nl-8a
	for glk-linux-kernel-3@plane.gmane.org; Sun, 28 Apr 2013 23:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604Ab3D1VMn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 28 Apr 2013 17:12:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43909 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752428Ab3D1VMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Apr 2013 17:12:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4E51A911;
	Sun, 28 Apr 2013 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SqYkPfOAg99OrdicQLD9RAm7Pq0=; b=vFX/tS
	3Ea+aZ4Mmbp/TNG5X0wEPo5GnJj4BzT83PfOSLttpyHQAdgBbu967eJZwOIW86As
	Tkd2NJudCubdmuSsKicbrZk8qrLz4YQ8WkSDu4KyPU1ZgG+u5/4bBpGK2VnsPa4V
	lBE3plgrIraVL47IToG2+WfNjI1Xii3kPFQFg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=spxXW2olSSPgdlr7rq3xPSR3x5jsL2Sn
	4JTaleRUYHEczR338cwByPU/wmgDnuC2ttEtONEc0vEq2iqXML11KlxYdHg08y9l
	9CHYyNyYSXjzam+k1lW9yGYiZRmylrJfTF9StKDZyvYN26HUo9mCLdzHHru9SPGb
	XqdblqwJbyA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 304681A910;
	Sun, 28 Apr 2013 21:12:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A4B171A90C;
	Sun, 28 Apr 2013 21:12:40 +0000 (UTC)
In-Reply-To: <517B62D8.5020006@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 27 Apr 2013 07:32:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C471092-B048-11E2-8485-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222755>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/27/2013 04:24 AM, shawn wilson wrote:
>> On Fri, Apr 26, 2013 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>>>  * There was no good way to ask "I have a random string that came from
>>>    outside world. I want to turn it into a 40-hex object name while
>>>    making sure such an object exists".  A new peeling suffix ^{object}
>>>    can be used for that purpose, together with "rev-parse --verify".
>>>
>> 
>> What does this mean / what is the reason behind this? I can only think
>> it might be useful in a test suite to make sure git isn't doing
>> anything stupid with hashes...?
>
> The topic is discussed here:
>
> http://git.661346.n2.nabble.com/Bug-in-quot-git-rev-parse-verify-quot-td7580929.html
>
> As discussed in the thread, when verifying that an argument names an
> existing object, it is usually also appropriate to verify that the named
> object is of a particular type (or can be converted to a particular
> type), which could already be done with syntax like
> "$userstring^{commit}".  But if, for example, you want to avoid
> unwrapping tags but also want to verify that the named object really
> exists, "$userstring^{object}" now provides a way.
>
> And what do you have against test suites? :-)

And it is not about test in the first place.  Git is designed to be
scriptable, and it is not unreasonable for a scripted Porcelain to
want to learn the full object name of the object that is referred to
by a string that it suspects may be an object name.  Perhaps you are
feeding the entire git mailing list archive to a script that picks
up any object name in the messages and tallying the number of times
each object is mentioned.  Then you would want to key the table that
counts the number of appearances for each object with the object
name, because different message may spell the name of the same
object differently, e.g. f9fc12cf3, v1.8.3-rc0, etc.  With a helper
function "found_one_more_instance" that records the fact you saw
another mention of an object, such a program may do something like
this:

	tokenize_git_mailing_list_message |
        while read userstring
        do
		canonical=$(git rev-parse $userstring^{object}) &&
	        found_one_more_instance "$canonical"
	done
