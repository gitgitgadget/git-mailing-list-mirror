From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: Add an option to set up a mirror
Date: Sat, 02 Aug 2008 11:55:04 -0700
Message-ID: <7vr697l01j.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:56:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPMHG-00011t-Gu
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbYHBSzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbYHBSzT
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:55:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54517 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754129AbYHBSzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:55:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 417DA45522;
	Sat,  2 Aug 2008 14:55:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B82594551B; Sat,  2 Aug 2008 14:55:06 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808011600170.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Fri, 1 Aug 2008 16:00:45 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8930EF3E-60C4-11DD-B0AE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91168>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The command line
>
> 	$ git clone --mirror $URL
>
> is now a short-hand for
>
> 	$ git clone --bare $URL
> 	$ (cd $(basename $URL) && git remote add --mirror origin $URL)

I think this would be a useful behaviour and I am very tempted to violate
the general policy of not taking any new options nor features after -rc1.

I however notice that there are differences bewteen the above sequence and
what your code actually does:

 - The "remote add --mirror" sequence tells it to mirror everything, but
   the patch still mirrors only heads;

 - You are not setting up "remote.*.mirror = yes" in the configuration;
