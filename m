From: Johan Herland <johan@herland.net>
Subject: Re: [ANNOUNCE] Git v2.0.0-rc0
Date: Wed, 23 Apr 2014 09:33:40 +0200
Message-ID: <CALKQrgd0Psp0nWUsmW16aR4io4xu_gumJmRdLGU+MOSzJvBobQ@mail.gmail.com>
References: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
	<475e137b5095e45c92a87a9969f58f0@74d39fa044aa309eaea14b9f57fe79c>
	<20140422185829.GB15516@google.com>
	<xmqq4n1l3yyf.fsf@gitster.dls.corp.google.com>
	<20140422210002.GC15516@google.com>
	<xmqqy4yx2gz9.fsf@gitster.dls.corp.google.com>
	<20140422221148.GD15516@google.com>
	<20140422222519.GC144079@vauxhall.crustytoothpaste.net>
	<xmqqbnvt2d7v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:33:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcrgp-0005Sx-4m
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 09:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757251AbaDWHdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 03:33:50 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:51423 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757236AbaDWHdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 03:33:47 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Wcrge-000BKh-HW
	for git@vger.kernel.org; Wed, 23 Apr 2014 09:33:44 +0200
Received: by mail-pb0-f47.google.com with SMTP id up15so503465pbc.6
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 00:33:40 -0700 (PDT)
X-Received: by 10.69.15.2 with SMTP id fk2mr17390163pbd.123.1398238420502;
 Wed, 23 Apr 2014 00:33:40 -0700 (PDT)
Received: by 10.70.48.232 with HTTP; Wed, 23 Apr 2014 00:33:40 -0700 (PDT)
In-Reply-To: <xmqqbnvt2d7v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246812>

On Wed, Apr 23, 2014 at 12:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> What we could do instead is simply require a newer version of
>> Getopt::Long, which would let people continue using their ancient OSes
>> and install a newer version from CPAN if necessary.  It's also the
>> proper way to specify the dependency.
>
> Yes, but if its inability to properly grok --option="" is the only
> reason we want to add a dependency, wouldn't it suffice to simply
> state in the documentation (1) how to recognise the symptom to see
> if the version the user has is too old, e.g. "if you see this error
> message", "run 'perl -v' to see if your perl is older than X",
> etc. and (2) how to work it around, i.e. "instead of giving an empty
> value with --option='', say --option ''"?

FWIW, the least intrusive approach is what I find most agreeable:

 - Fix the tests to use --prefix "" instead of --prefix=""
 - Update the documentation like Junio suggests above.
 - Reformat an example using --prefix ""

I.e. use Kyle's patch to t9117, plus something like this:

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 5b3c38d..9f579e0 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -91,6 +91,9 @@ COMMANDS
 NOTE: Before Git v2.0, the default prefix was "" (no prefix). This
 meant that SVN-tracking refs were put at "refs/remotes/*", which is
 incompatible with how Git's own remote-tracking refs are organized.
+If you still want the old default, you can get it by passing
+'--prefix ""' on the command line ('--prefix=""' may not work if
+your Perl's Getopt::Long is < v2.37).

 --ignore-paths=<regex>;;
        When passed to 'init' or 'clone' this regular expression will



...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
