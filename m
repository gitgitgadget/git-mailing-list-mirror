From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: remove Perl use by implementing "git
 bisect--helper --sq-quote"
Date: Tue, 21 Apr 2009 23:03:16 -0700
Message-ID: <7veivl444b.fsf@gitster.siamese.dyndns.org>
References: <20090422045524.3606.81842.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 08:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwVZp-0002cv-LX
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 08:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbZDVGDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 02:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZDVGDX
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 02:03:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbZDVGDX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 02:03:23 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A550ACBF1;
	Wed, 22 Apr 2009 02:03:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2F11FACBF0; Wed,
 22 Apr 2009 02:03:18 -0400 (EDT)
In-Reply-To: <20090422045524.3606.81842.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed, 22 Apr 2009 06:55:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48E50AB0-2F03-11DE-AE39-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117175>

Christian Couder <chriscool@tuxfamily.org> writes:

> The sq() function in "git-bisect.sh" was the only place where Perl
> was needed. This patch remove this use of Perl by implementing
> a new "--sq-quote" option in "builtin-bisect--helper.c".

Isn't it because only git-bisect.sh for whatever reason reimplements sq
using Perl while original implementation in am used sed for more
portability?

I would suspect, if it were 3 years ago, that any serious porcelain
writers would have very much appreciated such a feature that gives shell
programmers an easy access to a quoting function that allows a safe eval,
and I would have strongly suggested that the feature to be implemented in
a more permanent place rather than in bisect--helper; perhaps a better
place would be the kitchen-sink "rev-parse".

But given that nobody seems competent enough to do serious programming in
shell these days, I am not sure if the choice between bisect--helper and
rev-parse makes much of a difference ;-).
