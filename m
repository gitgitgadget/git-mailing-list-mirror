From: Evgeny <evgeny.zislis@gmail.com>
Subject: Re: [PATCH] mergetool: export variables for use by custom mergetools
Date: Sun, 18 May 2008 03:12:36 +0300
Message-ID: <b6840c770805171712j636c8f43tde9c0a0b74ec58b@mail.gmail.com>
References: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com>
	 <20080517233414.GA28196@hashpling.org>
	 <b6840c770805171655y691fbd0vd2d65d0914757b63@mail.gmail.com>
	 <20080518000739.GA29689@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, tytso@mit.edu,
	git@vger.kernel.org
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun May 18 02:13:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxWX8-0001mz-1h
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 02:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbYERAMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 20:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755307AbYERAMj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 20:12:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:3583 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264AbYERAMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 20:12:38 -0400
Received: by ug-out-1314.google.com with SMTP id h2so192175ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=j/OpVmuzXVTUwTppatNCB077w5scGkICG5X69X74OsE=;
        b=UM/WSDbjfAaJJpq0jo4xhm7ekWwY8hQJJvkuUtc/HI2B3kFAmH2QpINIFUT3XaLUOPnds++CYQ1ftIMbsB+ViOYiBHVC1jfpApxjBtEGmHJt+rQOutAqUf2BhFFYPjPpOgns6LAUss4zBO0SP4SLiD46UuqrWhpZn/NypUxn0FY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w7irf4h9dR/TShBu5DfZk9ZBEkSA4jJXoDiL5ebS21PeXdlX/TL9tPfdN1aAsbImMVWrjPT7LEMW2eF/WbTznSduEgI0NU+hzeVE6DNwEvQ/n3yfprqhgDoOLEUsa/1SON4WXa9Rgn5OI6bjuRW50s36o4jIan3QbN3v91YPGHw=
Received: by 10.67.10.18 with SMTP id n18mr1676317ugi.4.1211069556071;
        Sat, 17 May 2008 17:12:36 -0700 (PDT)
Received: by 10.67.26.8 with HTTP; Sat, 17 May 2008 17:12:36 -0700 (PDT)
In-Reply-To: <20080518000739.GA29689@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82370>

I also tried directly with
  cmd = $HOME/Applications/p4merge.app/Contents/Resources/launchp4merge
"$PWD/$BASE" .....

It also did not work without $PWD, but it also did not work when I
used it from the command line. Some weird error, saying :

Incorrect parameters:
'./test.BASE.18308' is (or points to) an invalid file.
'./test.LOCAL.18308' is (or points to) an invalid file.
'./test.REMOTE.18308' is (or points to) an invalid file.

Use 'launchp4merge -h' for more help.


I think it's a p4merge bug, they did change it to Qt4 lately. Probably
broke a couple of things.


On Sun, May 18, 2008 at 3:07 AM, Charles Bailey <charles@hashpling.org> wrote:
> On Sun, May 18, 2008 at 02:55:10AM +0300, Evgeny wrote:
>> Ohh, so the documentation is not clear then.
>
> That's a pity, I did make an effort with the documentation, but
> explaining things is not my strongest ability.
>
>>
>> [mergetool "p4merge"]
>>       cmd = p4merge.sh "$PWD/$BASE" "$PWD/$REMOTE" "$PWD/$LOCAL" "$PWD/$MERGED"
>>       keepBackup = false
>>
>> [merge]
>>       tool = p4merge
>>
>
> "$PWD/" looks very wrong. Perhaps p4merge.sh is changing its working
> directory and not handling the passed paths correctly?
>
>> Thanks for the explanation!
>> I believe that an example in the documentation could be a nice
>> addition, to clear things up in the future.
>
> Yes, there were a few examples in the original patch mail text (note
> that 'path' has sinces changed to 'MERGED'), but they never made it to
> the documentation. There's also some discussion about eval vs. leaking
> environment variables:
>
> http://thread.gmane.org/gmane.comp.version-control.git/74059
>
> --
> Charles Bailey
> http://ccgi.hashpling.plus.com/blog/
>
