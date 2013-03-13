From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Rename conflicts in the index
Date: Wed, 13 Mar 2013 11:05:01 -0700
Message-ID: <7va9q72n1u.fsf@alter.siamese.dyndns.org>
References: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Edward Thomson <ethomson@microsoft.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 19:05:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFq3T-0005ox-7O
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 19:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933095Ab3CMSFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 14:05:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab3CMSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 14:05:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B03C5BC1D;
	Wed, 13 Mar 2013 14:05:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zZBKQQMAP4pirDAY16SBSDdK8MA=; b=mrnPAd
	phoFhhKq/ljfbMYoWeUrUUUC9iYmY8ClfN1periwdxGeiF+3Jg71mcl7kqnOrpti
	J29oh8/Qvmy0KrdYT8jSIZoQOM2X18EVn/4bP6mmlzKhGbeZUgbPNVLIN+U5Tpx+
	0RlOm5+Am8QbZhMhV6EfW0MMYosL8LXzQfQz0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tZ94U+horEM0RhYa1mivF/PQs0lLEtdz
	293VeHcyftaWqr/EIVULoyuTTOmmUGRa3cchUYIp29k/2SmtfGdDd8skmLPQjlQb
	cf5G80mW5YMb6TfWDMDi7mVMxdmbQYnrwo87IlktoX94pzJor2bWkDr2u/Azd0FT
	uM+JXjUk6Ts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5749BC1C;
	Wed, 13 Mar 2013 14:05:03 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27CA6BC1A; Wed, 13 Mar 2013
 14:05:03 -0400 (EDT)
In-Reply-To: <A54CE3E330039942B33B670D971F857403995D93@TK5EX14MBXC252.redmond.corp.microsoft.com> (Edward Thomson's message of "Wed, 13 Mar 2013 14:08:49 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 874684F8-8C08-11E2-A35F-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218081>

Edward Thomson <ethomson@microsoft.com> writes:

> I would propose that we store the data about the file in conflict as it
> occurred through the renames.  For example, in a rename 1->2 conflict where
> A was renamed to both B and C, you would have a single conflict entry
> containing the data for A, B and C.  This would allow us to provide more
> detailed information to the user - and allow them to (say) choose a single
> name to proceed with.
>
> Is this something that has value to core git as well?  Alternately, is
> there something particularly stupid about this proposal?

I do not offhand see anything particularly stupid; a new optional
index extension section CACHE_EXT_RENAME_CONFLICT might be a good
addition.

Is "one side moves A to B while the other side moves it to C" the
only case, or is it just an example?  Off the top of my head, "one
side moves A to x while the other side moves B to x/y" would also be
something we would want to know.  I am sure there are other cases
that need to be considered.

I do not think we can discuss the design at the concrete level until
the proposal spells out to cover all interesting cases in order for
implementations to agree on the common semantics.
