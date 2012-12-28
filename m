From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: git diff --ignore-space-at-eol issue
Date: Fri, 28 Dec 2012 21:33:24 +0100
Message-ID: <CALWbr2zSe6GEy=_7SXqRocKwhXauXmP7eMMmDur4Vg7npqBPyg@mail.gmail.com>
References: <BLU163-W40634B340214076467C88ECF360@phx.gbl>
	<CALWbr2y3BdqcD-62jhPSQsK3U=8-Dc=R-jxg8H0yqpgVfdHJXw@mail.gmail.com>
	<BLU163-W51DAB90003C969CDF837A2CF3F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: John Moon <johnmoon77@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 21:33:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Togci-0006N4-Te
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 21:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab2L1Ud1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 15:33:27 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54529 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501Ab2L1Ud0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Dec 2012 15:33:26 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so5480470eek.33
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5ByjZ/yaw9NRcFonqYYWWmKbOo6l0OM928JstHH/rGU=;
        b=kfixr2UPrj+Qrm3uGsh810y3jtWZrKiNo23AtsGhA3pRtMrgYWNS4yqL/nB6sVFhEo
         rM7tTD/m6o2Q4JiAJI+HJoctKN8apVsFDAEruqoJWii1Xb4zZASihjnjVAQvd27pTN2+
         i+IkGtCKcj2Rr4cCaxt6maCVbKuCbrONgb5/BdtEgaawB4KGQHcIR8UUm6kmm/q4TQ4v
         JMyiLeEh0KSeBLgXXdzM34y9pFz8GIafZ19v9GXwM6kxlzbviNM4tD1u5nWxsxTdodD4
         Q5Ck6+krG9N83RAvWWriu6E/9zU1oMzIVxXnwOO4xBn6Vh5qZPNMLLpGWPBg+o1iURlW
         yktw==
Received: by 10.14.225.72 with SMTP id y48mr88240118eep.46.1356726805013; Fri,
 28 Dec 2012 12:33:25 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Fri, 28 Dec 2012 12:33:24 -0800 (PST)
In-Reply-To: <BLU163-W51DAB90003C969CDF837A2CF3F0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212257>

Then you should give the output of diff --stat, and he will be able to
ignore files with no changes.

The change was originally made for permission changes. diff --stat
needs to show files have changed even though, indeed, there is no diff
output.

You could also use --numstat and filter out files with no changes
(starting by 0 0).

On Fri, Dec 28, 2012 at 8:59 PM, John Moon <johnmoon77@hotmail.com> wrote:
>
>
>> $ git diff --ignore-space-at-eol test.txt
>> $ git diff --ignore-space-at-eol --stat test.txt
>> test.txt | 0
>> 1 file changed, 0 insertions(+), 0 deletions(-)
>> $ git diff --ignore-space-at-eol --name-status test.txt
>> M test.txt
>>
>> The idea is that even though diff doesn't show any differences, stat,
>> shortstat, numstat and name-status reports the file as being changed.
>> This is available since v1.8.1-rc0.
>
> Thanks for the info.  Unfortunately it's not what i would expect.
> If i told git diff specifically to ignore line endings, why is --name-status  showing me a file as being modified when the only modification is the very thing i told it to ignore.
> The same thing for --stat, why is it showing me a file with zero changes?  Just my opinion though.
>
> I'll tell you why this is a problem for me, basically what i am doing is running the "git diff --ignore-space-at-eol --name-status "  on my root directory to give to someone else who is not using git to give them the files that i have modified.  I don't want to give them a file where only the line ending has changed.
>
> Cheers.
