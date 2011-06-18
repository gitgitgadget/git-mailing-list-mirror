From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] rebase -i -p: doesn't pick certain merge commits that
 are children of "upstream"
Date: Sat, 18 Jun 2011 12:12:22 -0500
Organization: Exigence
Message-ID: <20110618121222.03ee0b79@sh9>
References: <4DEB495F.9080900@kdbg.org>
	<1307419725-4470-1-git-send-email-andrew.kw.w@gmail.com>
	<1307419725-4470-2-git-send-email-andrew.kw.w@gmail.com>
	<7vmxhlpvob.fsf@alter.siamese.dyndns.org>
	<4DF64932.1090607@sohovfx.com>
	<20110616172454.13ff1a18@sh9>
	<4DFC4863.2090803@sohovfx.com>
	<20110618101718.6ff03688@sh9>
	<4DFCD6A5.7000707@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Sat Jun 18 19:12:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXz4S-0001JL-So
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 19:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab1FRRM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 13:12:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40261 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab1FRRM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 13:12:26 -0400
Received: by gxk21 with SMTP id 21so1660428gxk.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=BnQiGuaFXafbBh4r9/nrJpEV1CxirTRzNFG107Nc8aM=;
        b=Cu8aOXhdwZ536mPHbgwys5aehzVxCJHtdczaraH4VHket+9vj6LSu3xiavxPetg7nz
         xqW9i1sLXT3q8QXt0Frn+mx46YkuYiENMZxk6OPmeUIEh7Zj8wfWrM8OH82cn3a/Lqq0
         SC6AhLi2fTkVDwc3E8ymk441/wsLyPwMsgmtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Wd/qHEyN2IeEphE5P1lP/y+p3HcUviYenyRY56YL2WQCUi8SneWFMZTuUrHeoPHbrj
         ptqPqJ0XzP1Ct2vGyG58/zAvvLKs+cHIQV1tDBVK2hFNKuhyl8/3oTd6vNFwkUTGiv3t
         /RJhOnBGwAQhp4yEGoKfaift+W4DNNHIz4VIQ=
Received: by 10.236.187.99 with SMTP id x63mr5551326yhm.174.1308417145627;
        Sat, 18 Jun 2011 10:12:25 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net [184.187.11.226])
        by mx.google.com with ESMTPS id i61sm2490862yhe.47.2011.06.18.10.12.23
        (version=SSLv3 cipher=OTHER);
        Sat, 18 Jun 2011 10:12:24 -0700 (PDT)
In-Reply-To: <4DFCD6A5.7000707@sohovfx.com>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175978>


> The bug section in rebase's documentation does mention that "attempts
> to reorder commits tend to produce counterintuitive results", which I
> think serves as a fairly good warning saying "reorder at your own
> risk".

True.

> Also, if we do a "rebase-i-p A1", the C1 branch will appear in
> the todo list.

Hm, good point.

> There shouldn't be any topo-reordering unless the user explicitly 
> changes the order of the commit.  The user is faced with the same 
> limitations (and bugs) as rebase-i-p'ing D1, so we shouldn't have to 
> handle the C1 case any different.  rebase is perfectly capable of 
> handling the D1 case, just as how the C1 case is handled.  We're only 
> running into this issue because we're trying to filter out C1 when 
> rebase-i-p'ing B1.

Okay, that makes sense.

I agree with you then, with the behavior of "rebase-i-p A1" plus the
disclaimer in the docs warrants C1 showing up, C1 should be in the
todo list for "rebase-i-p B1" as well.

...I can think of cases where personally I'd want to only move
around commits on the first-parent line, e.g. even in the case of
"rebase-i-p A1", to have less noise (C1 and any others on its branch)
in the todo, but at that point it sounds like I'm projecting behavior
onto rebase-i-p that isn't actually there.

- Stephen
