From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: core.autocrlf considered half-assed
Date: Tue, 9 Mar 2010 13:11:01 +0300
Message-ID: <20100309101101.GJ31105@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.1003060018170.20986@pacific.mpi-cbg.de>
 <20100307092701.GC31105@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1003081225280.14277@intel-tinevez-2-302>
 <20100309072412.GF31105@dpotapov.dyndns.org>
 <alpine.DEB.1.00.1003091028440.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	torvalds@linux-foundation.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyXL-0001Do-JU
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754085Ab0CIKLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 05:11:10 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:38149 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892Ab0CIKLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 05:11:08 -0500
Received: by fxm5 with SMTP id 5so1003396fxm.29
        for <git@vger.kernel.org>; Tue, 09 Mar 2010 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+Zl8MpD9NAFvDmr22Fa74I2Z0jCm3fLAj6LOP0aEKc0=;
        b=xgBYk39a1Erl/edEVVOVkDtflbiERtL9wIo9TYsARzVWFwLO+TxgD6NO0+x5yo//1+
         3WxSHyWYZRWsDzh5hQ5cjyGYZEAof19XzFZoO45A6X+podywIbcZ6+JGJn2yDBhDJ5eu
         k2tYwg+x0+TQ25FQggpUOCd/bBTSKYvriOGJE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fT7PfKJBdo6qEVT0f/f+N7SAPsid3OXemQak7iKo7udWkUq71IRkT1XiJkgH7yDokD
         Am5COmtZ6Lo5q9FtZHgbsmYfPi5wxF5Ni8envQH3emwC9o4rjWIlY/zmzk4sif752khr
         sifFPRc16nvFoFqgpMHRXZzGnUZxpxx574PFM=
Received: by 10.223.77.85 with SMTP id f21mr1085126fak.40.1268129463987;
        Tue, 09 Mar 2010 02:11:03 -0800 (PST)
Received: from localhost ([91.78.51.61])
        by mx.google.com with ESMTPS id 16sm3576016fxm.15.2010.03.09.02.11.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Mar 2010 02:11:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1003091028440.7596@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141823>

On Tue, Mar 09, 2010 at 10:29:20AM +0100, Johannes Schindelin wrote:
> 
> That is just papering over the real culprit: Git checks something out. 
> This should be clean. But then Git says it is not.

We have two filters: from-git-to-worktree and from-worktree-to-git. If
those conversions are inconsistent for whatever reason, it is not going
to be well even if we found a way to solve this not-being-clean-after-
checkout problem.

One possible approach is to mark all files that had CRLF conversion
during checkout and apply the opposite conversion only to them. But what
about newly added files? Wouldn't this lead that to the situation where
newly added files will have the incorrect ending?

IMHO, this not clean after checkout repo demonstrates that you have the
incorrectly crlf configuration in it. So, you probably should correct
.gitattributes (or even to disable autocrlf in it if this repository is
not intended to be used with autocrlf=true). Either way, your current
settings are incorrect. It is better to fix it than try to hide it!


Dmitry
