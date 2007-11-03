From: Jim Meyering <jim@meyering.net>
Subject: Re: why the 'g' prefix on the SHA1 in git-describe output?
Date: Sat, 03 Nov 2007 17:10:43 +0100
Message-ID: <87ir4j71j0.fsf@rho.meyering.net>
References: <871wb7a53d.fsf@rho.meyering.net>
	<8c5c35580711030656h23d5910ah824de41a2cf4eafe@mail.gmail.com>
	<472C915E.8070205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Nov 03 17:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoLaO-0002BQ-VB
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 17:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbXKCQKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 12:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754595AbXKCQKp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 12:10:45 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55871 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbXKCQKo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 12:10:44 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ED1B917B57F
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 17:10:43 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id D6DE617B57A
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 17:10:43 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 8962E54C01; Sat,  3 Nov 2007 17:10:43 +0100 (CET)
In-Reply-To: <472C915E.8070205@op5.se> (Andreas Ericsson's message of "Sat, 03
	Nov 2007 16:18:54 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63289>

Andreas Ericsson <ae@op5.se> wrote:
> Lars Hjemli wrote:
>> On Nov 3, 2007 1:25 PM, Jim Meyering <jim@meyering.net> wrote:
>>> Can anyone tell me what motivated adding the 'g' prefix on the SHA1 in
>>> git-describe output?
>>
>> I'm not sure what _motivated_ the 'g', but currently git-rev-parse
>> understands the output from git-describe _if_ the 'g' is present.
>>
>
> It's been there since 908e5310b958619559d34b0b6da122f058faa47e, which
> has the commit-subject 'Add a "git-describe" command'.
>
> I think it'd be more trouble removing it now than it is to keep it,
> since a lot of script depend on it being there for parsing out
> versioning info in various autobuild- and release scripts.
>
> If you want to change it, I'd suggest adding a "--no-sha1" option
> that makes the entire "-g%s" part of the output go away, or
> perhaps adding a --format="%v-%d-%g" (for the default behaviour).

Thanks to both of you for the feedback.
FYI, I didn't propose to change it in git.

I was wondering whether to restore the 'g' in snapshot version
numbers for coreutils, autoconf, etc.:

  http://thread.gmane.org/gmane.comp.sysutils.autoconf.general/9784/focus=9811

Since coreutils version strings will end up having at least one more "."
(currently they look like this: 6.9-375-3e3f8), that means transforming
a version string into input for git-rev-parse will require the reverse
xform.  Once you're doing some transformation, an additional one to
insert the required 'g' is no big deal, so I expect to continue omitting
the 'g' from version strings: makes file names 1 byte shorter.
