From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-cvsimport: add support for cvs pserver password
 scrambling.
Date: Fri, 14 Aug 2009 00:25:37 -0700
Message-ID: <7vskfusvpq.fsf@alter.siamese.dyndns.org>
References: <1250233111-19188-1-git-send-email-dirker@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Dirk Hoerner <dirker@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 09:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbrAg-0001wx-CG
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 09:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbZHNHZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 03:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbZHNHZq
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 03:25:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755959AbZHNHZp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 03:25:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B8A128EEB;
	Fri, 14 Aug 2009 03:25:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 78F2128EEA; Fri, 14 Aug 2009
 03:25:39 -0400 (EDT)
In-Reply-To: <1250233111-19188-1-git-send-email-dirker@gmail.com> (Dirk
 Hoerner's message of "Fri\, 14 Aug 2009 08\:58\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE2B269E-88A3-11DE-89DB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125912>

Dirk Hoerner <dirker@gmail.com> writes:

> Instead of a cleartext password, the CVS pserver expects a scrambled one
> in the authentication request. With this patch it is possible to import
> CVS repositories only accessible via pserver and user/password.
>
> Signed-off-by: Dirk Hoerner <dirker@gmail.com>

Thanks.

While I appreciate your effort to add a test, I'd rather not apply the
test part of your patch for two reasons:

 - It is not a test against a real cvs pserver but is a whitebox test to
   verify that the program says what the program is supposed to spit out
   to the network; and

 - It still is a network test that will fail if the TCP port is occupied
   for whatever reason when the test is run, which will make automated
   build and test cycle unreliable.

Unfortunately, I do not see an easy way to run a real cvs pserver
listening to a local unix domain socket under $TRASH_DIRECTORY, which
would solve both of the above issues.
