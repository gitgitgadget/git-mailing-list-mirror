From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Trying to use AUTHOR_DATE
Date: Fri, 29 Apr 2005 16:35:58 -0700
Message-ID: <4272C4DE.8090806@zytor.com>
References: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 01:30:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRewN-0008Mu-PJ
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 01:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbVD2XgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 19:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbVD2XgM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 19:36:12 -0400
Received: from terminus.zytor.com ([209.128.68.124]:50366 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263068AbVD2XgJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 19:36:09 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j3TNa5xY017198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 Apr 2005 16:36:06 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: tony.luck@intel.com
In-Reply-To: <200504292314.j3TNE1P23342@unix-os.sc.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL 
	autolearn=ham version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

tony.luck@intel.com wrote:
> I'm using cogito-0.8 (036bb73c6dd1871101ca19557298684ab9832f81) and trying
> to set AUTHOR_DATE based on the "Date:" from the patch e-mail.  But, it
> appears that commit-tree is munging this based on my timezone.
> 
> Here's what I set in the environment before invoking cg-commit:
> 
>   AUTHOR_DATE="29 Apr 2005 02:02:00 -0700"
> 
> and here's what cg-log reports on the "author" line:
> 
>   Fri, 29 Apr 2005 10:02:00 -0700
> 
> My /etc/localtime is set for "US/Pacific" ... which is where the 8 hours
> comes from (I think).  If I set "TZ=GMT0BST" as well in the environment of
> cg-commit to override /etc/localtime, then the author time comes out ok,
> but then the "committer" time gets messed up.
> 

There was a time-parsing bug somewhere, where mktime() got invoked on a 
UTC date.  I proposed changing it to curl_gettime() instead.

	-hpa
