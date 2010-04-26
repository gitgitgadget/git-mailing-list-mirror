From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] fast-import: validate entire ident string
Date: Mon, 26 Apr 2010 09:02:47 -0700
Message-ID: <20100426160247.GD7502@spearce.org>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com> <20100424160608.GA14690@progeny.tock> <20100424190419.GA7502@spearce.org> <20100424203827.GA24948@progeny.tock> <20100424211042.GC24948@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 18:03:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6QmG-0001iL-Fu
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 18:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394Ab0DZQDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 12:03:00 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:28226 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab0DZQC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 12:02:59 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2611085fga.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 09:02:58 -0700 (PDT)
Received: by 10.87.68.7 with SMTP id v7mr2567975fgk.71.1272297772522;
        Mon, 26 Apr 2010 09:02:52 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 9sm8775291fks.56.2010.04.26.09.02.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 09:02:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424211042.GC24948@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145825>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> The author, committer, and tagger name and email should not include
> any embedded <, >, or newline characters.  The format of the
> identification string is
> 
>   ('author'|'committer'|'tagger') sp name sp < email > sp date
> 
> If an object has no name attached, then git expects to find two spaces
> in a row.

This is going to be a problem I think.  Some importers are probably
writing "committer <bob> ...." when pulling from systems that don't
have a concept of name vs. email (e.g. CVS or SVN).  I highly suspect
that requiring two spaces here will cause a lot of importers to fail.

If we really need to require two spaces, I think we need to honor
the documented input format but rewrite the line inside of the
import process to match the two space convention.
 
-- 
Shawn.
