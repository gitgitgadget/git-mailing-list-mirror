From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: stgit truncates binary files to zero length when applying patches
Date: Wed, 16 Nov 2005 11:11:56 +0000
Message-ID: <b0943d9e0511160311k725526d8v@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 12:12:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcLCr-0004t1-Md
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 12:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbVKPLL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 06:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbVKPLL5
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 06:11:57 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:49002 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030276AbVKPLL5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 06:11:57 -0500
Received: by xproxy.gmail.com with SMTP id i30so1640941wxd
        for <git@vger.kernel.org>; Wed, 16 Nov 2005 03:11:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cSRQthhBuMrTMn41nhj5y9yIcOVSlsvhRhKuet9byFC2XkVhwpuO87t9AquXRn/Pl5Ntw5jG5jgYE8WJ3a1pA5OyXH7dp0dVdNNix1G2F5F2Iujh1uHFVjrpQExuCwJ+ZsS9IMJoJpplFXhJYmp+zGo3bQbA78uJM9wUnz1jRIs=
Received: by 10.70.54.2 with SMTP id c2mr3852552wxa;
        Wed, 16 Nov 2005 03:11:56 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Wed, 16 Nov 2005 03:11:56 -0800 (PST)
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12020>

On 15/11/05, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> When applying patches and not fast-forwarding, stgit truncates the
> binary files to zero length:

I've never tried binaries with StGIT before. When pushing a patch, if
a merge is needed (like in your case, the base of the foo patch has
changed), StGIT first tries "git-diff-tree | git-apply" for speed
reasons. If this fails, it falls back to a three-way merge.

Unfortunately, git-apply doesn't fail for patches including binary
files and simply creates an empty file. I think git-apply should be
changed to fail to apply this kind of patches.

--
Catalin
