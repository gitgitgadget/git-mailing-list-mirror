X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 12:00:41 +0000
Message-ID: <200612141200.42875.andyparkins@gmail.com>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612141123.02346.andyparkins@gmail.com> <Pine.LNX.4.63.0612141224330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 12:00:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fPcBT8QxwSdYbjh2tdwUO3WWrJ55wHfEpGAlm74MeCJKEuMb42sSMnrV12MlHDrdsBw9uEhEf6npz0PsNOHNHPXNnxBzjEUA36uCmaiCaxjHa1RaK4l3LW82IyYBu/BxtzjpD9AMlpo3584mAGCWOwEXU000V9I+Vwwd4py9MgE=
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.63.0612141224330.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34326>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GupGh-000102-76 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 13:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932679AbWLNMAw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 07:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWLNMAw
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 07:00:52 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:7010 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932679AbWLNMAv (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 07:00:51 -0500
Received: by ug-out-1314.google.com with SMTP id 44so474727uga for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 04:00:50 -0800 (PST)
Received: by 10.66.244.10 with SMTP id r10mr1273876ugh.1166097650104; Thu, 14
 Dec 2006 04:00:50 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id q1sm2386915uge.2006.12.14.04.00.49; Thu, 14 Dec 2006 04:00:49 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Thursday 2006 December 14 11:27, Johannes Schindelin wrote:

> And now you know one of the reasons we have no true progress bar.
>
> Another reason is that it would be relatively expensive to calculate,
> since the total _size_ is not known beforehand (remember, the pack is
> calculated on the fly).

Hmmm; just thinking out loud now... I used to calculate ETA's for simulations 
I ran that had similar problems - i.e. you don't know how long it takes until 
its done (it was with genetic programming function trees, and of course you 
don't know what operations will be in the next generations tree, so you can't 
estimate a time).  I just showed "something" by doing a standard: how long 
did n/N take therefore N will take... then I plotted the error in the ETA 
after the simulation completed.  Interestingly it was always a -exp(-x) 
shape.  In other words it got more accurate towards the end (of course); 
which is exactly the sort of accuracy you would want.  At the beginning you 
just want a broad "this will take a few hours" measure.  Towards the end, you 
want to know "there is 1m50s remaining".

I wonder if the number of objects is a reasonable measure of progress.  Let's 
say we're transferring 100,000 objects.  Let's also say that the average size 
of objects is 100 bytes.  Let's finally say that the object sizes are evenly 
distributed throughout the 100,000 objects.  This would mean that the first 
1,000 objects are just as representative as the last 1,000 objects; or any 
other randomly chosen 1,000 objects.  In which case, the size of the first 
thousand objects would be approximately one hundredth the size of the total 
transfer.  Volia: an estimate of the total size of the transfer.

Obviously this estimate would be continuously updated, and would become more 
accurate as more objects are transferred.  The data rate would of course be 
based on only the previous X objects rather than the total transferred to 
take account of changing server conditions.  From these ETA could be 
estimated.

Obviously the ETA is unstable, but it's only for giving users an idea of how 
long is left; not for strict accounting.




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
