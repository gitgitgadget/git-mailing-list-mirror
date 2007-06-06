From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] git-submodule: move cloning into a separate function
Date: Wed, 06 Jun 2007 01:55:04 -0700
Message-ID: <7vira15uon.fsf@assigned-by-dhcp.cox.net>
References: <11810357523435-git-send-email-hjemli@gmail.com>
	<11810357522478-git-send-email-hjemli@gmail.com>
	<46653DB2.997A3ABD@eudaptics.com> <op.ttf34qd99pspc6@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 10:55:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvrIc-0007SV-2w
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759688AbXFFIzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759765AbXFFIzI
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:55:08 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:39751 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759647AbXFFIzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:55:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606085505.VDXA12556.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 04:55:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 88v41X0091kojtg0000000; Wed, 06 Jun 2007 04:55:05 -0400
In-Reply-To: <op.ttf34qd99pspc6@localhost> (Lars Hjemli's message of "Tue, 05
	Jun 2007 13:13:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49271>

"Lars Hjemli" <hjemli@gmail.com> writes:

> This is just a simple refactoring of modules_init() with no change in
> functionality.
>
> Signed-off-by: Lars Hjemli <hjemli@gmail.com>
> ---
>
> On Tue, 05 Jun 2007 12:40:50 +0200, Johannes Sixt <J.Sixt@eudaptics.com> wrote:
>
>> Lars Hjemli wrote:
>>> +               module_clone "$path" "$url" || exit $?
>>
>> Minor nit: The idiom that is commonly used in situations like this (see
>> other git-* shell scripts):
>>
>> 		module_clone "$path" "$url" || exit
>>
>> because exit without argument uses the code of the last command
>> executed.
>>
>
> Thanks, I'll follow up with matching changes to [patch 2/2].
>

This seems to be WS munged by your mailer.

> ...
> +	die "Clone of submodule '$path' failed"
> +}
> +
>   #
>   # Run clone + checkout on missing submodules
>   #
> @@ -40,20 +67,6 @@ modules_init()
>   		# repository
