From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 14:19:23 -0400
Message-ID: <AANLkTindiOoy-4W5DJ9AGa8q29Tsm9P8K_4TEgRfmJW=@mail.gmail.com>
References: <90e6ba53a8a0a88e46048cee6566@google.com>
	<AANLkTinDPa7ngcTEfYC8k2O3hwkYszEUsb3pZqnuOSo2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 20:19:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgM5L-00021J-5O
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 20:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757392Ab0HCSTZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 14:19:25 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61490 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0HCSTY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 14:19:24 -0400
Received: by qyk7 with SMTP id 7so397001qyk.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4G2ceNV4jukzewcpBvTDmk7qCRdftmxtQEG+olKYlrc=;
        b=nExKjkyq4VFcQYceLY8px7OlUjjiQJRpr+ZeoZPa7HNszRZi0A4/b8v2bWpxcaBLP+
         TSh++Nk0pRfq2mOV7hBGhJcX6jehPYRQEjyLC7ApwCMXGJ+NtJvVagtJjRSkN/FPLSLw
         8MUX3Eg9C96DyakE6B2+UhhNCw7hPTK4mu0Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dDxdQPgv0lu6z6rvi8oUSa/uJBuzqzfONR3Urtv4ZkPQiONmgt3g14I2cxifLzRRoH
         khaTVZ2pOEkh7/KF6d52pb0YIwNyMk8VAqpSs5B85sWPXqrOC8H/fe2uB47F+InzOqJ8
         vKyhbB8l8bpduBiEZ6Y3d+F5yolvG1aiPGQZE=
Received: by 10.224.2.147 with SMTP id 19mr3005338qaj.60.1280859563997; Tue, 
	03 Aug 2010 11:19:23 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Tue, 3 Aug 2010 11:19:23 -0700 (PDT)
In-Reply-To: <AANLkTinDPa7ngcTEfYC8k2O3hwkYszEUsb3pZqnuOSo2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152531>

On Tue, Aug 3, 2010 at 1:49 PM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Tue, Aug 3, 2010 at 19:10, =C2=A0<Euguess@gmail.com> wrote:
>> The command you provided is not giving any error messages in one of =
the
>> repositories which shows incorrectly.
>>
>> As for URL - unfortunately it cannot be done as all the code is on c=
losed
>> LAN
>
> Ok. Try the following:
>
> 1) make sure caching is disabled in /etc/cgitrc (nocache=3D1)
> 2) find the repo.url setting for the troublesome repo in /etc/cgitrc
> 3) run `PATH_INFO=3D$BAD_REPO_URL /path/to/cgit.cgi 1>cgit.html 2>cgi=
t.log`
> 4) check if cgit.html is ok - if so, your problem is probably due to
> stale cache entries which could be caused by permission problems or
> stale *.lock files in /var/cache/cgit
> 5) check cgit.log for any errormessage - if there's errors but they
> don't make any sense to you, try repeating step 3 but run cgit under
> either strace or gdb.
> 6) please report the results of this experiment ;)
>
> --
> larsh
>

I have disabled cache: i have nocache=3D1 (we are working without cache
yet,  cache-size set to 0, but for the experiment i commented this
out)
We are using scan mode as we have central folder to store our repos.
So I switched off the scanmode by commenting the scan-url out from
cgitrc

Now when i'm trying to generate the html for the repo in question i
get html where it says "no repositories found". It is obviously not
picking up the PATH_INFO

The command is like this:
$ PATH_INFO=3D/home/users/gitrepouser/repos/subfolder/repo.git
=2E/cgit.cgi 1>cgit.html 2>cgit.log

Usually, we are scanning the folder /home/users/gitrepouser/repos/
cgit.log is empty so far


Thanks,
Eugene
