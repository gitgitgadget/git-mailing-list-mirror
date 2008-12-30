From: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>
Subject: Re: is there an easier way to do this ?
Date: Mon, 29 Dec 2008 20:26:49 -0800
Message-ID: <3ab397d0812292026j2feedf50tdbaa0109f89543f7@mail.gmail.com>
References: <gjc52u$ehc$4@ger.gmane.org> <gjc5t2$g02$4@ger.gmane.org>
	 <8c9a060812292000k18ccd466g628ea4161bac188b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Zorba <cr@altmore.co.uk>
To: "Jacob Helwig" <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 05:28:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHWDS-0005Kz-LM
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbYL3E1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYL3E1E
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:27:04 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:32432 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbYL3E1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 23:27:01 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3988744qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 20:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VBv4aBRJhLXz85qa1YbKCtFBQzkq3MgR9uc9ZzZPQOQ=;
        b=uollUH5qQUsnHA5WazzYz/9HoWhZ0rpK7Qaj7RCwP2m8HVwontOJAmyRQ1u6XgVWXP
         O9NEGfuTfzJxARfWP1VAf/4VP6qnVvew3dMWMmVMUt2PL9NMQoZcS2oD1eeki4N/XbG1
         8ZYY9Fmd42QIf3RJxFqAVqJ8/AXszhnAeMpYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dkXfxVnPUJuUBcQOM1d/omyeDMjWDL31oFzFn4ldBBRvbTM+CiZzL2rcx2EyrcV4Gj
         Z3ApGMK0YxxzhWmmeTwAzgwyzyX1iJabsSR2c4CWaFHNOOIRhX2hJdNUtVsbDojdcy3m
         S7chwcxoMZDjPuZDTODHt6bSykmbsBMtROuts=
Received: by 10.214.183.19 with SMTP id g19mr11983536qaf.72.1230611209682;
        Mon, 29 Dec 2008 20:26:49 -0800 (PST)
Received: by 10.215.41.3 with HTTP; Mon, 29 Dec 2008 20:26:49 -0800 (PST)
In-Reply-To: <8c9a060812292000k18ccd466g628ea4161bac188b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104156>

$ git add .
$ git commit -a

no, you don't need git commit -a, just git commit

so,

$ git add .
$ git commit -m "my msg"

why?

git add . will add everything to the index, including a notation about
removing deleted files (i hope you know what the index is, if not,
google 'index' or 'staging area', this will clear everything up).

git commit will take everything from the index and commit (not the
working tree of files) it to the actual repository.

git commit -a will take every file that is already tracked in git, but
NOT newly added files, and add/update the content in the index, then
commit it.

so, git commit -a is equivalent to

git add -u
git commit



On Mon, Dec 29, 2008 at 8:00 PM, Jacob Helwig <jacob.helwig@gmail.com> wrote:
> On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
>> The manual shows you can SHOW untracked files, but not add them as part of
>> the commit -a jig
>>
>> Seems a bit strange that git-add operates on both exisging and new files
>> when used standalone, but its behaviour changes when encapsulated in
>> commit -a...
>>
>> So, I thought maybe $ git commit -a, then $ git add .
>> but then the files tracked have missed the commit boat they were meant to be
>> on, haven't they,
>>
>> hang on -
>> what about
>>
>> $ git add .
>> $ git commit -a
>>
>> I do believe I've cracked it
>> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded
>> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>>
>> "Zorba" <cr@altmore.co.uk> wrote in message
>> news:gjc52u$ehc$4@ger.gmane.org...
>>> ok, now I'm in this for real, archiving versions of our website project
>>> (5k files approx)
>>>
>>> so here is the workflow:
>>>
>>> - copy version 1 files into GIT dir
>>>
>>> - open git bash
>>>
>>> $ git init
>>>
>>> $ git add .
>>>
>>> $ git commit -m "version1"
>>>
>>> all vanilla ? cool
>>> next job = store version 2, so delete version 1 files from GIT dir, copy
>>> in version 2
>>> version2 has different files from 1 - which ones? Out of 5k files could be
>>> 1% = 50 new ones, and same amount removed. Why should I care, with such a
>>> powerful friend as git around, n'est pas?
>>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to pick up
>>> any files that have been REMOVED (or "deleted" in git-speak)
>>>
>>> $ git commit -a -m "version2"
>>>
>>> BUT this does not pick up any new ones that have been added,
>>>
>>> and when we run
>>>
>>> $ git status > ../git_status.txt
>>>
>>> these are referred to as "untracked files"
>>> only problem there are 50 ish
>>> is there not another flag on git commit to treat any untracked file as a
>>> new file ?
>>> (would save me typing or creating a list out of these untracked ones and
>>> feeding them into git add)
>>>
>>> I know, I realise now I should have looked up git-commit in the manual -
>>> in case its not there, pls enlighten me !
>>>
>>>
>>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> If you do an explicit git add, then you don't need the -a on git
> commit, since everything you want to commit will already be in the
> index for git commit to work with.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
