X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 14:11:19 +0000
Message-ID: <200612011411.20113.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200612011212.35656.andyparkins@gmail.com> <20061201122854.GR18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 14:11:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ezeP0VamSbJ6PEbLCrhk9VsSsYno1wSPxJYSMPypMcvZl5KXZ55V5Pmuj1XWAPIIBZ+IS8jRfZwu2GstVcjESNtswFTRM7/8ugaAa211jbKiV/FqrhYn5f5OUrU50hbnUehelO2YOmWdfa7Rqtnorhd5zoog7fNqMKrCamfuy4I=
User-Agent: KMail/1.9.5
In-Reply-To: <20061201122854.GR18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32927>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq96w-0006FK-CF for gcvg-git@gmane.org; Fri, 01 Dec
 2006 15:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758520AbWLAOL0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 09:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758884AbWLAOL0
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 09:11:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:31333 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758067AbWLAOLZ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 09:11:25 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2431617uga for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 06:11:24 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr7292697ugg.1164982283756; Fri, 01
 Dec 2006 06:11:23 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id e1sm25539037ugf.2006.12.01.06.11.22; Fri, 01 Dec 2006 06:11:23 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 2006 December 01 12:28, Martin Waitz wrote:

> > It seems wrong because it's making commits in the supermodule that aren't
> > commits to do with that project.
>
> Of course they are part of your project, just like all the tree and blob
> objects, too.

I wouldn't go as far as that; just because I use libxcb doesn't mean I want 
it's history merged with mine.  However, I think my worries are unfounded, 
your comment about being able to independently clone the libxcb tree helped 
me there.  If I've understood; while the objects themselves are stored in the 
supermodule ODB, they are still independent.  In fact, they're only in the 
supermodule tree because it's most convenient to keep them there; it sounds 
like it's very easy to strip them out again.

> It is the commit of the submodule, so its parents point to the submodule
> history.

Again, if I'm understanding, it's a bit like when you have an additional root 
in a normal git repository, for example:
 
 * -- * -- * -- * (project1)
       \
        * -- * -- * (project1/stable)
             
   * -- * -- * -- * (project2)

Then to make project2 a submodule of project1, one of the project1 trees 
simply refers to a commit in project2.

I think my original idea for how this works was correct with one minor flaw, 
and from that flaw all the other concerns flowed.  I imagined that there were 
two object databases - one for the supermodule and one for the submodule.  
The fault was that there aren't two ODBs there are two roots.  Which of 
course is a far easier way to blend to repositories.  Apart from that, I 
think I'm entirely in sync, and it was merely my wanting to put each of these 
roots in their own repository that caused all the confusion.




Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
