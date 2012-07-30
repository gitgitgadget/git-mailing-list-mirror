From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 06:07:06 +0530
Message-ID: <CAMK1S_hAO0LGHa7e3KY6bT9z+f76Jc6_gCpwYbLqV9WPdgX1Cw@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<20120729212627.GA26430@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 02:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Svdz3-0002sc-0n
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 02:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753806Ab2G3AhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 20:37:09 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51599 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718Ab2G3AhI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 20:37:08 -0400
Received: by lbbgm6 with SMTP id gm6so3212058lbb.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=488CINS3WRuehUdMhwrthsCMF4fqF1lKzOgoZrf9jbA=;
        b=TvbSkZYl7pfWOoJlyqU3HllC8mLJik/2NkaMblPBxQyojzqy7fWAnkTeVz8XcGwTzV
         IVb4u4TKUYJZSUZtW9FhYeoVIHO8krsx44xa92yHm+HLbmeTt4NW5mlUpLZnM+xh57tk
         aHdhllmzB2IcEc0ie/CQ3MBJFbaijPqgUqwhsax1Sy4vodTOetZDlW1vMh9ymTc8huay
         bpaeDWnR+R6bNQWIMfSTleB/rXwqFBXcyB2O0n90XNJ/WsxxCM9sA90QenM29NrmLFyO
         F2modwwELQLvBihrbC4QWb/Kia78+/SHh4LjGzYMf7uZJtGHdgl2/h3B2xFHKwk4hS/s
         Yvzg==
Received: by 10.112.36.97 with SMTP id p1mr4502723lbj.37.1343608626790; Sun,
 29 Jul 2012 17:37:06 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Sun, 29 Jul 2012 17:37:06 -0700 (PDT)
In-Reply-To: <20120729212627.GA26430@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202509>

On Mon, Jul 30, 2012 at 2:56 AM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Sorry I missed this thread earlier. I'll drop this if it's not something
> that's wanted.
>
> On Sun, Jul 29, 2012 at 01:51:34PM -0700, Junio C Hamano wrote:
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>> > Uggh, no.  Client-git should only talk to server-git.  It shouldn't be
>> > talking first to some *other* program (in this case gitolite), and
>> > then to to server-git.  That doesn't sound sane to me.
>
> This is exactly the way gitolite works. It's placed between git-server
> and git-client. Does some checks and approves a connection if some
> criterias isn't met. See the example when trying to clone an
> non-existing repo from gitolite. You won't get an git error but a
> gitolite error.
>
> I can understand why my idea is beeing rejected but I can't see why the
> gitolite way should be considered sane. It seems more like an hack to
> me (according to git design principles).
>
> So from a git point of view, why is it sane for passing through STDERR
> but not STDIN and STDOUT?

That is precisely the point.  The pack protocol (see
Documentation/pack-protocol.txt in the git sources) works with
STDIN/STDOUT.  Run with GIT_TRACE_PACKET=1 to see some of that info
fly past on various git commands.

It explicitly leaves STDERR for the purpose of providing user's extra
information, including errors.

Gitolite is merely using that same mechanism.

And I repeat, if you insist on calling what gitolite does an
"interaction" (which to me means two-way communication, not a one-way
error/warning/diagnostic stream), we do not have enough in common to
discuss this any more.
