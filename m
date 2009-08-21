From: David Aguilar <davvid@gmail.com>
Subject: Re: git diffall, open all diff files immediatly (eg tabbed window
	in BC)
Date: Thu, 20 Aug 2009 22:40:45 -0700
Message-ID: <20090821054044.GB32879@gmail.com>
References: <loom.20090821T053954-649@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Seba Illingworth <seba.illingworth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeMsG-0005tD-AJ
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 07:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616AbZHUFku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 01:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442AbZHUFku
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 01:40:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:24939 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZHUFkt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 01:40:49 -0400
Received: by rv-out-0506.google.com with SMTP id f6so164318rvb.1
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dzOHNdhgZK1bxEwGGcThlrC4BYcHi+yFcnskHRoOr3o=;
        b=dIqjOdCQBi+54pCLOydqKmPCLBjMvgTDZ86Bz2s2+8C+hvHHDJ4zC6/h6fKAie7t9C
         Rf7FYVFcyPU93XgOjHZx6Tbb/ZjHt1CPSHQzoehJI8caSWakDguQlWOYJtb6woBxULWk
         Y/tToBFgIAtFtLT43eGB4smNPqWLXstR89WHU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Lzu/uOsyUOZqV34envX7A6ktd7AiYc2X9tujFhlBo6Ao2vioJyB+W7UKpEvBeMLq6g
         JnqNcTzYVEzyKv2h8luGI2sImioNLlt/kexSsl/nqWtuSCaxWCtyVHAHPrFwqW7xT5Ta
         FmvBWj2M1bg0dUpSRQR7dSs/y0ObE+Jqsgh0Q=
Received: by 10.140.141.20 with SMTP id o20mr402832rvd.188.1250833248940;
        Thu, 20 Aug 2009 22:40:48 -0700 (PDT)
Received: from gmail.com (cpe-76-94-197-182.socal.res.rr.com [76.94.197.182])
        by mx.google.com with ESMTPS id g14sm2563873rvb.11.2009.08.20.22.40.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 22:40:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20090821T053954-649@post.gmane.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126677>

Hi,

On Fri, Aug 21, 2009 at 03:47:07AM +0000, Seba Illingworth wrote:
> I came up with the following 'git-diffall' script to open all diff files
> immediately, rather than default behavior of opening them one at a 
> time in serial.
> 
>     for name in $(git diff --name-only $1); do git difftool $1 $name & done
> 
> I blogged the details at 
> http://blog.codefarm.co.nz/2009/08/git-diff-and-difftool-open-all-files.html

You must have difftool.prompt (or mergetool.prompt) set to
false, otherwise git would be prompting you during the loop.

To make it work irrespective of the configuration, pass
--no-prompt or -y to difftool.


Also maybe something like:

for name in "$(git diff --name-only "$@")"; do
	git difftool "$@" "$name" &
done

The quotes should make it work paths that have spaces.
The "$@" should let you pass arbitrary parameters to difftool.

Have fun,

-- 
		David
