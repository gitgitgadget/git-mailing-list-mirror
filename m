From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Thu, 16 Feb 2012 05:40:26 -0800 (PST)
Message-ID: <m3d39esxrg.fsf@localhost.localdomain>
References: <vpq39abrxav.fsf@bauges.imag.fr>
	<1329395775-18294-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Feb 16 14:40:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry1ZZ-0003hT-8k
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 14:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245Ab2BPNk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 08:40:29 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58508 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab2BPNk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 08:40:28 -0500
Received: by eaah12 with SMTP id h12so726948eaa.19
        for <git@vger.kernel.org>; Thu, 16 Feb 2012 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=x/Ditq7/YmJsrHxyJXLiJlzlCyPQgPn1N+uBny4VgKw=;
        b=WmbCke/azTee5d3JebybisHLfb6NK+Wug6yH9nRohxgUujl0fIqOU6WG5oMkz2LlEm
         wckM8Oam6jsEYl1LruK92qTAcZ8Jr5j0cunOeudUmrEUY8FZPc8E8SStHZBOYRoW2SjR
         4NJM/tjJbOHZYHo5tSJJXP7g4E3VGlx5fg6rM=
Received: by 10.14.53.74 with SMTP id f50mr1599897eec.5.1329399626934;
        Thu, 16 Feb 2012 05:40:26 -0800 (PST)
Received: from localhost.localdomain (abwb213.neoplus.adsl.tpnet.pl. [83.8.225.213])
        by mx.google.com with ESMTPS id u9sm6416794eem.11.2012.02.16.05.40.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Feb 2012 05:40:26 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1GDdliS009148;
	Thu, 16 Feb 2012 14:39:57 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1GDdVaC009144;
	Thu, 16 Feb 2012 14:39:31 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1329395775-18294-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190894>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Changes since v2:
> 
[...]
> - Shell style issues (thanks to Jakub)
[...]

> +verbose "Auto-detecting PDF viewer"
> +candidates="xdg-open evince okular xpdf acroread"
> +if [ "$(uname)" = Darwin ]; then
> +    # open exists on GNU/Linux, but does not open PDFs
> +    candidates="open $candidates"
> +fi
> +
> +for command in $candidates; do
> +    if [ "$PDFVIEWER" = "" ]; then
> +	if command -v "$command" >/dev/null 2>&1; then
> +	    PDFVIEWER="$command"
> +	else
> +	    verbose_progress
> +	fi
> +    fi
> +done
> +verbose_done "$PDFVIEWER"

Eh?  I don't see shell style issues fixed (loop inside conditional
instead of vice-versa, "test ..." instead of "[ ... ]").

Nb. I think it would be good to put detecting PDF viewer in its own
function, don't you?

-- 
Jakub Narebski
