From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] am: invoke perl's strftime in C locale
Date: Tue, 15 Jan 2013 17:42:12 +0100
Message-ID: <CALWbr2w+q5=Z8__g+J_s2NtTMgziHrntFqsi8vCJyvfO2qi81A@mail.gmail.com>
References: <20130114205933.GA25947@altlinux.org>
	<20130115155953.GB21815@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 15 17:42:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv9as-0001OW-GD
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 17:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab3AOQmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 11:42:14 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:38905 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab3AOQmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 11:42:13 -0500
Received: by mail-qa0-f42.google.com with SMTP id hg5so2523861qab.8
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uFNrgoVKwct5tHGDBnuQrDrS7+odwzWQqhog3cKLlQs=;
        b=psv8yW/OaqT2Z1aRcBGNMg5SiPe2SXCD7UxUuYW1xbCXipT7hOS/08ofqJNmfI/WfX
         6rZmYLGJIY2XUaHvTxSjUE5dhLQ7SJlke3etnnXLSfa9jKY9jLQhBSGHe9JBaZxnHUzf
         gKcGAfPRgX/7vKfJhUV1jKLc9vPjb1OT188fBgnYkoaHt15HKUD9aXMurHwDtDL+tMHf
         dVlGxOrvD19uE9WAJRiJ81dfVFxSlOzoPyKh1LkyUeNj0CoRv2ZvZZcGrZF3g9gB94Xy
         r3KGa07gXkk/ItseOzY++cUGsY6Dn2JwTYlAXl+y1shyqtM4tAAtXh0tk3zxvmyh3eHC
         trIA==
Received: by 10.49.62.39 with SMTP id v7mr88466450qer.15.1358268132765; Tue,
 15 Jan 2013 08:42:12 -0800 (PST)
Received: by 10.49.11.233 with HTTP; Tue, 15 Jan 2013 08:42:12 -0800 (PST)
In-Reply-To: <20130115155953.GB21815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213646>

> This puts all of perl into the C locale, which would mean error messages
> from perl would be in English rather than the user's language. It
> probably isn't a big deal, because that snippet of perl is short and not
> likely to produce problems, but I wonder how hard it would be to set the
> locale just for the strftime call.

Maybe just setting LC_TIME to C would do ...

>From locale(7) man page:

       LC_TIME
              changes  the behavior of the strftime(3) function to
display the current time in a locally acceptable form; for
              example, most of Europe uses a 24-hour clock versus the
12-hour clock used in the United States.
