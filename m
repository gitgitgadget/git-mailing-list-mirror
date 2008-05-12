From: "Dana How" <danahow@gmail.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sun, 11 May 2008 22:57:01 -0700
Message-ID: <56b7f5510805112257u13252c71kda880fb3f3e43485@mail.gmail.com>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop>
	 <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop>
	 <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org>
	 <83EE186A7AF140179C6C73B367471EC7@justinuTop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>, git@vger.kernel.org,
	justin0927@hotmail.com, danahow@gmail.com
To: "Justin Leung" <jleung@redback.com>
X-From: git-owner@vger.kernel.org Mon May 12 07:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvR2s-0005xY-DH
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 07:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbYELF5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 01:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753225AbYELF5H
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 01:57:07 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:21022 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYELF5D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 01:57:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1683063fgg.17
        for <git@vger.kernel.org>; Sun, 11 May 2008 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=D7FaFW+ayYJ3hiPzvy9k9G2i+oIft8Z/7rC1uU8MvgM=;
        b=Nsrlv3cyXw5pWjjNXg8EM3F0LwZCJfm7FXqdV4QS9V/GuGTDbk8ut1yf6GO5+jAcEjDTvD85hK7ZkkROFie56uKLqj629DSdEg/VlOJ76JT7AD4R1SwKq689eJ8CdJ3QUgIi/UYCvIDOhGPz3woPkbTx/haHhbiIORrYI0ZQ0Jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O2sU1w95L8XgP8o9YD5P8B6XAR/Z7ojhqCpdSt8mm1xBrRsBIhwNp2NtK7xXBPwlfsrfJHZkC/Lb6uB9JINeAZcfA1eX1ezY9kQ8v1T4zCDixMRWlv06I477EYRCi4opx2/ZoSqVG4Svqgdjh/Ybxx4zd0mLsnqFvCoWral8EKw=
Received: by 10.78.170.6 with SMTP id s6mr1836081hue.75.1210571821990;
        Sun, 11 May 2008 22:57:01 -0700 (PDT)
Received: by 10.78.130.7 with HTTP; Sun, 11 May 2008 22:57:01 -0700 (PDT)
In-Reply-To: <83EE186A7AF140179C6C73B367471EC7@justinuTop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81833>

On Sat, May 10, 2008 at 10:29 PM, Justin Leung <jleung@redback.com> wrote:
> > Honestly, it sounds like SVN is actually a good fit here. Just because git
> > is awesome for many things does not mean it is the end-all-be-all  of
> > version control systems. SVN still has its place as the last true
> > centralized system. Given your constraints and workflow, why do you  think
> > git is better than SVN?
>
> The ability of inter-user (designer-verifier) code sync'ing without letting
> the incomplete or incompatible RTL code to propagate to the main build
> stream is going to facilitate the design flow and efficiency .
>
> The ability of local revision control means that no more over writing of
> design files until commit .
>
> I think these 2 things will really buy us alot .

Hi Justin,

I was originally drawn to git for the exact reasons you identified in
your 2nd email.
Namely,  it is extremely difficult in a p4-based environment to share
intermediate work within a design team without pushing the work out to
be visible by the entire team.  "Inter-user design sync'ing" is exactly what
I wanted.  In its absence,  we have made all references between files
relative.  This means you can flip over to someone else's netlist by changing
one path (say to the top-level design file) to point into someone's private
repository.  That top-level file then includes everything else using paths
relative to its own location,  so you get the correct stuff automatically.
Of course,  you get tripped up all the time by stuff implicitly used and not
named in the top-level file and its children...

Now,  it would be far better for this to be a lightweight branch in git,  and
then having people checkout this branch and use it.  (Because,  for example,
while one person is pointing into another's tree,  the latter can't change.)
But p4 (and cvs) has trained everyone to think of branches as painful and
for wizards only.  Plus I am not personally interested in investing any time
writing scripts on top of p4;  the ideas I outlined in the previous paragraph
were easier and almost as good as anything (easily) doable in p4
(but not as good as lightweight branching).

I agree with other responses to your email that you may want to think
about writing simple wrapper scripts that add tags to checkins with some
simple incrementing numeric part to keep your back-end people happy.  Yet
other responses were distracted by the linearity of your centralized/shared
checkins:  the inter-design sync'ing you want,  and the lightweight branching
it may imply,  aren't necessarily incompatible with the linear main
public history
that most design teams expect (and which is unavoidable in design work
containing lots of unmergeable files,  such as layout design).
So I don't necessarily think you would be happy with Subversion
(I'm certainly not happy with p4).

There are two other issues you may want to keep in mind.  In our
chip design activities,  we have a lot of very large files (100MB to ~3GB),
and the p4 repository has grown beyond 3TB.  Now,  this is simply
a data set size region which is not used by the git developers.  I think
the git data model is fine for large projects and files (Linus mused otherwise
a few weeks ago,  but it seems fine to me),  but due to lack of use,
various details when handling large files/projects remain to be worked out
and/or optimized as much as the rest of git.  It is true since I
started watching
there have been a lot of important improvements in this area.

Secondly,  you may also want to discuss with your IT people (or whoever
is responsible for back-up) how git packs/repacks repositories.  Ours were
very uncomfortable with the idea that the _entire_ repository has to get
re-arranged frequently.  I think they would have been much happier
with an approach more similar to how Unix systems were backed up in the
80s: have a level-0 repack which repacks everything, a level-1 which repacks
only stuff added since the last level-0,  level-2 since level-1,  etc.
To do this would be a pretty straightforward change to git-repack.sh,
probably using .keep files.  In each level it is clear what needs to
be backed up.

Anyway,  good luck!  Many of the things you touched on,  or which I
mentioned above,  have been (partially) implemented or at least
discussed before,
so your requests aren't crazy.  Unfortunately,  in my case,  having 6 surgeries
in my family in the last year has kept me from doing that much useful
for git along these lines and thus I remain stuck with p4 for now.
-- 
Dana L. How danahow@gmail.com +1 650 804 5991 cell
