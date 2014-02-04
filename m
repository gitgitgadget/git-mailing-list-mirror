From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 04 Feb 2014 14:54:28 -0800
Message-ID: <xmqq61ou7al7.fsf@gitster.dls.corp.google.com>
References: <20140117041430.GB19551@sigill.intra.peff.net>
	<20140117042153.GB23443@sigill.intra.peff.net>
	<xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
	<20140121054927.GD5878@sigill.intra.peff.net>
	<xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
	<20140204221220.GA5457@sigill.intra.peff.net>
	<xmqqiosu7ca2.fsf@gitster.dls.corp.google.com>
	<20140204222507.GA6031@sigill.intra.peff.net>
	<52F16D77.2000604@rawbw.com>
	<20140204224803.GB6317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yuri <yuri@rawbw.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:54:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAotC-0001w6-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:54:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934990AbaBDWyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:54:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933232AbaBDWyc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:54:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC719679E5;
	Tue,  4 Feb 2014 17:54:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ghHZ1eTJLA0V4dv/zS5B6TVFfg=; b=fAWX0+
	QXeu+TjGCGl98xF7hscoxtORZezPVtgVDLtyZ5NlkxybztCOEcaWquINBdPNm0G6
	Gm5MaoWMg3RzfYZKz8s0F8i3QFBwsrjtgjnNZMKS2xnArjmuoTcp2abdKlhlR++Q
	rwjuPk7aVEFDqeqLF3wbS08PVfg2Nb0r6Fyiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFbIE/rwOGMmzF7Zjr8IfgoLzqIjNVNd
	++PcnvZ6vD5baxSFALSa+I8boSV/9HAttbIjAznDaV0Ptuttjhv6YPz1I0MKsdED
	o+fA23JgNNvhYnHYejapnGESwxDUihgAK/neNcfuahHxUraVht+99EdwHTwr8AgZ
	680GLHXw+HE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF4E1679E4;
	Tue,  4 Feb 2014 17:54:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16BF5679E3;
	Tue,  4 Feb 2014 17:54:31 -0500 (EST)
In-Reply-To: <20140204224803.GB6317@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Feb 2014 17:48:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EDC45A0-8DEF-11E3-89B7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241583>

Jeff King <peff@peff.net> writes:

> The safest thing would be to turn off auto-color when LESS (or any of
> the pager environment variables) is set at all (and not worry about
> whether "R" is set; only know that _we_ are not setting it, so we cannot
> count on it). But that would potentially inconvenience a lot of people
> whose default color would suddenly go away.

That is just as safe as disabling color for everybody, isn't it?
Half of existing users have LESS with R, and the other half do not
have LESS at all.  The former will be harmed, the latter will not
see any difference.

Oh, and then new users who do not know R for LESS will not even
notice that Git could support coloured output.  Those among them who
read manpages and find --color option will then see ESC[33m in their
output and we are back to where we started X-<.

So I think we are already at the safest place.  Those who see ESC[33m
will know they are missing some good stuff and can ask around, which
is better than doing anything else at this point.

I think that is the same conclusion as yours, "there is nothing to
be done."
