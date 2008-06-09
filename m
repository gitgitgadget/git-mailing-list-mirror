From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] cat-file --batch / --batch-check: do not exit if hashes
 are missing
Date: Mon, 09 Jun 2008 15:27:22 +0200
Message-ID: <484D2FBA.1010606@gmail.com>
References: <1212967717-5165-1-git-send-email-LeWiemann@gmail.com>	<alpine.DEB.1.00.0806090033030.1783@racer> <484C73DA.10804@gmail.com>	<alpine.DEB.1.00.0806090201090.1783@racer>	<484D033A.3020006@gmail.com> <m3lk1ex3s6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 15:29:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5hQ8-0000Ev-2P
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 15:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928AbYFIN13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 09:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbYFIN13
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 09:27:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:49214 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbYFIN12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 09:27:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1505569fgg.17
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=yAhVUYNRrPoYplhv2vgE8IgUDCY4A1cIDTgSp2vVi4o=;
        b=Kg8bk2mZ5BCxdp+DPMIyY60sO6aZ2PN93PTfctgP8vmHR+bPImmo5InAgCYySzBVIC
         j8HpU9T1VIsmRiMXurfzC/frLL37/qrs3uI3pKr5wjNz6QfWdD6EhbwnXgr80lHvv9Ce
         8wlfMH/DGoMPon+6qO1iPLr8G9taUAbMYaEa4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=QLSqHBugTu7Y9kSP8H4T9lcKbBhQmDvd4hHSWbA47v8Jl4tCQAl2BH0zDa4rALIGin
         wh4I3US2Pb9vp8TZza50mLyMgA4SZp+VwRtIbqGWr4QiAupEYYOQ3xhS25uSnLyXLQVn
         GSB97ItjDh+3vvTgLPTwA2RAnAYWZeKuE96LM=
Received: by 10.86.33.10 with SMTP id g10mr4297634fgg.15.1213018046861;
        Mon, 09 Jun 2008 06:27:26 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.232.240])
        by mx.google.com with ESMTPS id e11sm11227194fga.4.2008.06.09.06.27.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 06:27:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <m3lk1ex3s6.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84381>

Jakub Narebski wrote:
> I think the (usual) solution is to add --ignore-missing and
> --no-ignore-missing (or --noignore-missing), add configuration
> option 'catfile.ignoreMissing', make ignore-missing default and
> deprecate it with some transition time...

*shrugs*  I'm not convinced that anyone would ever *not* want to use 
--ignore-missing, since programs that use --batch(-check) presumably 
query for a large batch of objects and therefore define their own error 
handling anyway.  Also, it's not like you could accidentally ignore the 
"<object> missing" output in your code since you're parsing the output 
anyway.  So I'm not sure what the point of changing the current behavior 
is.  (Perhaps add a --exit-on-missing option?  Not that I or anyone else 
has ever asked for that feature.)

In any case, can please someone review my patch?  I think my patch 
should be independent of these things (since it's a bug fix), and I'd 
hate to see it not make it into the code just because some people don't 
seem to like cat-file's behavior. ;-)  (I need it for the Perl API, 
after all.)

-- Lea
