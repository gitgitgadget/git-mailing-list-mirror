From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Tue, 12 Mar 2013 15:16:33 -0700
Message-ID: <7vehfk5kn2.fsf@alter.siamese.dyndns.org>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	David Aguilar <davvid@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 23:17:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFXVH-0005rH-2q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 23:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587Ab3CLWQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 18:16:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45480 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755301Ab3CLWQg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 18:16:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B645BBF9B;
	Tue, 12 Mar 2013 18:16:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zTXXMSwNltqPALsoqLjUNqeo8IE=; b=k9bfV1
	oDThRX1bql92r50dnzgLAOPII5YVNnBfxb6SSYiNqEPVDQnJ3crw9pJ2esGMZIx2
	HJas0jcJk9qjwuebDJTVSzkYdS20N9+IeW0Gn0qpskqEYohhC7vTF5GT/RJYSXPd
	I4Tijm2vyrVNtxZABYDV7dY9UEF8mBH7xpeyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uGbkd6PUEievOnTWpY0xUAFVi76OCkR4
	exyPTL+ddpslBx5FC5L/TJJdIpZdqzftJlouK03WOfk+GDWqkTk16Co1BWllzvbO
	BWtY8HB1cQvwY76PknJwQpbaL6NJoBcLOLeF0NhS4+3ClfKdKIVp/5s8S0NjZMRE
	MCwcwgOYWR0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB217BF9A;
	Tue, 12 Mar 2013 18:16:35 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C5F2BF97; Tue, 12 Mar 2013
 18:16:35 -0400 (EDT)
In-Reply-To: <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com> (Matt
 McClure's message of "Tue, 12 Mar 2013 17:43:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80682CB4-8B62-11E2-920F-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218004>

Matt McClure <matthewlmcclure@gmail.com> writes:

> An alternative approach would be to reuse git-diff's option parsing
> and make it tell git-difftool when git-diff sees the working tree
> case. At this point, I haven't seen an obvious place in the source
> where git-diff makes that choice, but if someone could point me in the
> right direction, I think I'd actually prefer that approach. What do
> you think?

I do not think you want to go there.  That wouldn't solve the third
case in my previous message, no?
