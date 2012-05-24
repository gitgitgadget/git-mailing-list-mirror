From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] rebase -p: do not redo the merge, but cherry-pick
 first-parent changes
Date: Thu, 24 May 2012 13:09:59 -0700
Message-ID: <7vpq9twdbc.fsf@alter.siamese.dyndns.org>
References: <4FBAA33D.1080703@kdbg.org>
 <CAOeW2eE9EW3gER7ZDThGABtZ0doNuUb70DnKrnzD+OeWYLO7cQ@mail.gmail.com>
 <7vzk8yzq35.fsf@alter.siamese.dyndns.org>
 <CAOeW2eGvEaQYk9KODmLzZuEBu-KhKcQeL4PE-4YHwSgtP0dJfA@mail.gmail.com>
 <7vehq9xz7a.fsf@alter.siamese.dyndns.org>
 <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stephen Haberman <stephen@exigencecorp.com>,
	Andrew Wong <andrew.kw.w@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:10:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXeMT-0005KW-2d
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758619Ab2EXUKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 16:10:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64277 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070Ab2EXUKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:10:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D6DC880D;
	Thu, 24 May 2012 16:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=evjmziMDF7Bk/jrL1AVhOroFtTc=; b=DfsDVK
	Cud1IHi0CGKlJaG5zhP20Ouskb5UX2UHSlLvKxsqaWn6P4pt42nsx4tyQXPXwNkq
	PTRF+yuMN97TPCuU9SfHeI6fZWpZQFrPm90MhDQ1yvCABvV/kQqcKDpjmGP/CvVv
	/OU8QKfdUZfLDc6DgBkaG0nSEo+W2DWuEVBGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Prs8GA/6h2Tnho+34CEImtd//gaGUMXP
	BwpHEwS6poOKbt0sj27I5tageviGW3hFyAOCwceGjzgQ+Rjn8HvWjr6AhChizeO8
	NaYv4/LhpU9Mskw2dX3p+GIkU2h6U+PhjebIv+Clv/eQ82H1dLWdjGEt8x2unYk4
	x5yQaWldhgg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24C4E880C;
	Thu, 24 May 2012 16:10:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B0E68807; Thu, 24 May 2012
 16:10:07 -0400 (EDT)
In-Reply-To: <CAOeW2eH85+qa2PXS55_xGwH+tpMDMEK76HywfpLTYrv_Dtg49Q@mail.gmail.com> (Martin
 von Zweigbergk's message of "Thu, 24 May 2012 10:47:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7541F76E-A5DC-11E1-AD18-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198414>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> ... I assumed the reasoning was that any work spent on
> git-rebase at this point will be thrown away once git-rebase instead
> calls into the sequencer....

Ah, sorry I mis-read you.
