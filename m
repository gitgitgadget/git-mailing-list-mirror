From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging limitations after directory renames -- interesting test
 repo
Date: Fri, 18 Feb 2011 16:44:24 -0800
Message-ID: <7vwrkwn993.fsf@alter.siamese.dyndns.org>
References: <AANLkTimsQmOLDENX27YqpicBeFFZrfgEAsLvFiJqoV7w@mail.gmail.com>
 <20110218222151.GB4258@sigill.intra.peff.net>
 <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 01:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqawH-000095-Nx
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 01:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab1BSAoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 19:44:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab1BSAoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 19:44:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5223436D8;
	Fri, 18 Feb 2011 19:45:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OXrl8sPYfxQcbWIo5SwpS37tHvs=; b=h8BIhH
	doqhexwYhIMnJJXzKTcDVb6DXCjYqhiTwC41ZflSemJeRG1PCk/6Lj+XRhGqe/8K
	yJWJJDn7VwBFN/poORsm46d0KLVDoslKpVnF5pW4F3KIfKAifydUWffyFarLkBfB
	AHBr+2hS7b451Fgo4MDxTykwmOluT4kvKZXx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GV+Pm4kYDwXl6R+zNGKgwHoCXNi4Keeg
	zk8KbMCFrQjMzZx6SnWg6SUfHRBa8EFDUdBgqcPVUglIV1p5zGEFAGw+NrCyXoXQ
	OcTBf/jjdDgAjD4kfGThYtpofVDTq+m7hSS/I/zzgIhucSAGiYCuT1QWX0CnIpOo
	r/zXuhRkI/w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1196236D7;
	Fri, 18 Feb 2011 19:45:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3089936D3; Fri, 18 Feb 2011
 19:45:34 -0500 (EST)
In-Reply-To: <AANLkTimKp+Z==QXJg2Bagot+Df4REeANuxwVi7bpPCXr@mail.gmail.com>
 (Linus Torvalds's message of "Fri\, 18 Feb 2011 15\:27\:36 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 937DC7B6-3BC1-11E0-B137-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167238>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ouch. I thought that commit wasn't _supposed_ to make any difference.
> If it does, then that sounds like a bad bug. Junio?

It already has been reverted.

I haven't really looked at the issue yet, but for one thing it seemed to
break synthesis of the virtual common tree inside merge-recursive for some
reason, and ends up producing a lot more diffs than necessary between the
common and the tips being merged.
