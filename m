From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: blobs (once more)
Date: Wed, 06 Apr 2011 14:20:09 +0200
Message-ID: <4D9C5A79.30207@drmicha.warpmail.net>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com> <alpine.DEB.1.00.1104061121000.2040@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:23:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Rm3-0004pg-6R
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850Ab1DFMXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 08:23:45 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48641 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755655Ab1DFMXo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 08:23:44 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3C8B52096A;
	Wed,  6 Apr 2011 08:23:44 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 06 Apr 2011 08:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=EsuJVXELbrzVqeLTHN4kwpFWbwQ=; b=KwUvhrIqkSiQoVev6Znn256fTybzesUwLTC4NUbeHkZHeIJqWWl5M0tmYNOcwf/8RY7r79NXam5JL4z7lfzlLnLe01ItPfiFCCBr4BWuFZDQohoIXFOwObuyLDxggTMcjftyzZrMgt+pNyykl94VI4Xkz0tUqvJ5aZT1u4Erd4E=
X-Sasl-enc: nF6rwOob3dJe6/b38ZrNf0M6LbwzC84aJbFFOblDCmq7 1302092623
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7FAA04088E3;
	Wed,  6 Apr 2011 08:23:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <alpine.DEB.1.00.1104061121000.2040@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170967>

Johannes Schindelin venit, vidit, dixit 06.04.2011 11:25:
> Hi,
> 
> On Wed, 6 Apr 2011, Pau Garcia i Quiles wrote:
> 
>> Binary large objects. I know it has been discussed once and again but 
>> I'd like to know if there is something new.
>>
>> Some corporation hired the company I work for one year ago to develop a 
>> large application. They imposed ClearCase as the VCS. I don't know if 
>> you have used it but it is a pain in the ass. We have lost weeks of 
>> development to site-replication problems, funny merges, etc. We are 
>> trying to migrate our project to git, which we have experience with.
>>
>> One very important point in this project (which is Windows only) is 
>> putting binaries in the repository. So far, we have suceeded in not 
>> doing that in other projects but we will need to do that in this 
>> project.
>>
>> In the Windows world, it is not unusual to use third-party libraries 
>> which are only available in binary form. Getting them as source is not 
>> an option because the companies developing them are not selling the 
>> source. Moving from those binary-only dependencies to something else is 
>> not an option either because what we are using has some unique features, 
>> be it technical features or support features. In our project, we have 
>> about a dozen such binaries, ranging from a few hundred kilobytes, to a 
>> couple hundred megabytes (proprietary database and virtualization 
>> engine).
>>
>> The usual answer to the "I need to put binaries in the repository" 
>> question has been "no, you do not". Well, we do. We are in heavy 
>> development now, therefore today's version may depend on a certain 
>> version of a third-party shared library (DLL) which we only can get in 
>> binary form, and tomorrow's version may depend on the next version of 
>> that library, and you cannot mix today's source with yesterday's 
>> third-party DLL. I. e. to be able to use the code from 7 days ago at 
>> 11.07 AM you need "git checkout" to "return" our source AND the binaries 
>> we were using back then. This is something ClearCase manages 
>> satisfactorily.
> 
> I understand. The problem in your case might not be too bad, after all. 
> The problem only arises when you have big files that are compressed. If 
> you check in multiple versions of an uncompressed .dll file, Git will 
> usually do a very good job at compressing them.
> 
> If they are compressed, what you probably need is something like a sparse 
> clone, which is sort of available in the form of shallow clones, but it is 
> too limited still.
> 
> Having said that, in another company I work for, they hav 20G repositories 
> and they will grow larger. That is something they incurred due to 
> historical reasons, and they are willing to pay the price in terms of disk 
> space. Due to Git's distributed nature, they had no problems with cloning; 
> they just use a local reference upon initial clone.
> 
>> I have read about:
>> - submodules + using different repositories once one "blob repository"  
>>   grows too much. This will be probably rejected because it is quite 
>>   contrived.
> 
> I would also recommend against this, because submodules are a very weak 
> part of Git.
> 
>> - git-annex (does not get the files in when cloning, pulling, checking 
>>   out; you need to do it manually)
>> - git-media (same as git-annex)
> 
> Yes, this is an option, but a bit klunky.
> 
>> - boar (no, we do not want to use a VCS for binaries in addition to git)
> 
> I did not know about that.
> 
>> - and a few more
>>
>> So far the only good solution seems to be git-bigfiles but it's still
>> in development.
> 
> It has stalled, apparently, but I wanted to have a look at it anyway. Will 
> let you know of my findings!

I think in many applications the "download-on-demand" approach which
git-annex takes is very important. (I don't know how far our
sparse/shallow supports this.) Also, their remote backends look
interesting. And no, I don't want Haskell as yet another language for
our code base.

Fedora handles big files (compressed tar balls) in git with a file
store, scripting (fedpkg) and tracking only a text file with hash values
("sources") in git; somehow a baby version of git-annex.

The symlink based approach of annex (big file is a symlink to the
"object store" which is indexed by blob content sha1) reminds me very
much of our notes trees and the way textconv-cache uses it. It feels as
if we already have all the pieces in place. (I don't think we need to
track big files' contents, only their hashes; this is fast for read-only
media, see annex' worm-backend.)

Another crazy idea would be to "git replace" big files by place-holders
(blob with the big file's sha1 as content) or rather the other way
round, but I haven't thought this through.

Michael
