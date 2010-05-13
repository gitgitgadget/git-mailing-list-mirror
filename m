From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: [RFC/PATCH v3 4/5] Rename "crlf" attribute as "eolconv"
Date: Thu, 13 May 2010 13:47:45 +0200
Message-ID: <014C9B00-800C-465D-A0B9-98BEEB7D7A96@gmail.com>
References: <cover.1273700831.git.eyvind.bernhardsen@gmail.com> <6dd7bef7811283b03b8b9dac93c9a264d007bcb0.1273700831.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005121824260.3711@i5.linux-foundation.org> <AANLkTilQjSKNYq8NEabcsZc5WWF86kWMWxnTy-mShVgS@mail.gmail.com> <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 13:47:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCWtO-0006GY-Br
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 13:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab0EMLrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 07:47:49 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:45402 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0EMLrs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 07:47:48 -0400
Received: by ey-out-2122.google.com with SMTP id d26so200015eyd.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=2bxDe2gUUrrB2lNNJvNrOGepBvHJ9BJlA9A+SqkFi88=;
        b=NR0HMgPHHnfmlMz+D+KR6OIJa+Jwug0dcfDobG637pOZuw0lZ0ADcqDoWeMFihHwCc
         hyS5s6LlEzIaPVXAjLc5sEzB1OJ6k2NMl3XuRk6Ld3/N4VN/ZpL64CZbxjZ7wVWyAemq
         +5RcwStWvGo0Y5wczaNF1MLb7L2PFa6KMDq6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=FqVuWuX3YUsRTjK4fXWip1J7eG91CZENQtHCzI4c6Lwtl4nwW/AHSJmq9fTK0enfDe
         DaLnHIOWBxhmr/TxuZCckEEmmp1KO+xKsiyhJ9j/36NDpGl6VKTDk3h2Vc/NSZ5X4H1h
         Sw9kvbJxqRHLqw3oBszN4XDsF86lDffiG0nCo=
Received: by 10.213.75.139 with SMTP id y11mr3919164ebj.63.1273751267562;
        Thu, 13 May 2010 04:47:47 -0700 (PDT)
Received: from [172.16.3.204] (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 14sm647119ewy.6.2010.05.13.04.47.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 13 May 2010 04:47:47 -0700 (PDT)
In-Reply-To: <AANLkTimCraGNet9lCuJGmFNR5JcDRQBTz1yME6GQFo4B@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146991>

On 13. mai 2010, at 11.58, Robert Buck wrote:

> Quick question here, while people would be in the convert.c functions
> when making the above changes. This question is related to detecting
> whether a file is text, but the question could be spun off to a
> different thread if you so wish...
> 
> Have you considered skipping the UTF8 BOM and provided that the
> remaining content is considered text allow auto conversions? The check
> is simple, and would cover at least 50% of latin-derived languages.
> Since you have the buffer at hand, and are in the same file
> (convert.c), simply check for an initial EF BB BF. This would fix some
> text files created on Windows (someone had mentioned Notepad I
> believe). Out of the box experience for eol and text detection for
> Windows users would be improved.

I just did a quick test with a plain text file; it was detected as text both with and without a utf8 BOM.  Looking at the code, characters >= 128 are considered printable so the BOM shouldn't make any difference at all.  Do you have an example utf8 text file that is misdetected as binary?
-- 
Eyvind
