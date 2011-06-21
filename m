From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/13] Sequencer with continuation features
Date: Tue, 21 Jun 2011 10:48:09 -0500
Message-ID: <20110621154808.GE15461@elie>
References: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 17:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ3Bd-0002Py-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 17:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab1FUPsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 11:48:17 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64041 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690Ab1FUPsP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 11:48:15 -0400
Received: by iyb12 with SMTP id 12so2951871iyb.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PgOlwd5FGzk5sK2DD0HXueunKs2NGnEIqc3FphSTNu0=;
        b=SmbvgY8GD2EC+cOt0QwY6vPM558NIZChd3SFWORVnU/F19XitPCEpYo077CcaGpkMM
         flD1fvXAxGGcthbYLmZpSYxgUOAdo9WmLgm1OyWEhQyl9ZJiwuiDfZ0Kw5hwRWVCksjf
         qLdCzdIsP1NYV9ML2O67GaehAgxYx0BRWyCtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uXpYbdkfqiX8NK5Y8Y5RFxMYYJBJ+Y9IMAcI1X4T0OH9jgt0wRVYfnqqx2hYs2iFUZ
         xUFpq/oJIBMxu6KxiGPOd2ncOcrr/SaqBUOPNHmjTf5G+b40GJKQTr7ndd/zXXSRoE/r
         CvvkBe2h3jXQ3mkP3t59PQy3EKfKjaDgmOteo=
Received: by 10.42.153.6 with SMTP id k6mr6443047icw.154.1308671294379;
        Tue, 21 Jun 2011 08:48:14 -0700 (PDT)
Received: from elie (adsl-69-209-79-158.dsl.chcgil.ameritech.net [69.209.79.158])
        by mx.google.com with ESMTPS id y1sm1801321ica.16.2011.06.21.08.48.12
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Jun 2011 08:48:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1308661489-20080-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176162>

Hi,

Ramkumar Ramachandra wrote:

> I think I can safely say that
> I'm quite happy with the general state of this series now.

It's certainly starting to shape up.  I'll quickly review the style
and commit messages now, since the part I was lobbying for most has
been dealt with (hoorah!) and the rest of the substantive part seems
to have some potential changes queued up if I understand correctly.
In particular, I have high hopes for changes rippling through once
tests get added to make the detailed behavior more clear. :)

General rule of thumb about style, especially commit messages: if
something looks wrong, it is.  Which is to say, the goal is to make
the code easy to read and hack on, and part of that means avoiding
that moment of surprise that might interfere with someone getting on
with the task at hand.  If I seem to be not making sense, please as
usual do not assume I am right, but think carefully about it and
(ideally) gently correct me if I'm wrong.

Okay, on to the patches.  The general shape of the series is a little
odd --- some die() elimination, removal of globals in preparation for
making this a reusable API, and then the title feature that does not
rely on any of the patches before it.  Still, it makes a kind of sense
from the point of view of development:

 1. First, getting to know the API and using that process to come
    up with obvious improvements.

 2. Next, implementing the new feature.

If I had been writing it, I would have rebased the last 4 patches
against master as a new series (so they could be integrated more
quickly), but I don't mind reading it this way.

Regards,
Jonathan
