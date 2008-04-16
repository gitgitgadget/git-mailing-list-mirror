From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Thu, 17 Apr 2008 01:17:23 +0400
Message-ID: <20080416211723.GI3133@dpotapov.dyndns.org>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com> <20080416200107.GG3133@dpotapov.dyndns.org> <46a038f90804161356o7518ec72j3bfb4e9fe4e48852@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nigel Magnay <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:26:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmF81-0000AF-3s
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 23:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYDPVYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 17:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYDPVYc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 17:24:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:3937 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbYDPVYb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 17:24:31 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2986058fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=SIhaSdoRfIomy8YoFHCyLjQWNVQAx3SWBBoDxgLxDqE=;
        b=P7rpG4VG6Al03W7LFTCYa5OhuDXdQlbfzYR148foCDzOXpawlcpn4N5jf8AGfBwY7TfN0BJjG3bDCY1FQcNVKjmHIZgmsksdB+Q7ad+jfSVOAzV/C+qntFj9Ep1Zv7Nun2MPI1Sx/yBiqfO9NZKl33ocvgMwgpZHA238EwsPCeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PzO7WcfrpyYQKDZ+M0MMXTGK7Q9PHE03OXn8lQf+lvYNbZu7xJak7weaUAOsyxYADZpAYYTMI2jvTALu1xI/VVxtT1t+JRNfq/jKVqehzKnJEdLiK3T28Ys9rWxLM+54QdwZivoMiOHJ2cxnGTMWQPMqaezknyHTZ+XCsWUJs+0=
Received: by 10.82.127.15 with SMTP id z15mr808039buc.14.1208380647777;
        Wed, 16 Apr 2008 14:17:27 -0700 (PDT)
Received: from localhost ( [85.141.188.158])
        by mx.google.com with ESMTPS id k9sm2303982nfh.35.2008.04.16.14.17.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 14:17:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <46a038f90804161356o7518ec72j3bfb4e9fe4e48852@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79755>

On Wed, Apr 16, 2008 at 03:56:18PM -0500, Martin Langhoff wrote:
> On Wed, Apr 16, 2008 at 3:01 PM, Dmitry Potapov <dpotapov@gmail.com> wrote:
> >  core.autocrlf=false is a bad choice for Windows.
> ...
> >  If you do not want problems, you should use core.autocrlf=true
> >  on Windows.
> 
> If you are making the above statements in generally about git, I
> disagree.

I stand corrected. It should be either core.autocrlf=true is you
like DOS ending or core.autocrlf=input if you prefer unix-newlines.
In both cases, your Git repository will have only LF, which is the
Right Thing. The only argument for core.autocrlf=false was that
automatic heuristic may incorrectly detect some binary as text and
then your tile will be corrupted. So, core.safecrlf option was
introduced to warn a user if a irreversable change happens. In fact,
there are two possibilities of irreversable changes -- mixed line-ending
in text file, in this normalization is desirable, so this warning can be
ignored, or (very unlikely) that Git incorrectly detected your binary
file as text. Then you need to use attributes to tell Git that this file
is binary.

I have not used git-svn on Windows for some time now, because now I have
a mirror running on Linux, so I clone directly from it.

Dmitry
