From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: State of Perforce importing.
Date: Wed, 19 Sep 2007 19:23:41 +0100
Message-ID: <3f4fd2640709191123j64b53878vc96d785c13c3bca2@mail.gmail.com>
References: <20070917193027.GA24282@old.davidb.org>
	 <20070918233749.GA19533@old.davidb.org>
	 <200709190819.12188.simon@lst.de>
	 <20070919171243.GA23902@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Simon Hausmann" <simon@lst.de>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY4DF-0002jS-5l
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 20:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbXISSXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 14:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXISSXo
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 14:23:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:28116 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbXISSXn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 14:23:43 -0400
Received: by wr-out-0506.google.com with SMTP id 36so120178wra
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=01xHxCs+jHnlYUyP8y/oekP5rCQaSJFy1RxV06L0O/w=;
        b=U7c5of2Y4PcJ4y1f1uQHrTdVGLSWoUqwnw/e8y00LaxBZKOxAAvAtZ95tU6EgjIOX+av3SPvjHUN1ADrzpkpzGX1d/ZdEIvm2h0oo1CmgmjKhJ3yr4Ndfp+o4HCxJ77/DSWfi64rq4ykF52JVv765YhdT7uAYI2lL20MGx4ZoQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rt+R+TdKAPyOX/1Kv/o+tnnQEFJeFEpn36ms2y86MRvYUZfhaaJxc6XY5pDZnpwN6PsxsDoivHT3VwpilwopWrujzLPQmjcutzRfX7uwJRMRtHXaqd00aV/GqxFxXP4/MfLHoL8ZcxZ4spUTZxjb8HYuY9QTTWD5yEOdpdgqsSY=
Received: by 10.142.105.14 with SMTP id d14mr410721wfc.1190226221507;
        Wed, 19 Sep 2007 11:23:41 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Wed, 19 Sep 2007 11:23:41 -0700 (PDT)
In-Reply-To: <20070919171243.GA23902@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58719>

On 19/09/2007, David Brown <git@davidb.org> wrote:
> On Wed, Sep 19, 2007 at 08:19:11AM +0200, Simon Hausmann wrote:
>
> >> An additional problem:
> >>
> >>    - git-p4 doesn't preserve the execute permission bit from Perforce.
> >
> >Hmm, can you paste the output of
> >
> >       p4 fstat //path/in/depot/to/file/that/is/imported/incorrectly
> >
> >? I'm interested in the type of the file that p4 reports.
>
>    headType kxtext
>
> so the problem is that the git-p4 is only looking for an 'x' at the start.
> According to 'p4 help filetypes', we need to use execute for any of:
>
>    cxtext, kxtext, uxbinary,  and the others that start with 'x'.
>
> I think it would be sufficient to check the first or second character for
> an 'x'.  I'll make a change and give it a try later today.

These are the old file types. If you read the output of `p4 help
filetypes`, the new way of specifying this is with file type
modifiers. Therefore, you also have things like text+x.

- Reece
