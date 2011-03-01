From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/alternative/raw and rough] setup.c: denote repo wide
 pathspecs by ':'
Date: Tue, 01 Mar 2011 06:50:43 -0800
Message-ID: <7vsjv6evy4.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=xrnxUtkayyW1Merh49N6uHy5p-GMrYe6+p==t@mail.gmail.com>
 <bc49592f5e524a0d12aa55eeca1c5ca659b6525f.1298974647.git.git@drmicha.warpmail.net> <AANLkTimJ7QsPTW0Vm9JgYVbcRQRoTnuiXUxOK=0unk6P@mail.gmail.com> <4D6CD593.2090705@drmicha.warpmail.net> <AANLkTinke05gcQbrDLSUoBUus5gnx+ci5830766d2Jqs@mail.gmail.com> <4D6CDF20.3020701@drmicha.warpmail.net> <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:51:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuQui-0000mr-ET
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 15:51:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab1CAOuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 09:50:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740Ab1CAOuy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 09:50:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6EC1B4DA1;
	Tue,  1 Mar 2011 09:52:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PGXDzJlxEa+ZxEdxTKXtokOdffI=; b=BAMlFb
	fK+WfeU6ZJvOhLg9zAwUPDCY+qLim8nG46P4+0Ask1F9SgJfxddtivJ4GtGBt9Fu
	XwmvENaOAuepM3fLniQk8WC1HZu/8kjPzRGvsBekb9iBE0oiaOlRqMFiY8uaJ6V7
	u4KXBWP2nuI7XJY1NgjB/KhfUEO3cXPxO6kGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJEY5HJIRyZmM1uZSuqCRPadP6H76nYU
	+bHrm8Gg/lNGM9rutJcufPttWuvK1/2o1VZ/CQP4Snb05w0BqO7SpBZvZfE0MZId
	OqeAujDZkbL1T/mcPPvj0kx/hyJNv6Yd2zCC9Rm0QA15oclSN7cU3PLR/BDmXdgL
	4FXv8aKnomU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3AB764DA0;
	Tue,  1 Mar 2011 09:52:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE60A4D9F; Tue,  1 Mar 2011
 09:52:04 -0500 (EST)
In-Reply-To: <AANLkTikzSsBZ757p4gnwsUrGNmRKHsxrqXeqPKyLihjT@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 1 Mar 2011 19\:08\:28 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7BB9C8C8-4413-11E0-9D42-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168223>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> No. ':foo' as a reference to 'foo' in index is a SHA1-extended syntax
> and I think we try to avoid ambiguation when a sha1-extended syntax
> may look like a path or vice versa.

Very true.

Just as a thought experiment (I am skeptical about this whole "this is
from root" prefix idea to begin with, but I don't want to shoot an idea
down prematurely when there may still be untold gems I haven't seen in
it):

    $ git grep -e frotz .../

to abbreviate "I don't bother to count my ../" might be an alternative,
though.

The reason I am skeptical about the "from root prefix" is because I do not
see a way to make it compatible with other meaningful pathspecs.

    $ cd Documentation
    $ git grep -e frotz '*.txt'

would find frotz in all *.txt files in Documentation (and its
subdirectories), if the command takes "relatigve to cwd".

It also is very clear that

    $ cd Documentation
    $ git grep --full-tree -e frotz '*.txt'

would find those anywhere, inside or outside Documentation.

On the other hand, it is natural to expect that

    $ git grep -e frotz ".../*.txt"

should find *.txt files _only_ at the root level, so it is not as useful as
the --full-tree (or --root).
