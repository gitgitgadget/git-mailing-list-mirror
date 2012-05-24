From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Thu, 24 May 2012 10:31:53 -0700
Message-ID: <7vehq9xz7a.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
 <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
 <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 19:32:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXbtY-0003rz-Kk
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117Ab2EXRb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:31:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52092 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757980Ab2EXRb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:31:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98BA385E6;
	Thu, 24 May 2012 13:31:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VK1K4SmqjOo8S+YU2vvZRlU4oJU=; b=ld/h1Z
	pje+rr1sZ5R8dn9vOCNIeam9ogeMoFaNBboStx2v8/hL1mqg/SNUrUA98cV51K4d
	oiyyWJuErxiRHPUsc8VJMYiyFrTQY0X7sMM5Ec+BrmrzHwIQapDisXPdutzKjt0d
	crvFjOlRA+zPaiilK6jYll4mvVkbaK5rQKm7A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZWdTCdIFkaaUVI4eJPDTZoWupbwXtoMQ
	Eqm0PYT0MZiS8lNprE9FiwD1S1JQywm5Mzk/488iIwEok40e0npl8DTV/ERnney1
	7b44EfWZYjxv0zfh75ss0K4D434VWsTDj083WjPhwF5QN00+MfZvVEu+5W2EpGo+
	BfHi8mZylKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BC2C85E5;
	Thu, 24 May 2012 13:31:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14F6885E4; Thu, 24 May 2012
 13:31:54 -0400 (EDT)
In-Reply-To: <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Wed, 23 May 2012 13:41:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B41CE22-A5C6-11E1-A279-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198396>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Yes, I've had the same idea myself. Anyway, as Johannes said, that's
> probably something to consider for the sequencer.

Are you saying that "rebase -any-variant" and the sequencer should behave
differently?  It is not immediately obvious to me why it is a good idea.
