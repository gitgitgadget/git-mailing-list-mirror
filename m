From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 01 Jun 2011 15:22:09 -0700
Message-ID: <7vipspfazy.fsf@alter.siamese.dyndns.org>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
 <20110601220518.GA32681@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRto0-00011s-Nx
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab1FAWWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:22:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1FAWWS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:22:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A10CC4777;
	Wed,  1 Jun 2011 18:24:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rE5R3BMOEy+83DxDwDzdw2pHJmU=; b=Ni1wQY
	kPk9IhBGiJpvWIg/yELCb3/c74dClOLOdytY9t5qNMqBTscMrIutLU2i6b5mVLq9
	S18Q738xvA4XfHmw7Yifq6BXhpaAYbfFWnbVQeyekQ6vT494EAFZaWiU5eSGhbYi
	tG2eYHXV5zv2jQF36RQKjNriSU41sZBbX4q7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RVWOP9fS9b5Nk8/nWL1a7I6i9KFxScct
	WDW2KIQXKOCMZjs2iNFv5HdbGIP3nReT1s+ESXrZO8F+QZIIaCsEoowAkHI/4Xdn
	nVffk+GIDZ8KrY5o1GvfOEYYr+4SjYwc7nlC9Kxomi0rE2jG8Z7UDzUiywWfXf9l
	DjfBVimwdMs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DE044774;
	Wed,  1 Jun 2011 18:24:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CAB0476C; Wed,  1 Jun 2011
 18:24:19 -0400 (EDT)
In-Reply-To: <20110601220518.GA32681@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Jun 2011 18:05:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E6F5AAC6-8C9D-11E0-932A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174908>

Jeff King <peff@peff.net> writes:

> We basically have two choices:
>
>   1. Fetch objects for HEAD on clone.
>
>   2. Don't checkout a detached HEAD if we don't have the object (or
>      possibly, don't checkout a detached HEAD at all; we already do
>      something similar for the case of a HEAD that points to a bogus
>      branch).
>
> I think (2) is more consistent with the refspec we set up, but (1) is
> probably more convenient to users (and better matches the case where the
> remote is on a detached HEAD that _does_ point to something we have).

Probably. As HEAD is usually visible via ls-remote exchange, the usual
security concern would not come into the picture even if we do (1), even
though it feels somewhat wrong to do.
