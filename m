From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Mon, 19 Nov 2012 21:39:34 -0800
Message-ID: <7v1ufou92h.fsf@alter.siamese.dyndns.org>
References: <20121117153007.GB7695@book.hvoigt.net>
 <20121117192026.GI22234@odin.tremily.us>
 <7vd2z9t7y2.fsf@alter.siamese.dyndns.org>
 <20121120011628.GD321@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Tue Nov 20 06:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TagYr-00018v-Tw
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 06:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993Ab2KTFji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 00:39:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab2KTFjh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 00:39:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 113D66559;
	Tue, 20 Nov 2012 00:39:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Aisa+C4UVvP73bAGM5Qo/wOze8=; b=ErMHKj
	ID9Cm3g9hc+ZfAI2lpqyksbAcBahUH6mDLdLg5yUnB6bvaTYtPcjLJO+ghbQ7pwf
	+ER83Wb3XiDZWVc3PLQjimmH1xwnVvC4hNnROp13b9/O1p2mrwn+5syV5Cjh588B
	1OWSRymP44C3S5hrJ1BgrasQ60ZO1qypZcYlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ON4uu8YYmyFcymhW8zoePPioLesMHUdn
	7uThNIFdDGT2pB3ulwImbjnzO9yi6YjF8gon3x9jRKxuk67oRxaY1WC5b98s/Uto
	+Qs/PFLYelmJIqHzn65xSqHp4Xgj02IuzvWjjBpqgN/licOoLSJpflTvqhRsAUuA
	Pq4qVcUIlhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F053D6558;
	Tue, 20 Nov 2012 00:39:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 393156557; Tue, 20 Nov 2012
 00:39:36 -0500 (EST)
In-Reply-To: <20121120011628.GD321@odin.tremily.us> (W. Trevor King's message
 of "Mon, 19 Nov 2012 20:16:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AB4999FE-32D4-11E2-BE3A-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210078>

"W. Trevor King" <wking@tremily.us> writes:

> On Mon, Nov 19, 2012 at 04:49:09PM -0800, Junio C Hamano wrote:
>> "W. Trevor King" <wking@tremily.us> writes:
>> ...
>> > I think it's best to have users craft their own commit messages
>> > explaining why the branch was updated.  That said, an auto-generated
>> > hint (a la "git merge") would probably be a useful extra feature.
>> 
>> I am not quite sure I agree.  When the project says "Use the tip of
>> 'bar' branch for the submodule 'foo'" at the top-level, does an
>> individual user who is not working on the submodule 'foo' but merely
>> is using it have any clue as to why the submodule's 'foo' branch
>> 'foo' moved, or does he necessarily even care?
>
> If he doesn't care, why is he updating the submodule gitlink?

He may not be updating the gitlink with "git add foo" at the
top-level superproject level.  He is just using that submodule as
part of the larger whole as he is working on either the top-level or
some other submodule.  And checkout of 'foo' is necessary in the
working tree for him to work in the larger context of the project,
and 'foo' is set to float at the tip of its 'bar' branch.  And that
checkout results in a commit that is different from the commit the
gitlink suggests, perhaps because somebody worked in 'foo' submodule
and advanced the tip of branch 'bar'.

So:

 - at the top-level superproject level, entry 'foo' in the HEAD tree
   points at an older commit;

 - 'foo/.git/HEAD' points at refs/heads/bar, which matches the
   working tree of 'foo' and the index foo/.git/index..

I am not sure what should happen to the entry 'foo' in the index of
the top-level superproject after such a 'submodule floats at the
tip' checkout, but I imagine that it must match the contents of
foo/.git/HEAD's tree.  Otherwise, "git diff" at the top-level would
report local changes.

When committing his work at the top-level, he will see that 'foo'
gitlink is updated in that commit; after all that combination is the
context in which his work was done.

Or are you envisioning that such a check-out will and should show a
local difference at the submodule 'foo' by leaving the index of the
top-level superproject unchanged, and the user should refrain from
using "git commit -a" to avoid having to describe the changes made
on the 'bar' branch in the meantime in his top-level commit?  That
is certainly fine by me (I am no a heavy submodule user to begin
with), but I am not sure if that is useful and helpful to the
submodule users.
