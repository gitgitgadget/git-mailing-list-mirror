From: david@lang.hm
Subject: Re: Google Summer of Code 2009: GIT
Date: Thu, 19 Mar 2009 17:07:47 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0903191652500.16753@asgard.lang.hm>
References: <49B74373.3090609@gmail.com>  <alpine.DEB.1.10.0903121052310.16753@asgard.lang.hm>  <ab9fa62a0903121119j6c2a1d43kd9cda99db47b5e7c@mail.gmail.com>  <alpine.DEB.1.10.0903121148540.16753@asgard.lang.hm>  <ab9fa62a0903121200v73ec3522gcdebcd34122efc72@mail.gmail.com>
  <alpine.DEB.1.10.0903121214390.16753@asgard.lang.hm>  <ab9fa62a0903121245m621643bfq3c58557ccc9b266f@mail.gmail.com>  <alpine.DEB.1.10.0903121255040.16753@asgard.lang.hm>  <ab9fa62a0903121303v5a6cbf0ax413cc440b9c32e77@mail.gmail.com> 
 <alpine.DEB.1.00.0903190003100.10279@pacific.mpi-cbg.de> <ab9fa62a0903191217t5d0e6d9cn4915a425ed8084ff@mail.gmail.com> <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="8323328-52542757-1237506161=:10279"
Cc: saurabh gupta <saurabhgupta1403@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSJN-00026d-Gr
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbZCTAIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755389AbZCTAIE
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:08:04 -0400
Received: from mail.lang.hm ([64.81.33.126]:60745 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622AbZCTAIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:08:01 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id n2K07lDb013633;
	Thu, 19 Mar 2009 16:07:47 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.DEB.1.00.0903200034230.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Content-ID: <alpine.DEB.1.10.0903191652501.16753@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113868>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-52542757-1237506161=:10279
Content-Type: TEXT/PLAIN; CHARSET=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.10.0903191652502.16753@asgard.lang.hm>

On Fri, 20 Mar 2009, Johannes Schindelin wrote:

> Hi,
>
> On Fri, 20 Mar 2009, saurabh gupta wrote:
>
>> On Thu, Mar 19, 2009 at 4:46 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>>> For example, if we decide that OOXML is a must (as it is a proper
>>> standard, and many people will benefit from it), we will most likely
>>> end up in having to write a merge _driver_ (to handle those .zip
>>> files), _and_ a merge _helper_, although we can avoid writing our own
>>> GUI, as we can create an OOXML that has its own version of conflict
>>> markers.
>>
>> Well, for ODF type document, we can write a merge driver which will
>> change the xml file in an appropriate way that OO can understand it and
>> the user can see the merge result/conflict in a comfortable way. As
>> described by Junio, in this case, a dedicated merge helper is not needed
>> as OO can parse the markers made by merge-driver and provide the user to
>> resolve the conflict and register the changes to index.
>
> There is also the idea that OOffice has building blocks in place to help
> resolving merge conflicts.  For a successful application, you will have to
> show that you researched that option, and describe how well/badly it fits
> with the goal of the project.

true, although for the 'simple case' of an ODF text file you can use 
text strings exactly the same way you do with a text file. the difference 
is that when inserting the two versions of things into the 'conflict' 
version of the ODF file you need to make sure that you include the 
complete open/close set of tags in each version.

for example if file 1 has

<tag1 param='1'>
text
</tag1>

and file 2 has

<tag1 param='1'>
text2
</tag1>

you can do


<tag1 param='1'>
>>>>>>>>
text
========
text2
<<<<<<<<
</tag1>


but if file2 has


<tag1 param='2'>
text
</tag1>

your conflict would need to be

>>>>>>>>
<tag1 param='1'>
text
</tag1>
========
<tag1 param='1'>
text
</tag1>
<<<<<<<<

(although since < and > are special characters, they would really be &gt 
and &lt in the file)

if there are nicer ways to do this, supporting them would be good, but as 
long as the marker strings are configurable you can probably do so

you could change
the first string from >>>>>>> to <conflict option='1'>
the second string from ======== to </conflict><conflict option='2'>
the third string from <<<<<<< to </conflict>

and now instead of having to search for those special text strings, your 
ODF editor would 'magicly' identify them and remind you that you hadn't 
resolved all of them.

>>> - knowing what data types we want to support _at the least_, and what
>>>   data  types we keep for the free skate,
>>
>> As of now, how about going for XML files. For this summer, we can go for
>> XML files and latex files can be handled later.
>
> If your goal is just XML files (without any more specific goal, like ODF
> or SVG), I am afraid that I think that project is not worth 4500 dollar
> from Google's pocket.  I mean, we are not talking peanuts here.

I see good support for XML being a superset of what's needed to support 
ODF or SVG, not a subset.

or another way of putting it, the gitconfig definition for ODF would be a 
shortcut for a longer XML definition with a long list of options.

to be accepted by google, they will need to feel that the work is worth 
the money, so defining what file types you are going to support is an 
important item. This can include saying 'by handling this type of tweak to 
an XML file we can then handle file type Y instead of just file type X 
with the same merge driver'

as you are considering this list, please think about the items I mentioned 
earlier in the thread that would improve the support for config files and 
maintainers files (unordered lines/paragraphs)

>>> - a timeline (weekly milestones should be fine, I guess) what should
>>>   be  achieved when, and
>>
>> Timeline can be decided once we reach some conclusion and the work which
>> needs to be done become clear to us.
>
> Last year, most successful applications detailed a proposed timeline in
> their proposal...
>
> Do not get me wrong, I want this project to succeed.
>
> But on the other hand, I feel the obligation to be a bit demanding for the
> gracious donation of Google: we _do_ want to have something stunningly
> awesome at the end of the summer.
>
> And that means that I have to get the impression from the student proposal
> that something like that is at least _possible_.

sounds reasonable.

David Lang
--8323328-52542757-1237506161=:10279--
