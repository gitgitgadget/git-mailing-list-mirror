From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Making submodules easier to work with
Date: Wed, 7 May 2008 12:14:43 -0400
Message-ID: <32541b130805070914n2d090971rf367c838dcfd9557@mail.gmail.com>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
	 <BC221793-3FB5-4249-8E8D-819C1B413592@gmail.com>
	 <32541b130804301331o70310831raf71db7cbb51d507@mail.gmail.com>
	 <EFEF26F9-D5D6-4BAC-9A8F-6D96E45AFAF7@gmail.com>
	 <32541b130804301448i537a0b98ta01cecc472e20aec@mail.gmail.com>
	 <1209594215.25663.864.camel@work.sfbay.sun.com>
	 <32541b130804301528k70ae2f7eq5229c0b4bb1d3788@mail.gmail.com>
	 <20080501183837.GA4772@pvv.org>
	 <32541b130805011255t4b37a73cx9d670b9250e787c6@mail.gmail.com>
	 <1210117622.25663.1110.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Finn Arne Gangstad" <finnag@pvv.org>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Wed May 07 18:15:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtmIr-0002Y6-SD
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192AbYEGQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756457AbYEGQOs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:14:48 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:35694 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757261AbYEGQOq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:14:46 -0400
Received: by fk-out-0910.google.com with SMTP id 18so379339fkq.5
        for <git@vger.kernel.org>; Wed, 07 May 2008 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lXKF5IIGNzDgW+HdzSlTHn9hOT4hWvz+HPbbJyS3qzs=;
        b=sr6q8k6U7FEUhRQn94fO7/ENPvT1UHpM9S1v3N1okvYQ35cy4uFqKiv771/ciPMks6UjDya6+pHr4d5HLr8llUfQNABZes4Vui7/4/QpcoiIS2eBc/zxisXIaCTGgf28bcC72V4cRFnnaRCTBvEFkXeuk5Kp0+nDSX88aYkJd8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQbU0yNaOuDAJbmjxdgyiQbjSeP4EmP+mc7SjMMIE/DVqQMLx0+y8ATd/cAs4RR0qEdViwD3EmlQKe2ZTosASRuX6TvdJkLY7Rbm4MvWzIBMszV5lOz4h/hCxKmmmxB7d9r0f2uID4ocCnH17uti89sNykX9e++sCGfnozylM+s=
Received: by 10.82.107.15 with SMTP id f15mr234468buc.86.1210176883906;
        Wed, 07 May 2008 09:14:43 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 7 May 2008 09:14:43 -0700 (PDT)
In-Reply-To: <1210117622.25663.1110.camel@work.sfbay.sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81458>

On 5/6/08, Roman Shaposhnik <rvs@sun.com> wrote:
> May be my brain is saturated with "partial cloning" but somehow the
>  following looks like an interesting twist on a decentralized SCM:
>  imagine that the picture given by Finn Arne Gangstad weren't
>  static. IOW, os-lib wasn't really a separate component to begin
>  with but was first developed as part of a "crawler" and only
>  when the other team started to implement "indexer" there was
>  a need for os-lib to be shared between two independent projects.
>  Is there any nice way to express such a dynamic history sharing,
>  short of truly refactoring os-lib into a separate Git repository
>  and treating it either as a submodule or a subtree-merge?

Personally, I think it would be good enough to split out the os-lib
into its own repo using "git-filter-branch --subdirectory-filter", and
then link to it in newer versions of your crawler and indexer projects
using git-submodule.

There would be a bit of wastage here, since crawler still contains the
history of os-lib, which is the same (even the same tree and file
objects!) as the ones in os-lib.

I can think of two responses to that:

1) It's not very important, disk space is cheap and git repositories
are small, and it's much better to have an accurate history of the
crawler project than to overoptimize for space.

2) If the supermodule and submodule shared the same object repository
(eg. the submodule was checked out with
--alternate=<supermodule-gitdir>), there would be no need to waste
storage space.  If/when I get my act in gear and start submitting
git-submodule patches, supporting this behaviour is the direction I'll
probably start in.
(http://article.gmane.org/gmane.comp.version-control.git/78675)

Have fun,

Avery
