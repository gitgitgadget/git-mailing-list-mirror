From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: crash proof / recovery from power loss
Date: Thu, 25 Jun 2009 15:31:29 +0200
Message-ID: <46a038f90906250631k5e702f66g50a6e60db8bab856@mail.gmail.com>
References: <20090623210556.GB31015@twin.sascha.silbe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Sascha Silbe <sascha-ml-reply-to-2009-2@silbe.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJp49-0000a7-O6
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbZFYNb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 09:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZFYNb2
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:31:28 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:55452 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZFYNb2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 09:31:28 -0400
Received: by bwz9 with SMTP id 9so1397236bwz.37
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=rkvTJ3LLyDvZhnclMw7REMuVwe/eLvv+vu/S9Lgh55c=;
        b=T5LJnBTZc3T1u7JIAb5TvwqbAjvSmq76ZT280V4kKEMTKX9fDi8Qte0x+XnPSdIskk
         LNVrqEzklYe2r8nWtJSLr0ruY/q37f/etXeo9ZmLZvXWd+rCKwB3jUWIrqJ4r2GbTHF/
         Ro0KvU4q6Eklirilz2UkOvn7Q4rwODeTIlAwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=IBMnIBQSCrRF82fVLwH5BXu7EqA6wSnCMWMPs5g83ujjvubHBfaEGTB3L5lKY3yvtG
         YvxmtnrIHIpZIfwIYLb2CDrz8CpBZFPe51t6tF4BxtklCD3HP8syi5P1OB5nNxsXKWAC
         i3ZilqCGy1JI6Kypc0BZkMzzlS65rLqaD5bYE=
Received: by 10.223.106.148 with SMTP id x20mr2126020fao.68.1245936689853; 
	Thu, 25 Jun 2009 06:31:29 -0700 (PDT)
In-Reply-To: <20090623210556.GB31015@twin.sascha.silbe.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122211>

On Tue, Jun 23, 2009 at 11:05 PM, Sascha Silbe
<sascha-ml-devel-vcs-git@silbe.org> wrote:
> I'm going to use git as a back end for the Sugar data store / Journal=
=2E [1]
> One thing I'm worried about is how it's going to behave if a crash (e=
=2Eg. power loss - no corruption) occurs.
> What can happen in such a case? Is it always recoverable and if so, h=
ow?

Git is outrageously good in keeping things sane. On that front, you
won't see any problems.

Now... there is one area where it will hurt lots: storing large binary
blobs. Git assumes that every file is very small in comparison with
available physical memory.

 - Sugar utilities already can create files larger than available
memory. Think Record.xo, etoys, etc.

 - Many sugar target platforms are _very_ memory constrained. XO-1
being the prime example.

Lots of what git does would be good in the Journal. But some of the
core assumptions are not well matched.

There are some tunables in git that might help. And maybe you can
sidestep the harder corners of the problem by having a threshold, and
handling large files separately.

hth,




m
--
martin.langhoff@gmail.com
martin@laptop.org -- School Server Architect
- ask interesting questions
- don't get distracted with shiny stuff =A0- working code first
- http://wiki.laptop.org/go/User:Martinlanghoff
