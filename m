From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/20] remote-hg: split bookmark handling
Date: Wed, 10 Apr 2013 12:36:43 -0700
Message-ID: <7vvc7ukwj8.fsf@alter.siamese.dyndns.org>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
 <1365441214-21096-9-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3VcUyQUNBw+19O-_nf9HPWt=2uc35Keh6Z0jcgFF=Y7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:36:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0p8-00058s-B9
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760269Ab3DJTgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:36:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752182Ab3DJTgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:36:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CEF15EB7;
	Wed, 10 Apr 2013 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kd4X2/MFVNIOEmhITxjDt7NbRFw=; b=MdjH7U
	BFMLTwiXuc5MapZ7T/eMh6Z19GtNyaMNCb2Nn1GooQAIgfRl4XIPLNEQHlYIBJSB
	76crLAdGpl51pDmHLjBZ8MWdrYxLgnYxn+t8gAT5vPqVOh7nhzbd4I5JMmQfnQpD
	P4vh9hFZNHHixuZQDsvkXZZOgNYJkCriSlcmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nC2YuouFQaV8dneo8LLMEAsfSdWRLYt7
	vGUGKbsMDaaOhzdV98qnomINk/sGfIrWF+s8Yc/cKpRjGP6rTXw09HvLD7uJ4H7P
	ex14GvBqMITVLSlChpERjmfWddwpiH4ufn3tDlZ0Dhw6gNDKs+Yq6NhX0B9SYreD
	tHl43N8I8oc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394A915EB6;
	Wed, 10 Apr 2013 19:36:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80E3615EB3; Wed, 10 Apr
 2013 19:36:44 +0000 (UTC)
In-Reply-To: <CAMP44s3VcUyQUNBw+19O-_nf9HPWt=2uc35Keh6Z0jcgFF=Y7A@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 10 Apr 2013 14:14:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9E9A03A-A215-11E2-9BFD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220736>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Apr 8, 2013 at 12:13 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> --- a/contrib/remote-helpers/git-remote-hg
>> +++ b/contrib/remote-helpers/git-remote-hg
>
>> @@ -731,6 +722,26 @@ def do_export(parser):
>>      if peer:
>>          parser.repo.push(peer, force=False)
>>
>> +    # handle bookmarks
>> +    for bmark, node in p_bmarks:
>> +        ref = 'refs/heads' + bmark
>
> This should be:
>
> ref = 'refs/heads/' + bmark
>
> Should I reroll?

I'd appreciate it if you can reroll the entire thing.  That way, I
do not have to keep careful track of which one can be reused and
which need to be replaced.

Thanks.
