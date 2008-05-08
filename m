From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: [RFC] Use cases for 'git statistics'
Date: Thu, 8 May 2008 17:51:35 +0200
Message-ID: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 08 17:52:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ju8QA-0000Zv-0f
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 17:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764113AbYEHPvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 11:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbYEHPvl
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 11:51:41 -0400
Received: from el-out-1112.google.com ([209.85.162.177]:1800 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762699AbYEHPvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 11:51:37 -0400
Received: by el-out-1112.google.com with SMTP id s27so239494ele.1
        for <git@vger.kernel.org>; Thu, 08 May 2008 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=/4d35cSht5eSDh5Ue7qjuX+upOMTw6nONxPcDNMUVpk=;
        b=VUHfkpi1nx8JJYQlfL9ZTB+JoALWmSbFnXu3t9A1m4ByaTvA3mL1IE8OPPJsq50Q3WdkNIWX4Sn7TDg4Ez9F/mJdy1OjGzf4071bQMLwlFp1l94WHtrtUrESPmiS4Yd+kxD8+VeQSOFbvUgZ37H2pDy4ZKen2DQlkmhVOGn7oHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=SsaBLqvw39sbkISfmEZ2nWI7/bqOAmP1Tl/Y7UeAP+ZS1DFbiwNmUOpAyIMcRmlzg9UMAwZ4gVYU5nydC4koc+F1YSQai5oqumgeiiXaxX6Osn1relQ7CyX+E1xEQQeLY5G54DeiG8sIH2oOBPLm3BDT1XehuNZls17gmBLtnD8=
Received: by 10.142.211.10 with SMTP id j10mr1458601wfg.202.1210261895437;
        Thu, 08 May 2008 08:51:35 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Thu, 8 May 2008 08:51:35 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ef49ede9b62bf31a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81534>

Heya,

I've been busy to write up some use cases for 'git statistics' (a new
command that I will be implementing this summer during Google Summer
of Code). For more details on my proposal please see
http://alturin.googlepages.com/gsoc2008 (a pdf of the use cases is
hosted there as well for those who prefer pdf). I would like to ask
for comments on the current use cases; is anything missing, or should
a particular use case be removed/merged? Please let me know.

Thank you for your time.



== Terminology ==

There are four types of users: Maintainers, Developers, Bug-fixers,
and regular Users. The first three are all Contributors.

Name: Maintainer (Contributor)
Description: The Maintainer reviews commits and branches from other
Contributors and decided which ones to integrate into a 'master'
branch.

Name: Developer (Contributor)
Description: The Developer contributes enhancements to the project,
e.g. they add new content or improve existing content.

Name: Bug-fixer (Contributor)
Description: The Bug-fixer locates 'bugs' (as something unwanted that
needs to be corrected) in the content and 'fixes' them.

Name: User
Description: The User uses the content, be it in their daily work or
every now and then for a specific purpose.



== Use cases ==


A model where other Contributors review commits is assumed in all use
cases. When referenced are made to a Contributor addressing another
Contributor to adjust their behavior as the result of data mined, it
should be kept in mind that the Contributor should foremost be the one
to do this. Using this information to, say, spend more time checking
one's own commits for bugs when working on a specific part of the
content on one's own accord is is often more effective then doing so
only after being asked. </disclaimer>? :P


Name: Finding a Contributor that is active in a specific bit of content.
Description:
	Whenever a Contributor needs to know about other Contributors that
are active in a specific part of the content they query git for this
information. This could be used to figure out whom to send a copy of a
commit (someone who has recently worked on the content a commit
modifies is likely to be interested in such a commit). This
information may be easily gathered with, say, git blame. Aggregating
it's output (in the background if need be to maintain speedy response
times), it is trivial to determine whether a Contributor has more
commits/lines of change than a predefined amount. The main difference
with git blame is that it's output is aggregated over the history of
the content, for a specific Contributor, whereas git blame only shows
the latest changes.


Name: Finding which commits touches the parts of the content that a
commit touches.
Description:
	There are several reasons that one might want to know which commit
touches the parts of the content that a commit touches. This may be
implemented similar to how git blame works only instead of 'stopping'
after having found the author of a line, the search continues up to a
certain date in the past.


Name: Integrating the found 'bug introducing' commit with the git
commit message system.
Description:
	When a Bug-fixer sends out a commit to fix a bug it might be useful
for them to find out where exactly the bug was introduced. Using the
'which commit touched the content this commit touches' technique
optional candidates may be retrieved. After picking which of the found
commits caused the bug, this information may then automatically added
to the commit's description. This does not only allow the Bug-fixer to
make clear the origin of their commit, but also make it possible to
later unambiguously determine a bug/fix pair. Note that this is
automated, no user input is required to determine which commit caused
the bug, only the picking of 'cause' commits requires input from the
user.


Name: Finding the Author that introduce a lot of/almost no bugs to the content.
Description:
	Contributors might be interested to know which of the Developers
introduce a lot of bugs, or the contrary, which introduce almost no
bugs to the content. This information is highly relevant to the
Maintainer as they may now focus the time they spend on reviewing
commits on those that stem from Developers that turn out to often
introduce bugs. On the other hand, Developers that usually do not
introduce bugs need less reviewing time. While such information is
usually known to the experienced Maintainer (as they know their main
contributors well), it can be helpful to new maintainers, or as a
pointer that the opinion of the Maintainer about a specific Developer
needs to be adjusted. Bug-fixers on the other hand can use this
information to address the Developer that introduces most of the bugs
they fix, perhaps with advice on how to prevent future bugs from being
introduced.


Name: Finding the Contributor that accepted a lot of/almost no bugs
into the content.
Description:
	Similar to the finding Authors that write the bugs, there are other
Contributors that 'accept' the commit. Either passively, by not
commenting when the commit is sent out for review, or actively, by
'acknowledging' (acked-by), 'signing off' (signed-off-by) or 'testing'
(tested-by) a commit. When actively doing so, this can later be
traced, this information can then be used in the same ways as for
Authors.


Name: Finding parts of the content in which a lot of bugs are
introduced and fixed
Description:
	When a Developer decides to change part of the content, it would be
interesting for them to know that many before them introduced bugs
when working on that part of the content. Knowing this the Developer
might ask for all such buggy commits to try and learn from the
mistakes made by others and prevent making the same mistake. A
Maintainer might use this information to spend extra time reviewing a
commit from a 'bug prone' part of the content.

	
Name: Finding parts of the content a particular Contributor introduces
a lot of/almost no
bugs to.
Description:
	When trying to decide whether to ask a specific Contributor to work
on part of the content it might be useful to not only know how active
they work on that part of the content, but also if they introduced a
lot of bugs to that part, or perhaps fixed many. Similar to the more
general case, this can be split out between modifying content and
'accepting' modifications. This information may be used to decide to
ask a Contributor to spend more time on a specific part of the content
before sending in a commit for review.

	
Name: Finding how many bugs were introduced/fixed in a period of time
Description:
	As bugs are recognized by their fixes, it is always possible to match
a bug to it's fix. Both commits have a time stamp and with those the
time between bug and fix can be calculated. Aggregating this data over
all known bug(fixes) the amount of unfixed bugs may be found over a
specified period of time. For example, finding the amount of fixed
bugs between two releases, or how many bugs were not fixed within one
release cycle. This number might then be calculated over several time
frames (say, each release), after which it is possible to track
'content quality' throughout releases. If this information is then
graphed one can find extremes in this figure (for example, a release
cycle in which a lot of bugs were fixed, or one that introduced many).
Knowing this the Contributors may then determine the cause of such and
learn from that.

	
Name: Finding how much work a contributor has done over a period of time
Description:
	When working in a team in which everybody is expected to do
approximately the same amount of work it is interesting to see how
much work each Contributor actually does. This allows the team to
discuss any extremes and attempt to handle these as to distribute the
work more evenly.
	When work is being done by a large group of people it is interesting
to know the most active Contributors since these usually are the ones
with most knowledge on the content. The other way around, it is
possible to determine if a specific Contributor is 'active enough' for
a specific task (such as mentoring).

	
Name: Finding whether a Contributor is mostly a Developer or a Bug-fixer
Description:
	To all Contributors it is interesting to know if they spend most of
their time fixing bugs, or contributing enhancements to the content.
This information could also be queried over a specific time frame, for
example 'weekends vs. workdays' or 'holidays vs. non-holidays'.



-- 
Cheers,

Sverre Rabbelier
