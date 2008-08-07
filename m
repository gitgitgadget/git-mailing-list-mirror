From: Junio C Hamano <gitster@pobox.com>
Subject: Re: On PPC64, the parsing of integers on the commandline is
 bitshifted.
Date: Thu, 07 Aug 2008 14:42:29 -0700
Message-ID: <7vhc9wijsq.fsf@gitster.siamese.dyndns.org>
References: <20080807203122.GR22707@curie-int.orbis-terrarum.net>
 <X68iwLodMeAo1RYVJdU3iyNzAFylpDRpP1jkviJTeiOnoNs5n2qZcg@cipher.nrlssc.navy.mil> <CxVxAoKmEQsrgFdHEvL0sjkgBBIVZ3Zvsl0pPSuDSfH_8xM8NOSGfw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 07 23:44:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRDGs-0004D2-Jm
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 23:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbYHGVmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 17:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbYHGVmn
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 17:42:43 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58965 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092AbYHGVmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 17:42:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D5D944F6A6;
	Thu,  7 Aug 2008 17:42:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C9FD4F6A5; Thu,  7 Aug 2008 17:42:31 -0400 (EDT)
In-Reply-To: <CxVxAoKmEQsrgFdHEvL0sjkgBBIVZ3Zvsl0pPSuDSfH_8xM8NOSGfw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 07 Aug 2008 16:34:00 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C04FCD1A-64C9-11DD-BE02-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91608>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Brandon Casey wrote:
>> Robin H. Johnson wrote:
>>> In a 64-bit userland, big-endian environment, the parser gets integers
>>> wrong.
>> 
>> There is a fix on master. Can you try that out?
>> Unfortunately, looks like it did not make it into 1.5.6.5
>
> Also, just so you know, it is test-parse-options.c that is broken, not
> the parsing code. So, the rest of git should be using an int with
> OPT_INTEGER() and should operate correctly.

Yup, that is why it is not on 'maint' --- but somebody should audit the
parse_options() users in the real programs to make sure that there is no
similar breakages, namely, giving a pointer to long to OPT_INTEGER().
