From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD
 in tests
Date: Tue, 11 Jan 2011 01:54:41 -0600
Message-ID: <20110111075441.GB9445@burratino>
References: <201012302205.13728.j6t@kdbg.org>
 <201012311711.06989.j6t@kdbg.org>
 <20101231203019.GC5898@burratino>
 <201012312321.31294.j6t@kdbg.org>
 <7v62u8hz01.fsf@alter.siamese.dyndns.org>
 <4D2C09D7.3070700@viscovery.net>
 <4D2C0A5E.7090708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 08:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcZ4D-0005pN-Fz
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 08:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1AKHyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 02:54:52 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46835 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022Ab1AKHyw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 02:54:52 -0500
Received: by gxk9 with SMTP id 9so5240998gxk.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 23:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=So6JG4eor9mmL7rgRn3nzQZJlRa/BfMLVSOPNEOk+yA=;
        b=U7Bgmb9X3+FHIGV+87dHAxF0kLRDc2fPr+Goe/4TPD1HqQVR0nQhjQcUNl59DvYfML
         M9FS2eOQnwQ7OkUF0GYOetnFGZa3BQ0kd236kTqgVUOWw1puwT07evy0I9/hED0oE208
         mGsHgkZBwGrqp4j+yqY6iLYAwoP85tysRiraY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Q/1tEzNNOCtaTzC3GjcXWwwBvmehItLkVx8yUaWJFQqRVu9iq126iEjFHGmIKaSO82
         iko8Wmk9uxboMMIL+XPYNVcAiGfTdZZgVS2j3eI2Q8ZmIwOCH3AOJ+KGIMt8Y+CFcPQW
         ghD58G0x5xA0LX2FWrgaeJfO+cYLj+0SDrTgs=
Received: by 10.150.49.8 with SMTP id w8mr3603047ybw.181.1294732491062;
        Mon, 10 Jan 2011 23:54:51 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id v8sm15309757yba.2.2011.01.10.23.54.49
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 23:54:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2C0A5E.7090708@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164918>

Johannes Sixt wrote:

> This adds just a "do it this way" instruction without a lot of explanation,
> because the details are too complex to be explained at this point.

Thanks, looks very useful.

> --- a/t/README
> +++ b/t/README
> @@ -283,6 +283,12 @@ Do:
>     Tests that are likely to smoke out future regressions are better
>     than tests that just inflate the coverage metrics.
>  
> + - When a test checks for an absolute path that a git command generated,
> +   construct the expected value using $(pwd) rather than $PWD,
> +   $TEST_DIRECTORY, or $TRASH_DIRECTORY. It makes a difference on
> +   Windows, where the shell (MSYS bash) mangles absolute path names.
> +   For details, see the commit message of 4114156ae9.
> +

Perhaps it is also worth explaining the cases where $PWD is needed?

	By contrast, when a passing a path to git or constructing a URL,
	use $PWD.  It makes a difference on Windows, where

	 - $(pwd) is a Windows-style path such as git might output, and
	 - $PWD is a Unix-style path that the shell (MSYS bash) will
	   mangle before passing to native apps like git.
