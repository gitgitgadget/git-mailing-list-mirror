From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge, pull: introduce '--diffstat' option
Date: Sat, 05 Apr 2008 11:51:51 -0700
Message-ID: <7vtzigw2wo.fsf@gitster.siamese.dyndns.org>
References: <20080403103056.GD6673@coredump.intra.peff.net>
 <1207406935-22144-1-git-send-email-szeder@ira.uka.de>
 <200804051835.54097.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Apr 05 20:52:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiDVT-00070l-71
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 20:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbYDESwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 14:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbYDESwG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 14:52:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbYDESwF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 14:52:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8728673C2;
	Sat,  5 Apr 2008 14:51:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D29E373C1; Sat,  5 Apr 2008 14:51:54 -0400 (EDT)
In-Reply-To: <200804051835.54097.tlikonen@iki.fi> (Teemu Likonen's message of
 "Sat, 5 Apr 2008 18:35:53 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78860>

Teemu Likonen <tlikonen@iki.fi> writes:

> How about this: Officially and explicitly deprecate --(no-)summary and 
> advertise --(no-)diffstat as replacement. Also advertise that in some 
> future release --(no-)summary will have different meaning (i.e. 
> equivalent to merge.summary). There would be a reasonable (?) period 
> before changing the meaning of --(no-)summary.
>
> This is a bit hassle...

I'd favor, in the longer run:

 * --stat option to mean "show the diffstat between ORIG_HEAD and merge
   result" (i.e. current --summary);

 * perhaps a new configuration merge.stat to control the default for the
   above;

 * merge.log configuration to mean "add list of one-line log to the merge
   commit message" (i.e. current merge.summary);

 * perhaps a --log option to override the config default for each
   invocation.

 * deprecate --summary and merge.summary and remove them long after people
   are used to the above new set.

Transition needs to happen over time and across a major release bump.

We can do the first four in 1.5.6, and immediately declare deprecation,
and removal of --summary/merge.summary perhaps in 1.6.0.  
