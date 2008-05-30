From: Roel <roel.kluin@gmail.com>
Subject: Re: whomto.pl -- finding out whom to send patches to
Date: Fri, 30 May 2008 11:29:50 +0200
Message-ID: <483FC90E.3020404@gmail.com>
References: <20080529210018.GA5508@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Sverre Rabbelier <alturin@gmail.com>,
	Joe Perches <joe@perches.com>, git@vger.kernel.org
To: Vegard Nossum <vegard.nossum@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 11:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K20wb-0003cP-Nq
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 11:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYE3J3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752408AbYE3J3t
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:29:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:19574 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbYE3J3s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:29:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1686201nfc.21
        for <git@vger.kernel.org>; Fri, 30 May 2008 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=1unyXaByDxejaL2M5Pz/hmJOoNzrcyjibbotuLGrlz8=;
        b=MRKYAdcGUQd9bSi/mfZ/0jO48hFvempSCNu9laDQlTE2F8uKXG7Tw+wrJp1L9noLXQjpvFl0uC6AZT3A7j/DSNIGI38d29XC8BfkWgCZ4gQ1VCfBOTA6wnXWcWP4uiJ4C74UK7fS5M/i7y7fAn04itqCsub+ZztS1EMHshq19/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OzWW0nctZc18dLBbj5rkQqfeocx3koinv/ElDLc3cBk5CZWlcnZ42vKGLmU1kVWzOoTI6x8H9B+zA1DUJypchGZbw4bjLRB2dB4HCu7/lupbU3x/80mrT1rRctTFU4IJqDqQQpeQci9+uTfGA/AO/aLYB/xBuFZ1DkQOEo/4dGo=
Received: by 10.210.47.1 with SMTP id u1mr3802336ebu.133.1212139786235;
        Fri, 30 May 2008 02:29:46 -0700 (PDT)
Received: from ?192.168.1.113? ( [213.46.133.62])
        by mx.google.com with ESMTPS id k5sm14777858nfh.39.2008.05.30.02.29.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 02:29:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080529210018.GA5508@damson.getinternet.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83279>

Vegard Nossum schreef:
> Hi,
>
> I've written this perl script that takes a patch as input and prints the
> authors/committers of the affected lines, using git-blame as the back end.
>
> (The purpose of this is of course to find out whom to send patches to.)
>
> There are some caveats:
>
> - If I've understood correctly, git-blame incremental output doesn't split
>   commits when a newer one is found, so we currently possibly take into
>   account more than just the last patch to touch a line. This might not be
>   a disadvantage, however...
>
> - The patch must apply to the current working tree. I suppose there is
>   some way to use the index information in the patch to determine what to
>   run git-blame against, but this is currently beyond my git knowledge.
>
> - It's a bit slow, particularly for large files. But doing the same thing
>   by hand would be slower, so I suppose it's an overall improvement.
>
> Running this on a random -mm patch, for example
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.26-rc2/2.6.26-rc2-mm1/broken-out/acpi-fix-fadt-parsing.patch
> gives the following output:
>
>   $ perl whomto2.pl acpi-fix-fadt-parsing.patch
>   Running git-blame on drivers/acpi/tables/tbfadt.c...
>
>   To: (Committers)
>       48 Len Brown <len.brown@intel.com>
>   Cc: (Authors)
>       44 Bob Moore <robert.moore@intel.com>
>        2 Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
>        2 Len Brown <len.brown@intel.com>
>
> Maybe this tool can be useful? :-)
>
> (Improvements are of course also welcome.)
>
>
> Vegard

Based on Linus' script to get the email address of a maintainer, I wrote 
this bash script to get
an indication of relevant lists. Maybe you can make use of the part that 
parses the
MAINTAINERS file for relevant lists?

---

git log --since="1 year ago"  "$@" | sed -n "s/^    .[-a-z]*by: \(.*\) <.*$/\1/p" |
sort | uniq | sort -n -r | while read -r name; do
        sed -n "/^P:[ \t]*.*$name/,/^$/{
                s/^L:[ \t]*\(.*\)$/\1/p
        }" ./MAINTAINERS
done | sort | uniq -c | sort -n -r | while read -r nr list; do
        tot=`grep -c "^L:\W*.*$list.*" ./MAINTAINERS`
        echo "`expr $nr / \( $tot + 1 \)` $nr $tot $list"
done | sort -r | cut -d " " -f2- | while read -r nr tot list; do
        echo -e "$nr/$tot Acks were commited by maintainers of list $list"
done
