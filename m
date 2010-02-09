From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/4] git-imap-send: Add method to convert from LF to CRLF
Date: Tue, 09 Feb 2010 08:15:43 -0800 (PST)
Message-ID: <m31vgu9yjk.fsf@localhost.localdomain>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
	<1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
X-From: git-owner@vger.kernel.org Tue Feb 09 17:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neskh-0004JV-Jy
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 17:15:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815Ab0BIQPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 11:15:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:64307 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab0BIQPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 11:15:47 -0500
Received: by fg-out-1718.google.com with SMTP id e21so436745fga.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=XUxpO7ZSR6ccQlq18p6IbSzohtPpiToh+oG2lUhCtCU=;
        b=Uj0K3tZIOKMx83ygbE0wAEWYNPTA6q0HrvdFabPB8AcE697KezcJjCpiyVfOfGp81p
         y3W35AZbJen6vqUXTjN088LYFTaomO8jBv7A9/ozYhcGn9hfnfuiBZ20nPwL6MHvY8fD
         f/8j0+w83VB5/HfNxRJsaGzXwTq0i5siTVAqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=m2ey6FhKi1mCwGQ3evgtqdeAv22dTDcXjoncTPU4glDpEudwYteLtB2lHbDPggzr/H
         eydf4EpvbcLjUwHdIQayx4fO1BUBaEgTf377SnmoJxOh3U1FdgKM7gSt+X8K3BegJixW
         aoJ9UVF0eN6zjxN/QwYd7UKuiIkas7JQr84WI=
Received: by 10.87.48.11 with SMTP id a11mr630878fgk.36.1265732145793;
        Tue, 09 Feb 2010 08:15:45 -0800 (PST)
Received: from localhost.localdomain (abvg140.neoplus.adsl.tpnet.pl [83.8.204.140])
        by mx.google.com with ESMTPS id e11sm584573fga.4.2010.02.09.08.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 08:15:43 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o19GEtHV021462;
	Tue, 9 Feb 2010 17:15:02 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o19GENiq021450;
	Tue, 9 Feb 2010 17:14:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139410>

Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> writes:

> Some strict IMAP servers (e.g. Cyrus) don't
> allow "bare newlines ('\n')" in messages.
> So I added new boolean option "lf-to-crlf" to imap section.
> If this option enabled, git-imap-send converts LF to CRLF("\r\n").
> 
> If you want to use it, add line:
> 	lf-to-crlf
> to [imap] section of your .gitconfig .
> 
> This patch also adds description to Documentation/git-imap-send.txt .

> +imap.lf-to-crlf::
> +	If you use strict IMAP server (e.g. Cyrus),
> +	"bare newlines ('\n')" in messages are not allowed.
> +	If this option enabled, git-imap-send converts LF to CRLF("\r\n").
> +

If you take a look at Documentation/config.txt at the names of other
config variables, you would see that they have

  core.fileMode::
  core.ignoreCygwinFSTricks::
  core.quotepath::
  core.safecrlf::

names, i.e. either camelCase or allsmallcase, and not

  imap.lf-to-crlf::

with '-' to separate parts.  Values can and do use this syntax, like
e.g. `blank-at-eol` for core.whitespace.

The only outlier is add.ignore-errors (not add.ignoreerrors or
add.ignoreErrors).


The same is true for the other config variable you propsed in 3/4
patch.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
