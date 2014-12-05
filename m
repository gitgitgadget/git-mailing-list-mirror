From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 13:05:23 -0800
Message-ID: <xmqqfvctq030.fsf@gitster.dls.corp.google.com>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
	<xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
	<12536C063959480083CC2D4CBA0BA38E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>,
	"Duy Nguyen" <pclouds@gmail.com>, "Johannes Sixt" <j6t@kdbg.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 22:05:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xx04B-0006s9-H5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 22:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbaLEVF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 16:05:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbaLEVF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 16:05:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E1D924EC0;
	Fri,  5 Dec 2014 16:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MNI+3NQ6IFUWFKXvqMR6gkjd+4o=; b=d+/ZKB
	AQLKpRqZ2Anu7h06J97Z4QQtizBxhCtL922pSPebgZ5+GeJQ3jjBIhKLU5M/G61g
	u9RqFgXo4DA10oh5zEbhj9HPS2+ocvlqNUB5d/id0nRbdGOnAZXQtFbXwQ+uh0Y4
	hYCyALbRQSPB8uht/Iz0Vt7TG3yEcAUEgkCxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tb0ttewPbkGizXg5hzXD/1bP2dim3h3c
	Mu9ySzUfmt8nyHdUo8jhmwxNPr9nUJnTW+MyeTlQSumqbL8LxfnyHybVAUEr/GO6
	bkBrNj1XQd3tgVtDfmPjFlLVdyhA49kqmiCjIdD7RqE1u+Ia2nI4GF9OnpctspWr
	o5yIIUaxmkE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4464624EBF;
	Fri,  5 Dec 2014 16:05:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA41124EBE;
	Fri,  5 Dec 2014 16:05:24 -0500 (EST)
In-Reply-To: <12536C063959480083CC2D4CBA0BA38E@PhilipOakley> (Philip Oakley's
	message of "Fri, 5 Dec 2014 20:48:17 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E90AB8A-7CC2-11E4-BBC1-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260892>

"Philip Oakley" <philipoakley@iee.org> writes:

> The problem here is that there is no guidance on what those actions are
> that may make git 'notice'....

I think the guidance the users need is the one j6t has given already
in the upthread: "If you are promising Git you are not going to
touch a path, do not touch it.  Bad things may happen."

There is no need to say "if you touched this way or that way, then
you might get lucky." because the "lucky" part is not designed.  As
we find more codepaths that can rely on the promise by the user, we
may decide to take advantage of that promise even further and the
"lucky/unlucky" equation _will_ change when that happens.
