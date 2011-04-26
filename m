From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] Use floating point for --dirstat percentages
Date: Tue, 26 Apr 2011 09:52:28 -0700
Message-ID: <7vpqo9ez03.fsf@alter.siamese.dyndns.org>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-1-git-send-email-johan@herland.net>
 <1303776102-9085-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:52:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QElVG-0007tX-4Y
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 18:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614Ab1DZQwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 12:52:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46812 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182Ab1DZQwk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 12:52:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 42DDF4DDF;
	Tue, 26 Apr 2011 12:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ayUdud0lgnPwztIBpNNZ/8SQs8=; b=c82t95
	ZBT5zeAHB9uWS24wnbdF8pQVytF18DyvJu2amH3exz2yYj5HnbfzTNeY9qPv1p0y
	5jDi/+TSPy6u6JbIMjqsa1tj3zg8yKlX37JoPC2R2KIuq+lo55a2A6OXYZ9M+TR4
	Csads0wd/Z6mTPaYPUma7bRlHVp3VoUSLf5as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=snZvn6xSVQbkYey9ovFpg/3RSTO/456t
	LdSnCPRE6LMU7gf2QY1UaPQfOdHb8pW8iYgjQrW2vOdTlAVa7KH+XejkrtvI+oeq
	LwN1r6fsgEYj7qDZAATGaQTTlQ3OeMUPQW8Qtrl4wIBtEUdio40fhrzWDStnlADl
	uK6R8F9YOy4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D7514DDE;
	Tue, 26 Apr 2011 12:54:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D81C74DDB; Tue, 26 Apr 2011
 12:54:32 -0400 (EDT)
In-Reply-To: <1303776102-9085-6-git-send-email-johan@herland.net> (Johan
 Herland's message of "Tue, 26 Apr 2011 02:01:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE79B700-7025-11E0-994A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172107>

Johan Herland <johan@herland.net> writes:

> Allow specifying --dirstat cut-off percentage as a floating point number.
>
> When printing the dirstat output, floating point numbers are presented in
> rounded form (as opposed to truncated).

Why isn't it sufficient to change

	permille = this_dir * 1000 / changed

to

	permille = (this_dir * 2000 + changed) / (changed * 2)

or something?  If rounding is the only issue that bothers you (I admit
that it does bother me, now that you brought it up), that is.
