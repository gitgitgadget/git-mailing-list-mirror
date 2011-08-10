From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE file
 instead of MERGED
Date: Wed, 10 Aug 2011 11:12:11 -0500
Message-ID: <20110810161211.GC4076@elie.gateway.2wire.net>
References: <20110810160356.GA32126@ortolo.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: Tanguy Ortolo <tanguy+debian@ortolo.eu>
X-From: git-owner@vger.kernel.org Wed Aug 10 18:12:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrBOJ-0005Yh-Js
	for gcvg-git-2@lo.gmane.org; Wed, 10 Aug 2011 18:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589Ab1HJQMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 12:12:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54075 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab1HJQMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 12:12:16 -0400
Received: by gya6 with SMTP id 6so755921gya.19
        for <git@vger.kernel.org>; Wed, 10 Aug 2011 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=r+Hq6kImLPyyUDsPMI1yYkELWVeCpTr7uJbfTd+jjd0=;
        b=xaDvO6HKeRDlyT8i93u4fM6aYkb41JOTVBudKdgTo1+254Pj97fTqcEo8daXwqj1NU
         sqQSjK7petAxibrovnDGjdbemgWq7PqIh2AcFNWk9Yo+JPzyJ2wi2WvhCeAYGkmAYNQi
         0qztX6S9fBjd+uwzfPdDXtPlgNpv3RRwJV+Ok=
Received: by 10.101.154.17 with SMTP id g17mr7452063ano.32.1312992736174;
        Wed, 10 Aug 2011 09:12:16 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.ameritech.net [69.209.69.68])
        by mx.google.com with ESMTPS id l14sm897076anl.34.2011.08.10.09.12.14
        (version=SSLv3 cipher=OTHER);
        Wed, 10 Aug 2011 09:12:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110810160356.GA32126@ortolo.eu>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179072>

(+cc: some relevant people)
Hi,

Tanguy Ortolo wrote[1]:

> git-mergetool ideally uses tools that work with 4 files: BASE, LOCAL,
> REMOTE, which are the usual original and two new version of the file,
> and MERGED, which is where the tool is supposed to write the result of
> the merge.
>
> The problem is that most tools, at least graphical ones, specifically
> meld, can only work with three files, as they save the result to the
> original file.
>
> git-mergetool currently handles this situation by passing MERGED LOCAL
> REMOTE to the tool. This could be fine, but unfortunately MERGE contains
> the conflicts, formatted for manual resolution, so it is not really
> appropriate as an original file.
>
> I think it would be better to wrap such merge tools by:
> 1. passing them BASE LOCAL REMOTE;
> 2. checking whether or not BASE hase been modified:
>    * if it has, then copying it to MERGED,
>    * if it has not, exiting with return code 1 (merge failed).
> This check can be by either saving and comparing the mdate, or perhaps
> the SHA-1 hash of the BASE file.
>
> If this sounds good enough, I can dive into git-mergetoo--lib and
> implement it. In the meantime, here is an example of a custom merge tool
> that wraps meld for that purpose.

I think you forgot to include the example.  Anyway, at first glance it
sounds like a sensible idea.  David et al: thoughts?

Regards,
Jonathan

[1] http://bugs.debian.org/637355
