From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 08/13] prevent try_delta from using objects not in pack
Date: Thu, 5 Apr 2007 19:28:20 -0700
Message-ID: <56b7f5510704051928l5d1f5a02yccc8e57c222e5f64@mail.gmail.com>
References: <56b7f5510704051535ya98e86eu7f786f118c4fe229@mail.gmail.com>
	 <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 04:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZeBd-0008L8-Q2
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 04:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767508AbXDFC2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 22:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767504AbXDFC2X
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 22:28:23 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:12384 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767508AbXDFC2W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 22:28:22 -0400
Received: by nz-out-0506.google.com with SMTP id s1so428885nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 19:28:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LTn3WwHew/N7HMpqcePOrSSzWUII6U+dwm4O1NQIvUq7p/YqV1OKXK4rL2+UBzOKtV5K6+++f/k5kx36V+mSJiBn3K3F/TRj55uenBZbW3HbGZTa82tpnT4/IuyigMEDT8LKVho0TIvkjfcjggCsyE2ZDiLQSrL8U/uiaqSYuLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AkHK29zeohRkrfr2TPCeVg1uZl/xUkAPH32gyhugbQrllWtV9jwIvFr6N3y49npiiXBcJfSSbOB4l+J2dt0j6rYIsqh92a3EdTsPGELmW/R6eYRdUVSDG2laHUFO8QgneSYwHEVHgm48YqU0vsfLw1cyNRYD3ATBCMfEMw2GYPU=
Received: by 10.114.183.1 with SMTP id g1mr1043928waf.1175826500911;
        Thu, 05 Apr 2007 19:28:20 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 19:28:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0704052100420.28181@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43895>

On 4/5/07, Nicolas Pitre <nico@cam.org> wrote:
> What is the purpose of this patch?
>
> The try_delta() function is called with all objects before any object is
> written to a pack to find out how to deltify objects upfront.

I set no_write for 2 different reasons in the patchset.
(1) When the blob is too big (--blob-limit) and will never be written.
(2) When the blob has been written to a previous, finished pack.

You're correct that this patch will never see condition (2).

I think my repository statistics are a little unusual.
Perhaps I'm getting ahead of myself here,
but I also wanted to experiment with writing all blobs to one set
of packs,  and all trees, commits, and tags to another set
(but probably just one small pack).
I would use no_write for that and it would matter here.
But I haven't run any experiments yet so I don't know
if it makes any difference.  I have seen related discussions
on the mailing list so I know this isn't a new idea.
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
