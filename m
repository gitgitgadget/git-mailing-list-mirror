From: Vincenzo di Cicco <enzodicicco@gmail.com>
Subject: Re: Reference to a commit inside a commit message
Date: Wed, 30 Apr 2014 01:23:10 +0200
Message-ID: <CAKOJyXfHKwRXA==M2TaPNT-ZwLPF8YQeEoBoxbe-s6Q+UQgL0Q@mail.gmail.com>
References: <20140428183552.GA9709@workstation.Belkin>
	<20140429034128.GD11979@sigill.intra.peff.net>
	<535f5b6a41ff6_45e485b3087b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 01:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfHMq-0000u4-4u
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 01:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbaD2XXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 19:23:12 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:61144 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaD2XXL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 19:23:11 -0400
Received: by mail-vc0-f177.google.com with SMTP id if11so1226879vcb.36
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ffs/ZqhEY1bnAp+jezsXjZHKuuvx7vdn+BTGY8MzkgA=;
        b=I8njRb7L+3QXNMVH6tfcss4DozM1nZu1+hPLVBSj0iLrntYjAEbQ7EfTI2BkRpfW36
         9M/bUwhsruYynxGnTI25XGuNhULqxr8J2gA+U4doRqfw8FrWPwuJ3whA9dyiR6TuJ9sx
         hoMwPjxYtjlPHeeoMQ4CulryPDMGH/XEmj8PZW7Q/hNjK1WeCxDTAd5JHewfDHPPdO8o
         F9hCMyKEvS4GcUr5vtBWuekWb/XiKaE/+Tk4AoKttgjppaTXMx/F+z1LyvdzkymzC2a9
         Bo/EPy7Xq6h3+DHpFieENyCSDzk/5B33ODvT/rdHOIAzMoxG9XxTBUFnlcbxhSdWab/L
         xEjA==
X-Received: by 10.221.27.8 with SMTP id ro8mr583653vcb.30.1398813790863; Tue,
 29 Apr 2014 16:23:10 -0700 (PDT)
Received: by 10.220.177.198 with HTTP; Tue, 29 Apr 2014 16:23:10 -0700 (PDT)
In-Reply-To: <535f5b6a41ff6_45e485b3087b@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247665>

Thanks to all.
With interpret-trailers has been easy to make a simple script, also it
checks if the Hash passed is a valid Object.
I haven't found a simple way to mantain the blank line above the
output of interpet-trailers (not even through cleanup).
Follows the script, maybe could be usefull for somebody:

#!/bin/sh
for i in $*
do
    git show $i &> /dev/null
    if [ $? = 0 ]
    then
        trailers+=" see-also=$i"
    fi
done

msg=$(cat /dev/null | ../git-interpret-trailers $trailers)

git commit -m "$msg" -e
