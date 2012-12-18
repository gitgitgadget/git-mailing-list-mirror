From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH v3] git-completion.bash: add support for path completion
Date: Tue, 18 Dec 2012 19:55:46 +0100
Message-ID: <50D0BC32.2020401@gmail.com>
References: <1355851510-13438-1-git-send-email-manlio.perillo@gmail.com> <7v1uengsbm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 19:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl2Ko-000065-Qs
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 19:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755419Ab2LRSzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 13:55:53 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:65027 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab2LRSzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 13:55:52 -0500
Received: by mail-bk0-f49.google.com with SMTP id jm19so558793bkc.36
        for <git@vger.kernel.org>; Tue, 18 Dec 2012 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=ZE19GpjPNvQimUdiamDGmowFG3Lb6WQhI2iQ2icJR80=;
        b=Y3a3uHFswnq1wPYjAAjA2lQfj4/p5B3neNISsevEGP4DW5YsAq0sgSkcl9Nku1WQAn
         Vepggjtzjrdsl1a13KTifOiMVCfTiS9axNUOnm5q3N7HNS6x6d90mTfcxXLLAYYxI0Sq
         EOUoLHSMXZoe2NGL7ZMz1QDFV7O+EPbWX1i2XFgMs6Rw6Q2EK+s+dP7WZs25Mq1uwh8V
         OwkpE2MqNRAcTQpOJSo6PGlV7Dh2kA+ua9ZdmEz+QSlJZZu1LGACu92oScin0uM1afet
         TZ2G7ftldyEBPKfmZh2dhLRkX+TmDuJfLLEWY1ojb2UjYTl7dxS5RnZ0IEk7+G4vck0z
         Bmcg==
X-Received: by 10.204.136.209 with SMTP id s17mr1220101bkt.13.1355856950981;
        Tue, 18 Dec 2012 10:55:50 -0800 (PST)
Received: from [192.168.0.3] ([151.70.213.162])
        by mx.google.com with ESMTPS id l17sm2306764bkw.12.2012.12.18.10.55.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Dec 2012 10:55:50 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7v1uengsbm.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211772>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 18/12/2012 18:53, Junio C Hamano ha scritto:
> [jch: cc'ed git-completion experts to review implementation details]
> 
> Manlio Perillo <manlio.perillo@gmail.com> writes:
> 
>> The git-completion.bash script did not implemented full, git aware,
>> support for completion, for git commands that operate on files within
>> the current working directory or the index.
>>
>> For these commands, only long options completion was available.
> 
> I find the "long options completion" is a misleading phrase.  It
> sounds as if you changed the current completion that does not
> complete "git commit -<TAB>" but does "git commit --<TAB>" to
> complete the short options (e.g. "git commit -c"), but I do not
> think that is the topic of this patch.
> 

It does not sound misleading to me.
I'm saying that the git-completion.bash script only implemented
completion for long options, but not for file names in the current
working directory.

Do you think I should rewrite the subject and the log message introduction?

As an example, something like this in the subject:

  git-completion.bash: improve some git commands completion

and in the message:

  The git-completion.bash script did not implemented full, git aware,
  support for completion, for git commands that operate on files within
  the current working directory or the index.

  As an example:

 ...

I'm still not fully satisfied with it, however.
It still requires reading the full message to understand the changes
implemented.

>> As an example:
>>
>> 	git add <TAB>
>>
>> will suggest all files in the current working directory, including
>> ignored files and files that have not been modified.
>>
>> Full support for completion is now implemented, for git commands where
> 
> s/Full.*implemented/Support more comprehensive completion/; or
> something, talking in the imperative mood (i.e. as if you are giving
> the order to the codebase to do something).
> 

Ok.

>> the non-option arguments always refer to paths within the current
>> working directory or the index, as the follow:
>>
>> * the path completion for the "git mv", "git rm" and "git ls-tree"
>>   commands will suggest all cached files.
> 
> I thought you dropped "git mv" in this round.
> 

Well, no.
But the current implementation should not cause problems.
Also note that I added support for ls-files, too.

There are some XXX marks in the code, but I think that the changes
always improve the old behaviour.

> [...]
>> For all affected commands, completion will always stop at directory
>> boundary.  Only standard ignored files are excluded, using the
>> --exclude-standard option of the ls-files command.
> 
> I read "always stop at directory boundary" to mean that
> 
> 	git cmd t<TAB>
> 
> will give us "t/ tag.c" (assuming there is a new or modified file in
> t/ and tag.c is the only modified file at the root level that begins
> with "t") and then
> 
> 	git cmd t/<TAB>
> 
> will likewise show the files and top-level subdirectories within t/
> directory.  That would be great.
> 

Yes, this is how it works, bugs excluded (I'm not a bash/perl expert).


> [...]
>> +# Perl filter used to process path list returned by ls-files and
>> +# diff-index --name-only commands, in order to list file names
>> +# relative to a specified directory, and append a slash to directory
>> +# names.
>> +# The script expects the prefix path in the "pfx" environ variable.
>> +# The output must be processed with the uniq filter, to remove
>> +# duplicate directories.
>> +# XXX remove duplicates in the Perl script ?
> 
> Surely, that will remove one fork/exec with pipeline.  I am not sure
> what the performance implication of using Perl here, but because we
> do not have to stick to POSIX shell in this file, the completion
> experts would be able to help rewriting this logic as a pure bash
> script.
> 

Ok. I'll wait for a review from git-completion experts.

Note that the performance is the reason why I suggested, in a previous
email, that git should have some more options to format data in custom ways.
As an example, there is no way to tell ls-files to not recurse
directories, and there is no way to also get the file type.

A --no-recurse option, and a change in the code to make, as an example

  git ls-files --stage --modified

to honor the --modified option,  will probably make it possible to use a
simple sed filter (there is still the problem that, unlike ls-tree,
ls-files shows the complete file path).

> [...]
>> +__git_files ()
>> +{
>> +	local dir="$(__gitdir)" flags="-${1}"
>> +
>> +	if [ -d "$dir" ]; then
>> +		git --git-dir="$dir" ls-files --exclude-standard ${flags} ${pfx} \
>> +			| pfx=$2 perl -ne "${__git_index_file_list_filter}" \
>> +			| uniq
> 
> This is purely a style thing (note that style suggestions are not
> optional), but
> 
>         the data source command |
>         a filter command |
>         another filter command
> 
> is easier to read and can be spelled without the backslash.  The
> same comment applies to git-commit-files as well.
> 

I agree.

But I was copying the style currently used in the script
(see the __git_complete_revlist_file function).

Note that I plan to do a small code refactorization, since I need the
ls-tree support code from __git_complete_revlist_file function for a
future change. I can fix these style issues in that patch.

I plan to improve completion support for checkout and reset commands,
too (currently only the commit/tree-ish argument is autocompleted, but
not the path).


Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDQvDIACgkQscQJ24LbaUTT9wCgh6jtbhdQ7GNIkqCq34QjXdIs
w9QAnjz2VjPFm4n2ICkcWWEsqWDWM+Hm
=8/Ad
-----END PGP SIGNATURE-----
