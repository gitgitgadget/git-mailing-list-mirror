From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Re: [PATCH v2] mergetools/diffmerge: support DiffMerge as a git mergetool
Date: Sun, 13 Oct 2013 09:27:41 +1100
Message-ID: <CADoxLGM20QRihVLfbg0shdT2QZLjMBqvxy5N=AeLWR_TsTsugA@mail.gmail.com>
References: <1381554070-12241-1-git-send-email-ssaasen@atlassian.com> <CAJDDKr7LgCXjZLzZqKkkUnqt4EGdcA0wvf=uT8KZXba-+q00Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 00:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV7fh-00027w-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 00:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752922Ab3JLW2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 18:28:23 -0400
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43221 "HELO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752839Ab3JLW2X (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 18:28:23 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]) (using TLSv1) by na3sys009aob125.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUlnNBhUs1iMVDSsYZRypCBPLOINBhOAI@postini.com; Sat, 12 Oct 2013 15:28:23 PDT
Received: by mail-oa0-f52.google.com with SMTP id n2so3473379oag.39
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 15:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=z+00wgD2pU8RziYpKXetV6HkQnDxKgw1lYX2JuEHb7Y=;
        b=LzIZEHYoep/OX+Hsdq69SVQM1vcWDnlTDdc1cFGwInluUg443akuubqlC6OROVDwf2
         nZ9uSkhM3gWoknzLkMU6TuRTBZWr0mdpJiSBYkdjoEoMhOMlzhaIt3eLIQ8zk7C0EfKk
         IlZ+/PEzkVGTWCjz+c9avGOHut/1KXxNtDWdK8VYuaQ6IChKWV+P3X0YtSnH/hAWdjos
         OvW/rSvlwr/6V5QwfKYKzpZHJj1xkkJTFwioLP4XGftWxY/lY1iF3oTzItcFYt2wsmz/
         /0A6nj5NMIZ5acAjosyMjnq/Moflm/90GrBm6sOhMfTLJba8HEbUwPteg/oCDc3+xiHk
         8L3Q==
X-Gm-Message-State: ALoCoQk+cS4dd5M2L8/7U6l0q+GFeMfC6Xo55aOjL/kCtYEpqBjQzU7RuGs1uv0Jd4dfhxuTMcW1P2HIGY0+KDYsL9p0mzlFAm5jdQHmDG5UvTvaoKFG868wGxCDuztRFAzfBSlesK/Ca48tLOXEVoVEI/OeMVyQnA==
X-Received: by 10.60.93.67 with SMTP id cs3mr20836228oeb.12.1381616902272;
        Sat, 12 Oct 2013 15:28:22 -0700 (PDT)
X-Received: by 10.60.93.67 with SMTP id cs3mr20836155oeb.12.1381616901162;
 Sat, 12 Oct 2013 15:28:21 -0700 (PDT)
Received: by 10.76.116.72 with HTTP; Sat, 12 Oct 2013 15:27:41 -0700 (PDT)
In-Reply-To: <CAJDDKr7LgCXjZLzZqKkkUnqt4EGdcA0wvf=uT8KZXba-+q00Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236058>

Not a problem. I'll change it to:

tools="$tools gvimdiff diffuse diffmerge ecmerge"
tools="$tools p4merge araxis bc3 code compare"

and send a v3. Thanks for the review David.


On 13 October 2013 06:55, David Aguilar <davvid@gmail.com> wrote:
> Thanks for the re-roll.  We're very close; see below.
>
> On Fri, Oct 11, 2013 at 10:01 PM, Stefan Saasen <ssaasen@atlassian.com> wrote:
>> DiffMerge is a non-free (but gratis) tool that supports OS X, Windows and Linux.
>>
>>     See http://www.sourcegear.com/diffmerge/
>>
>> DiffMerge includes a script `/usr/bin/diffmerge` that can be used to launch the
>> graphical compare tool.
>>
>> This change adds mergetool support for DiffMerge and adds 'diffmerge' as an
>> option to the mergetool help.
>>
>> Signed-off-by: Stefan Saasen <ssaasen@atlassian.com>
>> Acked-by: David Aguilar <davvid@gmail.com>
>> ---
>>  contrib/completion/git-completion.bash |  2 +-
>>  git-mergetool--lib.sh                  |  3 ++-
>>  mergetools/diffmerge                   | 15 +++++++++++++++
>>  3 files changed, 18 insertions(+), 2 deletions(-)
>>  create mode 100644 mergetools/diffmerge
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index e1b7313..07b0ba5 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1188,7 +1188,7 @@ _git_diff ()
>>         __git_complete_revlist_file
>>  }
>>
>> -__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
>> +__git_mergetools_common="diffuse diffmerge ecmerge emerge kdiff3 meld opendiff
>>                         tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3 codecompare
>>  "
>>
>> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
>> index feee6a4..0fcb253 100644
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -250,7 +250,8 @@ list_merge_tool_candidates () {
>>                 else
>>                         tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
>>                 fi
>> -               tools="$tools gvimdiff diffuse ecmerge p4merge araxis bc3 codecompare"
>> +               tools="$tools gvimdiff diffuse diffmerge ecmerge "
>> +               tools+="p4merge araxis bc3 codecompare"
>
> I don't believe "+=" is portable across all POSIX shells.
>
> I tried this on "dash" (which is the default /bin/sh on Debian) and it
> was not understood there.
>
> $ f="1 2 3"
> $ f+=" 4"
> /bin/dash: 2: f+= 4: not found
>
> I think we should stick to the tools="$tools ....." style of concatenation.
>
> Everything else looks good to me.
>
> Thanks,
> --
> David
