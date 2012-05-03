From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Thu, 03 May 2012 11:43:35 -0700
Message-ID: <4FA2D1D7.3020807@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>	<4F9F3919.6060805@palm.com> <CAMK1S_jwVsyKrGoL5uVAiuRrOa8bz79-DAueBmHZE2k=PpcJ2Q@mail.gmail.com> <20120501111415.GD5769@thunk.org> <CAMK1S_jN_WdZF4W4szzyJqLfC3FmnhKQ65XQiD-JS_jxwSm8_g@mail.gmail.com> <4FA02830.3040407@palm.com>	<86havzoi8h.fsf@red.stonehenge.com> <4FA04D02.6090702@palm.com>	<86mx5rmx32.fsf@red.stonehenge.com> <4FA055D0.7040102@palm.com>	<86aa1rmvhb.fsf@red.stonehenge.com> <4FA05E9F.9090709@palm.com> <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Seth Robertson <in-gitvger@baka.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Thu May 03 20:43:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ10B-0000bH-0R
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 20:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2ECSni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 14:43:38 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:55586 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962Ab2ECSnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 14:43:37 -0400
X-IronPort-AV: E=Sophos;i="4.75,526,1330934400"; 
   d="scan'208";a="13294098"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 03 May 2012 11:43:37 -0700
Received: from fuji.noir.com ([10.100.2.12])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q43IhZU5012547;
	Thu, 3 May 2012 11:43:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <CAJsNXTmo1B86nSm7u923jJuGX0zajz3iqVu-onANMN-5BE5DfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196933>

On 5/1/12 16:01 , PJ Weisberg wrote:
> On Tue, May 1, 2012 at 3:07 PM, Rich Pixley<rich.pixley@palm.com>  wrote:
>
>> No, not a deploy system.  You use a deploy system to set up something like
>> multiple server http farms.  What I'm doing is more akin to porting the same
>> piece of software to 20 different operating system distributions.  I'm not
>> "deploying" the source code.  I'm developing it.
> I fail to see how you would end up with more than one branch per
> environment, though.  Fewer, if you do the merge before pushing your
> change back to the server.
>
> It sounds like you're asking for branches without names (or
> automatically assigned names like master-0, master-1, etc.).  I'm sure
> it's all very intuitive in Hg (which I know nothing about), but it
> sounds to me like a recipe for confusion.
I'm finding the reverse to be true.

In hg, I don't have to think about how many other branches or 
repositories there might be.  I don't have to track where the changes 
are.  And I don't have to do anything to add another repository to the 
mix or to remove one.  Trivial merges are trivial.  The view from any 
repository is identical, not just symmetric.  The things I want to do 
are all simple commands.  Pull from the cache, merge if necessary, do 
some work, push to the cache.  Repeat as necessary since there will be 
numerous collisions and merges since I'm working on multiple machines 
concurrently.  And eventually, push to central server.

With git, if I use the traditional triangle architecture, I have to 
manually name every repository and every branch uniquely, create fresh 
branches in every other repository when I create one new repository.  
Remove old branches from every other repository whenever I remove one.  
Track collisions manually, track which repositories have which changes 
manually, and be extra careful about moving changes around so that they 
don't collide or force merge commits because that screws up git 
histories.  In order to do a simple source code control task, I have to 
stop, formulate a plan for making things work in git that still ducks 
both the limitations and traps of git and still accomplishes my goal, 
and then execute that plan precisely, because recovery is difficult.

If I skip the standard git triangle merging architecture, I can collapse 
some of that bookkeeping by sharing a branch.  But the cost is that 
pushing, pulling, and merging become even more complex as I have to 
dodge more limitations, (essentially, pushing doesn't work, star 
networks don't work, etc.)

Trying to keep all of that bookkeeping in my head, or trying to remember 
all of those arbitrary and unnecessary limitations is more complicated.

I'll grant that some of this is unique to my current work flow.  But I 
think that a lot of it carries into other work flows as well.

--rich
