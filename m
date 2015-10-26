From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v1] git-p4: Add option to ignore empty commits
Date: Mon, 26 Oct 2015 20:40:02 +0000
Message-ID: <562E8FA2.9050507@diamand.org>
References: <1445280239-39840-1-git-send-email-larsxschneider@gmail.com> <56273197.3010505@diamand.org> <F77F291C-89D1-48B6-9E9F-AD7220CE0141@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:40:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoYt-00065g-Jy
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbbJZUkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:40:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34656 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbbJZUkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:40:03 -0400
Received: by padhk11 with SMTP id hk11so198396108pad.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=G5T1xecV9Qcwq8dTfUyIESe0pxkkdm0c2qGFTuTVqBs=;
        b=V9PG5jS2DEbzfe2dt2/w7epR8CFqtyeU+riLvtkUI7Tnscs2VvAyV9g1Y37h2Yv8xd
         ESlyX8E96Hj5+XJOul76KPzvwcycIPBZ5gSIYIuIR2lbT0H8hwhF0zawKSStPw48mxw1
         BSlssJ21OmixiHRlo8nmJg1xiDCXww9L5kpJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G5T1xecV9Qcwq8dTfUyIESe0pxkkdm0c2qGFTuTVqBs=;
        b=ALZtGNYjfXyJio7qgLnLEQC82HIWjkjqWbFFaRdMnzY2hwtOfIKRxR13CPY0FEBBqP
         VKCzatp638zxR4anA54mhi8BGdcPbYrDDw4UCn9StRsff1rMh7jWUzILHoBdnwrMV4iM
         IMlAtgQMjT1GcEBBpDZmJUJm3FDxtxqEU0GIPeM8H94rXhRoi6LQRbjwt6qylFZ7FU03
         +0Q7zHiQKVYTHrAmcHWtey1kEPAwn4OyD1mOSD0YI6BZXDRFLq/X1x/ZhljzQjbEvpli
         tg3KZdsWLjuY1TEXyw6kRyjGUl8E7YdEu31FXQQTOp3mhs7jazjva17FpOLp+rv+48XR
         +6fg==
X-Gm-Message-State: ALoCoQkdRbu/OlT5wcN3DVpJAQ2Ll4xo0Gb7TZVBD23g6dlMUlqmBYH2v9Wik6otItaNusHvxeqj
X-Received: by 10.68.130.74 with SMTP id oc10mr24325046pbb.159.1445892002579;
        Mon, 26 Oct 2015 13:40:02 -0700 (PDT)
Received: from [192.168.245.128] (cpc12-cmbg17-2-0-cust914.5-4.cable.virginm.net. [86.30.131.147])
        by smtp.gmail.com with ESMTPSA id ux3sm35625764pac.18.2015.10.26.13.40.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 13:40:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <F77F291C-89D1-48B6-9E9F-AD7220CE0141@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280223>

On 24/10/15 19:08, Lars Schneider wrote:
>
> On 21 Oct 2015, at 08:32, Luke Diamand <luke@diamand.org> wrote:
>
>> On 19/10/15 19:43, larsxschneider@gmail.com wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>
>> This seems to be adding a new function in the middle of an existing function. Is that right?
> That is true. I could move these functions into the P4Sync class if you don't like them here. I added them right there because it is the only place where they are used/useful.

It just seemed a bit confusing, but I'm ok with them here as well.

>
>
>>
>>> +            if not self.clientSpecDirs:
>>> +                return True
>>> +            inClientSpec = self.clientSpecDirs.map_in_client(path)
>>> +            if not inClientSpec and self.verbose:
>>> +                print '\n  Ignoring file outside of client spec' % path
>>> +            return inClientSpec
>>
>> Any particular reason for putting a \n at the start of the message?
> I did this because "sys.stdout.write("\rImporting revision ..." (line 2724) does not add a newline. However, I agree that this looks stupid. I will remove the "\n" and fix the "Import revision" print. Speaking of that one: this is only printed if "not self.silent". Is there a particular reason to have "self.silent" and "self.verbose"? Should we merge the two?

self.silent and self.verbose seem like two slightly different things. I 
would expect silent to prevent any output at all. But actually it doesn't.

If we wanted to implement it properly, I think we'd need a new function 
(p4print?) which did the obvious right thing. Maybe something for a 
rainy day in the future.

>
>
>>
>> Also, could you use python3 style print stmnts, print("whatever") ?
> Sure. How do you prefer the formatting? Using "format" would be true Python 3 style I think:
> print('Ignoring file outside of client spec: {}'.format(path))

Will that breaker older versions of python? There's a statement 
somewhere about how far back we support.

> OK?
>
>>
>>> +
>>> +        def hasBranchPrefix(path):
>>> +            if not self.branchPrefixes:
>>> +                return True
>>> +            hasPrefix = [p for p in self.branchPrefixes
>>> +                            if p4PathStartsWith(path, p)]
>>> +            if hasPrefix and self.verbose:
>>> +                print '\n  Ignoring file outside of prefix: %s' % path
>>> +            return hasPrefix
>>> +
>>> +        files = [f for f in files
>>> +            if inClientSpec(f['path']) and hasBranchPrefix(f['path'])]
>>> +
>>> +        if not files and gitConfigBool('git-p4.ignoreEmptyCommits'):
>>> +            print '\n  Ignoring change %s as it would produce an empty commit.'
>>> +            return
>>
>> As with Junio's comment elsewhere, I worry about deletion here.
> I believe this is right. See my answer to Junio.
>
>
>>> +
>>>           self.gitStream.write("commit %s\n" % branch)
>>>   #        gitStream.write("mark :%s\n" % details["change"])
>>>           self.committedChanges.add(int(details["change"]))
>>> @@ -2403,7 +2412,7 @@ class P4Sync(Command, P4UserMap):
>>>                   print "parent %s" % parent
>>>               self.gitStream.write("from %s\n" % parent)
>>>
>>> -        self.streamP4Files(new_files)
>>> +        self.streamP4Files(files)
>>>           self.gitStream.write("\n")
>>>
>>>           change = int(details["change"])
>>> diff --git a/t/t9826-git-p4-ignore-empty-commits.sh b/t/t9826-git-p4-ignore-empty-commits.sh
>>> new file mode 100755
>>> index 0000000..5ddccde
>>> --- /dev/null
>>> +++ b/t/t9826-git-p4-ignore-empty-commits.sh
>>> @@ -0,0 +1,103 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='Clone repositories and ignore empty commits'
>>> +
>>> +. ./lib-git-p4.sh
>>> +
>>> +test_expect_success 'start p4d' '
>>> +	start_p4d
>>> +'
>>> +
>>> +test_expect_success 'Create a repo' '
>>> +	client_view "//depot/... //client/..." &&
>>> +	(
>>> +		cd "$cli" &&
>>> +
>>> +		mkdir -p subdir &&
>>> +
>>> +		>subdir/file1.txt &&
>>> +		p4 add subdir/file1.txt &&
>>> +		p4 submit -d "Add file 1" &&
>>> +
>>> +		>file2.txt &&
>>> +		p4 add file2.txt &&
>>> +		p4 submit -d "Add file 2" &&
>>> +
>>> +		>subdir/file3.txt &&
>>> +		p4 add subdir/file3.txt &&
>>> +		p4 submit -d "Add file 3"
>>> +	)
>>> +'
>>> +
>>> +test_expect_success 'Clone repo root path with all history' '
>>> +	client_view "//depot/... //client/..." &&
>>> +	test_when_finished cleanup_git &&
>>> +	(
>>> +		cd "$git" &&
>>> +		git init . &&
>>> +		git p4 clone --use-client-spec --destination="$git" //depot@all &&
>>> +		cat >expect <<-\EOF &&
>>> +Add file 3
>>> +[git-p4: depot-paths = "//depot/": change = 3]
>>> +
>>> +Add file 2
>>> +[git-p4: depot-paths = "//depot/": change = 2]
>>> +
>>> +Add file 1
>>> +[git-p4: depot-paths = "//depot/": change = 1]
>>
>> Could you not just test for existence of these files?
> Well, I assume the right files are in there as this is covered with other tests. I want to check that these particular commits are mentioned in the logs (including the commit message and the change list number).
>
>
>> If the format of the magic comments that git-p4 ever changes, this will break.
> I understand your reasoning. But how can I check for the correct commit messages, change list number and their order in a efficient different way?

Fair enough!

>
>

Thanks!
Luke
