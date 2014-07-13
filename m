From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 4/4] cache-tree: Write updated cache-tree after commit
Date: Sun, 13 Jul 2014 10:22:34 -0700
Message-ID: <xmqqbnst18dh.fsf@gitster.dls.corp.google.com>
References: <1405120947-3142-1-git-send-email-dturner@twitter.com>
	<1405120947-3142-4-git-send-email-dturner@twitter.com>
	<CAPig+cQpzomDmwVqgDGrP4qC1OujRXu5e1wc=EwX61k_RpLbKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 19:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6NU9-00024S-Ez
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 19:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbaGMRWp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 13:22:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60107 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbaGMRWo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 13:22:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19906262F6;
	Sun, 13 Jul 2014 13:22:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vh0phgVKjd3EYrzSa3reuHik3I8=; b=WlN1GL
	gDsi+Zmu33ED5969DpkmH7advjE4QfP5UCQHfho8ntPAIz2mBIr+7Shhn2yGnIsT
	G3O2gYVckRubxt2tcWGN8X+DxUETwx0goJs/OTSQT4AvriG77z68jImH8wyb0v5Q
	aP+VDfpqrnwjFRuJsKw9x1U0W+2p1Oxp0AhVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AtsRBkUlxzBc28IaO8EwHW5Jr1IRjYlU
	m1he//TQqA7PYkuPD0lDQNNjz8cH8hn7ayZHrIV0eWQxI1a6oQVWkYpYBbhVi3vn
	dOF2vnoAuFGmzye00IPOqlLy9Trq/ukc7y/e3F9Pvac17FrT9dycl2Ae9vpbKHyl
	aakwTpFFS7k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0FD81262F5;
	Sun, 13 Jul 2014 13:22:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8E693262EF;
	Sun, 13 Jul 2014 13:22:18 -0400 (EDT)
In-Reply-To: <CAPig+cQpzomDmwVqgDGrP4qC1OujRXu5e1wc=EwX61k_RpLbKg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Jul 2014 19:56:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3DD79C92-0AB2-11E4-ACF4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253452>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       (echo p; echo 1; echo; echo s; echo n; echo y; echo q) | git commit --interactive -m foo
>
> Broken &&-chain.
>
> Would a printf make this more readable?
>
>     printf "p\n1\n\ns\nn\ny\nq\n" | git commt ... &&
>
> Perhaps not.

But

	printf "%s\n" p 1 "" s n y q

is vastly more readable, I would think.

Don't we have test_write_lines which is exactly that, though?
