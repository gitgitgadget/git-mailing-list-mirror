From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Wed, 6 Apr 2016 23:40:07 -0400
Message-ID: <20160407034007.GC17848@LykOS>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
 <CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 05:40:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ao0nv-0002CJ-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 05:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbcDGDkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 23:40:16 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33879 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbcDGDkO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 23:40:14 -0400
Received: by mail-qk0-f196.google.com with SMTP id z64so3132656qkb.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ofgT0SWkQspXbPFEx3+B0ESGs+y11OBdwxjx+0oqgSs=;
        b=LL19FD69HdjU9Tbln7ShsIF+0Ug0eTTTaoYp9yPVhIa9R0Y334zwnocLwmgAlKUtiv
         cHPccbaJIFM7Gyc3ZeTGWV8Xox/Vya9YRH7dOURmBQ7Co5bTqZezMyisLS8vjkZxnvwb
         mkIdCpp0bgduHtz+9o3xHw5/KmRf1GFsQDu5CoiDwGF2g6A1rnY10zQu8GcYI+H9chaZ
         FgOyrnhsQAR+r5prE0A8MbTCr4qoHtNTQMBaDLtpy/pl5zD0LG9iuEwf4wpYr/EJ30G5
         6leFy/nzrowXorUnkywiPlv/F8Yf4yFd/UjS+d8pMc1Ee3HMo/byAN+nmg5C0ZZDuaqV
         8ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofgT0SWkQspXbPFEx3+B0ESGs+y11OBdwxjx+0oqgSs=;
        b=DQT4WEmWnBIIzQ/Vmlu4fSSoSHVZwbpnzMPXPkolG7RP00bbyi/c3XdvaBKFKAgON3
         CbvOpiWM6w91bsJ86eNos8T5cJ9BJRYvEN1l89nMBSfOQlhFZq0RNRuQbFwMQbsrjTwh
         P9+dNXsGo7YPjpFUt+T1ZQI+X7c2Ytohx9Vwiej4/fhzG5yHA0UfVh62EgG0wPq+YuiY
         OgoH3hFovJVs9apbJZ+xwra5MDJrGbESJc7LbRBn1F9xuOpjV9RuCdho+bxeWT2X8SKl
         R0NFbkccFX1IhII0niJwbafuiffYbpRVPSMscBTlC/LO9vAzkSpDbZvHA8VKKWF51/vK
         OIMw==
X-Gm-Message-State: AD7BkJLDeJjzJfClhG/UaYVKVVEF0Qt0afneICWi1URzFL4veCli6PD4s2yRk6DxxnGpExcV
X-Received: by 10.55.215.82 with SMTP id m79mr887874qki.16.1460000408574;
        Wed, 06 Apr 2016 20:40:08 -0700 (PDT)
Received: from LykOS ([12.11.110.3])
        by smtp.gmail.com with ESMTPSA id y123sm2670269qka.0.2016.04.06.20.40.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 20:40:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290904>

> > v5 (this):
> > Added helpful feedback by Eric
> >
> >  * Reordering of the patches, to avoid temporal inclusion of a regression
> >  * Fix typos here and there.
> >  * Review commit messages, as some weren't representative of what the patches
> >    were doing anymore.
> >  * Updated t7030 to include Peff's suggestion, and added a helped-by line here
> >    as it was mostly Peff's code.
> >  * Updated the error-handling/printing issues that were introduced when.
> >    libifying the verify_tag function.
> 
> This version is a more pleasant read, easier to digest and understand.
> All of my review comments were minor; nothing demanding a re-roll. As
> such, this version is:
> 
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> 
> If you do happen to re-roll based upon the review comments, feel free
> to add my Reviewed-by: (but not if you make larger changes).

Thanks! I'll add your and Junio's in another re-roll.
-Santiago.
