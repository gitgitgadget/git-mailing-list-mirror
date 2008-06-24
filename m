From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 13:22:12 +0200
Message-ID: <200806241322.14224.jnareb@gmail.com>
References: <m3mylbl0xb.fsf@localhost.localdomain> <willow-jeske-01l5PFjPFEDjCfzf-01l5kQf4FEDjCXUa> <willow-jeske-01l5kwGPFEDjCc7b>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:19:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB6Yu-0007sP-7H
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 13:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbYFXLSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 07:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYFXLSv
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 07:18:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15877 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYFXLSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 07:18:50 -0400
Received: by ug-out-1314.google.com with SMTP id h2so700097ugf.16
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 04:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Jf9Kf1CHmpiQwu7ej96HuSQhHuMO3v/QS5Lf827hbJM=;
        b=rgWensmdi0hTNxieJXRub8g3iqRY6HGWj+yHEISkz1HBCt2jBKKtnPN14ccNJEi3+n
         +fU9jc3WqpWXcvhPCXxwpCmVmf/pVriEZfBgn8V1Yi0+mQWjJiXxMpwnSlxigNoFonW0
         r0sdmWX4Am68aXS2j7p+/J+GPw4PLBwGQevGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=e++/dIO6zgeS7z8xtXtpM/7ZH975JQxtGYv/vVOIrkFUY6jQ2/LrCCGd0wCxteFva+
         p8usMp65UvbVK2u8nj9As/DqJsAXZ/4dCZG8Q6C5YyYJ4NAvjx9bzo0OS6SLAmZ8+xqv
         fVBM3NFv4FX75FgMvFA9DShVKmqK7oehzgvy4=
Received: by 10.67.115.14 with SMTP id s14mr3185405ugm.59.1214306328635;
        Tue, 24 Jun 2008 04:18:48 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.195.249])
        by mx.google.com with ESMTPS id q1sm33003464uge.37.2008.06.24.04.18.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 04:18:47 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <willow-jeske-01l5kwGPFEDjCc7b>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86034>

David Jeske wrote:

> To re-ask the same question I asked in my last post, using your ascii
> pictures...
> 
> 
> Let's assume we're here..
> 
> .<---.<---.<---A<---X<---Y    <--- master
>  \
>   \--B<---C                   <--- customer_A_branch <=== HEAD
> 
> 
> And this person and everyone else moves their head pointers back
> to master without merging:

You could simply say: they stop working on 'customer_A_branch' branch
(moving HEAD poter is simply switching to / checking out / working on
different branch).
 
> .<---.<---.<---A<---X<---Y    <--- master              <=== HEAD
>  \
>   \--B<---C                   <--- customer_A_branch
> 
> 
> Now, five years down the road, our tree looks like:
> 
> 
> .<---.<---.<---A<---X<---Y<--.(3 years of changes).--ZZZ  <--- master  <=== HEAD
>  \
>   \--B<---C   <--- customer_A_branch
> 
> And someone does:
> 
> git-branch -f customer_A_branch ZZZ

If they are using '-f', i.e. force, they should know and be sure what
they are doing; it is not much different from 'rm -f *'.

If reflog for 'customer_A_branch' expired it would be hard to go back
to old 'customer_A_branch', and impossible after garbage collector
pruned history.

What you _should do_, if you want to preserve old 'customer_A_branch'
pointer is to *tag* it, e.g. something like 'Attic/customer_A_branch';
if you use annotated tags you can even state why do you want to keep
old work, and why old work wasn't merged into long-lived branch, and
why the work was abandoned.


-- 
Jakub Narebski
Poland
