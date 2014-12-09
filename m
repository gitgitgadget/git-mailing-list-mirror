From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/7] parse_color: refactor color storage
Date: Tue, 9 Dec 2014 15:56:27 -0500
Message-ID: <CAPig+cRBxN4arhdW87d6EmM_=CNP3qQv3v1NmA4B6gMBDVn=0g@mail.gmail.com>
References: <20141120151418.GA23607@peff.net>
	<20141120151704.GD23680@peff.net>
	<54875825.7060008@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Scott Baker <bakers@canbytel.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRpg-0003uV-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbaLIU42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:56:28 -0500
Received: from mail-yk0-f172.google.com ([209.85.160.172]:61618 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaLIU41 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:56:27 -0500
Received: by mail-yk0-f172.google.com with SMTP id 131so629508ykp.31
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 12:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m/BKTifnpSWaWNey5xSm2ZJCt5yRVuZH1go7j9W9tX0=;
        b=pk+/0Fj6TsaW/Kjy99BzFlw9LODyPHZELsqfOAMCYarK5vSLVQRihqHmjGHDv1mUcF
         Lbxb6FXNC5AW4/urfbPGqz0k88Ncw0DEdkP4jVI1Sgn7Ta3GQbVxOt0yXrukvnusqsdK
         KhRH3VajNhPR3kKMosPagero5gpum7PoudvrbuNhf4e1SCIT9NP/3FStQkykbfZTbZcJ
         N2mjwfYrzIb7eg45bi4QjMCrElogOEmYd4csmGMZZyct5XO1Aj1VXGfjn10Had3AdJNX
         cvyrCVi2lV6WPLKTyuz+6gov+EFoNeAgK9W21Tnn6fbcdesDTci/hwtH4CQ4+kikFuon
         zTrw==
X-Received: by 10.170.42.151 with SMTP id 145mr357800ykk.74.1418158587205;
 Tue, 09 Dec 2014 12:56:27 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 9 Dec 2014 12:56:27 -0800 (PST)
In-Reply-To: <54875825.7060008@kdbg.org>
X-Google-Sender-Auth: XSYLNoYFaECj8cOY2vWeV4XOihc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261167>

On Tue, Dec 9, 2014 at 3:14 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 20.11.2014 um 16:17 schrieb Jeff King:
>> +#define COLOR_FOREGROUND '3'
>> +#define COLOR_BACKGROUND '4'
>
> This (COLOR_BACKGROUND) causes an ugly redefinition warning on Windows,
> because we inherit a definition from a Windows header. How would you
> like it fixed? A different name or #undef in front of it?

One way this sort of problem was handled in the past was the sanitize
the preprocessor namespace [1].

[1]: https://github.com/git/git/blob/master/compat/mingw.h#L80
