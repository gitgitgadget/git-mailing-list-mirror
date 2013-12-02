From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] send-email: set SSL options through IO::Socket::SSL::set_client_defaults
Date: Mon, 2 Dec 2013 16:14:09 +0530
Message-ID: <CALkWK0nn867+3+cToc=QMyA0u+0oPJkq+nmB1T3DP+kiiwb72Q@mail.gmail.com>
References: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
 <c5308d5ffb34b70cbfea5a39e08902904fac1400.1385938050.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Dec 02 11:44:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnQzm-0001y6-N0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 11:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab3LBKou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 05:44:50 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:52186 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab3LBKou (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 05:44:50 -0500
Received: by mail-ie0-f173.google.com with SMTP id to1so19864155ieb.4
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 02:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ocSrOTeYua5qMYP9Dsv/ASGYEaN4JOrM7qxQedSG87Y=;
        b=bWtu6P4M82IaU3XSUyowZyRkmy2s1wJXPTtPCLXzFG8RSvhc4ll6LMfm8chinglQHJ
         UKU4L16tbmZYYq0frdB4AJBB3URMtGgDTnUMMK8gXy6ZaT55oaUwdKLmnJdbmV01EH4k
         6YQk48o+w19qYE9oXEzi4ZUTaeM5Ja83KU+RIU8TMlT2uYAgajQUZwSJWo1aVMD6Gxsv
         0QLn6AUIdzUnYvJuZqImXGbJnc1nXLaaGXOLU/4a+/BaJ7iSlKATDm6gqjOWXXPusQNi
         RjIhsaTbGIFy98+CUAYsBj/gRBaFsFmaTuS0Z6MxS+gDfjNQmTGKPJF7VMxrok9CAEO0
         sfwg==
X-Received: by 10.50.66.180 with SMTP id g20mr4457664igt.29.1385981089715;
 Mon, 02 Dec 2013 02:44:49 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Mon, 2 Dec 2013 02:44:09 -0800 (PST)
In-Reply-To: <c5308d5ffb34b70cbfea5a39e08902904fac1400.1385938050.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238624>

Thomas Rast wrote:
> When --smtp-encryption=ssl, we use a Net::SMTP::SSL connection,
> passing its ->new all the options that would otherwise go to
> Net::SMTP->new (most options) and IO::Socket::SSL->start_SSL (for the
> SSL options).
>
> However, while Net::SMTP::SSL replaces the underlying socket class
> with an SSL socket, it does nothing to allow passing options to that
> socket.  So the SSL-relevant options are lost.

Both [1/3] and [2/3] look good. However, I'm curious about this one:
Net::SMTP::SSL inherits from IO::Socket::SSL, where new() is defined.
In the documentation for IO::Socket::SSL,

  $ perldoc IO::Socket::SSL

I can see examples where SSL_verify_mode and SSL_ca_path are passed to
new(). So, I'm not sure what this patch is about.
