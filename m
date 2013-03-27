From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: propagating repo corruption across clone
Date: Wed, 27 Mar 2013 21:17:38 +0530
Message-ID: <CAMK1S_jH-OJnH=XeCnEKvY6TkjZHZg_DLJ3KaVHNi9k0WA1REA@mail.gmail.com>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
	<20130324192350.GA20688@sigill.intra.peff.net>
	<CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
	<20130325145644.GA16576@sigill.intra.peff.net>
	<CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
	<20130325155600.GA18216@sigill.intra.peff.net>
	<CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
	<20130325200752.GB3902@sigill.intra.peff.net>
	<CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
	<20130326165553.GA7282@sigill.intra.peff.net>
	<1364340037755-7580771.post@n2.nabble.com>
	<7vr4j1qzao.fsf@alter.siamese.dyndns.org>
	<CAMK1S_jZcoA9sy+ixXmy8uj2E9E4Q6W2pLQVFStZMgH9eRoo6g@mail.gmail.com>
	<7v1ub0rijl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rich Fromm <richard_fromm@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:48:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKsa8-0003zH-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459Ab3C0Prk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:47:40 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:45448 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab3C0Prj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:47:39 -0400
Received: by mail-we0-f179.google.com with SMTP id p43so1757544wea.10
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 08:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=w+SAO7rdIxkSRFineniUv0lDowjhe71LfEfIOhYUpZU=;
        b=EnOwWkNVqYbfORpjWMftDGZGhwd659Mf1H+/CWrEVJh0Hn4iEjxpsPBjKrs41zhYZw
         ar5oJkzg3yIQkrFzk5JT5dtEy2DntWjIYwVQMVY2ar8WOVMEnNq5xVGngunk1dBWL8kb
         rVe632nptDlvszFvkhQiu4CpByUKwoteduaTEykLSGRm7SvciKtiqTSDexgh1wtZwIo3
         Krj0Z94ufk4vWGDuLFr2UAxVv1pbgBVMkWs3Nszz0ZitqOWB47Aj/FtDpV/lGiCTR143
         vtlE/8l4zTHxAxLCS1dacLjz8RIDYsTuXz5v/UoRMfbWcMaTaAYukMjr/e6+VjBnrtDp
         ao3Q==
X-Received: by 10.180.81.232 with SMTP id d8mr10616813wiy.25.1364399258530;
 Wed, 27 Mar 2013 08:47:38 -0700 (PDT)
Received: by 10.194.153.161 with HTTP; Wed, 27 Mar 2013 08:47:38 -0700 (PDT)
In-Reply-To: <7v1ub0rijl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219259>

On Wed, Mar 27, 2013 at 8:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> On Wed, Mar 27, 2013 at 9:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> To be paranoid, you may want to set transfer.fsckObjects to true,
>>> perhaps in your ~/.gitconfig.
>>
>> do we have any numbers on the overhead of this?
>>
>> Even a "guesstimate" will do...
>
> On a reasonably slow machine:
>
> $ cd /project/git/git.git && git repack -a -d
> $ ls -hl .git/objects/pack/*.pack
> -r--r--r-- 1 junio src 44M Mar 26 13:18 .git/objects/pack/pack-c40635e5ee2b7094eb0e2c416e921a2b129bd8d2.pack
>
> $ cd .. && git --bare init junk && cd junk
> $ time git index-pack --strict --stdin <../git.git/.git/objects/pack/*.pack
> real    0m13.873s
> user    0m21.345s
> sys     0m2.248s
>
> That's about 3.2 Mbps?
>
> Compare that with the speed your other side feeds you (or your line
> speed could be the limiting factor) and decide how much you value
> your data.

Thanks.  I was also interested in overhead on the server just as a %-age.

I have no idea why but when I did some tests a long time ago I got
upwards of 40% or so, but now when I try these tests for git.git

    cd <some empty dir>
    git init --bare
    # git config transfer.fsckobjects true
    git fetch file:///full/path/to/git.git refs/*:refs/*

then, the difference in elapsed time 18s -> 22s, so about 22%, and CPU
time is 31 -> 37, so about 20%.  I didn't measure disk access
increases, but I guess 20% is not too bad.

Is it likely to be linear in the size of the repo, by and large?
