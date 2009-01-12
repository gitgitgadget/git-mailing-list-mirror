From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Lightweight tag ?
Date: Mon, 12 Jan 2009 15:54:27 +0100
Message-ID: <496B59A3.2080507@drmicha.warpmail.net>
References: <38b2ab8a0901111044x5db21d74i25ff7a26bb702a5d@mail.gmail.com>	 <7v63klsgf5.fsf@gitster.siamese.dyndns.org> <m2bpucnas2.fsf@gmail.com>	 <496B3DA8.1040308@drmicha.warpmail.net> <38b2ab8a0901120556x279f320oe693304dd2452050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 15:56:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMOCp-0000vH-9a
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 15:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbZALOyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 09:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbZALOyb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 09:54:31 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54473 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491AbZALOya (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 09:54:30 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 63E31210295;
	Mon, 12 Jan 2009 09:54:28 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 12 Jan 2009 09:54:28 -0500
X-Sasl-enc: qVAd/krrCA9uBoWgumZnuxfoKwB47HjxjHHw5q5YQYt7 1231772067
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 7D832354D8;
	Mon, 12 Jan 2009 09:54:27 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <38b2ab8a0901120556x279f320oe693304dd2452050@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105347>

Francis Moreau venit, vidit, dixit 01/12/09 14:56:
> On Mon, Jan 12, 2009 at 1:55 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Your test above confirms that the description is correct and nothing is
>> missing. "git push" pushes explicitly listed refspecs (or : as a
>> default). It pushes tags (light and heavy) when asked to.
>>
> 
> So do you mean that the only way I have for pushing annoted tags only is
> to do:
> 
>    $ git push origin refs/tags/annoted

You could use the equivalent, more user friendly "git push origin tag
annoted".

> That's not what Junio said:
> 
>    Don't use explicit --tags blindly.  It says "no matter what kind of tag,
>    transfer everything under refs/tags".  Otherwise you won't see a
>    difference.
> 
> So I interpret this like don't use --tags otherwise lightweight and annoted tags
> are the same.

I don't see a difference between lightweight tags and tag objects
regarding the question of automatic tag following, see my parenthetical
request for correction (below) in case I'm wrong.

>> "git pull" pulls tags if they can be reached from heads which are
>> pulled. It pulls all tags only when asked to.
>>
> 
> [...]
> 
>> So, "non-local" tags are the ones which can be reached from heads which
>> you pull, and local ones are the others.
> 
> So I can't create a local tag on public heads (the ones I'm pushing
> out), can I ?
> 
>> I don't think lightweight tags are more local than tag objects
>> (please correct me if I'm wrong; I think this needs more doc)
> 
> Perhaps it needs documents which are more user friendly: I don't know where
> the 'lightweight' word is coming from (perhaps from the implementation) but
> I would expect that the _local_ term appears in the git-tag manual.

It's the other way round. "lightweight" is in the first few lines of the
man, "local" nowhere. In fact I don't see it anywhere in the docs.

>> It's just that the latter reside in the object db
>> store whereas the former are simple refs under refs/tags.
> 
> That's implementation detail...
> 
> I just need to create a local tag where I'm sure it won't be seen by others
> whatever the git operations I'm doing, normally a simple "git tag" switch
> should be enough...

Taking "whatever" literally this is impossible, of course.

Taking it /cum grano salis/ it's still impossible within the same repo:
If others have read access they can "ls-remote" and "fetch" happily what
they want. The sane and easy way is to use a private repo for your local
work and all your "local tags", then to push to a public (i.e.
publically readable) repo those branches and tags which you want to be seen.

Are you a Mercurial user by any chance? "hg tag -l" creates local tags
which are stored in an unversioned, private file, whereas "hg tag"
creates (and commits) a tag entry in a versioned file, which is the
source of some confusion and problems with hg tags ("hg co sometag" does
not contain sometag etc.). Maybe you want the behaviour of "hg tag -l"?

Cheers,
Michael
