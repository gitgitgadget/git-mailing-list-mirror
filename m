From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sun, 21 Sep 2008 18:32:56 +0700
Message-ID: <fcaeb9bf0809210432x500cf586k877d07b335bf33de@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <7vzlm21n83.fsf@gitster.siamese.dyndns.org>
	 <fcaeb9bf0809210311x7e9337fbmd978e95aa7998525@mail.gmail.com>
	 <200809211249.10016.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 13:40:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhNJ9-0001Pu-JU
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 13:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbYIULeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 07:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbYIULeZ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 07:34:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:7854 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYIULeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 07:34:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1047627fgg.17
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yzrwty2lYRboWWVa/MfMzMp4mLLjbT+OB5tgrgiGp9o=;
        b=k9eDN6814tdbuyzr4xaRdUkSRxOQPvuAv0YxT1qSTA2yIxXVzELJD4cKmsauPfdO86
         EF10KQiP5mohOta0rNn/+M2VFhaHdJYre1kTF4s9QS3zYTlTihHgm5KIF9on1Wrhd7Pw
         VFhBBcrM9AJKT3LWKgBJswCJDJy42EQTO0yww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tNd9vTKL74pP3n65hz9+m/eOb0c7Cm5rHoq2rTe1lPg5r74TiBkuFkAuMl1SlZzBfm
         tCBxCS1fP3U6kFJnDyIJgpnrZxID/YBK55DTNkGBRlhIH9nmCv/BAFgyEJsdegOlLRe1
         YERVH7DxHQ1jk4gh3uEtkcmnr+8cfOK+T3HtM=
Received: by 10.86.68.1 with SMTP id q1mr3797917fga.2.1221996776504;
        Sun, 21 Sep 2008 04:32:56 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sun, 21 Sep 2008 04:32:56 -0700 (PDT)
In-Reply-To: <200809211249.10016.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96392>

On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 21 Sep 2008, Nguyen Thai Ngoc Duy wrote:
>  > On 9/21/08, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> > >  How would that --narrow-match that is not stored anywhere on the
>  > >  filesystem but used only for filtering the output be any more useful than
>  > >  a grep that filters ls-files output in practice?
>  >
>  > Well, it works exactly like 'grep' internally.
>  >
>  > >  I would imagine it would be much more useful if .git/info/attributes can
>  > >  specify "checkout" attribute that is defined like this:
>  > >
>  > >         `checkout`
>  > >         ^^^^^^^^^^
>
> [...]
>
>
>  > >  Then whenever a new path enters the index, you _could_ check with the
>  > >  attribute mechanism to set the CE_NOCHECKOUT flag.  Just like an already
>  > >  tracked path is not ignored even if it matches .gitignore pattern, a path
>  > >  without CE_NOCHECKOUT that is in the index is checked out even if it has
>  > >  checkout attribute Unset.
>  > >
>  > >  Hmm?
>  >
>  > Well I think people would want to save no-checkout rules eventually.
>  > But I don't know how they want to use it. Will the saved rules be hard
>  > restriction, that no files can be checked out outside defined areas?
>  > Will it be to save a couple of keystrokes,   that is, instead of
>  > typing "--reset-sparse=blah" all the time, now just "--reset-sparse"
>  > and default rules will be applied? Your suggestion would be the third,
>  > applying on new files only.
>  >
>  > Anyway I will try to extend attr.c a bit to take input from command
>  > line, then move "sparse patterns" over to use attr.c.
>
>
> First, I think that this was Junio asking for discussion more than
>  for changing the design.

I just tried to see if it was feasible. Checking the source again, I
misunderstood  gitattributes/gitingore's leading '/' notion (in a good
way). Leading '/' means './' and that would be fine for
.git{attributes,ignore}. In sparse patterns, leading '/' means
toplevel directory because you may want to checkout some more from a
subdirectory without moving up to toplevel directory. Now
.git{ignore,attributes} and sparse patterns are incompatible, gaah...

>  Second, while unifying the "check the match" part of gitignore,
>  gitattribute and sparse checkout would be IMVHO a good idea, I'm

It is surely good. Optimization like 68492fc (Speedup scanning for
excluded files.) could be applied to .gitattributes too. Now I know
why I was confused when reading the matching part of
.git{attributes,ignore}.
-- 
Duy
