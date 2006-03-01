From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 1 Mar 2006 15:08:39 +0000
Message-ID: <b0943d9e0603010708l72cb14d1w@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <20060227222600.GA11797@spearce.org> <tnx1wxmig75.fsf@arm.com>
	 <20060301145105.GB3313@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 16:09:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FESwX-0005Ve-Pf
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWCAPIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCAPIl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:08:41 -0500
Received: from xproxy.gmail.com ([66.249.82.200]:21848 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932386AbWCAPIk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 10:08:40 -0500
Received: by xproxy.gmail.com with SMTP id s13so101570wxc
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 07:08:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n8wcX12oUyE+jA+97Bl81DQBFsfVB4+ExWLcCMYZW3KlIknV7ILukbk7KJEVW5F0exSyVbmz73NKymmc44wByrmwiNSnxh3fxozl5B7W+00+NAFsTayeD2G4gswiouRZIVpGkoE+hyIKgoztx9+Pgx4YUk5aMve/mFpa0Fs9niI=
Received: by 10.70.123.18 with SMTP id v18mr2022627wxc;
        Wed, 01 Mar 2006 07:08:39 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Wed, 1 Mar 2006 07:08:39 -0800 (PST)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060301145105.GB3313@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16978>

On 01/03/06, Shawn Pearce <spearce@spearce.org> wrote:
> [Side Note: I've suddenly stopped receiving mail from vger.
>  Even majordomo isn't replying to my pleas for help.  Arggh!
>  Yet all other incoming email seems to be fine.]

news.gmane.org

> True.  The constant reapplication does really slow it down.  So does
> grabbing the reverse patch and seeing if it applies backwards
> cleanly.  Neither operation is fast, and neither is really going
> to be fast.

I realised that, depending on the number of patches merged upstream,
using this option can make StGIT faster. That's because when pushing a
patch (without the --merged option), StGIT first tries a diff | apply
followed by a three-way merge (even slower) if the former method
fails. This means that for all the patches merged upstream, StGIT
tries both methods since diff | apply fails anyway. With the --merged
option, StGIT would only try the reverse-diff | apply and, if this
succeeds, it will skip the normal push methods.

--
Catalin
