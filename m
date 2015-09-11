From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for "Pass graph width to pretty formatting, so '%>|' can work properly"
Date: Fri, 11 Sep 2015 13:19:09 -0700
Message-ID: <xmqqoah8zp36.fsf@gitster.mtv.corp.google.com>
References: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
	<1441993845-25778-1-git-send-email-josef@kufner.cz>
	<CAPig+cRkSRSC0eaBencw8cFrd64sUBQE44aSJ0T2WyPg2JTFCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Josef Kufner <josef@kufner.cz>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 22:19:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaUmy-0002Yp-AX
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 22:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbIKUTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 16:19:12 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34949 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbbIKUTL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 16:19:11 -0400
Received: by pacfv12 with SMTP id fv12so85243961pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 13:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HO/AzTYh9K/DnZZDs7Bt+cU4TWs6JbUjbzukfRAZ10Q=;
        b=xxvmZUhyiPmEdK+f70mimW/b1t4vPjlQhztqyBcLiNtZdpJxHE+IEPtttSn93HBIoE
         4e9T9//XeB1nobeLWBwCi5kbvL8rfQIvfP4NW/bsPD38wpEi5vEGa+B4IZsRQz1XtXwX
         Esl/p9MxheIhBLYohmcGqQvt2OZQ9yAa+8d53sjb7VYpqX6Oi8rixzRdpwNC49+eJI6G
         HrOY/gO/IE6T2vCjUrEKcaXnqDkpbKt4Nyz93fcIC13UhlcDqUBnJfTjwiIW4QODpSc5
         iEhEj2BDu877+xMpg0ZBCm5OnJj0q+sse/D/L4Nf8fsSKvV57Vb6mMdFmMfhY+GGpR3V
         2FdA==
X-Received: by 10.66.142.233 with SMTP id rz9mr1313784pab.23.1442002750598;
        Fri, 11 Sep 2015 13:19:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id uk6sm1950437pac.27.2015.09.11.13.19.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 13:19:09 -0700 (PDT)
In-Reply-To: <CAPig+cRkSRSC0eaBencw8cFrd64sUBQE44aSJ0T2WyPg2JTFCw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Sep 2015 15:37:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277693>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expected &&
>
> You don't seem to be taking advantage of qz_to_tab_space's
> transliteration of Q to tab and Z to space, so s/qz_to_tab_space/cat/
> would make the code clearer.

Don't cat into a pipe unless you are concatenating multiple files,
though ;-).
