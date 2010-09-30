From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] Add bidirectional_transfer_loop()
Date: Thu, 30 Sep 2010 08:55:02 -0500
Message-ID: <20100930135502.GG4850@burratino>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Sep 30 15:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Jet-0007Pc-KO
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 15:58:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab0I3N6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 09:58:11 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61731 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123Ab0I3N6K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 09:58:10 -0400
Received: by eyb6 with SMTP id 6so728588eyb.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 06:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lMj9/YliCNOUd3PtDnb6KQJ9LA/phE2Y3+EEEa5ghCg=;
        b=oBg21NEskoC+F+8dtIrvl++X0FPvoUXuxXtP6+60KWAxDnpqdQfcN5y4oCoX5PKvtj
         maue8guHEE7BEWMUKJtmtnTJknoaTz8ju0vgEEgB0qQynD2TIXCIm99p5dLgPqrRcmRD
         mEWL8JaNpHZtOJRBVOyfXz5AnE8uWjpFFwkpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DdYnXVTZiZyi4p+YwpTfwjQCMyOy0E7Lwul9oOGKJcai9Iruap3HLZVYfVwl1lpoyH
         HmRLFRXCXBkNaNT1HYYMVb3tk//94sgu75+TXCgjmavyU2w+pZ//yqLtbjgSdtgCxfqY
         82C/Y5/SxaBnkFjZqd5Nt6F++ErgAdhTwa/tI=
Received: by 10.103.192.9 with SMTP id u9mr1788741mup.130.1285855088952;
        Thu, 30 Sep 2010 06:58:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r4sm4511301faa.19.2010.09.30.06.58.06
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 06:58:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285847579-21954-2-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157669>

Ilari Liusvaara wrote:

> --- a/transport-helper.c
> +++ b/transport-helper.c
[...]
> +	if (!in_hup && inbufuse < BUFFERSIZE) {
> +		stdin_index = nextindex++;
> +		polls[stdin_index].fd = 0;
> +		transfer_debug("Adding stdin to fds to wait for");

Why not:

		trace_printf("trace: adding stdin to ...");

?  That would give the user control of where tracing output goes
(settings like GIT_TRACE=17).

If trace is too noisy (I don't think it is), maybe we should
make it more nuanced, like GIT_TRACE=17:transport?
