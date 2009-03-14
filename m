From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: Re: [PATCH] Remove unused assignments
Date: Sat, 14 Mar 2009 21:57:13 +0100
Message-ID: <49BC1A29.60503@googlemail.com>
References: <49BA56D5.5050807@googlemail.com> <7v7i2rc0zp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 21:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiawS-0002cf-VE
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 21:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617AbZCNU5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 16:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754593AbZCNU5T
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 16:57:19 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:54931 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZCNU5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 16:57:18 -0400
Received: by fxm24 with SMTP id 24so3032880fxm.37
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 13:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=X/Bpod2vDW0sYziuqq+NHyrcpnTHa9bFux+FM5D+WMQ=;
        b=cx5CgnLhM4rAdQCxLfLXwpi/XobNf3CAe7XtrLUiOe8s2kIRgM2W+qx9H/s5hIl/ZW
         e/MlMycJfG/7HttZm5voolJGXfj1eiTn9EHJAihsgB/fh7MwCi3U8jvKppxtbFCZMbMG
         Q+33IEyHef9eEWBi0wonwd7QFj+B02stJljBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pgSmSSinyLjD3u2V2CGsQ8bpDYeCM5cLFdmwtnTvDhayw518+gMC3GWKaCowWZePVk
         6V6Mwpug3lBSFVkgwJtBW8BVovGN8qLQ9sbpsN3/52QyZFSxrChoovihlL8FNcadHzmt
         Gr4NUnu4I/apVCWA3OKuQpvqTKjInOwRU/ZPw=
Received: by 10.103.198.20 with SMTP id a20mr1349514muq.63.1237064235205;
        Sat, 14 Mar 2009 13:57:15 -0700 (PDT)
Received: from golden.local (p5B01D5C6.dip.t-dialin.net [91.1.213.198])
        by mx.google.com with ESMTPS id s11sm6670195mue.47.2009.03.14.13.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Mar 2009 13:57:14 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <7v7i2rc0zp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113266>

Junio C Hamano wrote:
> 
> Thanks.  I eyeballed all of them and they look safe, but this patch made
> me wonder...
> 
> Did you use some dataflow analysis tool to spot these?
> 
> It will never scale if a human has to sanity check output from a
> mechanical process like this patch, especially when the human is already a
> chokepoint of the whole process (i.e. the maintainer).

Yep, they were found with a little help of the clang static analyzer

http://clang.llvm.org/StaticAnalysis.html

It is in early stages of development so it may report false positives and
it chokes on some files. Here is the latest output I have, with my patch
applied:

http://doktorz.mooltied.de/stuff/scan-build-2009-03-13-2/

I've looked briefly at the "Logic Errors" and they all seem to be false
positives. I did not have enough time to look into all the remaining "Dead
Stores" though.

-- Benjamin
