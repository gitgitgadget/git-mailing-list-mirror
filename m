From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitweb: false base href sent when integrated via reverse proxy
 and path_info is active
Date: Sun, 28 Nov 2010 15:10:55 -0600
Message-ID: <20101128211054.GA20203@burratino>
References: <20101128081048.13668.67286.reportbug@sb74.startrek>
 <20101128162720.GB18335@burratino>
 <AANLkTinM8qyL9DafMx4XWBQ5RUeWABKVc5mNjdVEkQfZ@mail.gmail.com>
 <201011281847.40233.jnareb@gmail.com>
 <4CF2BBEE.2050808@nachtgeist.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Daniel Reichelt <debian@nachtgeist.net>
X-From: git-owner@vger.kernel.org Sun Nov 28 22:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMoWd-0003Gs-9k
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 22:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163Ab0K1VLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 16:11:05 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0K1VLD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 16:11:03 -0500
Received: by gyb11 with SMTP id 11so1689287gyb.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=It3HXo/Wp/v4McE6WPFh8lWaJU0NIbPO3OYWaVtqA48=;
        b=GLepgfywzrLduaIUuH3Rgv4Ql0cHM1YXcUWLnIijnJ2l1rkmnNj/XGVr8UD1KJFqfJ
         CAXlb7N6MzVaQWejhEm53gHPzM6BCCn6wVM0olkrsvIWZKPUFn6QR7NjlslLNkK6Da75
         sAwC8PXI5C+2TnyhHlyf5P+/D7T+0widHn9to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LHiptlovOFfQofuNU9lplVXsxl21yWkXhgWx0AluQ1kLXdVhBMuVU+3FfvLyXCN/i3
         IwZnN9GUAuf8AmHmDVggJczx3afRdTGpXtilIa9PRKHO8ee2aAe/HeaW1GFwT601HP2D
         tZsCdn7eJL0znmIt8f7AvX5tp7aVvZW8YFfJc=
Received: by 10.100.251.1 with SMTP id y1mr1984021anh.56.1290978661724;
        Sun, 28 Nov 2010 13:11:01 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id i10sm4894461anh.32.2010.11.28.13.10.59
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 13:11:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CF2BBEE.2050808@nachtgeist.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162361>

Daniel Reichelt wrote:

> However, I just tried that and it failed. $base_url gets ignored in
> gitweb.conf and even setting $my_url and $my_uri in gitweb.conf seems to
> have no effect at all.

Aha.  The bug fixed by v1.7.3-rc0~85^2 (gitweb: allow configurations
that change with each request, 2010-07-30) strikes again.

Daniel, could you try again with version 1:1.7.2.3-2.1 (from Debian sid)?

Jakub, we should probably tweak evaluate_uri to do something special if
$base_url is already set, or advertise that $base_url needs to be set
in per_request_config when that feature is enabled.

Thanks again.
Jonathan
