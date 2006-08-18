From: Junio C Hamano <junkio@cox.net>
Subject: Unresolved issues #3
Date: Thu, 17 Aug 2006 21:09:03 -0700
Message-ID: <7vpseyelcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 18 06:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDvfU-0002HL-Na
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 06:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWHREJH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 00:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWHREJG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 00:09:06 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5312 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030235AbWHREJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 00:09:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060818040904.MRDP6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Aug 2006 00:09:04 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25619>

As everybody has probably noticed already, I am terrible at
maintaining "the current issues" list.  The most recent issue of
this series was done when?  Back on May 4th this year.

Shame on me.


Here is a list of topics in the recent git traffic that I feel
inadequately addressed, in no particular order.  I've commented
on some of them to give people a feel for what my priorities
are.  Somebody might want to rehash the ones low on my priority
list to conclusion with a concrete proposal if they cared about
them enough.


* Mozilla import team seems to be making an interesting set of
  discoveries around the area of scalability, although I haven't
  personally looked at any of the tools they are using so far.

  Continued discussion is encouraged, and I am looking forward
  to see the fruits of this effort.  Very much appreciated.

* Eric W Biederman outlined an alternative workflow to track
  history of the tip of a branch that does not use ref-log
  facility.

  Message-ID: <m1mzakpam8.fsf@ebiederm.dsl.xmission.com>

  I think this sort-of makes sense when everybody involved does
  not misuse the fake parallel branch for purposes other than
  tracking the tip of the other, "true", branch, but I fear it
  would confuse people quite a bit.  Eric talks about making
  rewinding and rebasing in distributed manner possible, but I
  do not know what merging between the fake branches would mean,
  for example.

* Matthias Lederhofer's helper for stand alone gitweb test looked
  very promising:

  Message-ID: <20060806165151.GB9548@moooo.ath.cx>

  With the recent flurry of gitweb changes, we really need a
  test suite to catch obvious breakages in the t/ hierarchy, and
  something like this patch would help.

  I'd like to apply this patch, if somebody wants to add gitweb
  tests.

* Jeff King sent a patch to color git-status output

  Message-ID: <20060805031418.GA11102@coredump.intra.peff.net>

  But later he started working on rewriting one core function
  from git-status in C, which I think makes a lot of sense.
  That would make this patch unnecessary.  A thread related to
  this effort is this:
  
  Message-ID: <20060810082455.GA30739@coredump.intra.peff.net>

  Hoping to see the C implementation of run_status but I am in
  no rush myself.

  I vaguely recall there was a companion patch to add vim
  colorizer for the current git-status output, meant for
  contrib/vim, but I lost it.  If somebody cares deeply enough
  please send it over.

* Alex Riesen still has problems with Git.pm/Git.xs on Windows
  with ActiveState Perl.

  Message-ID: <81b0412b0608020702q2fd4ec83ga43714c15538f7ad@mail.gmail.com>

  There was a workaround patch by Alex to disable certain
  commands that happen to use Git.pm:

  Message-ID: <81b0412b0608040640s44c0d84et94871bce0271b047@mail.gmail.com>

  But I sense this would make us think twice before using Git.pm
  in new programs (i.e. "Can Alex live without this new nice
  program?  If not maybe we should write it without Git.pm"),
  which feels backwards and I would like to avoid it if we can.

  I am not sure what the resolution of this should be.

* Michael S. Tsirkin discovered that we have trouble dealing
  with the same remote ref tracked by multiple tracking
  branches.

  Message-ID: <20060807125116.GA28658@mellanox.co.il>

  Since I do not see a valid use case that _must_ use more than
  one local tracking branch to track one remote ref, I think it
  is Ok to declare it an error to do so.  However, at least, we
  would need a better error message even then.

* Jeff Garzik reports that the summary page of gitweb does not
  look at anything other than "master" which is not appropriate
  for his tree.

  Message-ID: <44D874F0.6000907@garzik.org>

  I probably should bug gitweb gang (Jakub, Luben, Martin Waitz,
  Aneesh) about this.

* gitk bottom-left pane layout is reported to be broken for some
  people.

  Message-ID: <20060802192922.GA30539@prophet.net-ronin.org>

  "carbonated beverage" tried some random hacks to work it
  around but I do not think we have gotten anywhere, and the
  discussion fizzled out.

  I vaguely recall paulus saying it was a Tk bug but do not
  recall hearing nor understanding any details myself.

* "A Large Angry SCM" wrote a nice summary, "Git files data
  formats documentation".

  Message-ID: <44D51D47.9090700@gmail.com>

  With one final update by Nico yesterday, I think it is ready
  for inclusion.

  Does somebody care to make a patch out of it to add it to
  Documentation/technical/, maybe removing pack-format.txt there
  after making sure all it talks about is covered by the new
  documentation?

  I do not have enough "virginity" to spot omissions in the
  description anymore, so comments from somebody new to the
  system are very much appreciated.

* Martin Langhoff proposed git-xxdiff as a helper after a failed
  merge.

  Message-ID: <11546492331601-git-send-email-martin@catalyst.net.nz>

  I like the general idea of this a lot, but am having a bit of
  trouble envisioning how we can integrate this while making
  sure mergers other than xxdiff can be added easily without
  disrupting the end user experience.

* Shawn Pearce noticed that fsck-objects do not fully check some
  fields in commits:

  Message-ID: <20060814062830.GF18667@spearce.org>

* Although "annotate" had some big fixes just before 1.4.2, Ryan
  seems to feel "blame" has already won.

  Message-ID: <20060807194539.GD15477@h4x0r5.com>

  Is there still an area "annotate" shines more than "blame -c"?

* "Michael barra_cuda" noticed that an option "--no" is
  ambiguous to git-revert:

  Message-ID: <200608031742.23170.barra_cuda@katamail.com>

  I need to fix this.

* Cherry-pick should not require -r to suppress "cherry-picked
  from" message.

  Message-ID: <Pine.LNX.4.64.0607120834200.5623@g5.osdl.org>

  This was requested by Linus, which I haven't done anything
  about yet.  Maybe making -r a no-op, defaulting not to add the
  message, and introducing --record-original flag to add it
  would be a way to go?  My fingers are trained to automatically
  type -r when doing cherry-pick which is a very good indication
  that the flag was a mistake.

* Martin Waitz has a patch to accept "end-of-cover-letter"
  marker in patch messages.

  Message-ID: <20060723214524.GC20068@admingilde.org>

  I did not take the patch, primarily because I do not want to
  encourage "cover letter then log then patch" format, and also
  the proposed marker "+++" looked somewhat ugly (see Message-ID:
  <20060801193408.GF16364@admingilde.org> for an example).

  If somebody wants to rehash this I am still open to reconsider
  it, but I sense a veto from Linus coming...
