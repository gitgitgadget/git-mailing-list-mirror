From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFE] pre/post-stash hooks
Date: Wed, 24 Feb 2010 17:34:35 -0800
Message-ID: <a038bef51002241734w127e9e9btd3f3dd73aca1336@mail.gmail.com>
References: <hlmi1o$fk5$1@ger.gmane.org> <hm3urb$1nf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:34:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkSck-000206-M7
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 02:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab0BYBeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 20:34:37 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35053 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121Ab0BYBeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 20:34:36 -0500
Received: by pvb32 with SMTP id 32so1101895pvb.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 17:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=WQV2VWOdBXzaHq9s2tI0whLYfdcm9wHA9fSL8/c4SCw=;
        b=Bql6LXt3W13TcU5kz24ozzmzciXa7FsFzCkYPZxh0I5UuWhhKRIxKhoIxYhNAA7pA+
         8o0nVvW0u0unCtQWBOybxbZLx7f+TD0ZK3sbBpVMS/BQu8BCV4ounxLxPYSiLAF7Ea9Q
         BVYoWjt+0h/bAEinwS6ORVy3yHFLK/HvsFdwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TjLbSZ0z70gJ/1f/kPjI48erJjqS+obTPQ7aXrWW7A5HrWo0z69j+3CA5ZIbHeBF0O
         NrMJY6TZJWnVn+Tc9EN/eMSAIfJDBCgdRzTxRRW3yeUq7EfUfU8PvlQY8YhaDDNnDMyj
         ugxFS63Y6TX6IogHZgz8HCwfYING9mVYqjxww=
Received: by 10.114.99.20 with SMTP id w20mr285192wab.128.1267061675905; Wed, 
	24 Feb 2010 17:34:35 -0800 (PST)
In-Reply-To: <hm3urb$1nf$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141018>

On Wed, Feb 24, 2010 at 11:31 AM, Scott R. Godin
<scottg.wp-hackers@mhg2.com> wrote:
> giving this a bump since I haven't received any replies on it yet, and it's
> a valid question, IMHO.
>
> On 02/19/2010 12:33 PM, Scott R. Godin wrote:
>>
>> While I had known about git stash, and just never used it, I'd finally
>> gotten to the point where it was needed, only to discover something that
>> I found interesting.
>>
>> My use case may a bit rare at the moment, I'll admit, but not at all
>> far-fetched, and probably growing in usage as time goes on.
>>
>> In contrib/hooks is the script 'setgitperms.perl' which, when added to
>> pre-commit, post-merge, and post-checkout, makes sure to track the file
>> permissions fully, not just +/-x. This can be vitally important for
>> webdevelopers who must keep certain permissions on certain directories,
>> such as for e-commerce solutions like Magento, etc, so that the clients
>> may upload new product images through the interface rather than via ftp.
>>
>> However when I recently used stash to push some changes aside while I
>> did something else first, and then ran git stash pop, I realized that
>> there weren't any hooks that would enable setgitperms.perl to be
>> ensuring/tracking the file permissions are applied correctly after stash
>> usage.
>>
>> Granted that full directory/file permissions may not be all that
>> important to some of you coders, but I can assure you that web
>> developers may not see it that way.
>>
>> Again granted, I could probably set up a Makefile, but not everyone
>> knows how to do that (particularly those webdevelopers who aren't coders
>> who would typically be familiar with Makefiles.
>>
>> Also granted I could probably find a way to work around this issue with
>> an alias, but my thought is that I shouldn't have to.
>>
>> There are some of us who exist who have this funny thought that
>> computers should be able to do things for us without us having to
>> explicitly tell them to, specifically, every time. We'd prefer to set
>> things up generally "just do this EVERY time for EVERYthing" and forget
>> about it, and let the computer handle it. I'm sure you're familiar with
>> us, since we are us. :-)
>>
>> So, with this in mind, in addition to requesting pre/post-stash hooks
>> just for this alone, I'd like to solicit some thought from the rest of
>> you as to potential possible usages/requirements for said hooks for
>> reasons _other_ than running 'setgitperms.perl'
>>
>> Are there any reasons why pre/post-stash hooks _shouldn't_ exist?
>>
>> How difficult would it be to implement?
>>

Well for my 2 cents I've always seen stash as a way to prevent me
having to deal with a commit/merge right now when I get
interrupted/distracted. The things I stash usually don't work and
aren't complete, otherwise I would have committed them. Which really
is my answer to your question, pre-commit hooks exist so anything that
needs to be guaranteed in an automated way can still be done when it
really matters. As a git user I wouldn't find pre/post stash hooks
useful because its not something I'd use in my work-flow. But if it's
your itch go for it, don't let me put you off from floating a patch on
the list.
