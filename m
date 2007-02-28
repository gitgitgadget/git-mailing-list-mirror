From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Create a symbolic link as a regular file on filesystems without symlinks.
Date: Wed, 28 Feb 2007 18:18:52 +0100
Message-ID: <200702281818.52668.johannes.sixt@telecom.at>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at> <11726125052184-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.63.0702272342160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 18:47:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSu0-00053S-I6
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:47:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbXB1Rrl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXB1Rrl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:47:41 -0500
Received: from smtp1.noc.eunet-ag.at ([193.154.160.117]:56055 "EHLO
	smtp1.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXB1Rrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:47:40 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.noc.eunet-ag.at (Postfix) with ESMTP
	id 6C19B34140; Wed, 28 Feb 2007 18:18:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 34370121FE;
	Wed, 28 Feb 2007 18:18:53 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.63.0702272342160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40975>

On Tuesday 27 February 2007 23:44, Johannes Schindelin wrote:
> On Tue, 27 Feb 2007, Johannes Sixt wrote:
> > -	if (S_ISLNK(mode))
> > +	if (trust_symlink_fmt && S_ISLNK(mode))
>
> First of all why "_fmt"? I would have called it "trust_symlinks".

Because the file type is encoded in a mask named S_IFMT ;)
But the more I think about it, I'll rename it to has_symlinks.

> Wouldn't this be better:
>
> -  		if (to_tempfile) {
> -  			strcpy(path, ".merge_link_XXXXXX");
> -  			fd = mkstemp(path);
> +  		if (to_tempfile || !trusk_symlink_fmt) {
> +			if (to_tempfile) {
> +	  			strcpy(path, ".merge_link_XXXXXX");
> +				fd = mkstemp(path);
> +			} else
> +				fd = create_file(path, 0666);
>
> Hmm?

Sure; it amounts to the same, but is shorter.

-- Hannes
