From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 23:59:35 +0200
Message-ID: <484078C7.7020008@gmail.com>
References: <20080530095047.GD18781@machine.or.cz>	<1212179270-26170-1-git-send-email-LeWiemann@gmail.com>	<20080530210531.GH18781@machine.or.cz>	<7vd4n3iivt.fsf@gitster.siamese.dyndns.org> <86r6bjmpqc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:00:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Ce1-0006AV-Rz
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYE3V7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYE3V7Z
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:59:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:49555 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYE3V7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:59:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so202567fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=5M7Gsk7Q/Z5tO5GesD68XofBUpZzr+ZPKg6YmG64huI=;
        b=UmWFWGZu+iQzXPEsgjb56rVTVNHKsJv2o4WNcRuNqPrj+qs4Z39CRQsJk0WL7tHarwfEPIs49asdFb6Zn47ZDM/4crTKWR6H+rXK/uXrGHj2rx/s0HBkYQmGTDclagk/x44bUbvSSu3R7FOehmk/YzK8sS4BrA6040itxGbinhY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=bcZ/OBI4FqTD+PaLyFMJ9Sos7GehMcKn4rPSPBnlk1orMWYsYe7Rx5dA5SsqCFvg492D9fJ0F1UQCfOVw2ZlPMa5EMq/JMCxFCQxh5g4jzRSKL/lc70ogF9F3DGB0O3DsvDEw5iOgkkfj6iaNPJPfb6kroluELqSSxyh5g7YuIM=
Received: by 10.86.90.2 with SMTP id n2mr7239010fgb.51.1212184763159;
        Fri, 30 May 2008 14:59:23 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.213.54])
        by mx.google.com with ESMTPS id 3sm1278029fge.3.2008.05.30.14.59.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 14:59:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <86r6bjmpqc.fsf@blue.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83346>

Randal L. Schwartz wrote:
> [Move to eval/die.]  No leak there.

I'm not an experienced Perl hacker, but I intuitively liked the 
throw/catch method better than the eval/die method.

If I read 
http://www.nntp.perl.org/group/perl.perl5.porters/2006/03/msg110331.html 
correctly, this has been fixed in recent 5.8 versions, so it would 
really only affect 5.6.  But perhaps we don't care about 5.6. ;-) 
People who run into serious memory issues with 5.6 will have to upgrade, 
and the existing functionality that programs like git-send-email or 
git-svn rely on seems to work fine with the memory leaks, so using 
throw/catch further probably won't cause any regressions for them.

I'm honestly not too keen on sacrificing time (or code prettiness) on 
5.6 compatibility, so if there are no reasons besides the memory leak to 
move away from throw/catch, perhaps we can just keep using it?

-- Lea
