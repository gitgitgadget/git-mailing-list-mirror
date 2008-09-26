From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git log and utf-u in filenames
Date: Fri, 26 Sep 2008 15:49:06 +0200
Message-ID: <81b0412b0809260649n7d7c0ccbwfde5504157687cda@mail.gmail.com>
References: <20080925215002.GA30810@kodama.kitenet.net>
	 <m3fxnn3ji6.fsf@localhost.localdomain>
	 <20080926063311.GA4939@blimp.localhost>
	 <200809260931.21883.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Joey Hess" <joey@kitenet.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 15:51:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjDiA-0003xd-UM
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 15:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYIZNtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 09:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbYIZNtK
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 09:49:10 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:22080 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbYIZNtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 09:49:09 -0400
Received: by rn-out-0910.google.com with SMTP id k40so312773rnd.17
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 06:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FKAQ2d8Td5EsKBUxM6nfleVJ8oSIFWhC2hpn/FimIM4=;
        b=YGfHOc9cXu6wgTEqDXmahk4S9yViuQ9kvA0R+4u4QuevPzj7lDu8yDoIP5aC/mDqXL
         J+blGp2ZoVYS9tYacnFdVmQhR4LryEVuu8PV1QNWDbwm2/9tabdBabh/iiQvKk2+lgAx
         mBa8yVRhzTeGCItnkSWjIGEgsziij/QE/px3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=i0ekOncSZHXtQxzzkJUmudL2PztrPpDYJd6LPUoZt4rn/Q0RG2hdQnGvAtlaBaD/5n
         ko8syMzLjT5IpHiSruaIF+DAtalXoyIoY6rpFvwuu4HF9qL5F2+ZSGx+EBMjiS5f5r53
         Jgq77KVa85I2YIoP94Ixs1bdBk84asXlbqDX8=
Received: by 10.100.8.4 with SMTP id 4mr1130177anh.38.1222436946828;
        Fri, 26 Sep 2008 06:49:06 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Fri, 26 Sep 2008 06:49:06 -0700 (PDT)
In-Reply-To: <200809260931.21883.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96851>

2008/9/26 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 26 Sep 2008, Alex Riesen wrote:
>> Jakub Narebski, Fri, Sep 26, 2008 01:15:58 +0200:
>> >
>> > Well, in gitweb we could use '-z' option for git-diff-tree and git-ls-tree,
>> > but it has its disadvantages, like having to do actual parsing record after
>> > record instead of simplys splitting outout on end of line ("\n") characters.
>> >
>>
>> How about simply splitting output on end of line ("\0" NUL) characters?
>> The "\n" NL you refer to is just as EOR as NUL.
>
> Doesn't work for "git diff-tree -z [...]" output. When there is rename
> or copy detected, NUL is used as separator between fields (beetween
> source and destination unquoted filename), not only between records:
>
>  git diff-tree
>      .... <src qfilename> TAB <dst qfilename> LF
>
>  git diff-tree -z
>      .... <src filename>  NUL <dst filename>  NUL
>

You still have the marker (Rnnn) from pre-<src filename> record and
can treat the next record correspondingly. Still a split, just a bit more
careful handling of the resulting list/array.
