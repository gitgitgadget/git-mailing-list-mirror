From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-gui: Help identify aspell version on Windows too
Date: Fri, 26 Sep 2008 08:29:48 +0200
Message-ID: <48DC815C.6030401@viscovery.net>
References: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Fri Sep 26 08:31:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj6qy-0001vF-8u
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 08:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbYIZG3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 02:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYIZG3v
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 02:29:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:20202 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbYIZG3u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 02:29:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kj6po-0001yM-UT; Fri, 26 Sep 2008 08:29:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A124C6B7; Fri, 26 Sep 2008 08:29:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1222378282-21757-1-git-send-email-hendeby@isy.liu.se>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96830>

Gustaf Hendeby schrieb:
> On windows, git gui fails to correctly extract the aspell version
> (experienced with aspell version 0.50.3) due to scilent white space at
> the end of the version string.  Trim the obtained version string to
> work around this.

With this I've partial success here: Aspell 0.50.3 alpha (downloaded from
http://aspell.net/win32/) is recognized, but

- it only ever checks the first line of the commit message;

- after I change the catalog in the Options, I can't "Save" (it does
nothing), until I change to some other catalog. I haven't discovered the
pattern, yet, when the "Save" succeeds.

- At startup the correct catalog is used. But if I change the catalog
during a session (if I succeed, see above), then the second-last picked
catalog is used.

Any idea how to debug this?

> @@ -80,7 +80,7 @@ method _connect {pipe_fd} {
>  		error_popup [strcat [mc "Unrecognized spell checker"] ":\n\n$s_version"]
>  		return
>  	}
> -	set s_version [string range $s_version 5 end]
> +			set s_version [string range [string trim $s_version] 5 end]

A strange indentation you have here.

>  	regexp \
>  		{International Ispell Version .* \(but really (Aspell .*?)\)$} \
>  		$s_version _junk s_version

-- Hannes
