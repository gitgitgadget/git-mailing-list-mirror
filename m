From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 12:11:42 -0700
Message-ID: <7v3amdtx8x.fsf@gitster.siamese.dyndns.org>
References: <loom.20080713T073129-112@post.gmane.org>
 <20080713124100.GB10347@genesis.frugalware.org>
 <20080713174659.GE10347@genesis.frugalware.org>
 <20080713184300.GF10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Hvammen Johansen <hvammen+git@gmail.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 13 21:12:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI704-0001eU-Pa
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 21:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbYGMTLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 15:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYGMTLu
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 15:11:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57172 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542AbYGMTLt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 15:11:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65CBE2E4EE;
	Sun, 13 Jul 2008 15:11:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B873B2E4EB; Sun, 13 Jul 2008 15:11:44 -0400 (EDT)
In-Reply-To: <20080713184300.GF10347@genesis.frugalware.org> (Miklos Vajna's
 message of "Sun, 13 Jul 2008 20:43:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AAE8E12-510F-11DD-9667-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88325>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Sun, Jul 13, 2008 at 07:46:59PM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
>> So far what I see is that the input for the reduce_heads() function is
>> (c1, c0, c2, c0, c1). The expected output would be (c1, c2), but the
>> actual output is c2. So I suspect the bug is not in builtin-merge.c
>> itself but in reduce_heads().
>
> This fixes the problem for me. Junio, does the fix looks correct to you
> as well?

You are correct, the "item"s are the highlander (i.e. "there can be only
one") objects but commit-list elements that hold pointers to them are not,
so we need to dereference and compare.

Thanks.
