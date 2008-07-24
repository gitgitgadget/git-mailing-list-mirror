From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 15:27:03 +0700
Message-ID: <fcaeb9bf0807240127p5226822atcd4a0711f1bc9c5c@mail.gmail.com>
References: <20080723145518.GA29035@laptop>
	 <alpine.DEB.1.00.0807231713280.8986@racer>
	 <fcaeb9bf0807230921m114f5ae0ybfec4917432d6dc7@mail.gmail.com>
	 <alpine.DEB.1.00.0807231753240.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:28:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwBG-0003GE-RV
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbYGXI1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYGXI1I
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:27:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:45564 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYGXI1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:27:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1338417fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3awUi5cvIvFBCHQyXRuD5o5/6kFW5nNomrbue/gAukA=;
        b=CO5MRAjFz2/7UGJODgH2WNpFngdVQ1xVfR7YI8DNak7DKcNw+YV0disX1+ccaP3GSA
         1jM9ECxk5z/LdqgAhaus1DPEaivwS4GbZAPQBkF+ofUa3/pTqsdYv5p8Cc8SKWLLb3LK
         bjSmVt+5nZ5/vOflqnZS0DSyJg8zCkJofjwl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dYnWcZjUeNQQjgSWN8MMFzq9HHyMz3y1baekFOyhE4MhA8cyRfKmiI0dwmr4FL0l49
         d6gbecCzAzG4j3YjdvvDeHca7/b4C+1f/9TLw45p4uOVbRkp/e09oJXLGKSfcnlpgzQ1
         fxpS8cbMRYf5AxehBocpohTm3z9GyxYds/I8A=
Received: by 10.86.49.13 with SMTP id w13mr625993fgw.30.1216888023962;
        Thu, 24 Jul 2008 01:27:03 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 01:27:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807231753240.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89849>

On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Wed, 23 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>
>  > On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  >
>
> > >  On Wed, 23 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>  > >
>  > >  > So in short, sparse prefix will be stored in config,
>  > >  > core.sparsecheckout.
>  > >
>  > > Do you really think the prefix should be stored anywhere else than the
>  > > index?
>  > >
>  > > With core.sparseCheckout you have to introduce a _sh*tload_ of config
>  > > loaders.
>  > >
>  > > And with core.sparseCheckout you are at the whim of the user, since
>  > > .git/config is _supposed_ to be user-editable.
>  > >
>  > > From a logical point of view, I'd say that the sparse prefix has
>  > > nothing to do with the "configuration" of the local repository.
>  >
>  > Well, whatever place. I chose .git/config because I did not want to
>  > introduce a new config place. But then how about .git/sparsecheckout?
>
>
> No, I did mean the index.  This is an attribute of the index: either it is
>  sparsely checked out or not.  You can even have multiple indices
>  (switching between them by setting GIT_INDEX_FILE) which have different
>  prefixes.

I don't think so. It's a mask for workdir, right? If you save it it
index, you can switch index and the prefix as well, but workdir only
has several subtrees that do not fit any other prefix than the
original prefix.

>  Ciao,
>  Dscho "who seems to recall that the first series was much less intrusive"

The first series only took care of index, so yes it's simpler.
-- 
Duy
