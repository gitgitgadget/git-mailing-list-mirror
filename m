From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Mon, 5 Aug 2013 22:32:05 +0200
Message-ID: <CALWbr2zNEzcEdEGYpZYfsYSXyJyjV4J23O6=cqYD7RDJMXOxRw@mail.gmail.com>
References: <1375733541-9099-1-git-send-email-apelisse@gmail.com>
	<CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 22:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6RRt-0005LT-D3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab3HEUcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 16:32:08 -0400
Received: from mail-qa0-f52.google.com ([209.85.216.52]:38612 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab3HEUcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 16:32:07 -0400
Received: by mail-qa0-f52.google.com with SMTP id bq6so1220952qab.18
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 13:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=50ZW8CQgVKX0n2ev1SZ83tFTSHpNvyHdx1k7dk/wV4Q=;
        b=Bb9GejGV8ETapmgmpyByfWxmQNRR/1j7RLMEf6mnkcbqNslsLe9UZxle+tyvlyzhZ4
         uC7ijj3bEjoPl9Bd3w1UK2iHZtNbusGCC42Lr8zvhCxDY2UHE9LQDjJ6MizphCnX1y39
         IOakQfwTuYtxWgn6CRZG2Avbu0G0NJDt7p8jjYEpJqZLN/R457NM1lmefopxTD1nYTDT
         KUoRXMmqhblICDaCiSraJcPM9JulhTPv/cR2hMCKbEfxc7xMO+EW+hQathADHi32vD6y
         flgzBmo88DhTND7ZDTWlmCgZIfPVfLK2Cs2iAExUzSdrIs3Kbh1vfKrP6iKQH5RFt5iY
         Y1lA==
X-Received: by 10.229.183.3 with SMTP id ce3mr3550090qcb.70.1375734725730;
 Mon, 05 Aug 2013 13:32:05 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Mon, 5 Aug 2013 13:32:05 -0700 (PDT)
In-Reply-To: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231702>

On Mon, Aug 5, 2013 at 10:30 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Mon, Aug 5, 2013 at 3:12 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
>>     $ git clone hg::~/my/repository && cd repository && git fetch
>>
>> Fix that by using python os.path.expanduser method.
>
> Shouldn't that be the job of the shell? (s/~/$HOME/)

I guess it is, as long as it looks like a path:

    $ echo ~
    /home/myuser
    $ echo hg::~
    hg::~
