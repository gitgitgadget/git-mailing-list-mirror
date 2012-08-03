From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 05/16] t2104: Don't fail when index version is 5
Date: Fri, 3 Aug 2012 14:42:39 +0200
Message-ID: <20120803124239.GC3226@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-6-git-send-email-t.gummerer@gmail.com>
 <878vdwcrmd.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxHDL-0001Uk-Cm
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab2HCMmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:42:43 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63226 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab2HCMmm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:42:42 -0400
Received: by wgbdr13 with SMTP id dr13so616890wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6Su385xJllaiNSxyWaadOMi5d9AMrKYb9aRe5YA5LxE=;
        b=ywU6D8ewh0MM+7M2REZWmVR0uddNr+lhpcWt7ZrcGhXeE/UlvSQDqGQ03xkKFGvtes
         q2yH8li3Sgz1xtn/9jFg9h7yxkPdZTTM5QmPVaSgS12yXUTh3GUIDyugG3wHpOe8zshs
         zoQ56VLZvYydvoY+X8Kd4thnB70NKiQl6rdiaUJuOALwFVv4Y9hDjUvMvmHUAZHdeUyn
         2Vp42la7XSqGFnzJb0Zb+OWuSjQIm+Ji+XHV9q/kMIiotRkoZOh+deb6ejp8iHgUWsFt
         GdPk4jMpA33EBC0xHnMidpfBeymv/Kbf0nipIDCcawnpYZ0JPvscx8eDFRFNQvTZglBe
         jHlQ==
Received: by 10.180.103.4 with SMTP id fs4mr4099840wib.16.1343997761371;
        Fri, 03 Aug 2012 05:42:41 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id w7sm39293983wiz.0.2012.08.03.05.42.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 05:42:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878vdwcrmd.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202835>

On 08/03, Thomas Rast wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > The test t2104 currently checks if the index version is correctly
> > reduced to 2/increased to 3, when an entry need extended flags,
> > or doesn't use them anymore. Since index-v5 doesn't have extended
> > flags (the extended flags are part of the normal flags), we simply
> > add a check if the index version is 2/3 (whichever is correct for
> > that test) or 5.
> 
> Next time we set a new index format as default (which might be when we
> make v4 the default!), we'll have to patch this again.  Wouldn't it make
> more sense to let them depend on a "default index format is v2"
> prerequisite?

Sounds good to me, since formats other than v[23] don't do anything
in this test anyway.

> > -test_expect_success 'index is at version 2' '
> > -	test "$(test-index-version < .git/index)" = 2
> > +test_expect_success 'index is at version 2 or version 5' '
> > +	test "$(test-index-version < .git/index)" = 2 ||
> > +	test "$(test-index-version < .git/index)" = 5
> >  '
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch
