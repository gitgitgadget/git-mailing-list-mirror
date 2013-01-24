From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 21:04:12 -0800
Message-ID: <7vip6ndveb.fsf@alter.siamese.dyndns.org>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
 <20130123211237.GR7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 24 06:04:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyEzM-0002NN-N6
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 06:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736Ab3AXFEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 00:04:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3AXFEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 00:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30845C346;
	Thu, 24 Jan 2013 00:04:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nfqLX+visLfj/Kg2lfY7oJgbQvg=; b=ZdIUjl
	Acs6ToFMh9nPMBc9rZgrp7Y2ZzeF/NQJdF4TOnbG5mW66uma8by4wlvaJX9hatA7
	vDQAfgjAd01M4uzHv7RzEcPFVAvYPV9B/EYHeWCNoFAELYIuX1gMTWPs8Sif4T3S
	KOEb/ThV2nno71UVOMJSV2YzM+LpftJCEmszI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B4qloAGi2woqdN/FX53drlOudBJ7WZnH
	u6ZYk2SiQw4B2HvMcPPuSJafxHksgw055/HWYy0IO+ix3Ib+4Q1rHMKKV0iEBebz
	HpawNqw9wV/wee04/+IK85Mx4VgPMRUHGXyfIym3xyHlqrh6PP1NylfTuR7YPj1/
	jsxvWiEfMGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 251D4C345;
	Thu, 24 Jan 2013 00:04:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8189EC342; Thu, 24 Jan 2013
 00:04:13 -0500 (EST)
In-Reply-To: <20130123211237.GR7498@serenity.lan> (John Keeping's message of
 "Wed, 23 Jan 2013 21:12:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7EE40466-65E3-11E2-B7D1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214391>

John Keeping <john@keeping.me.uk> writes:

>> Is it "it does not work yet with cvsps3", or "it will not ever work
>> with cvsps3"?  The impression I am getting is that it is the latter.
>
> The existing script (git-cvsimport.perl) won't ever work with cvsps-3
> since features it relies on have been removed.

I think you knew I already knew that.  I was hoping that cvsimport-3
that has multiple backend support may be able to start working by
reading the fast-import stream cvsps3 produces, once you sort out
the "last exported timestamp" issue out.  As far as the end users
are concerned, they would still be using cvsimport, even though the
wrapper may redirect the invocation to cvsimport-3.

In any case, something like that will not happen in the near term,
if ever, so "cvsimport will not work if you only have cvsps3" is a
good thing to add to its documentation.

Care to roll a proper patch with a log message?  I'll discard the
topic for now and replace it with your documentation update.

>> Also, should we have a suggestion to people who are *not* performing
>> a one-shot import, i.e. doing incremental or bidirectional?
>
> As far as I know cvsps is the only backend that attempts to support
> partial exports but the support for that in its fast-export mode needs
> work before I would consider it reliable.  For now the existing
> git-cvsimport is the best option I'm aware of.

Thanks.
