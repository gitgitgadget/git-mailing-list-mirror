From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 10:07:03 -0800
Message-ID: <7vr63386rc.fsf@gitster.siamese.dyndns.org>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de>
 <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de>
 <4970BA2B.7090807@viscovery.net> <4970BAE5.8080006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 19:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNt7Y-0003TB-O1
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 19:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761108AbZAPSHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 13:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760207AbZAPSHT
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 13:07:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759514AbZAPSHS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 13:07:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 73561913FF;
	Fri, 16 Jan 2009 13:07:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 46CCF913FD; Fri,
 16 Jan 2009 13:07:11 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8211FC5E-E3F8-11DD-ACDC-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105983>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Johannes Sixt schrieb:
>> G=C3=A1bor's patch needs a better justification which misbehavior it=
 tries to
>> fix, and the spot that it changes:
>
> I actually meant: "which use-case the patch tries to help". Because t=
he
> current behavior can hardly be classified as bug. ("You have no busin=
ess
> cd-ing around in .git." ;)

Thanks.

I think (1) the solution (almost) makes sense, (2) the patch needs to b=
e
explained a lot better as you mentioned in your two messages, and (3) i=
f
it does not affect any other case than when you are in a subdirectory o=
f
the .git/ directory, then you are doing something funny anyway and
performance issue Dscho mentions, if any, is not a concern.

My "(almost)" in (1) above is because the patch uses this new behaviour
even when you are inside the .git/ directory itself (or at the root of =
a
bare repository), which is a very common case that we do not have to no=
r
want to change the behaviour.  It also invalidates the precondition of =
(3)
above.

Dscho, what performance issues do you have in mind, by the way?
