From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Mon, 15 Sep 2008 22:05:13 +0200
Message-ID: <200809152205.15388.jnareb@gmail.com>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail> <200809151240.54495.jnareb@gmail.com> <fcaeb9bf0809150701j1161f87gcedef0013a244610@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:06:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKLB-0006s7-5n
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbYIOUFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753960AbYIOUFX
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:05:23 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:33641 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYIOUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 16:05:21 -0400
Received: by gxk9 with SMTP id 9so26004147gxk.13
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 13:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=DUcYBITsnNzfFT0gBUtQS60RskqnZfSJt0dZkEaEAj0=;
        b=Bx2YX56U2RrtUbQxOgiedSQLa+xHT+UDPBIRdazb7p6uaAc7r0tJ1MiTLc1UmmGhIO
         md+SIqKE9d2tftBtxKygP3Ce3nQ1ATHxrN84v1qgb4LyIhvZdD/K8j6Iq2eFzie9zV49
         G81e6mXkGqS9dGCn9oNcPikSQAELQabaEEC5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pxPk9ER2H+cK1+5rJEHcjbUx02YsY2xU77aZ3BARkrzBbwEFPnFIxTeVSQAeXEcWgh
         9vKvMW8sjVv1IE8Mzaced0eGXpO6GzdA/CMGHePCNQ+V//bo4h0ivRJtta7bt6S5IqGs
         fwQKwofa2md++Hw8hUF+4cWZj5sMQaacYYiss=
Received: by 10.86.4.14 with SMTP id 14mr42298fgd.20.1221509119399;
        Mon, 15 Sep 2008 13:05:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.248.215])
        by mx.google.com with ESMTPS id e20sm15578932fga.1.2008.09.15.13.05.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Sep 2008 13:05:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <fcaeb9bf0809150701j1161f87gcedef0013a244610@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95936>

On Mon, 15 Sep 2008 16:01, Nguyen Thai Ngoc Duy wrote:
> On 9/15/08, Jakub Narebski <jnareb@gmail.com> wrote:
>> [I don't see mails I am replying to on GMane interface to git mailing
>>   list, so threads might be broken. Strange... Perhaps too long lines
>>   were cause of rejection by anti-SPAM vger filter?]
> 
> It was because I used zenbe.com (limited choices at work) to send
> mails and did not realize until too late that zenbe.com did not encode
> UTF-8 properly in mail headers. It made vger.k.o nervous and refuse to
> accept my mails.

Yes, vger anti-SPAM filter is quite "trigger happy"...

>>  On Mon, 15 Sep 2008, Duy Nguyen wrote:
>>> On 09/15/2008 "Jakub Narebski" <jnareb@gmail.com> wrote:

>>>>> +Narrow spec will be used to specify how you want to narrow your
>>>>> +checkout. It is a list of pathspecs separated by colons. Each
>>>>> +patchspec specifies what files should be checked out on working
>>>>> +directory. Pathspec can contain wildcards and is relative to
>>>>> +current working directory. Usually asterisk (*) does not match
>>>>> +slashes. If a pathspec is prefixed by a plus sign (+), then
>>>>> +any asterisk will match anything, even slashes.
>>>>
>>>> First, does this mean that you can specify paths containing colons
>>>> (':') only using --add-path and --remove-path, or does it mean that
>>>> you cannot specify paths containg colon ':' (which should be rare)
>>>> at all as checkout limiter / checkout narrowing rule?
>>>
>>> You cannot do othat explicitly unfortunately. You can work-around using
>>> wildcard though.
>>
>> Couldn't you simply escape ':', i.e. write for example Git\:\:Tag.3pm,
>> or Eichten_PRD21\:313,1980_erratum.tex, or \:0.log, or perhaps
>> kmail/jnareb@gmail.com\:@pop.gmail.com\:995, or even something like
>> Mail/inbox/cur/1194202360.32296.mprnq\:2,S, in the same way like you
>> can escape other special characters, for example wildcard characters
>> like '\*' for '*' and '\?' for '?', and of course '\\' for '\'?
> 
> Sure. Somehow I forgot that.

Well, if it is possible, it should be stated in documentation.
Even if it is obvious.


> [...] how about this? Note that document changes that also require code
> change like narrow spec escape or '**' do not get in. I will change it
> when I update code.

> --<--
> Narrow checkout
> ---------------
> 
> Normally when you do checkout a branch, your working directory
> will be fully populated. In some situations, you just need to
> work on certain files, no full checkout is needed. Narrow
> checkout is a mode that limits checkout area according to your
> needs.

You have decided then on the term 'narrow checkout', and not
'partial checkout' or 'sparse checkout', then?
 
It would be nice if git mailing list came with examples of usage for
this feature.  It was quite frequently requested.  I can think off-hand
about two reasons one might want to use 'narrow checkout':

 1.) when you are not interested in files outside some selected
     set, and you don't want to mess files outside this set, even
     by accident.  For example for end-user documentation writers
     it would be Documentation/* (non-recursive).

 2.) when you work on some large monolithic repository which doesn't
     use submodules, and you have limited and small quota (or disk size).
     Usually repository size is smaller or comparable to checkout size,
     and even if it isn't you can use alternates to reduce size of
     repository (assuming that reference repository is hosted outside
     user quota).


> Because narrow checkout uses new index format, it will be
> incompatible with git prior to 1.6.0 regarding worktree operations.
> Repository-only operations such as clone, push, pull... should not be

s/pull/fetch/. pull affects working repository, and it can affect
narrow checkout unexpectedly by conflicts during merge part of pull.

> affected by narrow checkout. In order to make your working directory
> work again with those versions, you can use `git checkout --full` to
> return to normal mode (and compatible index format).

By the way, you have made "git checkout <file>" get file and mark
it "wanted", i.e. clear/zero "no-checkout" bit.  Wouldn't then
"git checkout ." be shorter equivalent to "git checkout --full"?
I'm not saying that '--full' option should be abandoned...

>
> In narrow checkout mode, checkout status of every files in your
> working directory will be recorded in index. If a file is marked
> "no-checkout", it means that file is not needed to be present in
> working directory by user or any git command. When a new file is added
> to index, it will be marked "checkout" unless narrow spec is applied.
> Unmerged files are always "checkout". linkgit:git-update-index[1] can
> be used to update "checkout/no-checkout" status in index. When you
> checkout new files using "git checkout <file>" they will be
> automatically marked "checkout". Other commands such as "git apply"
> can also checkout new files if they are needed.
> 
> "No-checkout" status is very similar to "assume-unchanged bit"
> (see linkgit:git-update-index[1]). The main difference between them
> is "assume unchanged" bit just ignores corresponding files in working
> directory while narrow checkout goes a bit farther, remove those files
> when it is safe to do so.

Good description (although probably could be improved even further).

>
> Narrow spec
> -----------
> 
> Narrow spec is used to easily specify how do you want to form your
> checkout area.  It is a list of pathspecs separated by colons. Each
> patchspec specifies what files should or should not be checked out on
> working directory. Pathspec can contain wildcards and is relative to
> current working directory. Usually asterisk (*) does not match
> slashes. If a pathspec is prefixed by a plus sign (+), then any
> asterisk will match anything, even slashes.

Here I think you should give some examples, perhaps together with
wildcard escaping, escape (backslash) escaping and colon escaping.

> 
> When you apply new narrow spec to your working directory using either
> --path, --add-path or --remove-path, it will update "checkout" status
> in index accordingly. Moreover, if a file is marked "no-checkout" and
> is present in working directory, it will be removed. If a file is
> turned from "no-checkout" to "checkout", then it will be added again
> to working directory. Modified and unmerged entries can't bear
> "no-checkout" status, if narrow spec applies to them, "git checkout"
> will refuse to update working directory.

Do I understand correctly, that if one uses --path=<colon separated list>
_only_ filenames matching one of patterns specified would be checked out,
--add-path=<path> would additionally checkout given path and mark "wanted",
and  --remove-path=<path> would additionally mark "no-checkout" and remove
path?  

What --add-path starts from, i.e. does

  $ git checkout --add-path=.gitignore

starts from empty set if --add-path is first, or from full set as without
--add-path?

And is <pathspec> matched against full pathname, or like .gitignore
rules, i.e. as full pathname if it has at least one '/' in it?

> 
> Narrow spec is not saved by "git checkout". You can form your checkout
> area on one go with --path option, or do it incrementally
> with --add-path and --remove-path.
> --<--

I would probably say that specification used to select which paths to
check out is not saved anywhere, and used only to mark paths in index
as "no-checkout" or not.  Or somehing like that.


Thank you very much for your continued work on this feature!
-- 
Jakub Narebski
Poland
