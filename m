From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add a test-case for git-apply trying to add an ending line
Date: Wed, 24 May 2006 14:32:01 +0100
Message-ID: <b0943d9e0605240632t4189f8d0yfdbab111c83f0426@mail.gmail.com>
References: <20060523214836.22628.2179.stgit@localhost.localdomain>
	 <7vd5e4z2je.fsf@assigned-by-dhcp.cox.net>
	 <7vhd3gxm73.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605231905470.5623@g5.osdl.org>
	 <7v8xosqaqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 15:32:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FitTA-0008Ig-Qu
	for gcvg-git@gmane.org; Wed, 24 May 2006 15:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbWEXNcD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 09:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbWEXNcD
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 09:32:03 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:59542 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932739AbWEXNcC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 May 2006 09:32:02 -0400
Received: by wx-out-0102.google.com with SMTP id s6so1203018wxc
        for <git@vger.kernel.org>; Wed, 24 May 2006 06:32:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qdqMaoVTOtBqkGQA47hhmO/B9kUZfcUhxo0upSq5GJIXPRFb8RIuxiabTCg9DSsGxHRrupHt61QsdANOSb2Sealo75OYjcn6ylwN4P+ksp3QUniQpyf4GXofaUVHVQq1LA6ZtIyHL1/0qmqDsuc3PtG8ciw1CEL1lpK8volCQUo=
Received: by 10.70.65.14 with SMTP id n14mr7727766wxa;
        Wed, 24 May 2006 06:32:01 -0700 (PDT)
Received: by 10.70.31.2 with HTTP; Wed, 24 May 2006 06:32:01 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xosqaqm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20684>

On 24/05/06, Junio C Hamano <junkio@cox.net> wrote:
> I'd admit that trying to apply a patch without context like the
> above example _is_ insane, and I realize that I am making this
> problem unsolvable by refusing the heuristics to consider that
> the patch is anchored at the end when we do not see any trailing
> context.  But somehow it feels wrong...

The reason I sent you this test is that GNU patch fails to apply the
diff but git-apply succeeds (and I thought git-apply is more
restrictive).

When there are context lines either before or after the "+" line, it
should be OK to assume that the diff has context and therefore the EOF
should be considered.

If there are no context lines at all, the diff is either without
context or it is meant to patch an empty file. The latter is safer and
probably valid for most of the cases but if you have a patch without
context, you could explicitely pass the -C0 option to git-apply.

-- 
Catalin
