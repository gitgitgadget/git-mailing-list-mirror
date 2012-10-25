From: Matt Arsenault <arsenm2@gmail.com>
Subject: Re: [PATCH] Fix git p4 sync errors
Date: Wed, 24 Oct 2012 19:41:36 -0700
Message-ID: <F0F92B0A-D37F-40D4-A0DF-43EEDA2818B9@gmail.com>
References: <AC43C2B4-623F-4590-9F92-6CCA26645EFE@gmail.com> <7vwqyjfxwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 04:41:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRDOL-0003fa-L8
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 04:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933356Ab2JYCll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 22:41:41 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:60740 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933068Ab2JYClk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2012 22:41:40 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so543824dak.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 19:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=GvDgiF5LV9wxIeCglPP9OSMMtHPz2FM032wLusQF3L4=;
        b=v8ZntLE1BVFfAL2cRFmH3dpypq2AWHFA7JhmcuXzma1BIBLWyGPnewey1I2H6aH8jJ
         xPxEAq8FwhflSo3AyPkPMsu0KheFlR8oicwjD7EhnlHTg6H8b+mI8ZL5XXcmHpqDbNNt
         j/IqskowxOrX9pfZ1bbgObQlqBEKvBoi4humBR8ew3ORxr9kkuMTysmqs7CQKFxDKkD4
         PalhVugHlwXlKfgN+1Jr/ldULo0D0ofXsQdmnr7vn8e90nJB3L1FZxuGoAmWJNrz20tO
         e1dmxTOO4Wmg5GXToDUeJFtKK68UyNAv0MbZX+ikzwtLfdHLYKAwsi+8YL/zTRBXAC4Y
         ydyw==
Received: by 10.66.88.197 with SMTP id bi5mr48901225pab.58.1351132899813;
        Wed, 24 Oct 2012 19:41:39 -0700 (PDT)
Received: from [10.0.1.108] (c-24-6-132-221.hsd1.ca.comcast.net. [24.6.132.221])
        by mx.google.com with ESMTPS id c1sm10449455pav.23.2012.10.24.19.41.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 19:41:39 -0700 (PDT)
In-Reply-To: <7vwqyjfxwd.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1499)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208335>


On Oct 21, 2012, at 12:06 , Junio C Hamano <gitster@pobox.com> wrote:
> 
>> 
>> This solves errors in some cases when syncing renamed files.
> 
> Can you be a bit more descriptive?  What are "errors in some case"?
> 
It might just be when files are renamed. I ran into this after months of using it, and I'm skeptical that in that time no files were ever renamed. I'm not sure what was special about the file that was renamed. (There also might have been deleted files in the same commit, not sure if that matters)

> In short, what I am getting at are:
> 
> - What breaks by not passing "-s"?  What are the user visible
>   symptoms?

There's a key error on the line
line 2198:        epoch = details["time"]
The details object is an error different fields set (I don't remember what it is exactly, I'm not at work right now)

> 
> - Why is it a bug not to pass "-s"?  How does the bug happen?

I encountered this one time after using it for months. One day I couldn't git p4 rebase with the key error.  I searched for the error and found some version of git-p4 that fixed a similar error by adding the -s to describe. Adding the -s fixed the error and everything seemed to be working correctly.
