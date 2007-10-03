From: david@lang.hm
Subject: Re: metastore
Date: Tue, 2 Oct 2007 17:52:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710021743270.25489@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
 <20071002211518.GA10445@hardeman.nu> <Pine.LNX.4.64.0710030018240.4087@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-1463811584-1531084491-1191367938=:4087"
Cc: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	David Kastrup <dak@gnu.org>,
	martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 03 02:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcsSq-0006TE-0b
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 02:51:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbXJCAvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 20:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbXJCAvk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 20:51:40 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:39635
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbXJCAvj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 20:51:39 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l930orSQ024356;
	Tue, 2 Oct 2007 17:50:53 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0710030018240.4087@reaper.quantumfyre.co.uk>
Content-ID: <Pine.LNX.4.64.0710021743271.25489@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59763>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1531084491-1191367938=:4087
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0710021743272.25489@asgard.lang.hm>

On Wed, 3 Oct 2007, Julian Phillips wrote:

> Subject: Re: metastore
> 
> On Tue, 2 Oct 2007, David Härdeman wrote:
>
>> On Tue, Oct 02, 2007 at 10:04:56PM +0200, David Kastrup wrote:
>>> David Härdeman <david@hardeman.nu> writes:
>>> 
>>> >  On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>>> > > also sprach David Härdeman <david@hardeman.nu> [2007.09.19.2016 
>>> +0100]:
>>> > > >  But I agree, if any changes were made to git, I'd advocate adding
>>> > > >  arbitrary attributes to files (much like xattrs) in name=value
>>> > > >  pairs, then any extended metadata could be stored in those
>>> > > >  attributes and external scripts/tools could use them in some way
>>> > > >  that makes sense...and also make sure to only update them when it
>>> > > >  makes sense.
>>> > > > > So where would those metdata be stored in your opinion?
>>> > >  I'm not sufficiently versed in the internals of git to have an
>>> >  informed opinion :)
>>> 
>>> I think we have something like a length count for file names in index
>>> and/or tree.  We could just put the (sorted) attributes after a NUL
>>> byte in the file name and include them in the count.  It would also
>>> make those artificially longer file names work more or less when
>>> sorting them for deltification.
>> 
>> Or perhaps the index format could be extended to include a new field for 
>> value=name pairs instead of overloading the name field.
>> 
>> But as I said, I have no idea how feasible it would be to change git to 
>> support another arbitrary length field in the index/tree file.
>> 
>>> However, this requires implementing _policies_: it must be possible to
>>> specify per repository exactly what will and what won't get tracked,
>>> or one will get conflicts that are not necessary or appropriate.
>> 
>> I think the opposite approach would be better. Let git provide 
>> set/get/delete attribute operations and leave it at that. Then external 
>> programs can do what they want with that data and add/remove/modify tags as 
>> necessary (and also include the smarts to not, e.g. remove the permissions 
>> on all files if the git repo is checked out to a FAT fs).
>
> You need more than that.  You need to be able to log, blame etc on the 
> attributes.  One of the big annoyances of Subversion properties is being 
> unable to find out when or why a property value was changed.
>
> I still don't see why the attributes need to be stored in git directly - 
> particularly if you are going to use an external program to actually apply 
> any settings - why not store the attributes as normal file (or files) of some 
> sort tracked by git?  You could use any number of methods - e.g. use an 
> sqlite database stored in the root of your tree, or a .<name>.props file 
> alongside each path that you have properties for.  You could even write a 
> system that uses such a method and was then SCM agnostic, allowing you to 
> keep your attribute tracking system if/when something better than git comes 
> along - or simply share it with less-fortunate souls stuck in an inferior 
> system.

one other big advantage of keeping things in a normal file, it's easier to 
get the results accepted into git!

don't forget that the core git maintainers don't really see this as a 
worthwhile effort, so the more intrusive the result is the less likely it 
is to be accepted. It may end up that storing the attributes inside of git 
_is_ the best thing to do, but it's gong to be a whole lot easier to get a 
patch to implement this accepted if it's a migration from an existing, 
heavily used, implementation then if it's from the 'outside' with people 
saying "this is a neat thing, we think people would use it if it only had 
this"

and even if an internal implementation does end up being the right thing, 
the exact shape of the API is an item that will require a lot of debate 
(and probably a few false starts) to get right. let's figure out the 
real-world useage patterns first, and then work from there as appropriate.

shifting back onto implementaion details

in the discussion a few weeks ago I was told that there is a way to look 
at the contents of a file that hasn't been checked out yet (somehow it 
exists in a useable form 'in the index') but when I asked for information 
about how to do this I never got a response.

the reason for needing this is that the routines writing the files need to 
be able to access this information when they are dong so, but that file 
may not be checked out.

for that matter, .gitattributes should have a similar problem (if 
.gitattibutes for a directory hasn't been checked out yet how do you know 
if you could do the line ending conversions on a file or not?). how is the 
problem addressed there? (or is it the case that all the use so far has 
really not used the per-directory files and everything is in the master 
file, and that doesn't change enough to find these problems?

David Lang
---1463811584-1531084491-1191367938=:4087--
