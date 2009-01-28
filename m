From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: Filter unknown commits from alternates of the
 remote
Date: Tue, 27 Jan 2009 17:47:17 -0800
Message-ID: <7vbptsyzfe.fsf@gitster.siamese.dyndns.org>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <20090128013840.GA7224@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRzXx-0006BM-5A
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbZA1Br3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 20:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbZA1Br2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:47:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbZA1Br1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 20:47:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C732B1D6A2;
	Tue, 27 Jan 2009 20:47:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 98CA21D6C7; Tue,
 27 Jan 2009 20:47:19 -0500 (EST)
In-Reply-To: <20090128013840.GA7224@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 28 Jan 2009 02:38:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DA9512C-ECDD-11DD-B756-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107448>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Since 40c155ff14c, receive-pack on the remote also sends refs from it=
s
> alternates. Unfortunately, we don't filter commits that don't exist i=
n the
> local repository from that list.  This made us pass those unknown com=
mits
> to pack-objects, causing it to fail with a "bad object" error.

Yeah, it is a step in the right direction, but is the *wrong* fix I
described in my previous message.

Our mails crossed ;-)

And I think we should have this in the place where we receive .have,
i.e. inside add_extra_have() in connect.c
