From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Sun, 29 Jul 2012 20:45:39 +0530
Message-ID: <CAMK1S_hHBB9BViH=CFuJNgMJzMtzhE0mGc7ryFaDWNxOoH2Pgg@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<CAMK1S_i7WjrZ=L_LVoTQriW8kKMPd+ABrgowpFCY3ks43E6K7A@mail.gmail.com>
	<20120729141354.GA16223@paksenarrion.iveqy.com>
	<CAMK1S_iFqQvU+USYf+wcsLFS1QtsytLnPfEhjcAVZa9Vwj8d1w@mail.gmail.com>
	<20120729150550.GA17679@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 17:16:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvVEH-0000sy-Q4
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jul 2012 17:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab2G2PPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 11:15:42 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42134 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab2G2PPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 11:15:41 -0400
Received: by lbbgm6 with SMTP id gm6so3093826lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 08:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3S9Yt1c7pzh6wcwablObMc7C0bbwq7q8bv62PgArJ7w=;
        b=oQ0koHmYDFow1+pAzWJFskgCjYNua72N9Zc+n1Q/GGIA45Ty3s417T7TnXKdQa1THe
         bnGrMQ22yCozqFHkGJxxWGi9BXYIUdEdSqqqrPqsCIeo4V+vznGap77fSZC3L8JqOMWU
         CMvZE7q2r7QJGe7gX0bcJBXEdX0DmGZK9HzDQsjThs2/nkz43yvLA518MUt9Nszo4D5C
         19IOquB45dzph289tya7KilspjwvEIO5jRogKehg4LcrjQLumQsy9ADDLf+5vTv8B8By
         4v6KbIkjhKBJB3t030m4HttUuhZsPEi2TyryIPV7nldRUUZ7v0ewxFJtqWoyamLxODaO
         vUYQ==
Received: by 10.112.102.136 with SMTP id fo8mr4098145lbb.106.1343574939653;
 Sun, 29 Jul 2012 08:15:39 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 08:15:39 -0700 (PDT)
In-Reply-To: <20120729150550.GA17679@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202482>

On Sun, Jul 29, 2012 at 8:35 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Sun, Jul 29, 2012 at 07:55:36PM +0530, Sitaram Chamarty wrote:
>> > Thanks, however I think auto-creation is a great feature for some cases
>> > and I think there can be even more useable functions if we could get
>> > user interaction.
>>
>> For the record, I don't think I agree.  There's a place to create a
>> human-conversation, and there's a place not to.
>>
>> If you want a dialog with the server, there should be *other* commands
>> that do that, instead of overloading git's own protocol.
>>
>> Since you mentioned gitolite, consider copying the fork command
>> (src/commands/fork) and munging the code into an explicit wild repo
>> create.
>
> I appriciate that you clearified you oppinion. Please excuse me if it
> sounded as I in any way speaked for gitolite. I use gitolite as an
> example becuase the target application in this case is unknown to most
> people (think gitolite with db-backend for user permissions).
>
> It's a valid design oppinion to not mix git protocoll with anything
> else. But gitolite already does that. Gitolite already have user
> interaction mixed with git interaction. Do you say to me that gitolite
> is broken and should not do user interaction over git-commands? Then why
> does wild repos exists and why does gitolite error messages exists?
>
> We're already down that road, why not do it better?

I think you misunderstood how gitolite works.  Gitolite does not have
*any* user interaction other than sending some extra messages back via
STDERR if you're using a normal git client to do normal git operations
(clone/fetch/ls-remote).

Such messages are *no different* from something that an update or
pre-receive hook might send back even on a normal (no gitolite) git
server.

The only time that gitolite might have any user *interaction* is when
using "gitolite commands".  These do not run git at all (neither on
the client nor on the server), and in fact merely provide a convenient
way to allow users to run a controlled set of specific *shell*
commands.
