Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74DC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9109B206D9
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5MaDzZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfLETXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 14:23:30 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34374 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 14:23:30 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so1740239qvf.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uadhBlbP0cCSySlQbwT7vjnthr8sOITPFS8ofkFId00=;
        b=d5MaDzZUWjZpltyPQnTzVsHHx6VAYIqLPh6LaiQmLrtbH1IEvyOhzu316G7vDz3Bas
         BKd5LecuWLDlXfp0GtkAqy1sATcTU7zRdQziJ5SUVr6fsgQoQkkT+BqJyvJaEkIO56pQ
         AcEQNzn73F9a58f3Lw/tDxf0DPScoHdUEX3LuW3D36mSEWEn3aP51wsl3c1rpMWkHbMC
         tUKvhJBvumzDi2k4ox+qVgF7dCrLVjQ5UppHNzQwrfb3huKAZszvNYROqAZjKvz9ONcc
         LLqe0LvSzKr5jnGAC3r1IENnNvSGMZe1nPJdofvqOnN9Qpx9S+29/7in3ekdAJrC6YnH
         uO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uadhBlbP0cCSySlQbwT7vjnthr8sOITPFS8ofkFId00=;
        b=entHYdXp4CgHAgNeqMT62daZDt4pSjodjM+x0vrOu1JXD3DcCH8ufXS6Mv5XAN8ODL
         L+6rfO4K+Q7U+kso3nHoc6QazwRS/2UIqXwc/Kxs+TioyZf7J+W82QVYhkwTSm7Mo37O
         r7Dej7a+nJ2d2cGrYiy46XDjfbKCgls6RkvXhQ124aJuAj3B/Q7TVheaizHgCd+1ieIb
         a/F2/FQDse51w8xyy6jN45Xg3VV/53ZcpvyIVzLb8ii4egkYMdQw1+fjJyfaLCaRkX/T
         g76627xsI355DdXCK5vAg99fDustwr4UyQl4WltEsR1PJaYhSzHkLfUbX0UU/FQXnV5T
         JqJw==
X-Gm-Message-State: APjAAAWwOSIEZuC2nWHpgCG0PzpMHH3L3xYBeipbNL41Gb1s+0yFkvgi
        aytjffp1Go+A2bxn1CictALW+zskIYU=
X-Google-Smtp-Source: APXvYqydu3dh+TJav/yWF97psuok55LB/SNdib1f2HEUYg/UyDi/8T1IbrMY5rYhQdkjueNKszKvTg==
X-Received: by 2002:a0c:c24f:: with SMTP id w15mr9273361qvh.66.1575573808832;
        Thu, 05 Dec 2019 11:23:28 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id c80sm5235652qkb.35.2019.12.05.11.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:23:28 -0800 (PST)
Subject: Re: [PATCH v4 05/11] git-p4: Add new functions in preparation of
 usage
To:     Denton Liu <liu.denton@gmail.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v3.git.1575313336.gitgitgadget@gmail.com>
 <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <1bf7b073b047ca7625d0861b160a9602135f7baf.1575498578.git.gitgitgadget@gmail.com>
 <20191205105034.GB1192079@generichostname>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <8531dbd5-018e-217b-9c9b-ef079c9af21c@gmail.com>
Date:   Thu, 5 Dec 2019 14:23:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205105034.GB1192079@generichostname>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/5/2019 5:50 AM, Denton Liu wrote:
>> Subject: git-p4: Add new functions in preparation of usage
> Nit: as a convention, you should lowercase the letter after the colon in
> the subject. As in "git-p4: add new functions..."
>
> This applies for other patches as well.


Got it.  Changing all leading characters to lower case.


>
> On Wed, Dec 04, 2019 at 10:29:31PM +0000, Ben Keene via GitGitGadget wrote:
>> From: Ben Keene <seraphire@gmail.com>
>>
>> This changelist is an intermediate submission for migrating the P4 support from Python2 to Python3. The code needs access to the encodeWithUTF8() for support of non-UTF8 filenames in the clone class as well as the sync class.
>>
>> Move the function encodeWithUTF8() from the P4Sync class to a stand-alone function.  This will allow other classes to use this function without instanciating the P4Sync class. Change the self.verbose reference to an optional method parameter. Update the existing references to this function to pass the self.verbose since it is no longer available on "self" since the function is no longer contained on the P4Sync class.
> Hmmm, so does the patch before this not actually work since
> encodeWithUTF8() isn't defined yet? When you reroll this series, you
> should swap the order of the patches since the previous patch depends on
> this one, not the other way around.

Good catch.  That's correct, the encodeWithUTF8() should be first.  I 
moved that commit earlier in the chain and actually split it up from the 
changes to write_pipe and gitConfigSet() so the text will be easier to see.


>> Modify the functions write_pipe() and p4_write_pipe() to remove the return value.  The return value for both functions is the number of bytes, but the meaning is lost under python3 since the count does not match the number of characters that may have been encoded.  Additionally, the return value was never used, so this is removed to avoid future ambiguity.
>>
>> Add a new method gitConfigSet(). This method will set a value in the git configuration cache list.
>>
>> Signed-off-by: Ben Keene <seraphire@gmail.com>
>> (cherry picked from commit affe888f432bb6833df78962e8671fccdf76c47a)
>> ---
>>   git-p4.py | 60 ++++++++++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 44 insertions(+), 16 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index b283ef1029..2659531c2e 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -237,6 +237,8 @@ def die(msg):
>>           sys.exit(1)
>>   
>>   def write_pipe(c, stdin):
>> +    """ Executes the command 'c', passing 'stdin' on the standard input
>> +    """
>>       if verbose:
>>           sys.stderr.write('Writing pipe: %s\n' % str(c))
>>   
>> @@ -248,11 +250,12 @@ def write_pipe(c, stdin):
>>       if p.wait():
>>           die('Command failed: %s' % str(c))
>>   
>> -    return val
>>   
>>   def p4_write_pipe(c, stdin):
>> +    """ Runs a P4 command 'c', passing 'stdin' data to P4
>> +    """
>>       real_cmd = p4_build_cmd(c)
>> -    return write_pipe(real_cmd, stdin)
>> +    write_pipe(real_cmd, stdin)
>>   
>>   def read_pipe_full(c):
>>       """ Read output from  command. Returns a tuple
>> @@ -653,6 +656,38 @@ def isModeExec(mode):
>>       # otherwise False.
>>       return mode[-3:] == "755"
>>   
>> +def encodeWithUTF8(path, verbose = False):
> Nit: no spaces surrounding `=` in default args.


Fixed


>> +    """ Ensure that the path is encoded as a UTF-8 string
>> +
>> +        Returns bytes(P3)/str(P2)
>> +    """
>> +
> Trailing whitespace.
>
>> +    if isunicode:
>> +        try:
>> +            if isinstance(path, unicode):
>> +                # It is already unicode, cast it as a bytes
>> +                # that is encoded as utf-8.
>> +                return path.encode('utf-8', 'strict')
>> +            path.decode('ascii', 'strict')
>> +        except:
>> +            encoding = 'utf8'
>> +            if gitConfig('git-p4.pathEncoding'):
>> +                encoding = gitConfig('git-p4.pathEncoding')
>> +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
>> +            if verbose:
>> +                print('\nNOTE:Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, to_unicode(path)))
>> +    else:
> Trailing whitespace.
>
>> +        try:
>> +            path.decode('ascii')
>> +        except:
>> +            encoding = 'utf8'
>> +            if gitConfig('git-p4.pathEncoding'):
>> +                encoding = gitConfig('git-p4.pathEncoding')
>> +            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
>> +            if verbose:
>> +                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
>> +    return path
>> +
>>   class P4Exception(Exception):
>>       """ Base class for exceptions from the p4 client """
>>       def __init__(self, exit_code):
>> @@ -891,6 +926,11 @@ def gitConfigList(key):
>>               _gitConfig[key] = []
>>       return _gitConfig[key]
>>   
>> +def gitConfigSet(key, value):
>> +    """ Set the git configuration key 'key' to 'value' for this session
>> +    """
>> +    _gitConfig[key] = value
>> +
>>   def p4BranchesInGit(branchesAreInRemotes=True):
>>       """Find all the branches whose names start with "p4/", looking
>>          in remotes or heads as specified by the argument.  Return
>> @@ -2814,24 +2854,12 @@ def writeToGitStream(self, gitMode, relPath, contents):
>>               self.gitStream.write(d)
>>           self.gitStream.write('\n')
>>   
>> -    def encodeWithUTF8(self, path):
>> -        try:
>> -            path.decode('ascii')
>> -        except:
>> -            encoding = 'utf8'
>> -            if gitConfig('git-p4.pathEncoding'):
>> -                encoding = gitConfig('git-p4.pathEncoding')
>> -            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
>> -            if self.verbose:
>> -                print('Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path))
>> -        return path
>> -
>>       # output one file from the P4 stream
>>       # - helper for streamP4Files
>>   
>>       def streamOneP4File(self, file, contents):
>>           relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>> -        relPath = self.encodeWithUTF8(relPath)
>> +        relPath = encodeWithUTF8(relPath, self.verbose)
>>           if verbose:
>>               if 'fileSize' in self.stream_file:
>>                   size = int(self.stream_file['fileSize'])
>> @@ -2914,7 +2942,7 @@ def streamOneP4File(self, file, contents):
>>   
>>       def streamOneP4Deletion(self, file):
>>           relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
>> -        relPath = self.encodeWithUTF8(relPath)
>> +        relPath = encodeWithUTF8(relPath, self.verbose)
>>           if verbose:
>>               sys.stdout.write("delete %s\n" % relPath)
>>               sys.stdout.flush()
>> -- 
>> gitgitgadget
>>
