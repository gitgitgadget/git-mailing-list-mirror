From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-cvsserver: handle change type T
Date: Sun, 16 Mar 2008 23:00:48 +0100
Message-ID: <47DD9890.3060005@gnu.org>
References: <E1Jay7s-0000dO-IX@fencepost.gnu.org> <7v63vmicvf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, beuc@gnu.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:01:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb0v5-0003PN-UW
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYCPWAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbYCPWAx
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:00:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:54248 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYCPWAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:00:52 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1453541fgb.17
        for <git@vger.kernel.org>; Sun, 16 Mar 2008 15:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=gPhn87vtcXIVpCrHTX1v7qmi46RNshN3RnI6uq3GtQg=;
        b=W721tRmA59e+PJy/T/d+qJzhnCKur6lGMMyD1LwC+8d65yV5/Dr5xLH+npU/qdQgF353ZTotscXXyChqk6mI80UL158JCPTB1CL1dg+o+GgQRrhFxJEb5fT7orVM8+lFV2W+a+RnF70wDOLju+QaKKy7M5izYWqisvwtmzKa5q8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=JiZweLzyRCDZaETg9P1NtStuur4wABocyXfT713+8jrApByqQlCtp5jcoERGHJSAr4sUgBRr6nFHRXFk211YfrJelgVdbhwsqig7jwuPRaEeU7yYzmuhpcoZ5fOJF491rSRb5UQfIG6/FFVlkfLN2g4NY5wVbscw/MxSrTeqP1E=
Received: by 10.86.97.7 with SMTP id u7mr4709113fgb.65.1205704850530;
        Sun, 16 Mar 2008 15:00:50 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e11sm18234342fga.5.2008.03.16.15.00.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Mar 2008 15:00:49 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <7v63vmicvf.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77391>

Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>> git-cvsserver does not support changes of type T (file type change,
>> e.g. symlink->real file).  This patch treats them the same as changes
>> of type M.
> 
> Hmm.
> 
> Do cvs clients even know how to handle symlinks, or will this patch just
> start sending the readlink(2) result as if it is just a regular file
> contents?

It was before too.  The problem arises if one found the problem, deleted 
the symlink, added the regular file -- and now cvsserver stops working 
at all. :-(

Paolo
