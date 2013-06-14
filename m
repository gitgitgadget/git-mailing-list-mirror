From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: remove existing output-directory
Date: Fri, 14 Jun 2013 06:55:26 -0700
Message-ID: <7vip1gssoh.fsf@alter.siamese.dyndns.org>
References: <1371213813-7925-1-git-send-email-artagnon@gmail.com>
	<20130614130910.GF23890@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUTW-0004Cs-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab3FNNz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:55:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362Ab3FNNz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:55:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84AA7257BD;
	Fri, 14 Jun 2013 13:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rQCcUybOuJBjbp1UaQBSt8xxvYg=; b=J5rYUV
	1w2MOrUFl8MOTKkO45Ia6Der6KNlBw0+XNEJFNmFlfwmZpAawTM4YEMXBkFs7mjs
	7SR4gXkPLEHFAOvUpg/eElNCPnSfsl4vZBscnwrkBRQHpAP5Db2Dj4kZc7/LvaI6
	2/uPRoG60Io9c8bq9evujXyIY9RlqkDe0Pt7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I8iatlXmf73sLGzgrHi9H81il2UiwZGz
	kTpl8pehQInD/9+B1Wc5/V0erwEA1ydFbahRFivGR5vGz46fLDSK9nWAFxmkpjdO
	eDrj8KUDEQQ5B8xlty6Y1AjMvEe1iw+f58yyzJjkATbL4e2cesziruOHxS1Q6+1d
	P2oqh/5St7s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A3DC257BC;
	Fri, 14 Jun 2013 13:55:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F02257B8;
	Fri, 14 Jun 2013 13:55:27 +0000 (UTC)
In-Reply-To: <20130614130910.GF23890@serenity.lan> (John Keeping's message of
	"Fri, 14 Jun 2013 14:10:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11CB971E-D4FA-11E2-A33C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227870>

John Keeping <john@keeping.me.uk> writes:

> On Fri, Jun 14, 2013 at 06:13:33PM +0530, Ramkumar Ramachandra wrote:
>> The following command
>> 
>>   $ git format-patch -o outgoing master
>> 
>> does not ensure that the output-directory outgoing doesn't already
>> exist.  As a result, it's possible for patches from two different series
>> to get mixed up if the user is not careful.  Fix the problem by
>> unconditionally removing the output-directory before writing to it.
>
> I don't think this is the correct behaviour.  I can think of cases where
> I would want to output multiple things into the same directory.
>
> It may be better to issue a warning when this happens, or die and
> provide a flag to let the user bypass that.

Absolutely.  I think this too dangeous, and will kill the
possibility to further improve "format-patch -v$n".

An option (and configuration that expresses the user's wish) to
error out when -o diretory exists is probably as far as we would
want to go. Removal is way too much to accept without risk of
hurting users.
