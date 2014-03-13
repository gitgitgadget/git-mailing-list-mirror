From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Thu, 13 Mar 2014 18:45:06 -0400
Message-ID: <CAPig+cS9n64boSSgoK-z=V9QFkvr=1Z2Db5KRrsyZNDthDE27A@mail.gmail.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
	<CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
	<xmqqr466hrru.fsf@gitster.dls.corp.google.com>
	<CAPig+cQU5__EPA2C3QvCPAT4od3Ux8kCgq-2H8nCddGdNqaG0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 23:45:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOENI-0001iH-7y
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 23:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbaCMWpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 18:45:08 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:42499 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbaCMWpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 18:45:07 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so1794020yhz.8
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 15:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7U4UWsHK4BPKQFTJjZvY+Ix5g4pi5cd6+zSz/u3RAoE=;
        b=cMWiC/5u9gRxdlOyyQjFTsoCtlUR6ooIu2y70PxqjqZmR7+DgL8K2YMyh67PwUwgfG
         w1nfNMTzRbM7pCxs+r9xJV/KoxReqXYFZEL4n7uhcF7bKp90lQBEbmAGu6z9sH/y5SUw
         6RarlAJ49GXbaEK/JnaUprGGVU4M2tEQ1RbnocNvDPtQy+Tjeqsb7CcPZ2deeVC7sU8q
         4zeZ4PHq6+C9IAXX5qTIwkP5n/mdcTfYTlc4XhoPrlAjTzc9tL2VGbCyC5D5t8iC9SH1
         80Zq6HbpKaiSPTqGYJR2Ceh9rkG8/wiQ35JrCRVEdpvjqRUstHoeRgZY6pW2KhqC5Aef
         oGFA==
X-Received: by 10.236.122.99 with SMTP id s63mr6038124yhh.19.1394750706213;
 Thu, 13 Mar 2014 15:45:06 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 13 Mar 2014 15:45:06 -0700 (PDT)
In-Reply-To: <CAPig+cQU5__EPA2C3QvCPAT4od3Ux8kCgq-2H8nCddGdNqaG0A@mail.gmail.com>
X-Google-Sender-Auth: c_4HiCFg5VT-qrgcDyiRna9BN9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244059>

On Thu, Mar 13, 2014 at 4:35 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> A more table-driven approach might look something
> like this:
>
>     struct M { const char *s; const char **a1; const char **a2; }
>     message[][2][2] = {{{
>         { "Branch %s set ... %s ... %s", &shortname, &origin },
>         ...
>     }},{{
>         { "Branch %s set ... %s", &remote, NULL },
>         ...
>     }}};
>
>     const struct M *m = message[!remote_is_branch][!origin][!rebasing];
>     printf_ln(m->s, local, *m->a1, *m->a2);

Of course, using NULL in the table like that would crash when
dereferenced: *m->a2. It was just an quick example typed on-the-fly.
Real code would want to be more careful.
