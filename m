From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Testing: XDG config files: Export a suitable
 `XDG_CONFIG_HOME' environment variable
Date: Tue, 17 Jul 2012 12:57:40 -0500
Message-ID: <20120717175740.GA14361@burratino>
References: <82316e5034d940e09fed719ae7bfdc3b-mfwitten@gmail.com>
 <679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 19:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrC1y-0001sY-EL
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 19:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab2GQR5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jul 2012 13:57:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41397 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875Ab2GQR5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2012 13:57:49 -0400
Received: by yenl2 with SMTP id l2so676503yen.19
        for <git@vger.kernel.org>; Tue, 17 Jul 2012 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9BYcq3BgjW5OH89EiVOKcraV7nLVPxP3eGCWQgmTrGc=;
        b=ck8jnTA5CSnD2OxLaDopTYDNm2xMupg4mzIle+C6FqQL9h4CEce8wv8SlGWotpA+qg
         BucDnS1okqsbmwRCIdeZMEedF2lzcDYoWYLq5hnN9OqacRXy79PJXjIkjRNdBeE0oyL3
         sMPHzjMgKHl9U98HLpjIewptiJpI+6rdf1MrqNyhjdK8SPyC0nm6n3BbpfMMdLGwhIWw
         JVO64/uO2D4YK4AhfeLU0Kyg3uoSUHApBXv/sbeY7ZScvigChsQCH5EiSHhXhqV3BQBs
         XS22fkZE4o++3i0m4eF3rL6W4DzU2MbInxbeHlapkkOPcIyvBWS3Kx2A36KVjA9WKiuW
         SLaw==
Received: by 10.43.59.71 with SMTP id wn7mr2131512icb.0.1342547868301;
        Tue, 17 Jul 2012 10:57:48 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id f8sm12351139ign.0.2012.07.17.10.57.47
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Jul 2012 10:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <679ad82bd4604d1c903f3c2fff2a8cfb-mfwitten@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201614>

Hi,

Michael Witten wrote:

> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -544,6 +544,9 @@ rm -fr "$test" || {
>  HOME="$TRASH_DIRECTORY"
>  export HOME
>  
> +XDG_CONFIG_HOME=$HOME/.config
> +export XDG_CONFIG_HOME
> +

I think this is a bad idea.  The typical case is for XDG_CONFIG_HOME
not to be set, and we need to make sure git works well in the typical
case.

But the general idea seems sane --- how about

	unset VISUAL EMAIL LANGUAGE COLUMNS XDG_CONFIG_HOME $(perl -e '
		...

?
