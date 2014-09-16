From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v14 01/11] trailer: add data structures and basic functions
Date: Tue, 16 Sep 2014 10:01:11 +0200
Message-ID: <CAP8UFD3wi2KCZhDAF7vqMpb72DbLMbHNDiDGi0tFLW+vzsQqSA@mail.gmail.com>
References: <20140915052330.26573.34823.chriscool@tuxfamily.org>
	<20140915053142.26573.86374.chriscool@tuxfamily.org>
	<xmqqsijs4o02.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 10:01:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTnhN-0008OY-Ky
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 10:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbaIPIBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 04:01:13 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59792 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbaIPIBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 04:01:12 -0400
Received: by mail-ie0-f175.google.com with SMTP id at20so5752363iec.6
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 01:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x3DDmbqS8tWmTYVb+B1ZCSyYeH4xLsipMWHLHJMqNxw=;
        b=C6hd7fRqOsEJazamcnbC/PSYlHli6QT4T7hdifxPPh41b0+b5Xx6TAIVE+c6hIW7KD
         e9InwkMDervskqF0AR1un9JPanSxYYuoqBVtTgCdCyV6DrawxKVpIYB/Rgoz96UomY6N
         MzTqw6rm4LD2KC7xbh0pWluMCXh/LUcE9INOX0VmqKfI8UV4p5dOne7MDrjyHvukJfXg
         KHXGCLN0LkTTkp2ybzW+/jdCu2EDwHnEkgx98Gj6CB5zbFPrpE03VCE0pe4C051C8C3V
         LNa4nPHUazTqzBm5Pl+nxsXsryBour1nwPRWpvG/bjNcXnPh4pU7w572msiBEpG26C1i
         W5nQ==
X-Received: by 10.51.17.66 with SMTP id gc2mr28516785igd.40.1410854471796;
 Tue, 16 Sep 2014 01:01:11 -0700 (PDT)
Received: by 10.50.250.179 with HTTP; Tue, 16 Sep 2014 01:01:11 -0700 (PDT)
In-Reply-To: <xmqqsijs4o02.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257127>

On Mon, Sep 15, 2014 at 10:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> +/* Get the length of buf from its beginning until its last alphanumeric character */
>
> That makes it sound as if feeding "abc%de#f@" to the function returns
> 3 for "abc", but

For me the last alphanumeric character in "abc%de#f@" is "f", so it is
the length from the beginning to "f" so it should return 8.

>> +static size_t alnum_len(const char *buf, size_t len)
>> +{
>> +     while (len > 0 && !isalnum(buf[len - 1]))
>> +             len--;
>> +     return len;
>> +}
>
> doesn't it look at '@', be unhappy and decrement, look at 'f' and
> break out to return the length of "abc%de#f"?

Yeah, that's the expected behavior.

> Perhaps that behaviour _is_ what you want, but then the comment is
> lying, no?

I don't think so, but maybe you are parsing the comment in a different
way than I am.
What would you suggest instead?

Thanks,
Christian.
