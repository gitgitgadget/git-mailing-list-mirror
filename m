From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/9] revert: simplify getting commit subject in
 format_todo()
Date: Fri, 9 Dec 2011 13:47:27 -0600
Message-ID: <20111209194727.GF20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6Pw-0003iF-Gs
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab1LITrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:47:32 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55254 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1LITrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:47:31 -0500
Received: by yenm11 with SMTP id m11so2371838yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mZGFDAwlAnodaB5q3DHKQq5M3VJAqib5SXRKhpzulcE=;
        b=eIRxQAc+FnNVpyw/3yVLDLPqCWXHnBUDvg005C4cs+M1QTXgImNy0KA6aNpRT1U3Ue
         VSK+UK5W+zk0qFVg79Fgr6Yj2J0aDcVV5+3kXbmq/TAo89bQCuMwJVJnIAsrm7I4QIq/
         xT43EuneikHocWm9cB9SNyKB604ZzdbOXLSKM=
Received: by 10.236.201.200 with SMTP id b48mr13880166yho.76.1323460051114;
        Fri, 09 Dec 2011 11:47:31 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 39sm26605856anu.6.2011.12.09.11.47.29
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:47:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186673>

Ramkumar Ramachandra wrote:

> format_todo() calls get_message(), but uses only the subject line of
> the commit message.  As a minor optimization, save work and
> unnecessary memory allocations by using find_commit_subject() instead.

Nice.  Thanks for explaining.

> Also, remove the unnecessary check on cur->item: the previous patch
> makes sure that instruction sheets with missing commit subjects are
> parsable.

I guess you mean the check that cur->item->buffer is non-NULL.  But
now I am confused --- what would that have to do with instruction
sheets with missing commit subjects?  If cur->item->buffer is NULL,
isn't find_commit_subject going to segfault regardless?

Can cur->item->buffer be NULL?
