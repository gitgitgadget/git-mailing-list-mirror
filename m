From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule.sh: Support 'checkout' as a valid update command
Date: Mon, 06 Jan 2014 08:20:53 -0800
Message-ID: <xmqq7gadkroa.fsf@gitster.dls.corp.google.com>
References: <CALas-iiF7Og8qjWoYeop3GofG_kR7w5DDcNkA1y3eQhu1Srxkw@mail.gmail.com>
	<1388890249-3577-1-git-send-email-ceztko@gmail.com>
	<20140105204423.GF3156@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Francesco Pretto <ceztko@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Mon Jan 06 17:21:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0CvJ-0001bN-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 17:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbaAFQVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 11:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753883AbaAFQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 11:21:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 434D55F406;
	Mon,  6 Jan 2014 11:20:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nhHeRZ07EdddJsrgd5/Ld7op0Mw=; b=T1/e72
	9nSpSc5kMeJvw0sB0/s6Rs6ocOCsA9IbWVafIoI1yaWIzzxdOqY5PztwvQdSevgr
	m9Sk3sYWEzf+3OpFF1TJEW4HyKsTfXVDQP9OzLKly/5RKtp1gOq/oj8Qcm77Ev35
	H1BEk7BQHVJ7+1b8t6LvvRD2LSLPXDtTdARgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AsbDWmuV3nZueIG4wNRtoKfdPHGhNy4O
	x+tAitZpfaTKj9j5J7iIk+5viYmffgkuefmkYyc5/Ws47MAJHK3FG9d3xChQTLow
	otWx0pfv8VvcXadk5o84eLIRoswLYVfdHKGxpI1v5AJ85qQjmmarU3CNSuCSuvaM
	LERrQl/5HF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BBF5F405;
	Mon,  6 Jan 2014 11:20:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88C215F401;
	Mon,  6 Jan 2014 11:20:55 -0500 (EST)
In-Reply-To: <20140105204423.GF3156@odin.tremily.us> (W. Trevor King's message
	of "Sun, 5 Jan 2014 12:44:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84EDC140-76EE-11E3-8B16-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240023>

"W. Trevor King" <wking@tremily.us> writes:

> On Sun, Jan 05, 2014 at 03:50:48AM +0100, Francesco Pretto wrote:
>> +			case "$update_module" in
>> +			'')
>> +				;; # Unset update mode
>> +			checkout | rebase | merge | none)
>> +				;; # Known update modes
>> +			!*)
>> +				;; # Custom update command
>> +			*)
>> +				update_module=
>> +				echo >&2 "warning: invalid update mode for submodule '$name'"
>> +				;;
>> +			esac
>
> I'd prefer `die "…"` to `echo >&2 "…"`.  It's hard to know if mapping
> the user's preferred (unknown) update mechanism to 'checkout' is
> serious or not.
>
> This commit also makes me think that --rebase, --merge, and --checkout
> should be replaced with a single --update={rebase|merge|checkout|!…}
> option, but that's probably food for another commit (and a long
> finger-breaking deprecation period).

All of the above points sound sensible to me.
