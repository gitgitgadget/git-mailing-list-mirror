From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] Multiple simultaneously locked ref updates
Date: Tue, 10 Sep 2013 09:30:29 -0700
Message-ID: <xmqqob80zlju.fsf@gitster.dls.corp.google.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:30:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQpt-0006zQ-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab3IJQah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41591 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203Ab3IJQah (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:30:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C59A4019A;
	Tue, 10 Sep 2013 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFB6IzwetmO963iSSUmTCqsi3ow=; b=X4w83V
	tiXjjPGopoBpTuNXPDmvT/aB+dikR12zTbW6sWexgLxlJX/t2ztoOegjYCSkKBWe
	AKu5pkmhnjW8kKGmO/SCI37WRjeEPlCKYJLvQ2k9BPklTQ0N0M2NoPiAOICCgLXD
	ryxcrvguljJqoHeT5e8B2v6Cda+ksyVZJkZ88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G86o31N/48y98lihE1j6f1DtCy8t7Iad
	K1b8YnFfzIWgqpLcXkqfme8Lq6PvB0v2CnmqG3bYKPeFpLxcIWkL9wGazPZilg6k
	2jDkXNm04hLFRbEKOwZlXlZOW8qyrQo556Wa3/E8ghpg+nZdZ04bMY1dVCSujopC
	XfogdF/hMXA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B177140197;
	Tue, 10 Sep 2013 16:30:34 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAC664017D;
	Tue, 10 Sep 2013 16:30:31 +0000 (UTC)
In-Reply-To: <cover.1378773895.git.brad.king@kitware.com> (Brad King's message
	of "Mon, 9 Sep 2013 20:57:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4FFCA682-1A36-11E3-8D15-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234441>

Brad King <brad.king@kitware.com> writes:

> Updates since the previous revision of the series:
>
> * The entire series was rebased on master at bb80ee09; it was
>   previously based on v1.8.4.
>
> * A conflict in refs.c with 47a59185 was resolved by preserving
>   the elimination of find_ref_by_name while adding our new content.
>
> * A conflict in builtin/update-ref.c with d5d09d47 (Replace deprecated
>   OPT_BOOLEAN by OPT_BOOL, 2013-08-03) was resolved by integrating
>   both changes.  The new options added in patch 7 now use OPT_BOOL.

I just test-applied these on top of bb80ee09 (Update draft release
notes to 1.8.5 for the second batch of topics, 2013-09-09), and
compared the result with the result of merging the tip of the
previous round 511910e1 (update-ref: add test cases covering --stdin
signature, 2013-09-09) with bb80ee09, and they more-or-less match
(the order of options[] array elements may differ in
update-index.c), which validates that existing merge conflict
resolution matches your expectation.

Thanks.  I am not sure if I should rewind and rebuild the series
with these patches, though.  This is a new feature and does not have
to be merged to 'maint', so rebasing is perfectly fine, but it is
not strictly necessary, either.
