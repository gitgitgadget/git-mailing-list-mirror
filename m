From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Behavior of 'git add \*.txt': bug or feature?
Date: Wed, 16 Sep 2009 13:30:15 -0700
Message-ID: <7vbplazl7s.fsf@alter.siamese.dyndns.org>
References: <vpqljke7jv8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo194-0004Oq-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759968AbZIPUaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759966AbZIPUaV
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 16:30:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757482AbZIPUaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 16:30:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 580D4532AC;
	Wed, 16 Sep 2009 16:30:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6nxZSou0D2By4WQliKXesEKds0I=; b=KKqwC2
	zai2mO5gSbw72jLd/JdrlC1LLfpFai/FfT02kECSgGnHOpLx1u6/YYokzZQLZHgA
	juNE9qmT5ieawairV8gw6qntzIzEqOl9U0DK2yFh4AjK/ZQThpVC1/I0n6s5mnyZ
	nbS7K3Lrfh05ffpyrYEtI9KBwzUfn8K6qv8Ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SRsRrPifeiy+dnU+ILxBZbzO5ErUeGqr
	QoKhvMVxrAFKWbQzdU8YXYny+2Antx840z9b45IRgC2YaHUpyTnurU38K0+I24NL
	KWgOAWQVWdLw5cmXv+hkrKf7tnaVefh27ZDAD2/+cmceFaDEfXNCUv1DMxAYSvLs
	aDaJMBgluuc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C29B532AB;
	Wed, 16 Sep 2009 16:30:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 28295532AA; Wed, 16 Sep 2009
 16:30:16 -0400 (EDT)
In-Reply-To: <vpqljke7jv8.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 16 Sep 2009 21\:46\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0C1DC32-A2FF-11DE-A711-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128675>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> It this the intended behavior? If so, what's the rationale for this?

I strongly suspect that it comes from the fact that we have two
definitions and three implementations of pathspec-aware tree traversal.
One family is unaware of shell-glob wildcards (they only do leading
directory path match) while the other know both leading directory path and
shell-glob.

It is on the list of long-term items to fix, as the change required is
quite involved.
