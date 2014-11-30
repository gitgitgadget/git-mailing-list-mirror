From: Pol Online <info@pol-online.net>
Subject: Re: git status / git diff -C not detecting file copy
Date: Sun, 30 Nov 2014 10:30:10 +0900
Message-ID: <CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Sun Nov 30 02:30:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XutL8-0007DZ-Or
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 02:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbaK3BaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2014 20:30:12 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:41961 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbaK3BaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2014 20:30:11 -0500
Received: by mail-qc0-f174.google.com with SMTP id c9so6153688qcz.19
        for <git@vger.kernel.org>; Sat, 29 Nov 2014 17:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pol-online.net; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j0tL7kMCo5rzFjjD4jIMMOJCM/iMoflr08jL95OXW0c=;
        b=R9dAZ4Oue5aViAxl3Y25kB517WPN7eyn3Et7bdo6X4O6qyPWNh3BqD603qNCPLfKF6
         I9PodAKJf0betbzsm7Y3b5GMIKHSahyGdVDpX1gtnThOd/Wf0YN3tzVxsPSoZEqNY+IU
         q8jmJrVyC0+dRVPIUFJVQuDCK1O6NPNqVR+Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=j0tL7kMCo5rzFjjD4jIMMOJCM/iMoflr08jL95OXW0c=;
        b=T3caJRvMDMW2mPCTmOmx72HtNYh6VWL1cHGXPPE3kg2zldNJ1u9CrXADLDITqj9oio
         2TLV83iH+q2nLr8Wy0WtNR+X3tQEnx+AXmLU+67PlKlakx/JBtZTlu3gIcIWvXZn/nLu
         j/r1wINJ1BBueOw3PNr27mxO7GQixc+1TB5q6u9QHy7+YQnuVQmgZtnk63q9TCJf6Lrn
         N0C4MPE54t4e7SWcXIXXHRiJRPuaFSJZn/1jBQJAeR0jQNzbFIs62tBPRC4DCxgjHIYq
         ReudY7yUMuTI5k8bNviorHdiRxgM0QmC5kn9+J1xRlKyv45Tczdph7grAGnNTv29JKcR
         70VA==
X-Gm-Message-State: ALoCoQmYl4+M6vKKCrec+aB653TJ8H606yuPqiLIAccFRY/i4HBo/6wPeROIw/I3Nypy4m07pvsN
X-Received: by 10.140.40.104 with SMTP id w95mr75178954qgw.14.1417311010188;
 Sat, 29 Nov 2014 17:30:10 -0800 (PST)
Received: by 10.140.97.5 with HTTP; Sat, 29 Nov 2014 17:30:10 -0800 (PST)
X-Originating-IP: [221.186.131.72]
In-Reply-To: <CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260383>

Hi Bryan,

OK that explains the behavior of git diff, but what about git status?
The doc implies it should be able to detect copies in the index /
staging area since it has a "C" state.

- Pol

On Sun, Nov 30, 2014 at 10:03 AM, Bryan Turner <bturner@atlassian.com> wrote:
> Pol,
>
> By default, -C only finds copies when the source file was also
> modified in the same commit. Since you did not modify hello.txt in the
> same commit where you copied it to copied.txt, it will not be
> considered.
>
> If you pass -C -C (twice), or use --find-copies-harder, Git will
> consider all files in the repository. Note that this can be slower,
> which is the reason why it's not the default.
>
> The documentation for git diff describes the -C (--find-copies) and
> --find-copies-harder flags and their limitations.
>
> Hope this helps,
> Bryan Turner
>
> On Sun, Nov 30, 2014 at 11:35 AM, Pol Online <info@pol-online.net> wrote:
>> Hi,
>>
>> The documentation for git status at http://git-scm.com/docs/git-status
>> implies that it should be able to detect both renames and copies (with
>> the R and C states). The command git diff -C should do it as well.
>>
>> However I can't get either to detect copies in this simple test case -
>> what is happening?
>>
>>
>> mkdir test
>> cd test/
>> git init
>> echo 'Hello World!' > hello.txt
>> echo 'Goodbye World!' > goodbye.txt
>> git add -A
>> git commit -m "Initial commit"
>>
>> cp hello.txt copied.txt
>> mv goodbye.txt moved.txt
>> git add -A
>>
>> $ git status --short
>> A  copied.txt  <------------ NO COPY DETECTED
>> R  goodbye.txt -> moved.txt
>>
>> $ git diff -M -C --summary --cached
>>  create mode 100644 copied.txt  <------------ NO COPY DETECTED
>>  rename goodbye.txt => moved.txt (100%)
>>
>> $ git commit -m Test
>> $ git diff -M -C --summary HEAD~
>>   create mode 100644 copied.txt  <------------ NO COPY DETECTED
>>   rename goodbye.txt => moved.txt (100%)
>>
>>
>> -Pol
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
