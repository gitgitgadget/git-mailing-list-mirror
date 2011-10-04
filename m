From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's
 keychain
Date: Tue, 04 Oct 2011 10:13:33 -0700
Message-ID: <7v39f8d6iq.fsf@alter.siamese.dyndns.org>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com>
 <20110929075627.GB14022@sigill.intra.peff.net>
 <CAG+J_DwntGc+j3duCVqsnoJGV18FqnwXJ99C1XqKope_zbGHAA@mail.gmail.com>
 <20110930221111.GB9384@sigill.intra.peff.net>
 <CAG+J_Dww1yOeq1LHQYMiObPKqrWbk4t8Hn=G9WpYWXFBbHiuhQ@mail.gmail.com>
 <20111003105908.GF16078@sigill.intra.peff.net>
 <CAG+J_DxAaw=vVENFUP5Mq9+inuDEpn_3Le_b7sO97wRUW6aFSA@mail.gmail.com>
 <20111004101610.GA11236@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 19:13:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB8Yn-0002Hh-3Z
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 19:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865Ab1JDRNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 13:13:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774Ab1JDRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 13:13:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5922E46B9;
	Tue,  4 Oct 2011 13:13:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BPJfUVlU6QdRvPJbEPtcNnuYO7M=; b=txP8pu
	BxUXYvjdJw52YzozV25SPnaYa3fi8A1cQcxjw6pOIekwo0XMxYCjjOGmOWjx0auA
	HzLWxYKAxNitdi3Pg0y/e036aFx/rk1eSIAJNoEtSYMqX6M9lOShaysZeEK/A1KQ
	MZQXd/GrBgqA5QNYERWAd0kawo7yxjslqFeeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0h2Yf4/gZE5Fav6W7E8k8VJ5IFphmSL
	z8ADRDsVExqbe06iO16akiQPfZEMxCWKnZsHPFsTcv7bI/w3JZyKTOYP+RdjpG53
	ofi4p/A/WqpNTDZpAndm7s9QKao15qwD1oDirExdtDTHjBzkZ3ECJvLHV5JppJTq
	K+Pjj+S9lWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E61146B6;
	Tue,  4 Oct 2011 13:13:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A7C4D46B5; Tue,  4 Oct 2011
 13:13:34 -0400 (EDT)
In-Reply-To: <20111004101610.GA11236@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 4 Oct 2011 06:16:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 311E7DF6-EEAC-11E0-AC73-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182778>

Now, I would like to start moving the core part of the credential helper
series to 'master'. Could people summarize what the current status of
various moving parts are?

Here is an example of write-up, based on my understanding (I said it
should be pretty-much ready, but please correct me if I am mistaken).

 - The core part have seen some updates while it was cooking in 'next',
   with help from inputs by credential plug-in authors. The API and the
   sample implementation should be stable enough that it can be given to
   people who follow 'master' perhaps with 'experimental, minor details
   still subject to change' label attached.

I'd like to see similar write-ups for plug-ins from people who were
involved in the topic, at least on the following:

 - Mac OS X keychain?

 - Gnome?

 - KDE?

 - Windows?

 - Others?

Thanks.
