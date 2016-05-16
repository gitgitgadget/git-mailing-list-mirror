From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/9] connect: only match the host with core.gitProxy
Date: Mon, 16 May 2016 15:54:25 -0700
Message-ID: <xmqqinydzk9q.fsf@gitster.mtv.corp.google.com>
References: <20160516000740.19042-1-mh@glandium.org>
	<20160516000740.19042-3-mh@glandium.org>
	<xmqqvb2dzlee.fsf@gitster.mtv.corp.google.com>
	<20160516223639.GA16182@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, tboegi@web.de
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue May 17 00:54:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2RPG-0004bo-An
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbcEPWya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:54:30 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcEPWy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:54:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2249B1C706;
	Mon, 16 May 2016 18:54:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p6hunFw96nNcFvLMCVhMutfAJWE=; b=icRg2x
	y7ahOnwFG8Q/03vUMHBQKMXfjL2wZaU4dGFX8SteB/zB34ANZwNVYAL6dREmtdpz
	hD+kk7kb+VpCuawQh/2cJ9zJF8Rg6kWvlfx/EyMJKNB8bUYy3JDIJ9FXpyBk7M68
	vCWsLI2eMCrRL6EU2sr7s8TNMAcX+Q9rh+uZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qWofss0ITMyJ7m85KMiBS2QX2RCUFk2l
	wlfkaDTQK0Jjeau1nzR0jc+bl66JPxve4/R0d8OfIhlFYzUKAPC+gdp86wYaDZ6U
	8xM9M6coUKMG92XcQSPsouy+Mps6dB/yKfLvkHeQww9fS4CphGS5TMe8V68aa5uG
	FYoNmN4T7r4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1706A1C705;
	Mon, 16 May 2016 18:54:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FCEB1C704;
	Mon, 16 May 2016 18:54:27 -0400 (EDT)
In-Reply-To: <20160516223639.GA16182@glandium.org> (Mike Hommey's message of
	"Tue, 17 May 2016 07:36:39 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 246C2984-1BB9-11E6-958D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294814>

Mike Hommey <mh@glandium.org> writes:

> The gitProxy script gets the port passed. Why would you need different
> scripts for different ports if the port is passed as an argument? Also,
> if it's deliberate, it's widely undocumented.

Fair enough.

A user who has been working around thsi "oversight", would have
relied on her proxy configured with 'script for myhost.xz:9111' to
be called for git://myhost.xz:9111/path, right?  We'd need to
somehow let her know that her configuration will be broken, but as
long as we can find a way to do so to ease the transition, I think
the updated "if you want to use a different behaviour depending on
port, use the port parameter" is a lot more sensible behaviour than
what we had traditionally.
