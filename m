From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [MinGW port] Unable to repack on Clearcase dynamic views
Date: Wed, 30 May 2007 15:08:40 -0400
Message-ID: <fcaeb9bf0705301208p6ce00315uc3cde4d43903ec0c@mail.gmail.com>
References: <fcaeb9bf0705300742u22b54c78vccbc037fb553141f@mail.gmail.com>
	 <34a7ae040705300811o22a7d9e9y1ca6e52c4bf23fcc@mail.gmail.com>
	 <fcaeb9bf0705300833t6f0639ddx2f507996e48d838c@mail.gmail.com>
	 <200705302028.15549.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Paolo Teti" <paolo.teti@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Lederhofer" <matled@gmx.net>,
	"Junio C Hamano" <junkio@cox.net>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 30 21:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtTXP-00031y-6l
	for gcvg-git@gmane.org; Wed, 30 May 2007 21:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXE3TIn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 15:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbXE3TIn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 15:08:43 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:12607 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXE3TIm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 15:08:42 -0400
Received: by an-out-0708.google.com with SMTP id d31so746550and
        for <git@vger.kernel.org>; Wed, 30 May 2007 12:08:40 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sIL+u41ne/z5RxBXht19gEkbX0KRxttAoeUlPI+scxcJ3Lqm/AAxwJUK3OCbqHoKKdYTDDRNXauqbQT1msWP1UPH8SIembBy5GJ02qwzFYsdiMKoIx85vZbbwkiwodJySxBXnwITyrCWgLYcTJ137j82EivaN9eOm53+KiZD23Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jq+m+eyZtLior/aUn0SzxYN438xap/LZyB4RNDqBy1HFn4qUpM1RPbNzCfWE8hWYMV5CWjsBfY0Gr8a/mt0GVXWuQj0+gsPb+u5TKbGmrD6hCEH2h+j9wi3l/aIC5Nd6wAjIQqKZFjWzh3YZGzruUeiSKZ9gvF3Hgdx2/oN7/70=
Received: by 10.101.14.16 with SMTP id r16mr822290ani.1180552120194;
        Wed, 30 May 2007 12:08:40 -0700 (PDT)
Received: by 10.100.127.2 with HTTP; Wed, 30 May 2007 12:08:40 -0700 (PDT)
In-Reply-To: <200705302028.15549.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48781>

On 5/30/07, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> onsdag 30 maj 2007 skrev Nguyen Thai Ngoc Duy:
> > On 5/30/07, Paolo Teti <paolo.teti@gmail.com> wrote:
> > > 2007/5/30, Nguyen Thai Ngoc Duy <pclouds@gmail.com>:
> > > > Hi,
> > > >
> > > > On clearcase dynamic views (kind of virtual drives), "mv -f a b" won't
> > > > work if "a" is read-only. Because git-repack.sh removes all write
> > > > permission before moving packs, it fails on clearcase dynamic views.
> > > >
> > > > My approach is rather ugly. Does anyone have a better solution?
> > >
> > > I hate clearcase, but honestly I have used it forced by a customer..
> > > The real problem is why you need to do a repack in a CC view, but..
> >
> > I don't like it either :) But you remind me the Matthias' workdir
> > patchset. With that I can move out .git to a real drive/filesystem
> > (which should also give better performance).
> >
> > I think it's a valid use case. Anyone remember why Matthias' patchset
> > was dropped?
> > It was last mentioned in
> > http://article.gmane.org/gmane.comp.version-control.git/43041
> >
> > Junio, Matthias? May I help?
>
> Wasn't because it's better to make .git a link to a repository somewhere
> else? Just a guess.
>
> ln -s /somewhere/repo/.git .git
>
> Works fine for me (yes, in a clearcase dynamic view).

Clearcase symlinks require checkout/checkin stuffs that I really don't
want to mess up with. Moreover, it seems not work if the link
destination is out of clearcase view (which is what I wanted).
-- 
Duy
