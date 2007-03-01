From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: defaults for where to merge from
Date: Thu, 1 Mar 2007 09:59:24 +0100
Message-ID: <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
References: <es450f$d58$1@sea.gmane.org> <45E5DE8A.2080101@lu.unisi.ch>
	 <81b0412b0702281607l6f9b1cadg9f3a84b06b9acd7d@mail.gmail.com>
	 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	 <45E68897.8000607@lu.unisi.ch>
	 <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	 <45E68EDE.2090405@lu.unisi.ch>
	 <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	 <45E69297.8070001@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Julian Phillips" <julian@quantumfyre.co.uk>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Thu Mar 01 09:59:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMh8M-0005Qm-1E
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 09:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933156AbXCAI72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 03:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933159AbXCAI71
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 03:59:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933156AbXCAI70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 03:59:26 -0500
Received: by ug-out-1314.google.com with SMTP id 44so319346uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 00:59:24 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y334NbnR+UU+DsGUrqjkJzy5aA0ja+tusLPhpsPl+a8kO/ow2p6q99Y2DKDoG/YUdtSQuB2Z3ksdZ+oouGeRbS3k6ke6JUPVT06t2FyBXTUfZ4YhNil52Z0dISlXlVzYZxMbKmEcUQnPd9dRTowcJM2KGooVV/NU+hWcr111StA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O48h7C/wqKaEqnbNXiaQuMT131+YRDyDOOht4A3U5A+Iaf0uJKI0PtmvZTQRD7ZiHZgd6hjAcTGwXSibNjAvDUvQX+pbC0ENKHKf4MLz0hnMncTiWQKDjOp4UZ/2D0eCXKSVwuqjifXEF8FN/UQNHME0JPGDtPlWE4u1AlCuub4=
Received: by 10.78.39.16 with SMTP id m16mr136827hum.1172739564741;
        Thu, 01 Mar 2007 00:59:24 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 00:59:24 -0800 (PST)
In-Reply-To: <45E69297.8070001@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41055>

On 3/1/07, Paolo Bonzini <paolo.bonzini@gmail.com> wrote:
> > How do I remove the garbage you added for TRACKING?!
>
> I see two possibilities:
>
> 1) I can add a "git-config --remove-section" option.  So you can do
> "git-pull" to merge onto your branches, and then remove the tracking
> section.

This is irrelevant in this particular context. It is just wrong here:
are you sure you _CAN_ know what it is you are removing?
Git config syntax is loosely defined, and branch or remote sections
can have important user information. Which he does not immediately
see typing git config --remove-section branch.abc _JUST_ to get
rid of the configuration he did not want in first place!

> 2) I can add a "git-branch --stop-tracking" option, which just removes
> the section.

This is independent and _probably_ not really needed. It is also
probably more complex than you think. Consider:

[remote "abc"]
  url = ...
  fetch = refs/heads/*:refs/remotes/abc/*
  fetch = refs/heads/test:refs/heads/abc-test

> 3) Same as 2), plus I add a "git-branch --no-track" option, which does
> not add the section in the first place.  But I do believe that there is
> no reason why this cannot be the default.

This is just what I asked for except for the first part.
And I see no reason for it to _BE_ the default.
Actually, how about making the default configurable _AND_ have
the --no-track option (for scripting)?
