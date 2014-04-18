From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Fri, 18 Apr 2014 16:36:20 -0700
Message-ID: <xmqq7g6mb47f.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
	<CAB=NE6VvDrMQ4ybF10MpXM-2672OdUTC_Rp2mdO3a5fuo1-H1Q@mail.gmail.com>
	<xmqqfvlbga4r.fsf@gitster.dls.corp.google.com>
	<CAB=NE6Vt8etieyR256Hxb=q6zMo7UAO2Zkm5900NrE+4=-3eXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
	Andreas Schwab <schwab@suse.de>, Jan Kara <jack@suse.cz>,
	Jeff King <peff@peff.net>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 01:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbIKw-0002uz-FS
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 01:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbaDRXg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 19:36:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37814 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691AbaDRXgY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 19:36:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB4417CC3B;
	Fri, 18 Apr 2014 19:36:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2XtKlqmYX/gUmx8GKIxSTLYxEUY=; b=JjeCNr
	qdcxEKrvD/Z+Xbv0/X/AvKDBNaJu/RAtMhdw/KAjrKVO8dyU6NdiuX5TV6rmtkCJ
	EGDxD0fqeYFgX2SOE/HUPUTm6FQh6QGzD+2w9vIlTvf4A8PmSGJGX46IdnUqZXuz
	hYj643xO/ncG1j5aKP75TpgU01a0YsfvWaysk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JVnl92J7PeBUUC9OH87WpWRWQRBHX8Nl
	XlXMSOpHt2rhBCmwZAR93xA2Atc9GJdygoPZaorsBs/IunWpmUeeO52ZhfIDcVbv
	tp25ibVlHrxCoGvs9C1eSiEO4bDnzA7kmSOLcy3n1t+H6ZskKoRb7qxVH2xW2Ucw
	RNk7+RqapBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A84957CC3A;
	Fri, 18 Apr 2014 19:36:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D16207CC39;
	Fri, 18 Apr 2014 19:36:21 -0400 (EDT)
In-Reply-To: <CAB=NE6Vt8etieyR256Hxb=q6zMo7UAO2Zkm5900NrE+4=-3eXA@mail.gmail.com>
	(Luis R. Rodriguez's message of "Fri, 18 Apr 2014 16:17:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F90A7DE-C752-11E3-AF52-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246488>

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:

> I think ultimately this reveals that given that tags *can* be
> arbitrary and subjective,...

Yes; see the part at the bottom.

>> Commit A can be described in terms of both v3.4 and v9.0,
>
> And in the real example case, why *would* c5905afb' be be described in
> terms of v3.5 instead of v3.4 ?

I am not interested in graphing that particular history between v3.4
and v3.5 myself.  If you are interested, I already gave you enough
information on how to figure that out.

>>     - find candidate tags that can be used to "describe --contains"
>>       the commit A, yielding v3.4, v3.5 (not shown), and v9.0;
>
>>     - among the candidate tags, cull the ones that contain another
>>       candidate tag, rejecting v3.5 (not shown) and v9.0;
>
>>     - among the surviving tags, pick the closest.
>>
>> Hmm?
>
> Sounds good to me!

Not so fast ;-)

My other message to Peff in response to his another example has an
updated position on this.  "Reject candidates that can reach other
candidates" is universally correct, but after that point, there are
at least three but probably more options that suit preference of
different people and project to break ties:

 - Your case that started this thread may want to favor v3.4 if only
   because that v3.4 _sounds_ smaller than v4.0 (in Peff's example),
   even when v3.4 and v4.0 do not have ancestry relationship.

 - The "closest" we have had is a heuristic to produce a result that
   is textually shorter.

 - And as I alluded to, "which one has the earliest timestamp?", is
   another valid question to ask.

And there may be more to appear.  A new command line option (and
possibly a new configuration) to choose from these three (and more
heuristics that will be added later) would be necessary.
