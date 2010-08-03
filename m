From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 19:49:34 +0200
Message-ID: <AANLkTinDPa7ngcTEfYC8k2O3hwkYszEUsb3pZqnuOSo2@mail.gmail.com>
References: <90e6ba53a8a0a88e46048cee6566@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Euguess@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 03 19:49:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgLcl-0003v2-4b
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 19:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457Ab0HCRtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 13:49:46 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64329 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429Ab0HCRth (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 13:49:37 -0400
Received: by fxm14 with SMTP id 14so2100000fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=FGAmwpZjKeEINOgiM6Q680R7GByauuFhq8hyfPOCwow=;
        b=ZHCTuZQKMFMOfvKHcwy5gvCeYAEX7Mmoc1hdMBiSs0OAKONmpXyfVxXL5Oqi98JBQi
         gNuVoBz4BvwGhw/9AR1FDWMUiMyuuHtbcsAnErQb1Xrnsj8iQ9ySw2FF/GQXtuwm7d1k
         KCouXzSXfAIc50As6f0i1mAZIRmw06GyCm2ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iX1at7oWUQLag7LWOlASp3/SqpMG7512s8ULKJ0rlQ62jW0drVKWN4g+F5Rf5zav97
         ZljDeQgpo1MtgdlzCX8dsOli96k5GgLKtF7AZ3CsQLQIdrK7qYkt0Nh7Qjrpi/ZQZ4Nv
         cLkwKEklMZ1wsdENfZhD1eYdvHShKTVVIEGVA=
Received: by 10.239.172.129 with SMTP id a1mr387714hbf.38.1280857774818; Tue, 
	03 Aug 2010 10:49:34 -0700 (PDT)
Received: by 10.239.165.79 with HTTP; Tue, 3 Aug 2010 10:49:34 -0700 (PDT)
In-Reply-To: <90e6ba53a8a0a88e46048cee6566@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152530>

On Tue, Aug 3, 2010 at 19:10,  <Euguess@gmail.com> wrote:
> The command you provided is not giving any error messages in one of the
> repositories which shows incorrectly.
>
> As for URL - unfortunately it cannot be done as all the code is on closed
> LAN

Ok. Try the following:

1) make sure caching is disabled in /etc/cgitrc (nocache=1)
2) find the repo.url setting for the troublesome repo in /etc/cgitrc
3) run `PATH_INFO=$BAD_REPO_URL /path/to/cgit.cgi 1>cgit.html 2>cgit.log`
4) check if cgit.html is ok - if so, your problem is probably due to
stale cache entries which could be caused by permission problems or
stale *.lock files in /var/cache/cgit
5) check cgit.log for any errormessage - if there's errors but they
don't make any sense to you, try repeating step 3 but run cgit under
either strace or gdb.
6) please report the results of this experiment ;)

--
larsh
