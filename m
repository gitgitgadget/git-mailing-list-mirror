From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: new stacked git feature
Date: Fri, 22 Feb 2008 13:54:12 +0000
Message-ID: <b0943d9e0802220554x4c0a6c98q39e8b253bb108f1e@mail.gmail.com>
References: <20080111194946.GA7504@redhat.com>
	 <1202834567.14175.68.camel@pc1117.cambridge.arm.com>
	 <20080213000806.GB25839@diana.vm.bytemark.co.uk>
	 <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com>
	 <20080213235204.GA10335@diana.vm.bytemark.co.uk>
	 <b0943d9e0802201506w353b5c05vece9f99730d7663c@mail.gmail.com>
	 <20080221074543.GB8250@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jason Baron" <jbaron@redhat.com>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Yann Dirson" <ydirson@altern.org>, git <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 14:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSYMY-00085w-2e
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 14:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759178AbYBVNyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 08:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760792AbYBVNyP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 08:54:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:40906 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993AbYBVNyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Feb 2008 08:54:14 -0500
Received: by wx-out-0506.google.com with SMTP id h31so380485wxd.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 05:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8C07t7NNB/NH64b4kOWPhNcViJqkHxHVXGNm/aHkZY8=;
        b=v1LaFi4olfHo2gLPpMRSY4lwcgQzkMhrYN65bsJfYMZ0ZzYSDTe+AGaZhpmCGVY9R+Lo2z1J8LjpCWDQ7U7hh0/Ayf/pdKFIYaEELybDVTF64lJHBlGkcswGwyGE02ClhPiYDyhkvMsoGZREJ0TGg21nIK9yF+9ILwmf2j8ejeM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=COJEaPy13goTuNKJ52obekuwiHPvfrDAgxChQiehjxKgbRO96wlESGtSzLw+r9zFLKdpxlrV1m1Ipybhzp4kumwf/hU6ovQfbVjVLsCcRdo3dWzABH3Yzfqok2uJxufnmoVAKD43UiTOCmOLdZJ7I216Y85nZCtpqhNiHWLONHo=
Received: by 10.141.202.12 with SMTP id e12mr7678778rvq.65.1203688452158;
        Fri, 22 Feb 2008 05:54:12 -0800 (PST)
Received: by 10.140.193.5 with HTTP; Fri, 22 Feb 2008 05:54:12 -0800 (PST)
In-Reply-To: <20080221074543.GB8250@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74723>

On 21/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-02-20 23:06:07 +0000, Catalin Marinas wrote:
>  > There is also a situation when patches on the remote stack were
>  > reordered and with some conflicts fixed. In this case, merging get=
s
>  > even more complicated (I think darcs solves this by making all the
>  > patches immutable but the base feature of StGIT is that patches ar=
e
>  > easily modifiable).
>
>
> The scheme I described should be able to handle this. When a patch is
>  pushed, its base is set, and we can just make a normal 3-way merge.
>
>  Consider a stack with two patches, a:A->B and b:B->C (A, B, and C ar=
e
>  commits). In one branch, this is modified to a:A->B1 and b:B1->C1; a=
nd
>  in the other, the patch order is changed so we get b:A->X and a:X->C=
=2E
>
>  When we merge these, the base is unchanged (so still A), and the pat=
ch
>  order is b, a (since it was changed in one branch but not the other)=
=2E

"stg sync" does pretty much the same now but in a more manual way. I
don't really like the way the conflicts are presented - i.e. you don't
know which patch was modified afterwards because the patches lose this
information (they are not topic branches).

>   1. First we push b. The A->X variant applies trivially, but the
>      B1->C1 variant needs the standard 3-way merge.

3-way merge with X and B1 as base? This leads to the current "sync"
issue, you can't tell which patch was original and which was modified.

Just a thought (not that I'd like this feature in StGIT). Someone
tried a project some time ago, similar to StGIT, but using topic
branches rather than individual commits per patch. The GIT history
looked very ugly, especially after re-ordering, but the advantage was
that you can avoid rebasing patches and simply merging changes from
bottom patches into top ones. This would make synchronisation of
patches between branches much easier.

--=20
Catalin
