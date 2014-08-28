From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] teach fast-export an --anonymize option
Date: Thu, 28 Aug 2014 11:43:29 -0700
Message-ID: <xmqqlhq8a20e.fsf@gitster.dls.corp.google.com>
References: <20140827165854.GC1432@peff.net> <20140827170127.GA6138@peff.net>
	<CACsJy8B3gFC7kLf-cLhAk3BgQ+v427rMXWHTqjU4LYP3NQte7Q@mail.gmail.com>
	<20140828123257.GA18642@peff.net>
	<53FF5CD7.8040603@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 28 20:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN4fu-0007wC-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbaH1Snm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 14:43:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57778 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbaH1Snk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2014 14:43:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 52FA535D2E;
	Thu, 28 Aug 2014 14:43:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KUba3Xlk0L0a4Z2duZWBRCigcMQ=; b=r/gKrV
	9GHySnCo9rAj0cZy639cWY75ynY9tbtf33v4jkI9gVDxMc3FTW3Ml9X+k+z5/T/M
	As2XH6VyDKugnxKSK+7vcGQvXNfOd+DHMzZh3LUcgsLIJ+7qUqEFHQePsWqBZgXN
	ey6kl0jfip+EQCI2Cau0Xsn+423NrEnWK5Qy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CNXNR/rVULta1+XbylTubjT0Qxg/G8sb
	Y50xhwo/Vt4FEQ7w6tlhFVSyaMC+KDXsAWdzmqAZn2qKPkuGdfJdAQpEdOuDzDCr
	vF8IjIlMkXdGsOrSNtIyUPHXV+wOoGAUGuaxw0QEpeF20JkvqS2bdM/5MDlP0bn1
	6CC8RJ3QCPo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 48B1C35D2D;
	Thu, 28 Aug 2014 14:43:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 399A235D24;
	Thu, 28 Aug 2014 14:43:31 -0400 (EDT)
In-Reply-To: <53FF5CD7.8040603@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 28 Aug 2014 17:46:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 352B922E-2EE3-11E4-8F0C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256112>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Dumb question (I have not even read the patch, so please just ignore me
> if this is indeed dumb!): Is the map of <original-name, anonymized-name>
> available to the user while he attempts to confirm that the bug is still
> present?
>
> For example, if I anonymized git.git, and did 'git branch -v' (say), how
> easy would it be for me to recognise which branch was 'next'?

It is not dumb but actually is a very good point.

There needs an easy way for the reporting user to turn an
observation such as "When I do 'git log master..next' I see this one
extraneous commit shown" into a corresponding statement to accompany
the anonymised output.  The user needs it to make sure that the
symptom reproduces in the anonymised repository in order to decide
if it is even worthwhile to send the output for analysis in the
first place.
