From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 03/18] usage: implement error_errno() the same way as
 die_errno()
Date: Fri, 26 Nov 2010 10:35:24 -0800
Message-ID: <7v8w0gq6fn.fsf@alter.siamese.dyndns.org>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.56613.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 19:35:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM39C-0002yW-6W
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 19:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab0KZSfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 13:35:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090Ab0KZSfp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 13:35:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33E222029;
	Fri, 26 Nov 2010 13:36:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZCKQc0S6OP64MSsDR1SaN4uIB30=; b=HXtdi7AGNO7hDfjvVlxRggV
	gxikHTU1sX/pITPx6Ubyxy3xapCpaLDqGnhOf/AobMtv7OPeg/eevJR+4azda8Hj
	Fhtoeku/5ylWKZ2iPdC5veFpdsI4oIXPEcka4RKDXHKmJl4QlZsiywEJLe/R37p/
	PWSXV3TsgHxhO+3a8lc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=J0A423PVXixEfLmD3rLYMCbgLlCJAPXCh7VsXLIKZyjhKblbD
	VsZa7Oek3STa060U+OsOt1Ew1jXda9BO04q4JnX37Lm1++aKMuzvL8wDyFvi3Bjy
	Ghna5gx7myxUSSYYmdaezZlsUov7ycYVH+e3rGXCFsPkIchBq0+YCvLLNY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3C5C2023;
	Fri, 26 Nov 2010 13:35:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 131C12013; Fri, 26 Nov 2010
 13:35:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEDF6F82-F98B-11DF-820A-DF8536391E49-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162273>

Christian Couder <chriscool@tuxfamily.org> writes:

> die_errno() is very useful, but sometimes we don't want to
> die after printing an error message and the error message
> from errno. So let's implement error_errno() that does the
> same thing as die_errno() except that it calls
> error_routine() instead of die_routine().

If this were "error_errno() is to error() as die_errno() is to die(); iow,
error_errno() does the same thing as error() but in addition shows the
errno information", it might be a good thing, but the above makes it sound
like you did something different.
