From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Tue, 11 Dec 2007 02:26:33 +0100
Message-ID: <200712110226.35343.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com> <200712102355.39084.jnareb@gmail.com> <7vejdujazu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 02:27:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ttx-0005CF-HX
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 02:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbXLKB0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 20:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbXLKB0w
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 20:26:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:51062 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbXLKB0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 20:26:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1147413nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 17:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=LtIhot2zF/3ACDDBBDS8a8iLEhjYBwkz9cqeH0a7RIw=;
        b=bMsQ+wUUoh46Lx2jasJ8Akvl6DwBysYwgS0MXOBefNXB6C8Nt67GLwCr5v+wFIOY67W7IaZXHNT6JAqZBI90VQr6g5YKwYGL83xzbULS0eV+f80YWbPuU1UbZECtB0iOYlnPfY/5+XurQKq29EiKIvMctV8ORJKCsgtq6BS30RY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KenWusoa+zV0O3k/nmciMSbSivSjzqKv3rsjKMkzM/t3ald67K3t6ZrK6jevEZAjpRLhupOwZRc2JTrPAT/+iQpkxmt+/67ySqcsMP9d6f9urNcbkBUzN/qUSrwuqB6D2sRfIxyiyNRDtepastRPOw4p3kZ5EGChxWmJdhgx71k=
Received: by 10.82.148.7 with SMTP id v7mr10615606bud.1197336409312;
        Mon, 10 Dec 2007 17:26:49 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id j2sm9802707mue.2007.12.10.17.26.46
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 17:26:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vejdujazu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67774>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Previous version of this patch (from 7 May 2007) used instead of current
> > only "to_name" format similar to git-diff-tree raw format for renames:
> >
> >   added deleted TAB path for "src" TAB path for "dst" LF
> >     
> > The problem was when -z option was used: how to separate end of record
> > from end of from_name and start of to_name. For git-diff we have status
> > to distinguish those; no such thing for numstat output. Previous version
> > of patch used (or was to use actually, because of error in the code)
> >
> >   added deleted TAB path for "src" NUL NUL path for "dst" NUL
> >
> > when -z option was used.
> 
> I think the cleanest at this point is to have --numstat-enhanced that
> shows
> 
> 	<added> <deleted> <status> <path1>
> 	<added> <deleted> <status> <path1> <path2>
> 
> Anything else would be a regression.

That is the plan[*1*]. Nevertheless always using destination filename for
"ordinary" numstat is a step in good direction. I don't think that would
break _any_ scripts (as previous version was not good to be parsed by
a machine); I think it is even more probable that old version _broke_
scripts if -M / -C was provided.

[*1*] When I (or somebody else) find time for that.

-- 
Jakub Narebski
Poland
