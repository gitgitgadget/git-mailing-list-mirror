From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Speed up bash completion loading
Date: Sun, 15 Nov 2009 00:50:16 -0600
Message-ID: <20091115065016.GA2849@progeny.tock>
References: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
 <20091111220832.GA31620@progeny.tock>
 <4AFCFF50.5080401@gmail.com>
 <20091113070652.GA3907@progeny.tock>
 <4AFD06CD.7090003@gmail.com>
 <20091113085028.GA4804@progeny.tock>
 <20091113090343.GA5355@progeny.tock>
 <4AFDC4F3.1050607@gmail.com>
 <20091114110141.GB1829@progeny.tock>
 <1258242380.9650.90.camel@swboyd-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <junio@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 07:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Ym5-0007ip-0B
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 07:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbZKOGjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 01:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZKOGjh
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 01:39:37 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:58882 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbZKOGjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 01:39:36 -0500
Received: by yxe17 with SMTP id 17so3979355yxe.33
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 22:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cKWYDGIpIY/B2yAo34slU5bu9VP4YcEuaCv6Xi6NtHA=;
        b=VEauXu8WKvosglMrJHvJEvoQ8ParrRBpaifyDl6kV1ebdqKOr5O5orSvALcXaU1/FG
         3noHUPmwI2nU6NLa6uJpE6VwXSOUBp+PDmHqFLvM3meaMIoisbjs13qqZKlNYxlQEuie
         HsxnrDSp/V5DdrpJowUHRUgCfNxf35do8mclo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UCIFRs4MbZQYW51LRrq8l75vniVorUJ8hyOesACVwWQwpCTQVvU34vJf9o4/Ck3RvA
         Q3Pb7Z7CKKyiDPA6mI93oxNGKxhi38R2DlDeC7Z9mKYEmADZaSvVl/EOhiETEliL/16h
         emvJPTdTUs32ctwXSOkkXX5OG6WjU0RV9M5Zs=
Received: by 10.150.44.24 with SMTP id r24mr11024571ybr.249.1258267182188;
        Sat, 14 Nov 2009 22:39:42 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm1560538gxk.3.2009.11.14.22.39.40
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Nov 2009 22:39:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1258242380.9650.90.camel@swboyd-laptop>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132911>

Stephen Boyd wrote:

> I was thinking of adding an option to git merge (like --strategies) to
> list the strategies without requiring you to be in a git directory. It
> doesn't look that easy at first glance so it might not be worth the
> trouble.

Right, that would require support from run_builtin().
