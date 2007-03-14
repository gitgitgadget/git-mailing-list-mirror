From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 10:06:53 -0700
Message-ID: <7vodmvah5e.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	<7v8xe0h19a.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140128y46ff6bb6m503eeae00c043ddf@mail.gmail.com>
	<7v6494dwms.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140701h60982fddw3ed8fa71288cb220@mail.gmail.com>
	<7v1wjrby4w.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 18:08:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRWwE-0000c9-Dj
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 18:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbXCNRGz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 13:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbXCNRGz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 13:06:55 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:52392 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXCNRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 13:06:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314170652.HBUA3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 13:06:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ah6t1W00L1kojtg0000000; Wed, 14 Mar 2007 13:06:53 -0400
In-Reply-To: <81b0412b0703140933v5c684aa9g1f61d61e502c6783@mail.gmail.com>
	(Alex Riesen's message of "Wed, 14 Mar 2007 17:33:21 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42214>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
>> > -     return run_diff_files_cmd(&rev, argc, argv);
>> > +     result = run_diff_files_cmd(&rev, argc, argv);
>> > +     return rev.diffopt.diff_exit_code ? rev.diffopt.exit_code: result;
>> >  }
>>
>> Yuck.  Let's call the former "exit_with_status" (meaning, the
>> caller instructed us to do that) and the latter "has_changes".
>
> I like "exit_with_status". But has_changes looks confusing
> good near return value of run_diff_files_cmd, which "has"
> nothing. Or do you mean to highlight this "difference"?

Maybe 'found_changes' would be a better name, then?

	if (exit_with_status)
        	return !!found_changes;
	else
        	return result;
