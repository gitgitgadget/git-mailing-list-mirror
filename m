From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: git-svn "cannot lock ref" error during fetch
Date: Thu, 7 Jun 2007 08:54:00 +0200
Message-ID: <8c5c35580706062354g5b19e4b8x43d211f634a8583b@mail.gmail.com>
References: <50C9688F-9C62-43AC-A84D-D84561671BAC@mac.com>
	 <20070607063158.GA2809@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "James Peach" <jamespeach@mac.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 08:54:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwBsk-0006u9-0w
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 08:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbXFGGyD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 02:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbXFGGyD
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 02:54:03 -0400
Received: from nz-out-0506.google.com ([64.233.162.224]:1879 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbXFGGyB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 02:54:01 -0400
Received: by nz-out-0506.google.com with SMTP id n1so414353nzf
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 23:54:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iCCo3Gph9tTFOGSaQFOzeyIJRMSik7SSvxvnwUTGBMJHIzczUnMlr8lqWbQNmHw/3U25Hf4E0E2YFcqAHPdhn+bJEUEyR5nT8o32KVK5n8k8XllwLW9EGosNBNAQeMIeVBklAwbOSb4+3YZ7ZmsrcfxvrQtI9B18AV7Opu5PLyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V0S59gnfJ6MNOcgVVqyAfYKTz4MhyE2SxHdbGWamNGAMHR8tvfcRWYpfYeXHrKp3PKq5kMGb3rNYhzBWBZSSD6xCfO2HWHlVkIeSLQUPmm7lnQEhKBxfKTCsKK0AXcvthlnCmikUjuLwvcWwq5AUDfQpOzXoelkJeyIIpgdGRuk=
Received: by 10.114.108.15 with SMTP id g15mr1236784wac.1181199240401;
        Wed, 06 Jun 2007 23:54:00 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Wed, 6 Jun 2007 23:54:00 -0700 (PDT)
In-Reply-To: <20070607063158.GA2809@muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49360>

On 6/7/07, Eric Wong <normalperson@yhbt.net> wrote:
> James Peach <jamespeach@mac.com> wrote:
> > update-ref -m r13726 refs/remotes/tags/project-92~9
> > 950638ff72acc278156a0d55baafbabb43f2b772: command returned error: 128
> >
> > Some amount of searching failed to turn up any hints on what this
> > error means or how I can work around it. I'd appreciate any advice ...
>
> Is there a tag actually named "project-92~9"?  If so, it's
> an invalid branch name for git.  I started working on a way
> around it by mapping new names to it, but haven't gotten around to
> finishing it....
>

fwiw: a similar error occurs when a svn tag-/branchname contains
spaces. The culprit seems to be $self->refname in

		command_noisy('update-ref', '-m', "r$rev",
		              $self->refname, $commit);

in rev_db_set()

--
larsh
