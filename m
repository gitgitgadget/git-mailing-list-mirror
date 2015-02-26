From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Thu, 26 Feb 2015 20:10:38 +0700
Message-ID: <CACsJy8D6nAt3fMw=oh5mwUwfAJKViN1pk9pf9gZSBGyquU_WBQ@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 14:11:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQyDn-0000RV-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 14:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbbBZNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 08:11:10 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45393 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753909AbbBZNLI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 08:11:08 -0500
Received: by iecat20 with SMTP id at20so14696704iec.12
        for <git@vger.kernel.org>; Thu, 26 Feb 2015 05:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pDFw/XfYZu9i8RSC8Ts5uuQX+d3bvntUSazmqMuM3jQ=;
        b=jSzWTUVdYInm+neYux1AM015jBsfyev7dI7W7Ef82XMbzYbjp5REgEUb1FGeljGXbw
         xT3V3ZcG1pNreNdTMoE5yY8pQ86D/KyrBS9cK5ivi4uBNPyzu3yxk+PLKmwhyKUj6N0A
         rvcTEAVCVy1IbF9wDxteGKtm0VXqevfzBbVun7vlI1W3/jbDNvL0hskcUt6OjlkFpUbf
         vLIJhHSppaoh3HiBUac+P5IWTpMOKLeyYi31W2NpWoTv/gy7F4AVoXURgN3PQ96Cwd1P
         vHUUQSegj64GMzMfPhhSVInmpZ1PCIby0d754pMjuqy3uHT63NjCIfU/oH0RlaPUog4f
         uJdA==
X-Received: by 10.50.118.97 with SMTP id kl1mr11308676igb.23.1424956268203;
 Thu, 26 Feb 2015 05:11:08 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Thu, 26 Feb 2015 05:10:38 -0800 (PST)
In-Reply-To: <20150218191417.GA7767@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264439>

On Thu, Feb 19, 2015 at 2:14 AM, Jeff King <peff@peff.net> wrote:
> Where I really need help now is in the "ideas" page:
>
>   http://git.github.io/SoC-2015-Ideas.html

Is this too ambitious for a summer? I suspect the answer is yes, but anyway..

Due to http limitations and stateless decision, a lot of data is sent
back and forth during have/want negotiation for smart-http. I wonder
if we could implement the "long polling" scheme in a CGI program. The
program terminates HTTP requests and recreates a full duplex
connection for upload-pack to talk to the client. upload-pack falls
back to the normal mode, used by git:// and ssh://.

An example of this is BOSH [1]. From a quick glance it does not seem
to require any special thing, so it's unlikely to cause problems with
firewalls, proxies.. If this is implemented as cgi (instead of http
server), we'll need to save session infos somewhere. I suppose shm
with proper locking is enough.

[1] http://xmpp.org/extensions/xep-0124.html
-- 
Duy
