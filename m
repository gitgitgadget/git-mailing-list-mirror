From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix notes handling in rev-list
Date: Wed, 18 Jul 2012 15:39:34 -0700
Message-ID: <7vhat4wv6h.fsf@alter.siamese.dyndns.org>
References: <20120325005504.GA27651@sigill.intra.peff.net>
 <1342463409-6919-1-git-send-email-jukka.lehtniemi@gmail.com>
 <20120717034640.GB20945@sigill.intra.peff.net>
 <7vvchnx7tc.fsf@alter.siamese.dyndns.org>
 <20120718072104.GB12942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jukka Lehtniemi <jukka.lehtniemi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 00:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrcuM-0003H2-25
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 00:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab2GRWjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 18:39:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58112 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab2GRWjo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 18:39:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AD9A81E0;
	Wed, 18 Jul 2012 18:39:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6SbQ4mBdS5ZhC6DIAGXkOAuhLxw=; b=PAeJpq
	TANs3fhhEKMHP9JbCOXDTRMeulo0nNjhK05E261MEPgiUvbj+8H53CsFqcvFuTE3
	XRk7dKgJfHeEWSBDZJjQyKp34Ra2MW6mQd3O3PrzwtisNCKadjWVMGm2uqfoHdQq
	uu23c1VuRL4LGV1GgqfASsfmPU15HDpKICvgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VdgM/aOVM/zXnOIqsdOg1CT2JrCu6r7p
	eNIGcgwwb4XS5/KhqMNONKHvjXqLNXT3i7J2cXBLHkp4K89k3DXi+AwQhGsEoPI9
	IYdfTKbTU5d+H4SJfMCUj1sL0w+Kgn9mkpSI6dvsRUxj5rrunD1V+ZKJ6InRssvb
	oZXuULFui2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B2581DF;
	Wed, 18 Jul 2012 18:39:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88CCF81DE; Wed, 18 Jul 2012
 18:39:35 -0400 (EDT)
In-Reply-To: <20120718072104.GB12942@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 18 Jul 2012 03:21:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 73466B34-D129-11E1-814F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201705>

Jeff King <peff@peff.net> writes:

> So leaving aside the --graph issues, we would need to decide what to
> show in the non-graph case. And I think your suggestion is good; there
> is no real need to dereference the blob (if you want that, you can turn
> on the pretty-printer).
>
> I'm just not sure what the output should be. I guess:
>
>   <commit_sha1> <notes sha1s>
>
> is probably the most sensible (it's sort of like --parents). And that
> solves the --graph issue, too, since it continues to take only a single
> line.

Surely.  "rev-list --parents --notes" would still be usable that
way, as a reader that requests such a combination is prepared to
tell commits (i.e. parents) and blobs (i.e. notes) apart.
