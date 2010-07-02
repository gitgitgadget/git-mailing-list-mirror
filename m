From: Tim Visher <tim.visher@gmail.com>
Subject: Re: Print last time and committer a file was touched by for a whole 
	repo
Date: Fri, 2 Jul 2010 07:55:19 -0400
Message-ID: <AANLkTil2Riz3_iKEREjsERVsBkSZdZ9wa9ujOahxjs4Y@mail.gmail.com>
References: <AANLkTikRElk07ZqK0TOM2WD31t-H5RVngvHNU9KM7e9D@mail.gmail.com> 
	<m3eifnner1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 13:55:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUeqS-0007aY-2C
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 13:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681Ab0GBLzl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 07:55:41 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:33798 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0GBLzk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 07:55:40 -0400
Received: by qwh6 with SMTP id 6so127108qwh.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NvvVpNGLCqhBTkGwG8gaOFXlnrZY/SLZ9rLtyWAuCjE=;
        b=P5uFktYGmU6l11sykHVktYQ9vau/zLHHXqU4lSIuB5kYc+sUNW+A9c2Hk0ey0znayH
         p24L4La4In1gak6MrWqlKQwyIZyxTu37d+n6PHaY89S+EpTbjQzxJnAADw6k73LroSTU
         djfGo5SjEbx4DrXz6Ymlunx4tdyjKLYQdg5WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pUdU5dGWfDrdlX2YzF+vMZPwjn+hUyrgPfrvgyfueFASXO9itKvmJ7bisYM0TvjzjM
         qobgaWBF2hWGxjpXwgyiaFn2cQczlzNgssmnde6qZ6uQrBkdI29KnbCHTrTSLFTtl/vd
         xWAL7qx8cu3Rc8QfPoMoZnUcOusNQLK6M1Hsc=
Received: by 10.224.36.15 with SMTP id r15mr301911qad.333.1278071739198; Fri, 
	02 Jul 2010 04:55:39 -0700 (PDT)
Received: by 10.224.6.134 with HTTP; Fri, 2 Jul 2010 04:55:19 -0700 (PDT)
In-Reply-To: <m3eifnner1.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150123>

Thanks everyone who responded.  I ended up doing

    find . -path "./.git*" -prune -o -print -exec git log -n 1 -- '{}'
\; > assets.txt

Little roundabout but seems effective.

On Thu, Jul 1, 2010 at 4:12 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> Tim Visher <tim.visher@gmail.com> writes:
>
>> I need to get a listing of the entire contents of my current repo (a=
s
>> in, I don't need deleted files or anything like that, just the curre=
nt
>> snapshot) with the time the file was committed and who committed it.
>>
>> Thoughts on how to do that?
>
> There does not exist a single git command that would do what you want=
=2E
> You would need to use 'git log -1 --follow' for each file in current
> snapshot ('git ls-tree -r HEAD'). =C2=A0IIRC there is some example ho=
w to
> do that in GitFaq or GitTips on git wiki (http://git.wiki.kernel.org)=
=2E
>
> Perhaps in the future 'git blame <directory>' would provide such
> output, or its equivalent (tree blame).

That'd be cool.

> By the way, what do you ned this for? =C2=A0Git versions whole projec=
t at
> once, not individual files. =C2=A0Is it some legacy from CVS?

Ummm...  Little embarrassing but this is apparently a requirement for
my company.  Every few years they ask for a 'listing of all software
assets, when they were last touched, who last touched them, and what
version of software they were touched for.'  Generous assumptions is
that they're probing us for how effectively we can lay our hands on
this information.  Cynics would say that someone somewhere decided one
day that it would be a good idea to have an __Excel Spreadsheet__
(yep, that's what it goes into) listing every file that every software
project everywhere in the company has, and that now people do it
because it's on a check list.

Anywho... Hooray for `find -exec`.

--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
