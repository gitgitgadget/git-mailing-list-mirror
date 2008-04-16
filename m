From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: Show a more descriptive error on failure
 when opening a patch
Date: Tue, 15 Apr 2008 22:20:28 -0700
Message-ID: <7vy77etlyb.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0804141532390.28504@racer>
 <1208187027-29198-1-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 08:02:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm05H-0007XL-RY
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 07:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbYDPFUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 01:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYDPFUm
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 01:20:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbYDPFUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 01:20:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCCBD2C7A;
	Wed, 16 Apr 2008 01:20:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id CFCDD2C79; Wed, 16 Apr 2008 01:20:30 -0400 (EDT)
In-Reply-To: <1208187027-29198-1-git-send-email-albertito@gmail.com> (Alberto
 Bertogli's message of "Mon, 14 Apr 2008 12:30:27 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79674>

Alberto Bertogli <albertito@gmail.com> writes:

> When a patch can't be opened (it doesn't exist, there are permission
> problems, etc.) we get the usage text, which is not a proper indication of
> failure.
>
> This patch fixes that by calling error() instead.
>
> Signed-off-by: Alberto Bertogli <albertito@gmail.com>
> ---
>
> On Mon, Apr 14, 2008 at 03:33:54PM +0100, Johannes Schindelin wrote:
>> On Mon, 14 Apr 2008, Alberto Bertogli wrote:
>> 
>> > +           if (fd < 0) {
>> > +                   error("can't open patch '%s': %s", arg,
>> > +                                   strerror(errno));
>> > +                   return 1;
>> > +           }
>> 
>> Do you absolutely want to retain the curly braces, and have two 
>> statements?   I would prefer "return error(...)", and if you absolutely 
>> insist on a return 1: "return !!error(...)".
>
> No, I'm not insisting on any version, I just thought returning 1 would be
> better since it will become the script exit status; Now that I think a bit
> more about it, maybe I should just use die() instead.
>
> Anyway, here's the version returning directly from error(); if you prefer it
> some other way just let me know.

I would apply this while changing "return error()" to "die()", as the
original usage() call would have exited here and we do not have a good
reason to change it.

Thanks.
