From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/31] refs.c: rename the transaction functions
Date: Fri, 16 May 2014 14:15:35 -0700
Message-ID: <xmqq38g9a0i0.fsf@gitster.dls.corp.google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-4-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 16 23:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlPTl-0001vU-9w
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 23:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454AbaEPVPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 17:15:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60557 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420AbaEPVPk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 17:15:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C36EE1480B;
	Fri, 16 May 2014 17:15:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGbxbliEP5mEuXvEbOKeFC2rTXM=; b=rNrB6V
	NSWqY9p1s6RtN9Va7l/CZfw7r+SIDZfD3FKFYcmesC8Nu3h4cvadd8XzaUTtXxU8
	1/928uHTU0NOcpw+EPnaNmwTLwB2FMpMEDzbdAFARWj0LmFZXGSLOTbEiCIup1Yr
	eB2chjP3x/0iWN0otUJW/jJOir8A9SdQreMNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oMmevlsHSyAWyeBizyAkacwO3vU2TEs/
	VLwXMypdyKJ0DcsIiT2n3ZEkwcs8Fdk4s4KdGLaP+CVrNy2WoaSWNsCZqSqjPSsB
	68Uw+S7k8GlW0clnwSV6Vu6C6L6AVcLm1Enx/IAp/SGRnnaG8uSQTbst2hANJlER
	T1KHMS2CWEc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAF041480A;
	Fri, 16 May 2014 17:15:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C3B3114806;
	Fri, 16 May 2014 17:15:36 -0400 (EDT)
In-Reply-To: <1400105610-21194-4-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Wed, 14 May 2014 15:13:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3978941C-DD3F-11E3-A306-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249417>

Ronnie Sahlberg <sahlberg@google.com> writes:

> Rename the transaction functions. Remove the leading ref_ from the names
> and append _sha1 to the names for functions that create/delete/update sha1
> refs.
> ...
> -		transaction = ref_transaction_begin();
> +		transaction = transaction_begin();

Why?  Do we forsee that there will never be other kinds of
transaction, and whenever we say a "transaction" that will be always
about updating the refs and nothing else?
