From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Allow multiple tag and branch directories in   git-svnimport
Date: Tue, 21 Aug 2007 10:46:23 -0700
Message-ID: <86wsvook5s.fsf@blue.stonehenge.com>
References: <20070821170858.GA1721@jack.stsp.lan>
	<20070821173838.GC1721@jack.stsp.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: subversion@elego.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 19:47:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXok-0000hy-B9
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875AbXHURqu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbXHURqu
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:46:50 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:42723 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760596AbXHURqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 13:46:49 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id DD8CC1DE515; Tue, 21 Aug 2007 10:46:23 -0700 (PDT)
x-mayan-date: Long count = 12.19.14.10.11; tzolkin = 5 Chuen; haab = 19 Yaxkin
In-Reply-To: <20070821173838.GC1721@jack.stsp.lan> (Stefan Sperling's message of "Tue, 21 Aug 2007 19:38:38 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56314>

>>>>> "Stefan" == Stefan Sperling <stsp@elego.de> writes:

Stefan> On Tue, Aug 21, 2007 at 07:08:58PM +0200, Stefan Sperling wrote:
>> +my @tag_dirs = defined $opt_t ? split /:/,$opt_t : "tags";
Stefan>       ^                                                ^^^^^
>> +my @branch_dirs = defined $opt_b ? split /:/,$opt_b : "branches";
Stefan>       ^                                                  ^^^^^^^^^^

Stefan> Ouch, just noticed it's a bad idea to try to initialise
Stefan> an array with a scalar. Sorry :-/

That's completely normal.  Perl predictably promotes the single scalar to an
array of one element.  I wouldn't have even noticed it in a detailed code
review, since it's so normal to do that.

In fact, the parens that you added do *not* make it a list.  The parens
are purely for precedence in:

    @a = (3, 5, 7);

because otherwise, the text:

    @a = 3, 5, 7;

would be parsed as:

    (@a = 3), 5, 7;

which would be pretty pointless.  It's the *comma* in a list context that
makes it a list.

So, your parens are not only uncommon, they are also completely ineffective,
similar to replacing 2 + 3 with (2) + (3) :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
