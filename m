From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Thu, 07 Feb 2013 10:25:48 -0800
Message-ID: <7vlib07zgz.fsf@alter.siamese.dyndns.org>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
 <20130207001635.GA29318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 19:26:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3WAp-0002as-2s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 19:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045Ab3BGSZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 13:25:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758690Ab3BGSZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 13:25:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8CF3C8DB;
	Thu,  7 Feb 2013 13:25:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DbLiLxC+R8o8OQC8ljUOnpGOMTM=; b=RkHh8x
	xcxRJlpeBiIAdp51jTCMKKyjsreDrx4A0oignPZYAGgDiShsrmwMylIqrWt5tGCL
	XOBRBi4OTL7u6By9brH8tVrO4UHVLshdRBEANLNXpYgFqk07uzxQLRi7gZznAw+p
	RY2QwYF+NErPE6pQ9A0ARoxtO4QTYhCCKWtCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=olocC/y68tfi81hDE1wKNqvdiZ4OsxK1
	btpQyA9NYX12w/xLCAIz4xcp96ZAhFFNsu0GdH+2dzuaIjAHeyqjrl9ln0K41BjD
	ZKK6my0CHJTw8PB02HRfAsgRWCKDzXe3sufRjRScNMhSnM9SAGt8H0ZH43EU2cnI
	+vmjQMLEItc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AD78C8D8;
	Thu,  7 Feb 2013 13:25:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0AD96C8CF; Thu,  7 Feb 2013
 13:25:49 -0500 (EST)
In-Reply-To: <20130207001635.GA29318@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 19:16:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC7103AC-7153-11E2-B285-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215707>

Jeff King <peff@peff.net> writes:

> If the new client can handle the old-style server's response, then the
> server can start blasting out refs (optionally after a timeout) and stop
> when the client interrupts with "hey, wait, I can speak the new
> protocol". The server just has to include "you can interrupt me" in its
> capability advertisement (obviously it would have to send out at least
> the first ref with the capabilities before the timeout).

Yeah, I would prefer people to come up with a way to share the port
and autodetect.  It is *not* a requirement for the updated server to
run on a separate port at all.
