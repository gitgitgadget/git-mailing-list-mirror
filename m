From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 00:51:17 -0700
Message-ID: <7v7hx6suiy.fsf@alter.siamese.dyndns.org>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <7vab22ubr5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbrZa-0005aI-SL
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756399AbZHNHv0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756404AbZHNHvZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:51:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743AbZHNHvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:51:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B0FA28FE1;
	Fri, 14 Aug 2009 03:51:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C386F28FDF; Fri, 14 Aug 2009
 03:51:18 -0400 (EDT)
In-Reply-To: <7vab22ubr5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 13 Aug 2009 23\:53\:50 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 44C03790-88A7-11DE-98D0-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125916>

Junio C Hamano <gitster@pobox.com> writes:

> I do not mean that this new feature is useless nor stupid.  Being able to
> say "git push --delete branch1 branch2" matches _a_ mental model (perhaps
> Hg inspired one) _very_ naturally.  There are branches on the other side,
> and there is a special operation called 'delete' that you can inflict on
> them.
>
> But it is a different mental model of how git natively does "push".
> ...
> These are both valid models.  They just do not mix, so let's avoid
> confusion by not allowing both at the same time.

One more thing.  I suspect that adding --delete and nothing else probably
makes things worse than not doing anything.

In a mental model where "push there --delete $branch" is natural, there
are branches on the other side, and when you run 'push' command, you name
the special operation, 'delete', that you would want to inflict on them.

In such a world, there probably are other (perhaps not so special)
operations you can inflict on the branches on the other side as well.
They are probably called something like:

	push there --create $branch $commit
	push there --update $branch $commit

If you give them only --delete without completing the vocabulary by giving
these operations as well, you would force people to mix "git native" world
model (i.e. there is no "mode" nor "opration"; there is only "list of
instructions, each of which encodes the equivalent of 'mode'") with this
Hg-inspired world model.
