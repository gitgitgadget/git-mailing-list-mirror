From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Thu, 17 Jul 2008 15:03:30 +0100
Message-ID: <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <alpine.DEB.1.00.0807171311010.8986@racer>
	 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	 <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
	 <alpine.DEB.1.00.0807171351380.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:04:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJU5w-0004PK-9d
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978AbYGQODd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756857AbYGQODd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:03:33 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:33824 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755079AbYGQODc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:03:32 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1952186yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Dfg94m40JLIsMlA095q2YwS54XTnTjezYiat6imkvds=;
        b=PjkbxXgqwU74eFcdVI40XS00Al9LDdmxoladD8JSqD/2Le8yfMviUoqQs1jKvzFCj+
         w4tLOZx34Dxe/ar33zn1S7ns8AImaYev96D6ELZsVDM6RwQDAcYh3KQpfDtgp7YX8LRy
         DnMjxT8DYoIR5Ht1sad0bEjuMO3i5uZsvQB2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=nLy6BxI1yZAxoKKiE6/oC5yjOm97iUCoHfI7kZ2Ke9NlrFAidF3ZbHdYLFYao1ZfAM
         3uzsMc8+tl6UAdcTMUBG7BKxXGPkoAOOSolqFTqGTdbGBZPTX9USxtTtTf9CpxNJ+mVb
         1kjIgr2OXphuGOMc9MGfCx+4QYI1svBRo6QDc=
Received: by 10.103.222.12 with SMTP id z12mr1959019muq.12.1216303410499;
        Thu, 17 Jul 2008 07:03:30 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Thu, 17 Jul 2008 07:03:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807171351380.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88854>

On Thu, Jul 17, 2008 at 1:58 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 17 Jul 2008, Nigel Magnay wrote:
>
>> On Thu, Jul 17, 2008 at 1:13 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > On Thu, 17 Jul 2008, Nigel Magnay wrote:
>> >
>> >> When doing a git submodule update, it fetches any missing submodule
>> >> commits from the repository specified in .gitmodules.
>> >
>> > Huh?  It takes what is in .git/config!  Not what is in .gitmodules.
>>
>> Huh? And where does .git/config get it from? Oh, that's right,
>> .gitmodules.
>
> Oh, that's right, after "git submodule init".  Right before you are
> supposed to change them if your setup commands that.
>
>> > So if you have another remote (or URL, e.g. if you have ssh:// access,
>> > but the .gitmodules file lists git://), just edit .git/config.
>>
>> So for my usecase, you'd have me go in and change *evey single one* of
>> my submodule refs from the centralised repository, *every time* I want
>> to do a peer review?
>
> No.
>
>> Doesn't the current system strike you as being somewhat centralised in
>> nature?
>
> No.
>
>> > I meant, that is the whole _point_ of having a two-step init/update
>> > procedure.
>>
>> Are you just determined that submodules should remain useless for "the
>> rest of us"?
>
> No.
>
> If you really need to change the "origin" back and forth between reviews,
> while the committed state of the superproject stays the same, then
> something is seriously awkward and needs to be streamlined in your setup.
>
> Because when the superproject's revision stays the same, "git submodule
> update" may fetch additional objects if you specify another remote, but it
> will check out just the same revisions of the submodules.  Because they
> were committed as such.
>
> But if you want to get objects from another server (as opposed to update
> the submodules' working directories to the latest committed revisions),
> which happens to have the identical layout of the principal server (which
> I would deem another setup peculiarity to be fixed), you might want to
> look into the recurse patch that was flying about on this list a few
> months back.

The layout wouldn't be the same - the submodules would be in the
corresponding subdirectories (I guess it could have some other,
stranger layout, but I'd consider that peculiar). So you're right, the
layout is different, which makes editing the config all the more
tedious.

I don't want to change the *origin* back and forth. I want to be able
to use repos with submodules in them as easily and as transparently
and in the same distributed way as git allows me to do if they don't
contain submodules. I.E I don't want it to be such a sisyphean
challenge every time with umpteen scripts to complete a usecase that
really ought to be supported as standard. The very first thing that
I've hit is that submodule update only talks to origin, so 'git pull
fred && git submodule update' falls flat on its face. Why am I being
forced to update config just to have a look-see at fred's project?

Your attitude seems to be that the status-quo is in some way
desirable; "It's no wonder that this tool is awkward to use in your
workflow.". This workflow is really common, and there's actual, real
people on this list complaining about it. Don't we think it could be
improved to be non-awkward ?

In the ideal UI, it ought to be possible to make the use of projects
with submodules (almost) completely transparent, like it is in the
vcs-that-dare-not-speak-it's-name.
