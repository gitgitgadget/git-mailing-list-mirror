From: Kevin Ballard <kevin@sb.org>
Subject: Re: `git status --porcelain` disagrees with documentation about quoting filenames with spaces
Date: Thu, 28 Oct 2010 14:17:31 -0700
Message-ID: <EFFE2D68-BBA3-4EF4-B56A-AA4882EDE1E4@sb.org>
References: <4AC7298E-73D7-4074-91CD-7C10DE414532@sb.org> <7v39rqb1ji.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 23:18:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZrN-0004BU-9w
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 23:18:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203Ab0J1VRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 17:17:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39252 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760149Ab0J1VRf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 17:17:35 -0400
Received: by gyg4 with SMTP id 4so1593779gyg.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 14:17:34 -0700 (PDT)
Received: by 10.91.10.20 with SMTP id n20mr3296036agi.56.1288300654383;
        Thu, 28 Oct 2010 14:17:34 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id z43sm1081298yhc.12.2010.10.28.14.17.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 14:17:33 -0700 (PDT)
In-Reply-To: <7v39rqb1ji.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160228>

On Oct 28, 2010, at 11:44 AM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
> [jc: why do you send messages with toooooooooooo loooooong lines sometimes
> and normal line lengths some other times...?]

I use a GUI mail client to write email. Anything I copy&paste is hard-wrapped,
anything I write directly tends to not include hard linebreaks at all. Would it
be better if I hard-wrapped my lines?

>> Given that the removal of quoting for filenames with spaces was an
>> intentional change, does anybody have any strong opinions about whether
>> we should restore the quotes in this scenario? The alternative is to
>> simply change the documentation, but the un-parsability of the
>> --porcelain format has me worried.
> 
> 28fba29 (Do not quote SP., 2005-10-17) explicitly addressed a breakage
> that quoted pathnames in contexts like this one:
> 
>    diff --git a/My Documents/hello.txt b/My Documents/hello.txt
> 
> I personally think people who add SP to their pathnames need to get their
> head examined, and in that sense I do not strongly mind if the pathnames
> in the above are quoted (that is why the original quotation before the
> said commit quoted them), but apparently other people did mind.  I also
> think people who have " -> " in their pathnames are even less sane beyond
> salvation, and between the two insanity, I'd rather help less insane ones
> by not quoting the above.

I agree that SP in pathnames in source is insane, but it's perfectly common to
do when working with non-source files. For example, in the project I'm using
right now, I have a file named "Application 1.0.xcdatamodel" and another named
"Application 1.1.xcdatamodel". These are data files and their name on disk
matches the name given to them in the IDE. In this case, I think the SP is
perfectly justified. Granted, having " -> " in your pathname is also pretty
insane, but my motivation here is just ensuring that the --porcelain format
is parseable even if you are insane.

> The best would probably be to special case SP (which is normally not to be
> quoted) _only_ in the context of "something" -> "something".

That's what I was thinking. I'll look into doing just that.

-Kevin Ballard