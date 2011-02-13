From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-gui: give more advice when detaching HEAD
Date: Sun, 13 Feb 2011 15:10:30 -0800
Message-ID: <7v4o87wmxl.fsf@alter.siamese.dyndns.org>
References: <20110212070538.GA2459@sigill.intra.peff.net>
 <7voc6hy771.fsf@alter.siamese.dyndns.org>
 <AANLkTi=3m3pvciKXgUXGffsA9xDddTum5mhWBoaWA3o+@mail.gmail.com>
 <201102131022.06863.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 00:11:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pol5n-0006Mh-Ri
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 00:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754834Ab1BMXKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 18:10:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab1BMXKs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 18:10:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4EC283DE0;
	Sun, 13 Feb 2011 18:11:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTqev5w6ctietMNwu9I3Mt3+YZU=; b=MPGp2l
	vTbsInhhPXbIkvB354M5dcu2BgPAnrBq6s76nL3icSHa5C3YJFJr79SzltA07W+B
	JiWGJfhTgOtUzjPjSoPxQPu09KI9FFgKLpytZjvdIKsT6wxcSZtnlDPx/rMgAywe
	uG2PCkiFlSBZquykN1AVWnE/di4AGSEKKcnXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qenmi+E4vpZd4FfcVZ4jqlmnJbkI9xmz
	KX9va1OVRP+P5r6EFQi1GJEtmpP+Q90XQSspnzU+9YdCjfEMnxNC1abUsnO20pVR
	FAY1syaKAVOAKvdt8b4urc549EfZkOpsI7aCVn1nYLs0KFMslBccEvGG+3eUUFN9
	j2+lObuK2PI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F037B3DDC;
	Sun, 13 Feb 2011 18:11:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 03DB13DD2; Sun, 13 Feb 2011
 18:11:36 -0500 (EST)
In-Reply-To: <201102131022.06863.j6t@kdbg.org> (Johannes Sixt's message of
 "Sun\, 13 Feb 2011 10\:22\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A00C42CC-37C6-11E0-BB2E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166680>

Johannes Sixt <j6t@kdbg.org> writes:

>> On Sat, Feb 12, 2011 at 09:42, Junio C Hamano <gitster@pobox.com> wrote:
>> > That way, the traversal will terminate much sooner than computing the
>> > true merge base.
>>
>> Since we want to use this in git-gui, do you intend to expose this as
>> a command somehow (e.g. 'git rev-parse --reachable HEAD --all' or
>> somesuch)?
>
> What's wrong with checking the output of
>
>   git rev-list -1 HEAD --not --branches --tags --
>
> for zero length?

Nothing, except that (1) that approach won't catch refs outside heads and
tags (like the ones I have in refs/merge-fixes and refs/hold), and (2) it
won't have an early termination optimization I mentioned either.

I don't know how much the early termination optimization matter in
practice, though.  It would probably depend heavily on where you begin.
