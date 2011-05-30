From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git fast-import : Warning duplicated ref:
 refs/remotes/origin/master
Date: Mon, 30 May 2011 15:13:51 -0500
Message-ID: <20110530201351.GB14427@elie>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie>
 <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530173517.GA13539@elie>
 <vpqzkm4gef2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>,
	git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 22:14:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR8qg-000232-CU
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 22:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab1E3UN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 16:13:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41150 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab1E3UN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 16:13:56 -0400
Received: by iyb14 with SMTP id 14so3179161iyb.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 13:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LwJXwGEf9oBrbSgYoQEf1IpEFRAw4l6gNYGKQExXTSU=;
        b=JT4dNuzZ/T7/BXmpay13tR/gW8ZZNTUa26rnbRnF1ZWVdZ5foR/Npj9YWoKZcr6Mu0
         Tl+A93A3igD4I7MEsosJaQjun7dcx7Xs/XfcH4y08Xo1S7uLg/A742e4BzR86LLZzhsz
         i8U+t99lwY2j0Y4yE3TZPPZwFk3BiTVL9+o1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hGntXs4E2sxgLr0lFKoffYw9ycheqgsSBUghuQ8PCmrll9m2bT4kllXvULkrzc+14A
         jWrzpkKwW5iRa9mloJDY7ZkNx3p+ast9t4aC2G6XQjCXHtzsUtt2b8HHxHaJAY/CXQeR
         Lmt6n7T2jQqsuNTL9hhJktoK56sE39hyBfiws=
Received: by 10.42.155.70 with SMTP id t6mr7866698icw.405.1306786435883;
        Mon, 30 May 2011 13:13:55 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id q15sm1318354ibb.14.2011.05.30.13.13.54
        (version=SSLv3 cipher=OTHER);
        Mon, 30 May 2011 13:13:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqzkm4gef2.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174774>

Hi,

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  sub mw_capabilities {
>>  #	print STDOUT "fetch\n";
>> +	print STDOUT "refspec refs/heads/*:refs/mediawiki/$remotename/*\n";
>
> Is this "mediawiki" comming from the URL (mediawiki::...), or is it just
> a convention you've set?
>
> We've tried with refspec refs/heads/*:refs/remotes/origin/*, but without
> success.

Yes, I stole the convention for the namespace name from the commit message
to v1.7.0-rc0~62^2~19 (Allow helper to map private ref names into
normal names, 2009-11-18).

> Do I understand correctly that the "pull" is done in 3 stages:
>
> 1) import into refs/mediawiki/origin
>
> 2) fetch the imported ref into refs/remotes/origin
>
> 3) and merge as usual into the current branch
>
> ?
>
> If so, I don't understand why the distinction between 1) and 2) is
> necessary, and why not to fetch directly into refs/remotes/origin/. IOW,
> in which case is refs/remotes/origin/master different from
> refs/mediawiki/origin/master for example?

That's a good question.  One answer is that fetching to elsewhere
allows the transport machinery to take care of rejecting non-fast-forward
fetches and pretty-printing the ref update information:

 From mediawiki::http://localhost/mediawiki
    479ee21..accd2c1  master     -> origin/master

I think in the long term, importing to no ref at all as Sverre
suggested and teaching the transport-helper to do the ref update would
make more sense.

Regards,
Jonathan
