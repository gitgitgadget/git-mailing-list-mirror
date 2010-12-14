From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Corruption in the repository
Date: Tue, 14 Dec 2010 13:19:01 -0600
Message-ID: <20101214191901.GA7257@burratino>
References: <1292255990.25237.27642.camel@korcula.inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Gareste <simon.gareste@scilab.org>,
	Bruno JOFRET <bruno.jofret@scilab.org>,
	Christian Couder <christian.couder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Sylvestre Ledru <sylvestre.ledru@scilab.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 20:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSaPB-0005Z2-Cr
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 20:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758723Ab0LNTTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 14:19:17 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36168 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab0LNTTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 14:19:16 -0500
Received: by vws16 with SMTP id 16so446279vws.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=b+POYXvOc3Wq7w67wI+kGbXyOF2pIM6jmS5eJfbFGMY=;
        b=SdHFx1peUZDNImGAR0zzAl4CX2oYUOHMbsHPh7oNvokm8orB3bf8FUT2vvepz2/T+g
         1VTpek3YC9tTMRlkKAu5PyUZCE16rB4B25a3I63mDl23CMxbBpvPOORzzIM8cHZnD0ZT
         RpH/FIt44fP/SAP1bA6eahB9dmtRKLGoqHY7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=YxsXKUB5gwfQZ4BR1lGvSKE7mw79m0w/gBr3ph9EcKkD8IQMoCYw9Y7JjLYpfemAFd
         i8yuPpv0fMGeyBDnWdDHLM+mwbw0LPu6613vqMKqIlL0NPumPB9Nr0op80lrVo8A1hlC
         BIKmIdt39aEZYY01FLjTVBPRTV3//8TodxWZg=
Received: by 10.220.201.10 with SMTP id ey10mr1661188vcb.126.1292354355545;
        Tue, 14 Dec 2010 11:19:15 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id p8sm91818vcr.42.2010.12.14.11.19.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Dec 2010 11:19:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292255990.25237.27642.camel@korcula.inria.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163679>

Sylvestre Ledru wrote:

> error: refs/changes/98/398/1 does not point to a valid object!
> error: refs/changes/98/398/2 does not point to a valid object!
> fatal: object cff52c24fba28408e7d021a8f35a717bef31521d is corrupted
> fatal: The remote end hung up unexpectedly

Ah, should have thought of this sooner.  There doesn't seem to be
corruption involved after all.

> Does anyone know how to repair this error ?

Use git from the "master" branch to consolidate pack files:

	~/src/git/bin-wrappers/git repack -a -d

Details are in f2e872aa5 (Work around EMFILE when there are too many
pack files, 2010-11-01), which will likely be part of git 1.7.4.
Thanks for reporting and sorry for the trouble.

Jonathan
