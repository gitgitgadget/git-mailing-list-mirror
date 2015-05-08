From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] http: add support for specifying an SSL cipher list
Date: Fri, 08 May 2015 08:59:17 -0700
Message-ID: <xmqqpp6bm562.fsf@gitster.dls.corp.google.com>
References: <1431056685-12337-1-git-send-email-lars@redhat.com>
	<1431087305-8988-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lars Kellogg-Stedman <lars@redhat.com>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri May 08 17:59:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqkgT-0008WC-FM
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 17:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbbEHP7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 11:59:23 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752930AbbEHP7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 11:59:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AD5674C432;
	Fri,  8 May 2015 11:59:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FUC1fajPuusB
	r0QrjPp0gtLaVeM=; b=BXA4DUSDPx5gAFnDAiaIu9FMZOPATnKyNmgP2H3aLQjg
	abj41NmFprNedaQU30237V+YsGVzjdIsVyXBpD+1vRoVzh8c5EEkeyyXe3Nsd8vi
	fULQdr2Ay9X7JcK7rI7kg0q2MhaIo4YLhG+XDg7ntHWHlsDwCeKQKyZO+2ojNg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Lf3X0Z
	eWr3i3r4/fq6XEhaOoVhHNJgoZzlVdG1zpCtqhSRgoka+Gw1NFnqoupPA7jIAANG
	MuUA5QTkD1pcBk9HrAwhx0JO7ZOxR4ze4Ght+KS1rQubQGW8jY4O2gmsKkF5kU2P
	J7sWPzR1HyNrJDo2/f7ywSqmDgUvgbQo3Cibk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4A6C4C431;
	Fri,  8 May 2015 11:59:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11EE44C430;
	Fri,  8 May 2015 11:59:18 -0400 (EDT)
In-Reply-To: <1431087305-8988-1-git-send-email-szeder@ira.uka.de> ("SZEDER
	=?utf-8?Q?G=C3=A1bor=22's?= message of "Fri, 8 May 2015 14:15:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F57645C-F59B-11E4-AFBE-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268620>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> ... or with 'git -c http.sslCipherList <cmd>' on the command line (bu=
t I
> don't think it should be mentioned here that a config variable from a
> config file can be overridden via 'git -c', because that's true for a=
ll
> config variables anyway).

I do not think it would be very useful in practice anyway, so I
agree we should not add it there.  You would not use the blanket
http.sslCipherList but target-specific http.<url>.sslCipherList more
often to work around specific quirks of one site in your
configurtion, and specifying the blanket form with "-c" on the
command line would not defeat that.

Speaking of urlmatch-assisted configuration variables, do they get
TAB completed on the command line?
