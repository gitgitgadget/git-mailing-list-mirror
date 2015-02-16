From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Multi-threaded 'git clone'
Date: Tue, 17 Feb 2015 06:16:39 +0700
Message-ID: <CACsJy8Brnu7rBxtCq_ac58BW7dOK=wtzMxVL-gsOUXJB2Jss9w@mail.gmail.com>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
 <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz> <20150216150305.GA8279@peff.net>
 <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz> <20150216154745.GA10120@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Lang <david@lang.hm>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNUul-00078G-D2
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 00:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbbBPXRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 18:17:13 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41195 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbbBPXRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 18:17:10 -0500
Received: by iecrd18 with SMTP id rd18so37184412iec.8
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 15:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=b8baPTzH9RbBPUpwXyHYU1wfskXVpApRladsVDmG8J4=;
        b=0F2TYi2K4yzKLOcbVcFPIsHJ8GWYCKNLIg8FdW0eMhcmAZHjBu4gdmRRf1wI/3t8vK
         E2o1gSOTJNWUffBUGdevytAbwt5VCLY0GSziNxsDQ6Kcr5t3LzII3VqCcnbEriUuF28U
         dfSmPugP1Kn2s9FDOi7lTWmgMNW4QbaMEjONDBnH/hNA3CeBLpQpaxyQAxvAPH9QrS2o
         2Rzzq81lAelFL5JJNiFnI2x91iNQpf/3uMz4IEmfPoEAO4IGsqIsaIDqJnGXwnioDCQv
         1CZMx2sWWLoGlZzkQKCsKMgqLgJUpJgkX9Jr77uWe7cvsfWy+cGMitc4m/9PSjIt5ikf
         uywQ==
X-Received: by 10.50.108.108 with SMTP id hj12mr24255517igb.47.1424128629666;
 Mon, 16 Feb 2015 15:17:09 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Mon, 16 Feb 2015 15:16:39 -0800 (PST)
In-Reply-To: <20150216154745.GA10120@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263924>

On Mon, Feb 16, 2015 at 10:47 PM, Jeff King <peff@peff.net> wrote:
> Each clone generates the pack on the fly
> based on what's on disk and streams it out. It should _usually_ be the
> same, but there's nothing to guarantee byte-for-byte equality between
> invocations.

It's usually _not_ the same. I tried when I wanted to produce stable
packs. The first condition is single-threaded pack-objects. Otherwise
thread scheduler could make object order unpredictable.
-- 
Duy
