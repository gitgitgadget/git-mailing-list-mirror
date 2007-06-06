From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Wed, 6 Jun 2007 15:58:09 +1200
Message-ID: <46a038f90706052058h1c823278o78ce0d8edce3caab@mail.gmail.com>
References: <46660F43.4060402@freedesktop.org>
	 <20070606133915.d72e4afe.git@ozlabs.org>
	 <87sl957naf.fsf@graviton.dyn.troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Stephen Rothwell" <git@ozlabs.org>,
	"Josh Triplett" <josh@freedesktop.org>, git@vger.kernel.org
To: "Michael Poole" <mdpoole@troilus.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 05:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvmf5-00029Y-FM
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 05:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbXFFD6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 23:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765282AbXFFD6M
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 23:58:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:30502 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbXFFD6L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 23:58:11 -0400
Received: by wx-out-0506.google.com with SMTP id t15so16485wxc
        for <git@vger.kernel.org>; Tue, 05 Jun 2007 20:58:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fwyn4uCMG7FuAaraij/QVFDPT8If2aKuvU5EQsdjxKw5LWoFgi6GI7SgKTy3kzcHK8MohVzsdZHDgnyvWt+NaxFuNm7WyaNzCqVB3ZnDepEQJNo2CEtALK5fOiWQOp+WfLOjF6Q+U5B+S7iNYJhsQGlgt+8lzDXKh0XCT2ogwqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qYong5+K9R7BWyOcp/OP8q4WMUgrGhcRwdnKh11lhsE8D+1ImMct4LthBHwQ7T4LwmDCCH1hOz/MUAjPQQZm5V2qgdhTdAi23ieFuGT7Io8dFyyb1VOal1W7OIYmqA3uVSAi0C9evRwX3k/DZGNd3trVLjrCpepBmvLq8vRBSGk=
Received: by 10.90.52.18 with SMTP id z18mr25586agz.1181102289183;
        Tue, 05 Jun 2007 20:58:09 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Tue, 5 Jun 2007 20:58:09 -0700 (PDT)
In-Reply-To: <87sl957naf.fsf@graviton.dyn.troilus.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49241>

On 6/6/07, Michael Poole <mdpoole@troilus.org> wrote:
> Stephen Rothwell writes:
>
> > On Tue, 05 Jun 2007 18:34:59 -0700 Josh Triplett <josh@freedesktop.org> wrote:
> >>
> >> -commits=$(cat ../revs | wc -l | tr -d " ")
> >> +commits=$(wc -l ../revs | tr -d " ")
> >
> > This is not equivalent, you probably wanted:
> >
> > commits=$(wc -l <../revs | tr -d " ")
>
> Which relevant version(s) of wc do not accept filename arguments?
> POSIX[1] seems to specify it.  Or do you mean that there is some
> subtle difference in its processing of stdin vs specified files?

Josh is right. The output *is* different because it contains the
filename as well. See

  $ wc < .gitk | tr -d " "
  2177551
  $ wc .gitk | tr -d " "
  2177551.gitk

cheers


m
