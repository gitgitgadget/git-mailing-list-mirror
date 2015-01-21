From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: .gitattributes on branch behaves unexpected. Should it be more stateless?
Date: Wed, 21 Jan 2015 13:45:19 -0000
Organization: OPDS
Message-ID: <F0A5C841474A4CEEB51C8F8487357189@PhilipOakley>
References: <CAGJ-DzH0meYgpE8My+UW4wbTxs6vo=wrgo0o21Lzh5Hg38ibEQ@mail.gmail.com><B551DC4135DC4DA3B8BA5E1BBA36BBEC@PhilipOakley> <CAGJ-DzFos0DHNettfSHp0HfCGKqC8agvqELezi6HLqWpob5f_g@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Max W" <max.w.7777777@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:36:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE14e-0008QP-1E
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:36:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922AbbAUTgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:36:16 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:37257 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753494AbbAUTgO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2015 14:36:14 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An0/ADj/v1ROl3l0PGdsb2JhbABbJ4JfUliDB4QXvlodCoVrAQMBAYEoRAEBAQEBAQUBAQEBOCAbhAcFAQEBAQIBCAEBGRUWCAEBIQsCAwUCAQMVBQIFIQICFAEEGAIGBwMUBggLCAIBAgMBCgIBA4d3AwkMCb1/hlOJLQ2FAYEhiG6DQIFIEQFQgm8ugRMFjllRgnaGZDaCRopdgz2EED4xAYELgTcBAQE
X-IPAS-Result: An0/ADj/v1ROl3l0PGdsb2JhbABbJ4JfUliDB4QXvlodCoVrAQMBAYEoRAEBAQEBAQUBAQEBOCAbhAcFAQEBAQIBCAEBGRUWCAEBIQsCAwUCAQMVBQIFIQICFAEEGAIGBwMUBggLCAIBAgMBCgIBA4d3AwkMCb1/hlOJLQ2FAYEhiG6DQIFIEQFQgm8ugRMFjllRgnaGZDaCRopdgz2EED4xAYELgTcBAQE
X-IronPort-AV: E=Sophos;i="5.09,443,1418083200"; 
   d="scan'208";a="540164474"
Received: from host-78-151-121-116.as13285.net (HELO PhilipOakley) ([78.151.121.116])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 21 Jan 2015 19:35:55 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262765>

Please, no top posting. It breaks the discussion flow.
From: "Max W" <max.w.7777777@googlemail.com>
> Hi philip,
>
> thanks for your reply.
>
>> You don't say which parts you believe should be identical, nor why.
> I expected my representation to be identical, nevertheless what path
> I have taken to come there. e.g.
> git clone -b <branch>
> git clone; git checkout <branch>
> should result in a binary-indentical representation of the files
> tracked by git. But they don't.

Don't forget that some of the EOL setting are also in the git config 
file(s) [global, system, local] so there may be differences from them.

Use 'git cat-file' to get the plumbing level view of the cannonical 
object content.

I am prtesuming that the ONLY differences you are seeing are end of line 
conversion changes for checkout. Is that correct.

Are there other whitespace changes happening? Is that on the way into 
the repo (git add). There are some white space settings available.

The other aspect maybe language coding settings (utf8, iso...., cp-..., 
etc).

Or is it even more than that? (Your first email suggested it was just 
line endings)

The discussion may be better helped on the googlegroups git-users forum 
git-users@googlegroups.com if this is more of a 'getting started with 
Git' problem.

>
> Why did I expect this? Good question. Feels more intuitive for me.
> Like "don't worry what you have done before. When your HEAD is on a
> certain commit, git will make sure all your files in your filesystem
> are they way you (and the other committers) want them to be".
>
>> [..]
>> Does that help?
> Yes, it helped me to distinguish better between data and 
> representation.
> New understanding: .gitattributes determines how to represent data.
>
> As .gitattributes is under git control there can be 2 versions of
> .gitattributes in 2 branches. So I can tell git
> - on branch foo with gitattributes * eol=LF show me all files with LF
> - on branch bar with gitattributes * eol=CRLF show me all files with 
> CRLF
> But this doesn't work. The representation of the files is
> determined/depending on how I cloned or fetched the repo. A "git 
> checkout
> bar" does not change the representation.
>
> Does this help to show where my concerns / my issue is?
>
> Best Regards,
> Max
>
>
>
> 2015-01-17 14:16 GMT+01:00 Philip Oakley <philipoakley@iee.org>:
>>> Hi,
>>>
>>> I am asking myself if git and .gitattributes should be more 
>>> stateless?
>>> i.e.
>>> whatever you have done before is irrelevant, when you reach status 
>>> XYZ
>>> with your
>>> git repo, it is EXACTLY and BINARY the same all the time and 
>>> everywhere.
>>>
>>> It took some time for me to figure out, that depending on HOW you 
>>> clone,
>>> the
>>> resulting local repo may differ. I did not expect this. I assumed 
>>> that
>>> when I
>>> clone, it is a clone (meaning: 100% identical). And that the things 
>>> I have
>>> done
>>> in my local repo before, don't have any relevance at all.
>>>
>>
>> You don't say which parts you believe should be identical, nor why.
>>
>> Internally Git can represent its object store in many ways based on 
>> some
>> objects being 'loose' and some objects being 'packed'. However both 
>> styles
>> of representation are of the same base objects and their contents.
>>
>> Then we have external OS representation, in particular the end of 
>> line
>> representations between the three main OS types Win/Mac/'nix. Git 
>> gives
>> _you_ the ability the use any of these representations for the same 
>> base
>> objects. Thus the object file with text "Hello World/EOL/Goodbye 
>> World" will
>> have three different binary representations once you export them to 
>> the
>> selected file system type (according to you .gitattributes settings).
>>
>> If you always select LF endings for text files (both on the way in 
>> and on
>> the way out of the repo), then you will get identical files on the 
>> different
>> clones. Git has many settings for personalisation.
>>
>> Does that help?
>>
>>>
>>>
>>> ** How to reproduce **
>>> 1) create a repo, add a file with LF ending, add a .gitattributes 
>>> telling
>>> git to
>>>   do a CRLF conversion
>>> 2) clone the repo
>>> 3) on brach development, change .gitattributes to LF
>>> 4) clone again
>>> 5) clone again, directly onto the branch development (git clone -b)
>>>
>>>
>>> ** Expected result, (I) **
>>> clone 2) and original repo 1) are bytewise identical
>>>
>>> ** Actual result (I) **
>>> clone 2) and original repo 1) differ, 1) has LF, 2) has CRLF
>>> as I have been warned before, I am (more or less) fine/OK with this
>>>
>>>
>>> ** Expected result, (II) **
>>> - clone without -b (4) and clone with -b (5) are bytewise identical
>>> - I would have expected, that whatever I do, as soon as I have a 
>>> clone and
>>> I am
>>>  on branch "development", my file should be LF
>>> - I would have expected, that HOW you clone is irrelevant
>>>
>>> ** Actual result (II) **
>>> without -b (4) I have a CRLF file on my disk. with -b (5) I have a 
>>> LF file
>>> on my
>>> disk. The clones are not bytewise indentical. It appears as if the
>>> .gitattributes in branch development does not have any reliable 
>>> effect.
>>>
>>>
>>>
>>> A potential solution might be be that
>>> - checkout
>>> - commit (a modified .gitattribues)
>>> - <further git commands>
>>>  do change the files in the local repo.
>>> As of now my understanding is that this is not how .gitattributes 
>>> (or
>>> .gitignore) are designed. .gitattributes only has influence on
>>> pushing/fetching.
>>>
>>> I don't know if and which side effects would occur if this design 
>>> would be
>>> changed. Hence I am glad to hear any feedback on the issue described
>>> above. And
>>> yes, I agree that this is a minor issue and that all .gitattribute 
>>> things
>>> are
>>> kind of edge cases.
>>>
>>> Thanks and with best regards,
>>> Max
>>>
>>>
>>>
>>>
>>>
>>>
>>> 1)
>>> mkdir git-bug-or-feature
>>> cd git-bug-or-feature
>>> git init
>>> echo "foo.bar eol=crlf" > .gitattributes
>>> echo "hello world" > foo.bar
>>> git add .
>>> git commit -m "now crlf"
>>> # [master (root-commit) 7f3f6b0] now crlf
>>> # warning: LF will be replaced by CRLF in foo.bar.
>>> # The file will have its original line endings in your working 
>>> directory.
>>> file foo.bar
>>> # foo.bar: ASCII text
>>> cd ..
>>>
>>> 2)
>>> git clone git-bug-or-feature git-bug-or-feature_clone
>>> cd git-bug-or-feature_clone
>>> file foo.bar
>>> # foo.bar: ASCII text, with CRLF line terminators
>>> cd ..
>>> rm -rf git-bug-or-feature_clone
>>>
>>> 3)
>>> cd git-bug-or-feature
>>> git branch development
>>> git checkout development
>>> echo "foo.bar eol=lf" > .gitattributes
>>> git add .
>>> git commit -m "now lf on branch development"
>>> file foo.bar
>>> # foo.bar: ASCII text
>>> git checkout master
>>> file foo.bar
>>> # foo.bar: ASCII text
>>> cd ..
>>>
>>> 4)
>>> git clone git-bug-or-feature git-bug-or-feature_clone
>>> cd git-bug-or-feature_clone
>>> file foo.bar
>>> --
>>
>> philip
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
