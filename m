From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: allow shallow fetching from a read-only repository
Date: Wed, 05 Mar 2014 11:50:41 -0800
Message-ID: <xmqqha7ch1bi.fsf@gitster.dls.corp.google.com>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
	<1393936205-15953-1-git-send-email-pclouds@gmail.com>
	<xmqqr46hltrl.fsf@gitster.dls.corp.google.com>
	<20140305124304.GA27214@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:51:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLHqB-00007A-SD
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbaCETuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:50:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36564 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221AbaCETup (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:50:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D2166F226;
	Wed,  5 Mar 2014 14:50:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zVSolJGpjL2/4kPAsmApg90ZYXg=; b=J26L9o
	doqx1XrXkwrT+5xnnMG0FrAZdjyBYOkvGqEF8Tllgl1QkcvSsp/vaDkdLuCMWDt9
	oPS02r/neO3Duw3urTFbSOm6CCdpAVvnMscyukITNQCeyi9P2cVBCL9dqWrsT27R
	58o0iKIdJdIF4FvtqKf6hwUJkNGQ8uKfv3B2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u1lyl9rwBtb6C8CFutDE/fXleiBzTR2C
	3E8LWIYiT3egBT8J/pCIhRWgvBpIv+B9hetCZVpjRlXq3m+c8YeICPM8u6zkI6Bh
	P8tmVW7GfQYzuTD2rIvtvbVyp93PmcQvxpvN3IxCKe16bL/dFm6eBoT7wxR9rdZz
	V6ZTHkAYNaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 826CC6F225;
	Wed,  5 Mar 2014 14:50:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A0AEF6F221;
	Wed,  5 Mar 2014 14:50:43 -0500 (EST)
In-Reply-To: <20140305124304.GA27214@lanh> (Duy Nguyen's message of "Wed, 5
	Mar 2014 19:43:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6FFA45AE-A49F-11E3-9441-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243473>

Duy Nguyen <pclouds@gmail.com> writes:

> If only there is a way to pass this info without a temporary
> file. Multiplexing it to pack-objects' stdin should work. It may be
> ugly, but it's probably the safest way.
>
> Wait it does not look that ugly. We can feed "--shallow <SHA1>" lines
> before sending want/have/edge objects. Something like this seems to
> work (just ran a few shallow-related tests, not the whole test suite)

Sounds like it is a much better approach to the issue.
