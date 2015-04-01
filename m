From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git status --amend
Date: Wed, 01 Apr 2015 10:16:22 -0700
Message-ID: <xmqqlhibn509.fsf@gitster.dls.corp.google.com>
References: <551AB64F.4030400@cs-ware.de> <20150331180414.GB19206@peff.net>
	<xmqqvbhhqal6.fsf@gitster.dls.corp.google.com>
	<20150401084230.GA12282@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Sven Strickroth <sven@cs-ware.de>,
	git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdMFi-00088V-F8
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 19:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbbDARQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 13:16:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751158AbbDARQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 13:16:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B40BA42018;
	Wed,  1 Apr 2015 13:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=35ihLyf02VaIJXsDHtw7wUiBhSE=; b=JCJva4
	FZ1Iw4m1/CQaqQ9ElffobbBzbM11NZkBWiDFAVPF7dVquIshcuQQfi3pysyUfOcj
	pk+IfXTRBufy0IqnwacGIGjHKKEYTm4BqYN8EMPGscCmE3gUHadP7B0YJ7niG7Cv
	qJMlz1y6lq6oFSi68IsgFjJBzAgrCrIY9VxYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fLkKcbOANACPn+O4wA+jPYaFv9nt89Fo
	BklwhdGXqbvS0eEG2K8pHOAZajXGuL+d8DrSsuKCWE6/Dg737vQSZoBgO3vqRyfs
	Y4duOhD6HV6ZsTXFfLC6J+LesM3F9W140IaSvKiqmKXTQXBD5ZenHPZ83ZNEdBNV
	r2L1DkwyKkA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB11B42017;
	Wed,  1 Apr 2015 13:16:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 336F342016;
	Wed,  1 Apr 2015 13:16:24 -0400 (EDT)
In-Reply-To: <20150401084230.GA12282@gmail.com> (David Aguilar's message of
	"Wed, 1 Apr 2015 01:43:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2D9B132-D892-11E4-B1C5-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266612>

David Aguilar <davvid@gmail.com> writes:

> Would generalizing "status" to have a more gittish syntax make
> you feel less torn?

One of my early draft responses included a one whose punch line was
"Why limit the comparison to HEAD and HEAD^ but no other point of
reference?"

But I discarded it as a useless suggestion before writing it down,
primarily because I couldn't come up with an explanation _why_ being
able to say "git status --relative-to=next Makefile" is useful when
on the 'master' branch.

Surely, I may have changes in the Makefile relative to my index
because I am preparing for the next rc release, and the Makefile in
the index may be different from that of the 'next' branch because I
am on my 'master' branch.  The potential output can be "explained"
in such a mechanical sense (e.g. "we generated the output this
way").

But I do not see an easy-to-understand explanation of the _meaning_
of the output, i.e. "What does it mean that the working tree file
has been modified since the checkout and the index is different
relative to that other branch?  How does that information help me
after I learn it?  What would I do differently with that information
at hand?"

Compared to that, "Show me what damage I would inflict if I did
'commit' now.  By the way, I may want to see that information
limited to these paths" is a question whose utility is easily
explained, and so is the same question with 'commit' replaced by
'commit --amend'.
