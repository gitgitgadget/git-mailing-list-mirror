From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Tue, 22 Apr 2014 14:26:34 -0700
Message-ID: <xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
	<20140422185829.GB15516@google.com>
	<xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
	<20140422210002.GC15516@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 23:27:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WciDR-0002E8-Nx
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 23:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420AbaDVV0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 17:26:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756950AbaDVV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 17:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0067A7F223;
	Tue, 22 Apr 2014 17:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QSUjB5LcnXKX7Ai0RE1caCGLp9Y=; b=JNxCfi
	5xsyNZYttXOw/KtaG90z3e+I86GLO5JhNTopA9Dd7FX5+IYWgY7dQafQDJc5ldWz
	VqH51SIG06hAM/0prYP2cDiT8+EAr3ICE5aXNRtC8yOyAKDGwEl8kg2TkLJGOeuX
	d7KiBAeumbO5SGFszC0qe2S0LN3gt56km/XgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PCFmxcrTSNp12OJw1sHCgaRaZ/UGW+2A
	nyj+XLhfED7jaVrJXLlsVAX2OP+EEVo74ey6AaeTIVv9FvYT0JOPo/N1rXo8RLOv
	hTBKw7uzmWmd0XcAKWa3KDzTZpNZEl6Zexiw1ic/WqhHziQIPnvj61zuqaa3ULjd
	WAd4N4mMbGg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1FE67F221;
	Tue, 22 Apr 2014 17:26:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 116A57F21D;
	Tue, 22 Apr 2014 17:26:35 -0400 (EDT)
In-Reply-To: <20140422210002.GC15516@google.com> (Jonathan Nieder's message of
	"Tue, 22 Apr 2014 14:00:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C888476C-CA64-11E3-80B4-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246788>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Hm, perhaps we should introduce a 'no-prefix' option to work around
>>> this.
> [...]
>>> That way, normal usage of --prefix would still be consistent with
>>> other git commands that prefer the form with argument attached
>>> (--prefix=foo, not --prefix foo; see gitcli(7)).
>>>
>>> Thoughts?
>>
>> I do not think that it is a good idea to use "--no-anything" for
>> something that is not a boolean.
>
> Do you mean it is a bad idea to support or a bad idea to make use of
> such support?
>
> I suggested --no- for consistency with current git commands that use
> parseopt.  But on second thought, I agree that it be confusing for
>
> 	--prefix=foo --no-prefix
>
> to mean something different from no --prefix parameter at all.
>
> The documentation says
>
> 	--prefix=<prefix>
>
> 		...
>
> 		Before Git 2.0, the default prefix was "" (no prefix).
> 		This meant that ...
>
> which suggests that I can use --prefix="" to mean no prefix.  Perhaps
> it needs a note to suggest using '--prefix ""' instead?

Is there another --option that takes an arbitrary user string that
could be an empty string (or will there be one in the future)?  If
that is the case, a better alternative might be to add an comment to
say that those with older Getopt::Long may have to use --option ""
instead of the --option="" form for any option whose value happens
to be an empty string to work around the command parser bug.
