From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/2] Re: run-command: write full error message in die_child
Date: Wed, 20 Apr 2011 05:33:19 -0500
Message-ID: <20110420103319.GA6027@elie>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <7v4o5v8dlp.fsf@alter.siamese.dyndns.org>
 <20110419070510.GB28291@elie>
 <4DAE8E66.5060705@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 12:33:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCUj1-0001KZ-E9
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 12:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab1DTKd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 06:33:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42261 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab1DTKd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 06:33:27 -0400
Received: by iwn34 with SMTP id 34so481939iwn.19
        for <git@vger.kernel.org>; Wed, 20 Apr 2011 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=el3A5xgeAP+JsBYSHdJHIrfk8xaNy9396bCm2uLudcQ=;
        b=xqa+2dfbkEqZQqSGZEMJ7C17S1LfNv4vLfrxX+hPtJOXVxDB0+eraaZS4h23iwOOlx
         83/1swMWhTLde4BuzOqRVYvChYcRPMdxdBHDTzYAhMUxD/893LkyGRGTQO0ZqDURMWZF
         CjwMgA44WXbDcxxqqSfhYelD5mpe08dZTcJCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tDfibtec6G60+1gzh/N7hjCMiaI0WrhsVrP6Q4bOKy73oCR0h4Slckaih9rCC/3nqs
         tyyQT5J6L+AzlfDNYf8lzp5/BH4OXChltSVDZi3zFEcUGR4lgtkET1h/HGL9DhkuQS6q
         kn+Q4BX7XKIgi8lDSGSSN39MXdBrFCskic7V0=
Received: by 10.42.155.73 with SMTP id t9mr244659icw.456.1303295606371;
        Wed, 20 Apr 2011 03:33:26 -0700 (PDT)
Received: from elie (adsl-69-209-64-141.dsl.chcgil.ameritech.net [69.209.64.141])
        by mx.google.com with ESMTPS id vr5sm295467icb.12.2011.04.20.03.33.23
        (version=SSLv3 cipher=OTHER);
        Wed, 20 Apr 2011 03:33:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DAE8E66.5060705@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171855>

Johannes Sixt wrote:

> Unfortunately, on Windows, the bash spawnd by git converts LF to CRLF...
[...]
> ... therefore, we fail here. Can we have this squashed in, because 'cat'
> leaves LFs alone?

Thanks for catching this...

[...]
> I did not check whether
> SANITY is really needed; I trust you did.

... and this.  No, SANITY is not needed.

Here's a reroll, on top of v1.7.5-rc3~2 (Revert "run-command: prettify
-D_FORTIFY_SOURCE workaround", 2011-04-18).  It even applies on maint
this way (not that anyone would need that :)).

Jonathan Nieder (2):
  tests: check error message from run_command
  run-command: handle short writes and EINTR in die_child

 run-command.c          |   15 +++++++++------
 t/t0061-run-command.sh |   23 +++++++++++++++++++++++
 test-run-command.c     |    2 ++
 3 files changed, 34 insertions(+), 6 deletions(-)
