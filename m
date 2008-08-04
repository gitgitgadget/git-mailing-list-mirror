From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: Re: [PATCH] git-svn.perl: Strip ChangeLog bits.
Date: Mon, 04 Aug 2008 10:07:57 +0200
Organization: lilypond-design.org
Message-ID: <1217837277.7649.24.camel@heerbeest>
References: <1217684549.8296.10.camel@heerbeest>
	 <20080802172742.GT32184@machine.or.cz>
	 <7vfxpnnwt5.fsf@gitster.siamese.dyndns.org>
	 <1217701021.8296.35.camel@heerbeest>
	 <7v4p63dstc.fsf@gitster.siamese.dyndns.org>
	 <1217765241.6178.11.camel@heerbeest>
	 <7vhca1u8to.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 10:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPv7o-0007Qc-98
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 10:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYHDIID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 04:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbYHDIIC
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 04:08:02 -0400
Received: from edu-smtp-01.edutel.nl ([88.159.1.221]:41989 "EHLO
	edu-smtp-01.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYHDIIA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 04:08:00 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-01.edutel.nl (Postfix) with ESMTP id 8C13D67769;
	Mon,  4 Aug 2008 10:07:58 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id 430F6DC168;
	Mon,  4 Aug 2008 10:07:58 +0200 (CEST)
In-Reply-To: <7vhca1u8to.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.23.4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91326>

On zo, 2008-08-03 at 13:45 -0700, Junio C Hamano wrote:

> Nice try, but after -rc1 we won't take feature enhancements on the
> 'master' branch.  The earliest this will appear is in 1.6.1.

Ok, I'm not that familiar with git development and I did not find any
newer/UNRELEASED list of features?

>  * Documentation; introduce this with heading --clean-changelog=<style>; I

Ok.  I tried ={gnu} first, which seems to be the style for multiple
choice arguments, but the document parser does not grok that.  {gnu|foo}
or {gnu|no-other-yet} did not really please me.

>    You seem to have taken the "arbitrary Perl snippet" part of my patch as
>    well, but it is not described here...

It all depends upon how you read the future.  I would most have chosen
to postpone that work until the second (or third) request for different
munging came in, but now that the code is already written...

>  * Script; two separate _clean_changelog and _clean_log_message variables
>    are not necessary (I removed the extra variable in the patch below).

Good, I didn't really look at that.

>    Your new tests do not seem to check these, but I think you should:

>    - what should happen without --clean-changelog=gnu?  (iow, additional
>      code does not regress the behaviour when this shiny new toy is not
>      used).

We could add a test to make sure that git-svn does not alter commit
messages, but it has little to do with this patch.

If this is not being tested atm, it is probably not deemed important
enough to test.  This could have regressed at any time.  

I would add a test for existing working code only if experience tells
you it is fragile and it (often) regresses, ie, when you fix a bug:
new/revised code.

>    - what should happen when an unknown style is given e.g. --clean-changelog=yak?

It would be nice if the script failed with an error message, telling
what the options are, but I do not really care that much about wrong
use.  You have that automatically if you use a sensible option parser,
this is where such a feature should be implemented, imho.

>    We prefer to use "test_cmp" for comparing expected and actual result,
>    not bare "cmp".

Ok.

> Here is what I tested and based the above comments on after minor fixes to
> ask comments from Eric.

Great, thanks.  We'll see what happens then.

Jan.

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
