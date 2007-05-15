From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Tue, 15 May 2007 22:36:05 +0100
Message-ID: <b0943d9e0705151436g64e24a32r23c45c19f750082@mail.gmail.com>
References: <20070506150852.8985.98091.stgit@yoghurt>
	 <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com>
	 <20070515210801.GO19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue May 15 23:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho4hE-0008N7-N0
	for gcvg-git@gmane.org; Tue, 15 May 2007 23:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906AbXEOVgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 17:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbXEOVgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 17:36:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:1741 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906AbXEOVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 17:36:07 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1679934uga
        for <git@vger.kernel.org>; Tue, 15 May 2007 14:36:05 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Se9UURlFY+SLfOrk3FymX2Tl8oN+jOoDIbdYOElw1eL1ojbcolPQixkGu87Lrr5j89x1q89llZCrV/UEr5kTQq5WZ+MqZBxUkN/PxKSpfY1tuz19tVN9ZRlkb5dLUwBh0rGjEpB+RiXzyIfPoDzmNqmypxJ+MUyJ2tarGmbum7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R6Xzx/rrwKEsQUnwe5iK3v7nviXrDEy4Bp3iSceaMhnTG31KFoGICckka2LTfNh+um4deo7lMLzBAZN+L7Cz8LK3HIoN/vthPThZVRGAoIZeNSLTN9P8D2Ay4d/ShtQMDXV6xXGLpmM3ECboKVSCRPS1N65B+LClE2pXSzLuryc=
Received: by 10.66.243.2 with SMTP id q2mr6264639ugh.1179264965457;
        Tue, 15 May 2007 14:36:05 -0700 (PDT)
Received: by 10.67.27.11 with HTTP; Tue, 15 May 2007 14:36:05 -0700 (PDT)
In-Reply-To: <20070515210801.GO19253@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47375>

On 15/05/07, Yann Dirson <ydirson@altern.org> wrote:
> On Tue, May 15, 2007 at 04:56:33PM +0100, Catalin Marinas wrote:
> > I think the self.__current_file (same for the base file removed in a
> > different patch) should still be available in the Series object and
> > removed when deleting a branch, otherwise you get a "Series directory
> > .. is not empty" exception.
>
> Shouldn't we also migrate to new format as soon as we need to touch a
> data - in this case, whenever we push/pop ?
>
> Or maybe declare a new "stgit stack format version" ?  Currently we
> have "stg branch --convert", which switches between a "new" and an
> "old" format which noone probably uses any more.  What about
> versionning the on-disk format, and possibly provide the "convert"
> functionnality back and forth between one format and the next, with
> formal documentation about which version works with which stack
> format ?

I think it would be useful to have a version file (probably per
branch) and just upgrade when a mismatch is detected (in the __init__
function). The other option is to keep ignoring the unused files until
the branch is deleted but we might make a change at some point that
would break things.

We should write successive convert() functions and keep all of them in
case one skips an intermediate version.

-- 
Catalin
