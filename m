From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-branch: only traverse the requested refs
Date: Thu, 11 Oct 2007 00:00:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102358110.4174@racer.site>
References: <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com>
 <1192053283-2351-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 01:00:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfkXd-0001Ay-3k
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 01:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbXJJXA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 19:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756648AbXJJXA2
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 19:00:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:57662 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756645AbXJJXA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 19:00:27 -0400
Received: (qmail invoked by alias); 10 Oct 2007 23:00:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 11 Oct 2007 01:00:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+XGTZLcc6XaXHjfhXlpRFkOM/rpvSS78SiZ6/nW8
	n4j/2g20lWg3Ki
X-X-Sender: gene099@racer.site
In-Reply-To: <1192053283-2351-1-git-send-email-hjemli@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60563>

Hi,

On Wed, 10 Oct 2007, Lars Hjemli wrote:

> This avoids looking at every single file below .git/refs when git-branch 
> is fetching the list of refs to display.
> 
> [...]
>
> +	if (kinds & REF_LOCAL_BRANCH) {
> +		ref_list.kinds = REF_LOCAL_BRANCH;
> +		for_each_branch_ref(append_ref, &ref_list);
> +	}

The function for_each_branch_ref() calls do_for_each_ref(), which in turn 
calls get_loose_refs(), which calls get_ref_dir() to read all loose refs, 
if they have not yet been read.

So I think that your patch (unfortunately) will no help Han-Wen's 
situation.

Ciao,
Dscho
