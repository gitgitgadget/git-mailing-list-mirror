From: Jehan Bing <jehan@orb.com>
Subject: Re: [PATCH v2] Add a setting to require a filter to be successful
Date: Fri, 17 Feb 2012 16:43:41 -0800
Message-ID: <4F3EF43D.2040102@orb.com>
References: <7vobsywck1.fsf@alter.siamese.dyndns.org> <4f3daaf7.e302440a.02ba.fffff463@mx.google.com> <4F3DFCD0.6070002@viscovery.net> <7vd39dqa1i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 18 01:44:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyYPP-0000yP-IX
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 01:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab2BRAno (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 19:43:44 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38911 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2BRAno (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 19:43:44 -0500
Received: by pbcun15 with SMTP id un15so4268710pbc.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 16:43:43 -0800 (PST)
Received-SPF: pass (google.com: domain of jehan@orb.com designates 10.68.138.194 as permitted sender) client-ip=10.68.138.194;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jehan@orb.com designates 10.68.138.194 as permitted sender) smtp.mail=jehan@orb.com
Received: from mr.google.com ([10.68.138.194])
        by 10.68.138.194 with SMTP id qs2mr35894509pbb.53.1329525823681 (num_hops = 1);
        Fri, 17 Feb 2012 16:43:43 -0800 (PST)
Received: by 10.68.138.194 with SMTP id qs2mr28945654pbb.53.1329525823644;
        Fri, 17 Feb 2012 16:43:43 -0800 (PST)
Received: from [192.168.13.5] (173-167-111-189-sfba.hfc.comcastbusiness.net. [173.167.111.189])
        by mx.google.com with ESMTPS id x6sm6453484pbp.31.2012.02.17.16.43.42
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 16:43:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vd39dqa1i.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQm/La61y1VBUPxSr8ZwDRrbT7nk4AmUN0cK63vOt4/4D2hjY+CsXfvsQCFEC0XGB2aUcxwj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190989>

On 2012-02-17 16:07, Junio C Hamano wrote:
> A few test in t0021 use 'false' as the filter, which can exit without
> reading any byte from us, before we start writing and causes us to die
> with SIGPIPE, leading to intermittent test failure.  I think treating this
> as a failure of running the filter (the end user's filter should read what
> is fed in full, produce its output and write the result back to us) is the
> right thing to do, and this patch needs more work to handle such a
> situation better, probably by using sigchain_push(SIGPIPE) or something.

If I understand what you're saying, current version of git already have 
the problem: if a filter fails without reading anything, git will die 
instead of using the unfiltered content. My patch has only made the 
issue apparent by testing with a failing filter.
Am I understanding correctly?
