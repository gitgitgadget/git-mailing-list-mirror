From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CPPCheck found 24 high risk bugs in Git v.1.8.3.4
Date: Tue, 20 Aug 2013 16:45:10 -0700
Message-ID: <xmqqd2p8udtl.fsf@gitster.dls.corp.google.com>
References: <85C8141E5DAD94428A121F706995A31F010F116FDAD3@MX1.net.tbe.com>
	<33FCCE7A2CD5494B88F3C5CDBC341DFD@PhilipOakley>
	<166132E40AA54EE387BA9B4558823C55@PhilipOakley>
	<CABPQNSZidMv4MEW+SqVm94pX4szw9QW8LFWsvBTOXYH7ezzycw@mail.gmail.com>
	<87eh9op5gq.fsf@igel.home>
	<CABPQNSZSXgvLw_i25em38B70EgtZrv9iQh8OaCJzYRCk2vjZXQ@mail.gmail.com>
	<87y57wnf03.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Philip Oakley <philipoakley@iee.org>,
	"Koch\, Rick \(Subcontractor\)" <Rick.Koch@tbe.com>,
	Git List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Aug 21 01:45:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBvc2-0007sh-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 01:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab3HTXpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 19:45:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44344 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359Ab3HTXpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 19:45:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B62B63A7F4;
	Tue, 20 Aug 2013 23:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nVLRuIaFudO9Yg5gJdNsvON+6po=; b=HmRnf/
	+je/nRXbJS61wG1+gEMTu4i69i3tbkFVpxwXifTWEbqdX0YIGlGdyl0C6J6RcTuO
	oySNQqujKJR0qeCTjKtsz8YB8hpCq8AMHRvjRs1PvmxlTo0Ty+q25i6TlYVCjOKf
	S1ny0p25w4Vk1JnsPxa0wPmOO1bZ2k9GqPWbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FczuXtQBMBiM6ZyYLhaN8Dn4QIgKknJ0
	j+2/wCdB1oRYqj1++Uhr70UEWnFVKKmkD8wdfP16d6nGtGiuYsuDUg4dHKUVO+nP
	w36kVnDlpnlAXy5wHYqdc1P5IUW91ohqyGUxTA3n4uHktFmDEzX74fEALRaPNJr7
	QtXfNrwv2lM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7ED23A7F3;
	Tue, 20 Aug 2013 23:45:15 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E26B33A7ED;
	Tue, 20 Aug 2013 23:45:14 +0000 (UTC)
In-Reply-To: <87y57wnf03.fsf@igel.home> (Andreas Schwab's message of "Wed, 21
	Aug 2013 01:01:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8FBADF68-09F2-11E3-BCFC-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232670>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I don't see how it's undefined. It's using the memory that 'pos'
>> *points to* that is undefined, no? The difference between 'pos' and
>> 'str' should still be the same, it's not like realloc somehow
>> magically updates 'pos'...
>
> It does.  Think of segmented architectures, where freeing a pointer
> invalidates its segment, so that even loading the value of the pointer
> traps.  Probably no such architecture is in use any more, though.

I love seeing that we have somebody who knows and can explain these
dark corners of ANSI C standard ;-)
