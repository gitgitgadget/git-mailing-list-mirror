From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] do not overwrite untracked symlinks
Date: Tue, 22 Feb 2011 12:01:48 -0800
Message-ID: <7vzkpnbzyr.fsf@alter.siamese.dyndns.org>
References: <201102022025.06140.j6t@kdbg.org>
 <7v7hdixkys.fsf@alter.siamese.dyndns.org> <201102022324.22123.j6t@kdbg.org>
 <201102051918.44848.j6t@kdbg.org> <20110205183351.GA25717@localhost>
 <20110220121343.GA21514@localhost> <7vaahpluy9.fsf@alter.siamese.dyndns.org>
 <20110221194623.GA31181@localhost> <7v62scftjl.fsf@alter.siamese.dyndns.org>
 <20110222192632.GB4881@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Feb 22 21:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PryR5-0008HW-8T
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 21:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab1BVUCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 15:02:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64876 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab1BVUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 15:01:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2EC9C376B;
	Tue, 22 Feb 2011 15:03:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z4TUYSYic1HlEpePuLrvK8BTtQ8=; b=NHIOkE
	5c75mhNDNN964yy6xMwq1vTK8Znd1wUG+K1A36wrDdKqDr7FlyLo2kzNWE6vu0vV
	op4+sY3GVzCNb1Gh17wXW5BQi0i1hwVNa42/UjZNMhUV9AbAP+SaZ5pqgAbA9Gd6
	NK5O4l+vR2NlV172RNtP4yaqbo9msQ9EE+Wys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZoW9+RnW8Gdm0QdMrNOivx8BK3LWCWXe
	aNLG9N60e7Oiy6beHjzhOFp4HvUYadXC9VZy0QYpOsJ1EKPbeAJNgNCPLuC3Fw/K
	hNRUC/nujF/f2qjOI37e6ueUz0xkuaPAy7wYxmr/eWV8cRloaWoECJ/6WBhXExWF
	y4bl+GRKfcg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9AA7376A;
	Tue, 22 Feb 2011 15:03:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5FD513764; Tue, 22 Feb 2011
 15:03:00 -0500 (EST)
In-Reply-To: <20110222192632.GB4881@localhost> (Clemens Buchacher's message
 of "Tue\, 22 Feb 2011 20\:26\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C31087DE-3EBE-11E0-9263-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167581>

Clemens Buchacher <drizzd@aon.at> writes:

> I strongly feel that we should separate the merge process into two
> steps.
>
>  - First, do everything in the index, ignoring the work tree.
>
>  - Second, checkout the index to the work tree while making sure no
>    changes or untracked files get overwritten.

Yes, I think most people who are familiar with the internals agreed on
this long time ago.

> ... But I can't
> get myself to feel good about fixing the function name, but not the
> function.

I think I said what I wanted to say badly.

I agree that the code structure is suboptimal; the badly named function is
just a manifestation of the fact that the abstraction used in the
codepaths involved is not a good one, I think.
