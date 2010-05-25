From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] run-command.c: ignore bad permissions on dirs in
 PATH
Date: Mon, 24 May 2010 22:34:16 -0700
Message-ID: <7vaarownmv.fsf@alter.siamese.dyndns.org>
References: <4BFB3C0A.2030505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dale Rowley <ddrowley@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 07:34:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGmme-0004On-1m
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 07:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238Ab0EYFe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 01:34:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45332 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752835Ab0EYFeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 01:34:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D752B6772;
	Tue, 25 May 2010 01:34:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HdtZccytE8SIu+jhjAI1uEeHz74=; b=azfMJe
	a4WXIHcsu2dgd7qRY7shQA3+e7OBw/Ue//XSsQ3vcf/oCmM6AB4yE4WeYTCp18jd
	n72fYo6ry2gYyRRfHZ8CLHRomG8/oH9P2tIMlFMatv9O6TPB0+O3Wo131Zw7jyRY
	OSI+M+zb3DImSemn2O4XGI7WckuKPi2EFAQWI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHlZF0HPrC7Z5+HZrOld92+6jYbs0BjR
	eV6MsGa2C74GxaUwCVTJSP4vAqbMYp1X/UJ00SGwdpTbpa3CxROn9AO7Oaxhl7ks
	nT/KUGBQqxI8uA/EaKrRX2vFbLV6Yci7PuM/rKiBj5t7AfEMXSSbCL53AETqCZog
	u/5RpUn/w0I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 596C6B6771;
	Tue, 25 May 2010 01:34:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8500FB676F; Tue, 25 May
 2010 01:34:18 -0400 (EDT)
In-Reply-To: <4BFB3C0A.2030505@gmail.com> (Dale Rowley's message of "Mon\, 24
 May 2010 20\:55\:06 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2BA997E0-67BF-11DF-8EF0-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147663>

Dale Rowley <ddrowley@gmail.com> writes:

> All of my git aliases stopped working one day. For example, when I ran 'git ci'
> (where 'ci' is an alias for 'commit') it printed out this error:
>
> fatal: cannot exec 'git-ci': Permission denied
>
> This error was confusing (I didn't have a 'git-ci' executable anywhere, so why
> was it complaining about permissions?) and it took me a while to figure out that
> this was happening because I happened to have a random directory in my PATH that
> had permissions set incorrectly. Git should probably ignore this, and here is
> one way to fix it, although I'm not sure if it's the best way.

As long as the issue is "a directory P on PATH is unreadable, and we tried
to see if P/git-ci is executable and reported failure by exiting", I think
your patch is a reasonable solution.

Thanks
