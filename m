From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 3/3] merge-recursive: Tolerate missing file when HEAD
 is up to date
Date: Fri, 24 Jan 2014 15:02:34 -0500
Message-ID: <CA+gQCGGRw7cTKH3zgPrsCWzMOs+FQZwt2xHU8FV-0s5x3QNZUw@mail.gmail.com>
References: <CABPp-BGAsrrjcZxVirzKU_VEyUM1U=4TFj18CieKKE7==c7v2A@mail.gmail.com>
	<cover.1390574980.git.brad.king@kitware.com>
	<5e5bfe752655c39fca626811972af9d0a90ddab9.1390574981.git.brad.king@kitware.com>
	<xmqq8uu5rwfk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, newren@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mxt-0003mK-4V
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaAXUCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:02:40 -0500
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:57497 "HELO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751582AbaAXUCk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 15:02:40 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]) (using TLSv1) by na3sys009aob104.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUuLG32u9P1TUatMdI2PLH1wYfUjyHp1R@postini.com; Fri, 24 Jan 2014 12:02:39 PST
Received: by mail-bk0-f54.google.com with SMTP id u14so1453961bkz.27
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 12:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=5Dovuq7uUiHaA5uHYW8SPsWvV5n4myL5fByuo5WDPMI=;
        b=lONNP9mWrRJBnRj5/y2g3bROBs8zxZgFXhkJJUNDPiZ1OghGirZv+n4AMAMTvExVKs
         LkoqQw/wAvjoqFfHCI2u27Tq/whteiF7Gg1t39z9SyvlSs0LpfXUbRlYchTzuBk/jQ5U
         JUDiYD6nohYyDFbfqmCRETAJ8/zY9GR6iNOWJts87bq84H2pH7VyA554ijdeLsLJTCuB
         nlv2mMYaztezK6ND3zB/H65vtzE1UZOSv0XeEbTqyIA7d/At3QJOeWIrQB34Yg8CaVr+
         BHPWzVnvhaD+f6S8dkUbzZXzTgYU+6eqfPX17+08LWSjRqW4EqVr5y3415kmQrLSc7km
         hhjA==
X-Received: by 10.204.164.203 with SMTP id f11mr7661697bky.50.1390593757188;
        Fri, 24 Jan 2014 12:02:37 -0800 (PST)
X-Gm-Message-State: ALoCoQnkDChdjibFB3nINN+NJNUimS6tf7JVhwGoklZ8xKBbhIPu9j+gjUdWzq2zNKR4+Op87DS/9MnoUAqKZxTD5qJtETiDEdSzWuYQyW7FevYZLfTN7+axZ53/zdigar1UOhPEc6VHUpG5QS37mKEDXFqS8jmxNQ==
X-Received: by 10.204.164.203 with SMTP id f11mr7661493bky.50.1390593754458;
 Fri, 24 Jan 2014 12:02:34 -0800 (PST)
Received: by 10.70.68.168 with HTTP; Fri, 24 Jan 2014 12:02:34 -0800 (PST)
In-Reply-To: <xmqq8uu5rwfk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241027>

On Fri, Jan 24, 2014 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> It somehow feels wrong to force callers of make_cache_entry() to be
> so intimate with the implementation details of refresh_cache_ent()
[snip]
> option bit CE_MATCH_MISSING_OK that asks it to treat a path that is
> missing from the working tree as if it is checked out unmodified.

I came to the same conclusion after reading Elijah's last response.
My next series revision adds an argument to make_cache_entry to
specify the refresh flags and honors REFRESH_IGNORE_MISSING.

Thanks,
-Brad
