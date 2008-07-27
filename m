From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more
 than 2 arguments
Date: Sun, 27 Jul 2008 11:11:22 -0700
Message-ID: <7vljzn2o51.fsf@gitster.siamese.dyndns.org>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
 <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 20:12:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNAjV-00012h-3m
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 20:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758054AbYG0SLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 14:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757626AbYG0SLb
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 14:11:31 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48089 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbYG0SLb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 14:11:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A68563F1B1;
	Sun, 27 Jul 2008 14:11:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9C2A33F1AF; Sun, 27 Jul 2008 14:11:24 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807271631470.5526@eeepc-johanness> (Johannes
 Schindelin's message of "Sun, 27 Jul 2008 16:38:05 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6F8876E0-5C07-11DD-9A64-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90351>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW I seem to recall that get_merge_bases_many() was _not_ the same as 
> get_merge_octopus().  Could you please remind me what _many() does?

I explained what merge-bases-many gives in a separate message last night
with pictures.

get_merge_octopus() is a more or less useless function.  It is there only
because the protocol between "merge" and strategies requires that the
former have to pass _some_ bases to the latter.  In fact, the octopus
strategy implementation completely ignores the heads given by "merge";
a single set of merge base given from outside is not even useful when you
build octopus by repeatedly running pairwise three-way merges.

With Christian's git-merge-base enhancement, the big comment at the end of
git-merge-octopus's main loop can go with a much improved "next" merge
base computation.
