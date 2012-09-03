From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 19:18:59 +0530
Message-ID: <CAMK1S_hZ5C_dr+0-QPavnfjsCqeHFgd+qz3AL++E=wMZ-mf7Zw@mail.gmail.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
	<20120903154732.5fb50b173fa51db8300624b3@domain007.com>
	<CAMK1S_iSbDNc39XjWZLgUJuBg71+A+CHbEq09QG+mntDQrdNxw@mail.gmail.com>
	<alpine.LFD.2.01.1209031410450.5945@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Mark Hills <Mark.Hills@framestore.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8X41-0008OB-H7
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 15:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab2ICNtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:49:53 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35853 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932107Ab2ICNtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:49:00 -0400
Received: by mail-lb0-f174.google.com with SMTP id gj3so2484087lbb.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HYD09FobWokEBCfiNRRdym1eiefzNAjL2NKWlr96lWY=;
        b=lcsrGVgR4Sn0s62+WrwG/8vXm5jy/R+mmq1u4l1wMiH6UPIDFG2O2S5UOM90TiENFj
         zpVtMVG4bqxql6VrL4vX2b5e7XiCn4J6j09wIxLJNlHtG86xMz5y5qS2Zu9enrNm9J0t
         tM9iupeZUdU7a9YpoL8z6+JJPw5SJykx3qSzIT41VMbmTMIKQifEHWRBRua99vSV7krr
         77nzpvFoSzALp2SqvUCcfMYAYHmmhY5WGYBhJYKyibphgSV2YbYb3wigwoo0wF3Y8gYR
         LWb/A3auZU5zYxBOHUiusmXM3uiy7q3Cowbr8V7SBb/KYTwWQPE/oXFqYgXrBXvPTH6r
         bj/A==
Received: by 10.152.125.116 with SMTP id mp20mr14071142lab.19.1346680139238;
 Mon, 03 Sep 2012 06:48:59 -0700 (PDT)
Received: by 10.112.129.227 with HTTP; Mon, 3 Sep 2012 06:48:59 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.1209031410450.5945@sys880.ldn.framestore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204693>

On Mon, Sep 3, 2012 at 6:45 PM, Mark Hills <Mark.Hills@framestore.com> wrote:
> On Mon, 3 Sep 2012, Sitaram Chamarty wrote:
>
>> On Mon, Sep 3, 2012 at 5:17 PM, Konstantin Khomoutov
>> <flatworm@users.sourceforge.net> wrote:
>> > On Mon, 3 Sep 2012 11:21:43 +0100 (BST)
>> > Mark Hills <Mark.Hills@framestore.com> wrote:
>>
>> [snip]
>>
>> >> This is quite cumbersome; we have a large team of devs who use a
>> >> simple 'git clone' to an NFS directory, but we wish to retire NFS
>> >> access.
>>
>> [snip]
>>
>> > gitolite kind of implements this ("wild repos") [1], you could look if
>> > it suits your needs.
>>
>> The simplest conf to do what you want in gitolite is something like this:
>>
>>     repo [a-zA-Z0-9]..*
>>         C   =   @all
>>         RW+ =   @all
>>
>> But of course your *user* authentication will probably change quite a
>> bit, since gitolite runs as one Unix user and merely simulates many
>> "gitolite users", while in the NFS method each of your devs probably
>> has a full login to the server.
>
> I'll check out gitolite, thanks.
>
> We use unix users extensively (groups, permissions etc.) with YP, and this
> works well; a separate permissions scheme is not very desireable.
> The ssh method works very well right now, and nicely transparent. It's
> only the initial clone/creation that is harder than it was over NFS. And
> it prevents the use of git-shell too.

If I had to do this, and didn't want to use gitolite or something like
it, I'd just make a script that will create the repo using an ssh call
then do a 'git push --mirror' to it.

Call it "git-new" or something and train people to use that instead of
"clone" when the repo doesn't even exist yet.

Bound to be easier than the administrative hassle you spoke of in your
other email...
