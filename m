From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/2] Look for a commit's parents in the standard way.
Date: Sun, 20 Aug 2006 11:43:22 +0100
Message-ID: <b0943d9e0608200343t517ec29dw2b6b49d9d69dbad5@mail.gmail.com>
References: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
	 <20060814165544.20350.41590.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 12:43:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEkmI-0003WW-Dz
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 12:43:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHTKnX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Aug 2006 06:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWHTKnX
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Aug 2006 06:43:23 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:3240 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750729AbWHTKnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Aug 2006 06:43:22 -0400
Received: by py-out-1112.google.com with SMTP id n25so1949218pyg
        for <git@vger.kernel.org>; Sun, 20 Aug 2006 03:43:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=blI0JYm+VTs07OsD27ZOPtOXF1a03cDtQPdzBizghfb67sM7kswux7CydF720YYNbwCnlHoU0FbzT/SCiO9TXoRxGN4RM4ShvgxaKAVoqMqP99ThrKnKvo9stLVGmIJpeo/YIitGJNRhch1c+AHnJogdocSsXAMmec7Ljn0Vm3c=
Received: by 10.35.114.16 with SMTP id r16mr10498465pym;
        Sun, 20 Aug 2006 03:43:22 -0700 (PDT)
Received: by 10.35.37.16 with HTTP; Sun, 20 Aug 2006 03:43:22 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060814165544.20350.41590.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25747>

On 14/08/06, Yann Dirson <ydirson@altern.org> wrote:
> This has the direct effect of taking info/grafts into account, since
> ignoring it only causes confusion.

I don't know the difference but is there any between parsing the
commit file and using git-rev-list --parents?

> +        self.__parents = split(_output_lines('git-rev-list --parents --max-count=1 %s' % id_hash)[0])[1:]

Instead of using the split() method, you could call
_output_lines('git-rev-list --parents --max-count=1 %s' %
id_hash)[0].split()[1:]. Maybe that's why they might deprecate the
global split method.

Setting self.__parents by calling get-rev-list would have a
performance impact on the push operation. I think we could remove the
__parents variable and only call git-rev-parse in get_parents() or
get_parent().

-- 
Catalin
