From: David Holmer <odinguru@gmail.com>
Subject: Re: [PATCH] gitk: Fix how remote branch names with / are drawn
Date: Wed, 13 Apr 2016 14:19:39 -0400
Message-ID: <CAE8SKAMgZzyzoiy4JsqONN4wVWgVq-YmMn1+j2ZtELx+wJ1xEQ@mail.gmail.com>
References: <1460512743-27100-1-git-send-email-odinguru@gmail.com>
	<CANoM8SXixymz3=NQWgG5vSo7XDNh18_OzrNXU4+Y8CQ0LkB6sw@mail.gmail.com>
Reply-To: OdinGuru@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 20:19:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqPOD-0007M7-By
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 20:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbcDMSTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 14:19:41 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35591 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbcDMSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 14:19:40 -0400
Received: by mail-qk0-f181.google.com with SMTP id o6so22551520qkc.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 11:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc;
        bh=iNisstipEgbMkJv1dJGH1egttWA2r7XPOtHhq3Bh+/s=;
        b=GvRanBD19WiaexRYkY1j0Ta9YvMVzBHRnvJ8q1PLhaL8QtUqVn6DNtSW2fexsgtMxf
         2GukH3kBPZBA0FsLHlk+l0WafNHKgzi8EyE9bHIYqfrkV2+3ox4zgbXK1BqUPbIYBq4e
         U/ybjITlYvkvGiMTPZQUa9Wa+cGixfYYT/0v6UHVjaFHqk3TJ6xfn1DZ+Szs+t94xHZg
         jqMJM1mC1pAzWEHMH9w3p0nUYWHEIOZBoLPqM6J5o4/mBRgkIytO/Y1RC11ZopUlr48y
         ww2L7adKoIfRgiRPOmZ+TisoUHBseByrlqfLs2d+5zEMbCGdabs2Old0ECZZFfHSIYNV
         GRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc;
        bh=iNisstipEgbMkJv1dJGH1egttWA2r7XPOtHhq3Bh+/s=;
        b=YecXtoFVlaboYzNjsXrWZIqyGTpNj2zuECrq/0mLJeYe7tvQ3L715FYifnWUPbzOBv
         Px/ekAIy3BgXXzKWQVlrtH0D1OzzGvNEhYtklC4khfidO9cUYEoubVuoIWTAHJl3+Pop
         18bucc+IdTvNpplV0H34UEDPx68ZiZB4DsmsfdOQ7/I+MIWJd+E3qwfefrLlgAq3Ann4
         R91D3IWlqqMxhKOmZhzgtVDRbsucc/kK49dJu4hvV/JV4VA86F21KoCQF0Y43g1CXB+Y
         ScBGahweuT30hGYKhnmHf1MzMAohd15Wu61wKekbmeGrXw/iVynmupYbTvmjcO5nkp3x
         EejQ==
X-Gm-Message-State: AOPr4FWbxPLwgr6buW7Q91jG6OPOeGXI9ctiQEjU2RCP2mgy27hFEN7fSOQk6RBwX6DN/DWfD5v+1mwj9kvtGA==
X-Received: by 10.55.72.148 with SMTP id v142mr13262055qka.102.1460571579509;
 Wed, 13 Apr 2016 11:19:39 -0700 (PDT)
Received: by 10.55.100.87 with HTTP; Wed, 13 Apr 2016 11:19:39 -0700 (PDT)
In-Reply-To: <CANoM8SXixymz3=NQWgG5vSo7XDNh18_OzrNXU4+Y8CQ0LkB6sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291473>

I agree that this switches the issue around and that a remote with a
'/' in the name would be miss colored in the same way a branch with a
'/' in the name is miss colored now. However, I would guess that
branches with '/' are MUCH MUCH more common than remotes with '/', so
like you say "this is a better state than the present". A "complete"
solution would take iterating through the list of remotes and matching
the explicit whole pattern (e.g. match
"remotes/my/remote/with/slashes/" for remote "my/remote/with/slashes")
but I doubt that is worth it for 99.9% of people.

The alternative regex that you are asking about is either using some
syntax I am not familiar with or isn't quite correct. I'm most
familiar with grep command line format, so perhaps tcl regex is
different.

The original code does the equivalent of this:

~$ echo "remotes/origin/dev/test1" | grep -o "remotes/.*/"
remotes/origin/dev/

The issue is that the '.*/' part is greedy in that it will match all
the way up to and including the last /

My solution was to change the . to [^/] which means "any character but
/". This stops the match at the first / after the remote name starts:

~$ echo "remotes/origin/dev/test1" | grep -o "remotes/[^/]*/"
remotes/origin/

The alternative you suggested with '.*?/' doesn't seem to work with grep:

~$ echo "remotes/origin/dev/test1" | grep -o "remotes/.*?/"
(no output, i.e. does not match)


Thank you.

On Wed, Apr 13, 2016 at 7:35 AM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Tue, Apr 12, 2016 at 9:59 PM, David Holmer <odinguru@gmail.com> wrote:
>> Consider this example branch:
>>
>> remotes/origin/master
>>
>> gitk displays this branch with different background colors for each part:
>> "remotes/origin" in orange and "master" in green. The idea is to make it
>> visually easy to read the branch name separately from the remote name.
>>
>> However this fails when given this example branch:
>>
>> remotes/origin/foo/bar
>>
>> gitk displays this branch with "remotes/origin/foo" in orange and "bar" in
>> green. This makes it hard to read the branch name "foo/bar". This is due
>> to an inappropriately greedy regexp. This patch provides a fix so the same
>> branch will now be displayed with "remotes/origin" in orange and "foo/bar"
>> in green.
>>
>> Signed-off-by: David Holmer <odinguru@gmail.com>
>> ---
>>  gitk | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/gitk b/gitk
>> index 805a1c7..ca2392b 100755
>> --- a/gitk
>> +++ b/gitk
>> @@ -6640,7 +6640,7 @@ proc drawtags {id x xt y1} {
>>             set xl [expr {$xl - $delta/2}]
>>             $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
>>                 -width 1 -outline black -fill $col -tags tag.$id
>> -           if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
>> +           if {[regexp {^(remotes/[^/]*/|remotes/)} $tag match remoteprefix]} {
>>                 set rwid [font measure mainfont $remoteprefix]
>>                 set xi [expr {$x + 1}]
>>                 set yti [expr {$yt + 1}]
>> --
>
> This likely fixes the problem for most situations, but doesn't for a
> remote with a '/' in the name.  Yet, I think this is a better state
> than the present.
>
> Is the regex `[^/]*/` more efficient than '.*?/`?  Or do you find the
> former more readable?
