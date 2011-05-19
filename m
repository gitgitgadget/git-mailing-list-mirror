From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] add Android support
Date: Wed, 18 May 2011 23:18:00 -0700
Message-ID: <7vaaej9pt3.fsf@alter.siamese.dyndns.org>
References: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 08:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMwYq-0004Rt-A6
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499Ab1ESGSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:18:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932267Ab1ESGSI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:18:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6BE265F51;
	Thu, 19 May 2011 02:20:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8yRbz/GACO4qAMI8W78GBg2smu4=; b=NjenJP
	0vdqZaQbzwwySUOC8AD4C4nDN/GOd6sxCT1oUG9QWb3aJI8GcukwM4/5qBPj76k1
	UksJf0m7Wh/me8w2zGrctIcuBLQ33Z5ja2MBTQTLmNyGfIOy8IHeaGGVguwsQE0M
	pSX8DdZzUrkj3P/uNkHsuJxPcutNkDcxbPdjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m4JhABLfpsJ/P0FO+ewkNTLYuzzpZPq+
	ZG5a/gFyiwJh3fgtn9B50/YE0rixCawJQtuL2St6YMLAQGnZEn38Zqy2mjWVaSMC
	k4yh8N81gllqbN07tox3GrIJJ3/2lNeo6sRU3V+PyW4egi8qx2fMoFraLnNcwb47
	tu6g06Ytmg0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 482E65F50;
	Thu, 19 May 2011 02:20:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 302B75F4F; Thu, 19 May 2011
 02:20:09 -0400 (EDT)
In-Reply-To: <B22B44EF-0AFB-44E3-93E3-61FA730431B9@gieschke.de> (Rafael
 Gieschke's message of "Tue, 17 May 2011 01:23:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E2E765E-81E0-11E0-8F20-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173930>

Rafael Gieschke <rafael@gieschke.de> writes:

> Currently, it is not possible to compile git for Android as the C library (Bionic)
> is neither providing getpass nor pw_gecos in struct passwd. Therefore,

Whoa, whoa, wait. That's doing too many things in one patch.

I am still debating myself if this rather huge patch is justifiable, or an
elaborate joke/hoax. Does anybody seriously want to run git on his phone,
tablet or set-top box?

I'd suggest splitting it into three patch series, and justify them
separately.

 (1) Support NO_GECOS_IN_PWENT (Makefile, ident.c);
 (2) Support NO_GETPASS (Makefile, compat/getpass.c, git-compat-util.h); and
 (3) Add uname_S = Android (Makefile).

The first two would become much easier to justify if presented that
way. At least you won't hear from anybody "we don't want that much code to
not to run git on a phone!", as it is not entirely implausible to imagine
environments without support for one or both of these two facilities.

I wonder if you want to emply the rename trick similar to the one used for
hstrerror/githstrerror you can see in the git-compat-util.h header file in
the second step, though.

Thanks.
