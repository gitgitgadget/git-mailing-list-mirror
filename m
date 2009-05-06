From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix sloppy Getopt::Long.
Date: Wed, 06 May 2009 10:24:50 -0700
Message-ID: <7v63gew3dp.fsf@alter.siamese.dyndns.org>
References: <1241547374-6737-1-git-send-email-robbat2@gentoo.org>
	<7vljpazuyg.fsf@alter.siamese.dyndns.org>
	<20090506064949.GB29479@dcvr.yhbt.net>
	<20090506161309.GC10702@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed May 06 19:25:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1krb-00053c-M4
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 19:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306AbZEFRYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 13:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZEFRYv
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 13:24:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:53248 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZEFRYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 13:24:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506172449.DLOS25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 May 2009 13:24:49 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oHQq1b00K4aMwMQ04HQqEE; Wed, 06 May 2009 13:24:50 -0400
X-Authority-Analysis: v=1.0 c=1 a=uHxVNUnCMDAA:10 a=uXjSJhdlV4cA:10
 a=7mOBRU54AAAA:8 a=ybZZDoGAAAAA:8 a=lYIe0EXVKz6HTpCfM5IA:9
 a=4ikWGzN8uQMzCARdvPqFX5jGF2oA:4 a=WeOa-AV5lc8A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090506161309.GC10702@curie-int> (Robin H. Johnson's message of "Wed\, 6 May 2009 09\:13\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118358>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Tue, May 05, 2009 at 11:49:49PM -0700, Eric Wong wrote:
>> Junio C Hamano <gitster@pobox.com> wrote:
>> > "Robin H. Johnson" <robbat2@gentoo.org> writes:
>> > 
>> > > Getopt-Long v2.38 is much stricter about sloppy getopt usage. The
>> > > trailing pipe causes git-svn testcases to fail for all of the --stdin
>> > > argument calls.
>> > >
>> > > Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
>> > 
>> > Eric, I'll take this directly to my tree.  Ok?
>> 
>> The empty "" after the "|" was intended for the set-tree command to take
>> a lone "-" as a parameter to also mean "--stdin".
>> 
>> The following should work, too, but I don't have time to test right now:
>> 
>> +			{ '' => \$_stdin, 'stdin' => \$_stdin,
>> +			  %cmt_opts, %fc_opts, } ],
> I confirm that it does correctly set the $_stdin variable (tested
> briefly).

Wait a minute.  Do you mean we would also need the above "explicit empty
argument sets $_stdin"?  Wasn't it your earlier analysis/claim that the
caller already takes care of a lone "-"?

Or do you mean "yes it would also work but it is not necessary"?
