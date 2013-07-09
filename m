X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 09 Jul 2013 13:25:14 -0700
Message-ID: <7vli5fv5ud.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<51DC6B37.9030108@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 9 Jul 2013 20:25:23 +0000 (UTC)
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vX9pRZACK60keC4G27/H1LuTs+c=; b=p3LdOC
	ufv2AwL6k2rfsX9mwEj1NiIGT24/+4rHQ/6ODhGDrVlbkVrPDgijOWVUyIEMWKD2
	RQUM6KZVSyJ3bNYK8BmZnawqFKNHDWfzodgr7mYeXXgLujlor0uH/q7eUIdT5b6V
	LEEmynNHzTvOsqdG6bZHsQMO7sKUZo1yCrPcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiVc5iKhAcwOO8qzxXMSGvAfa+iSH2lg
	YVuhfDZmKwL/Bpa6PEIxEppsv3dGRO9aLBri5MgIR5xrOIuAi/HKIV1uPBidpTdM
	PR/wOr42HVOKMXrc4NA/qi01CTGeIe6PA3JPkxf3E86wopu9Xw9ewtay6vZ+1ClT
	HaOcjYKdS2c=
In-Reply-To: <51DC6B37.9030108@alum.mit.edu> (Michael Haggerty's message of
	"Tue, 09 Jul 2013 21:57:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA58795E-E8D5-11E2-8A15-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230000>
Received: from vger.kernel.org ([209.132.180.67]) by plane.gmane.org with
 esmtp (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id
 1UweTS-0001Th-BO for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 22:25:22
 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753270Ab3GIUZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013
 16:25:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47941 "EHLO
 smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1753049Ab3GIUZR (ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013
 16:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id 837652F1C9; Tue,  9 Jul 2013
 20:25:16 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79E5E2F1C7; Tue,  9 Jul 2013
 20:25:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C40C72F1C6; Tue,  9 Jul
 2013 20:25:15 +0000 (UTC)
Sender: git-owner@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It would be more general to support "follow the second match to /A/"
> *independent* of whether the first match is also followed.  I think your
> proposal only allows the second to be followed if the first is also
> followed.  Therefore it seems to me that your wish is to add a
> side-effect to one feature so that you can use it to obtain a simulacrum
> of a second feature, instead of building the second feature directly.
>
> Perhaps allow <start> and <end> to be a sequence of forms like
>
> /A//A/,+20

Remember "A" is just a placeholder and in real life it would be more
than one character.  It is just as annoying as hell you have to type
it again.

I am not saying that a mode that resets the "start searching from
here" pointer to the beginning of the file is useless.  For example,
I would not mind typing a special character, e.g.

    -L <begin1>,<end1> -L !<begin2>,<end2>

that resets the search pointer to the beginning, for a rare case
where I want the search for <begin2> to restart at the top.

But the thing is, the default matters.  And it is far more common,
at least to me, when I want to say "from here to there, and then
from here to there", to expect the second "from here" would be below
the first one I already specified, while I am looking at the current
state of a single file from top to bottom and notice two places I am
interested in.

> /A/+20,/B/
>
>     Start 20 lines after the first match of /A/ until the subsequent
> match of /B/

Yes, I think -L "/^{/-4,/^}/" would be a nice thing to have, but I
think it is orthogonal to the issue of "where the search for /^{/
