From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: fix issues with COMP_WORDBREAKS
Date: Sun, 15 Apr 2012 19:38:50 -0500
Message-ID: <20120416003850.GH5813@burratino>
References: <1334524654-13482-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 02:39:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJZyK-0006rL-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 02:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2DPAi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 20:38:57 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34969 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab2DPAi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 20:38:56 -0400
Received: by iagz16 with SMTP id z16so6713323iag.19
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LjJt//eMIWOwGQgHOl8F27C7kyORnUBKFFjuMvjKHLw=;
        b=v0ILNVrzQ2WwUKWEUSC/S++K74CiHbFeTvAKsqSYLE++UhGuK9giAh9UUhvsAlmRoa
         H6iFROlZ0Y2lJS6rAAdCoWH/ufFlBWKIV/+gROzg/ZhLn8GRYQWk+GL9RK5WGAqW442r
         h3rwJdTvwNC0SMqpJPk4jFyQ0ptmHeWoLl0hvTc7IFI75a2xgtzO+pzVd5tCXMUZpMYg
         H0y+iO2E31gJ612sR93A30+MBSNEzkl0vduOO0kgI6y02kQxhsxUwHMLeR02tDgBSS8O
         Q/iQ6YNnRVzLNyjiKrL69ajKAYSIdw02t0QtyvAYQE6gwGX8l3/x3mkWg+pCu/D3b1Cp
         KY0A==
Received: by 10.50.42.164 with SMTP id p4mr4001385igl.72.1334536736069;
        Sun, 15 Apr 2012 17:38:56 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d5sm20158717iga.15.2012.04.15.17.38.54
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 17:38:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1334524654-13482-1-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195595>

Felipe Contreras wrote:

> In fact if COMP_WORDBREAKS doesn't contain a colon the completion gets
> all messed up. For example:
>
>  git push origin master:<TAB>
>  git diff master:<TAB>
>
> The "master:" prefix would be added again, unnecessarily.

Thanks.  Yeah, that sounds broken.

Unfortunately the patch introduces a regression: if after loading the
completion script I set COMP_WORDBREAKS not to contain a colon, then
with the current completion script

	git show HEAD:Docu<TAB>

completes fine, but with the patched completion script it seems to
get confused and strips off the HEAD.

Ideas?
Jonathan
