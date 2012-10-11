From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [minor] two tests broken when run with a --root directory that's
 a symlink
Date: Thu, 11 Oct 2012 16:26:37 -0700
Message-ID: <7vpq4o615e.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6Cu_4X=AywsDMebdoFYdEN1Gmp439aEAcehHBuMhziTw@mail.gmail.com>
 <50774D25.6000403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Tim Henigan <tim.henigan@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 12 01:26:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMS9Z-00026V-5l
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 01:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389Ab2JKX0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 19:26:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33490 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab2JKX0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 19:26:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D6378CA5;
	Thu, 11 Oct 2012 19:26:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rmFisWGHK6Ry8msA+THez1kiKXM=; b=fGYXfB
	rL5Nvoy7H50e+s9Zxe9eSAhYRmmUBvzKFErHKm18zMqHVwFyTj4KkmhkHpWuwlaH
	q17kc3nim83VK2Qn0qPnqAKD4okJYFrlKpanW0W8VHyy8oHRy8Q30NbvzrY7XFs5
	UZfkNbwnJRFyq7aa8m6d2VtHAnJq0MIL7FQew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FKN8jPVMpD+JNlbjnR6CyJVuIWrQ3GXD
	pidGzN7YwqEIdO44hHMXX37RW4DuRenT74Kfyuvj0ZmuW+EYuPCgMzTwHhMCaJ0Q
	1hbXHq308LYjpd74BojoZcJVHvyfxCFfy4NRS5e+qADU+g6Ajf/Ob2y2zHtAE6iT
	3l1uBKKK8gQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 498C48CA4;
	Thu, 11 Oct 2012 19:26:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B99C08CA3; Thu, 11 Oct 2012
 19:26:38 -0400 (EDT)
In-Reply-To: <50774D25.6000403@alum.mit.edu> (Michael Haggerty's message of
 "Fri, 12 Oct 2012 00:50:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1B256710-13FB-11E2-B2B9-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207521>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I ran into the same problem a while ago, and submitted a patch series
> that fixes t4035 (whose problems are related to GIT_CEILING_DIRECTORIES):
>
>     http://thread.gmane.org/gmane.comp.version-control.git/206633
>
> Junio didn't like the approach so much and I haven't yet had time to
> submit a revised version.

I like the approach of comparing each element of CEILING and the
directory not before but after resolving any symlinks in them.

My comments was only about the implementation that seemed to make
the API layering boundary more complex than necessary.
