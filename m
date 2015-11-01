From: Atousa Duprat <atousa.p@gmail.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sat, 31 Oct 2015 23:41:17 -0700
Message-ID: <CA+izobuGFGhho9X6xGdXMskay3UH6-FuzriNA7=mkveFjo0SBA@mail.gmail.com>
References: <CA+izobsBmYHHepYka795K2VnVLYBmN2tFqEyzSweMoS9gvuRVw@mail.gmail.com>
	<1446243122-21464-1-git-send-email-apahlevan@ieee.org>
	<xmqqa8r0j8tu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 07:41:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsmKn-0003yG-G8
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 07:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbbKAGlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 01:41:18 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36203 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbKAGlS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 01:41:18 -0500
Received: by ykba4 with SMTP id a4so112441333ykb.3
        for <git@vger.kernel.org>; Sat, 31 Oct 2015 23:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7nN/hNu1liJVYW4TRUT9QLeGeBUQCNf3mIpaLe0xLyM=;
        b=H/4cdvgkwj3zf598Rq8WRLLhriNP7tPmN03XbMipjH1mS63eqMoAAtmu64KvZdXXAk
         1bl0VeRfxSBzwqgSgcghLbUgvH1PuR1Q400re56rb1ehoVO4SSygbKxtVWbhFji7A3NQ
         74tYHwEEQg12/fylaFJa7QOD76YZhSWjtFwxsRJd83Lk8irf9MqgNzvhXctx/MgYRldJ
         VKJh/3UxgrUhEBAu4DblYk3tG2NwUbdAIkLyLvQgnuZ/2LsYGbwI5WrnfO7hMpyu84HR
         HaiVIfHjF3QxYTiFNQy3EIysfYcUHC7whEhc3dKsZ4dVRrnDu5+3t18A6sZtqmTRYFGx
         bMRw==
X-Received: by 10.13.251.193 with SMTP id l184mr12039036ywf.342.1446360077515;
 Sat, 31 Oct 2015 23:41:17 -0700 (PDT)
Received: by 10.37.91.198 with HTTP; Sat, 31 Oct 2015 23:41:17 -0700 (PDT)
In-Reply-To: <xmqqa8r0j8tu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280609>

>> +int git_SHA1_Update(SHA_CTX *c, const void *data, size_t len)
>> +{
>> +     size_t nr;
>> +     size_t total = 0;
>> +     char *cdata = (char*)data;

> I am not sure about the cast
> here, though.  Doesn't the function SHA1_Update() you are going to
> call in the body of the loop take "const void *" as its second
> parameter?  That's how openssl/sha1.h and block-sha1/sha1.h declare
> this function.

Indeed, the declaration needs a const void *; but I need to advance by
a specific number of bytes in each iteration of the loop.  Hence the
cast.

Atousa
