From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 04 Jan 2012 16:24:23 -0800
Message-ID: <7vk457ngi0.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org> <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Jan 05 01:24:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rib8A-0004jC-8F
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459Ab2AEAY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:24:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44597 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757414Ab2AEAYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:24:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0A2E6D0F;
	Wed,  4 Jan 2012 19:24:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tk2RAETEPeWJiTOO9Bl0hIFWd+w=; b=GcU+VC
	+OM4v1j8n7Ys2t3X+C4HkOEoJstFF9Gqw+27QvrZXkYqJSGRIXQrHlNuR/6rEsn0
	K9x7NoYP23+I2MgjT7vDCpdLq1btqAAZCdzWPOkFU8cnpi4qCmso/j0hqz2juhbZ
	5MT5A17M8AdzvrW9cgOXupBzbBhlJJtNOeKRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xut8Ib92jqfDGpkW92KH6QgMiNpbZMao
	UrVPjddrjdFkeXffvqvt6r81R6Ypqlc5WvTXjWJG1nT2jrJlkiUdA0cnR9x2Jy90
	YzxzEVp2/NSUk5962DFqqoaEcogUf4O7UqOWB4CbanaeZqBBGve0v5mhPq6QR/0z
	XyDJEo+EajM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E425F6D0E;
	Wed,  4 Jan 2012 19:24:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FFE46D0C; Wed,  4 Jan 2012
 19:24:24 -0500 (EST)
In-Reply-To: <20120105000713.GA24220@ecki.lan> (Clemens Buchacher's message
 of "Thu, 5 Jan 2012 01:07:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EC55440-3733-11E1-BE86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187958>

Clemens Buchacher <drizzd@aon.at> writes:

> On Wed, Jan 04, 2012 at 05:26:49PM -0500, Jeff King wrote:
>> 
>> Or is the problem the git wrapper itself, which doesn't kill its
>> subprocess when it dies (which IMHO is a bug which we might want to
>> fix)? In that case, couldn't we just use --pid-file to save the actual
>> daemon pid, and then kill using that?
>
> Or like this. Doesn't work with multiple children. I have yet to
> check if we have those anywhere.

Hmm, don't we have them in the same process group or something, though?
Can't we kill them as a whole?
