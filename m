From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Sat, 23 Mar 2013 21:00:05 -0700
Message-ID: <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com>
References: <20130321110338.GA18552@sigill.intra.peff.net> <20130321111333.GD18819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 05:01:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJc7G-0001oK-OT
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 05:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742Ab3CXEA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 00:00:28 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36607 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab3CXEA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 00:00:28 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so9537533lab.30
        for <git@vger.kernel.org>; Sat, 23 Mar 2013 21:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=22cHes9ySUM9IPP9xIqZKHQMypdfiU3Wo/wSU5xmQiY=;
        b=yMaAJS4oo+nFrN7PkGim+ZdeamnnCx/5gJF5S8tatT6GaDX6NAKAPEci93CH8NElnx
         L9PyWPl0oCerkQqkxPQvak/SfkGBHjyjza1jx+9gH1nPxx9J9PVJe2dIONLfbNgNp3IG
         qv1/jlc7ROVsb1TN3K2vKIa+fZa4W/ZF0bit6c8oGV5Tku6BWrlWFKIp/AGfNULMqtm2
         CdqGhQF2s1k8wKJnVEDdVLdeMFIvI2a9S+I4Qxp30P11G3HjCx3duk+feijJMLqiIEbd
         zpG/CFoKa2ul/Bv7piwBCVfFzdqh6iIIZQtLXnFLaBWr2COYteksiT31bG9lpZKvxYdC
         1cnw==
X-Received: by 10.112.20.68 with SMTP id l4mr3678849lbe.58.1364097626408; Sat,
 23 Mar 2013 21:00:26 -0700 (PDT)
Received: by 10.112.46.169 with HTTP; Sat, 23 Mar 2013 21:00:05 -0700 (PDT)
In-Reply-To: <20130321111333.GD18819@sigill.intra.peff.net>
X-Google-Sender-Auth: MyoI0M4Av7o4APocGG6QCuG6Sc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218931>

On Thu, Mar 21, 2013 at 4:13 AM, Jeff King <peff@peff.net> wrote:
>
> According to 47ec794, this initialization is meant to
> squelch an erroneous uninitialized variable warning from gcc
> 4.0.1.  That version is quite old at this point, and gcc 4.1
> and up handle it fine, with one exception. There seems to be
> a regression in gcc 4.6.3, which produces the warning;
> however, gcc versions 4.4.7 and 4.7.2 do not.
>

transport.c: In function 'get_refs_via_rsync':
transport.c:127:29: error: 'cmp' may be used uninitialized in this
function [-Werror=uninitialized]
transport.c:109:7: note: 'cmp' was declared here

gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3


Sigh...
