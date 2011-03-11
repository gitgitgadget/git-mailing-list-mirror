From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC resumable clone
Date: Fri, 11 Mar 2011 22:42:35 +0700
Message-ID: <AANLkTinDBm-Q3MA62r_TRqt-qxmPuDKPACr4bEPnJ6vz@mail.gmail.com>
References: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Miseler <alexander@miseler.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 11 16:43:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py4Uj-0002zr-GO
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 16:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755485Ab1CKPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 10:43:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60542 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1CKPnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 10:43:07 -0500
Received: by wya21 with SMTP id 21so2525539wya.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 07:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bvJjGQteasgf8ZaRQ3faMXjh627NIszw45s0qSeoO30=;
        b=G46ysOaBMUx4NyIVa4kG+CZNlrAPmA9wa/5BP+DiJ/IZcZiKyHxXmA6h9x5EHnhxbb
         W/1B0XftW85jywtLNb+GOwE2BCCDSfNg6tXXLqKI3nAXVR5h29Qd0e0Kd8+7Az/cQgC/
         JHr5WIVEfCuAumRQDzHijoFwjcJHw6h+cxwQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YacVq4yrRIs8EG4phoE6ptK56dlOp8+rFt8IDnGwSue91fQpzxEpSKysoGA6WdEmNs
         EtcG5VsOB7O9ogBOmJm85BfL5dX0kJFQqMDTCEAxlYnePoayyHfPyRVKpWD3fq2uSmx2
         nmk4L0yFt8CLaqYh8VKMHvtBKcwJ5zk+jYUSM=
Received: by 10.216.200.82 with SMTP id y60mr8444558wen.31.1299858185194; Fri,
 11 Mar 2011 07:43:05 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Fri, 11 Mar 2011 07:42:35 -0800 (PST)
In-Reply-To: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168910>

On Fri, Mar 11, 2011 at 10:17 PM, Shawn Pearce <spearce@spearce.org> wrote:
> I think the cached bundle idea is horrifically stupid in the face of
> the subsequent cached pack idea. JGit already implements cached packs,
> and it works very well. The feature just needs to be back-ported to
> builtin/pack-objects.c, along with some minor edits to my RFC patch to
> git-repack.sh to be able to construct the cached pack.
> ...

I wonder why I missed it. Probably to recent and has not be carved to
my mind yet.

> Junio and I would like see narrow checkout code re-implemented to
> support obtaining only a subset of the paths from the remote.

I'm close to finishing negative pathspecs (for extending narrow
clones). I'll get there.

> Once that is implemented, a client on a really bad network connection
> could do a resumable clone by grabbing a shallow clone of depth 1
> along no paths, partition the root tree up, then extend its paths
> grabbing subdirectories until the root commit is fully expanded. Then
> it can walk back increasing its depth until it runs into the cached
> pack... where it can then do byte range requests.

Yes. But then it'll cost server's processing power more. Partitioning
by path reduces chances of reusing deltas a lot.
-- 
Duy
