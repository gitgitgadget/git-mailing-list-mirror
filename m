Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FC41F461
	for <e@80x24.org>; Sun, 19 May 2019 17:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfESRM5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 May 2019 13:12:57 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:39586 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfESRM5 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 May 2019 13:12:57 -0400
Received: from 200116b846d5dd00093f8d91b5d27c97.dip.versatel-1u1.de ([2001:16b8:46d5:dd00:93f:8d91:b5d2:7c97]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hSNoX-0000Td-EQ; Sun, 19 May 2019 17:33:29 +0200
Subject: Re: [PATCH] make slash-rules more readable
To:     git@vger.kernel.org
References: <20190518140759.14500-1-admin@in-ici.net>
 <7b062fd1-c793-b8b9-c997-90f53f958e2c@iee.org>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Message-ID: <1730c168-c4fb-0e04-dd20-c267ce510fd1@in-ici.net>
Date:   Sun, 19 May 2019 17:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7b062fd1-c793-b8b9-c997-90f53f958e2c@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1558285975;b351865c;
X-HE-SMSGID: 1hSNoX-0000Td-EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.05.19 21:34, Philip Oakley wrote:
> Hi Adam
> 

Hi Philip

> On 18/05/2019 15:07, Dr. Adam Nielsen wrote:
> This "Otherwise" below could be the complement to the initial "If", or 
> could be part of a "matches" pair of example sentences. At least on my 
> initial reading I paired it via the 'matches'.

Now that you said it, I can see the ambiguity. Maybe its better to 
create a blank line separator, the mentioned paragraph is already very 
big. Perhaps like this:

     If the pattern contains no slash or only a trailing slash, [..].
     For example, `frotz/` matches `frotz` and `a/frotz` that
     is a directory (relative from the `.gitignore` file).

     Otherwise, if the pattern contains a non-trailing slash,
     the pattern is matched relative to the location
     of the `.gitignore` file.


On 19.05.19 03:59, Junio C Hamano wrote:
 >> Make all paragraphs valid, even if they are not read
 >> in strict order.
 >
 > I think you are giving up on this, and I do not think that is
 > particularly a bad thing ;-)

You are right. The paragraph below

 >> + - The above pargraph also includes the case of a leading slash.

can of course not be read in any order. Maybe its more precise to say:

     Remove meta-rules in a paragraph that effect the way one
     has to read upcoming paragraphs.

 > Now you (not you the author of the document, but figuratively "any
 > reader of this document") must have read all the four before this
 > point ;-)

This paragraph references to the immediate forerunner. Why do you think 
it references to all four paragraphs?

 > To put it differently, your reading of the above four
 > bullets are incomplete unless you read this too.

I would say the paragraph

 >> + - The above pargraph also includes the case of a leading slash. [...]

is redundant. Its purpose is to point out that the previous paragraph 
also included the rule about the leading slash.
So the above four paragraphs are valid in my opinion without this paragraph.

 >
 > Typofix: "pargraph" -> "paragraph".
 >
 > In any case, I cannot guess what 'also include the case of a leaning
 > slash' wants to say.

Maybe this is better understandable(?):

     Note that any pattern that starts with a leading slash contains
     a non-trailing slash and is therefore effected by the
     previous paragraph.

This might be even better after creating a new paragraph for the 
"Otherwise.." part as suggested by Philip.

 >        Note that the above rule means you cannot easily say "a file
 >        whose name contains 'hello' and in this directory only, not in
 >        its subdirectories." because a pattern 'hello.*' does not have
 >        any slash. To work around this limitation, you can prepend
 >        your pattern with a slash, i.e. '/hello.*'; the pattern now
 >        matches 'hello.txt', 'hello.c' but not 'a/hello.java'.

I think examples that are as descriptive as this should rather belong to 
the "Example" section. For the rules section I would like to keep the 
examples as short and clean as possible (I think Johannes agrees with me 
here?).

If understand you correctly, then you find my example too abstract? 
Maybe this is better(?):

     For example, the pattern `/bar` only matches the file or
     folder `bar` but not `a/bar`, whereas the pattern `bar` would
     match both (relative to the `.gitignore` file).


On 19.05.19 08:59, Johannes Sixt wrote:
 > All those examples unterrupt the flow of thought in a way that makes it
 > diffcult to follow the reasoning.

I agree with you that complex examples make it harder to read. However, 
I find that if a complex rule is accompanied by a simple example, it 
improves readability a lot. I find that for example the four paragraphs 
about the `**` have a perfect balance between rules and examples.

 >May I suggest a different approach to
 > upate this text? Provide two patches:
 >
 > - Patch 1/2 updates the Examples section such that it contains all
 >    examples that you provide in the text above, with explanation.
 >    Perhaps refer to the Examples section early above the rules.
 >
 > - Patch 2/2 updates the rules section without giving examples.

Maybe its best if discuss this for each changed/new paragraph if the 
example should be moved into the example section.

1.

 >> + - If the pattern contains no slash or only a trailing slash,
 >> +   the pattern is matched against all files and folders (recursively)
 >> +   from the location of the `.gitignore` file.
 >> +   For example, `frotz/` matches `frotz` and `a/frotz` that
 >> +   is a directory (relative from the `.gitignore` file).

I think the example very short and important, and it should stay.

2.
   - Otherwise, if the pattern contains a non-trailing slash,
     the pattern is matched relative to the
     location of the `.gitignore` file.
     For example, `doc/frotz/` matches `doc/frotz` directory, but not
     `a/doc/frotz` (relative from the `.gitignore` file).

Same here. Its a short and important. I would like to keep it there.


3.

     Note that any pattern that starts with a leading slash contains
     a non-trailing slash and is therefore effected by the
     previous paragraph.
     For example, the pattern `/bar` only matches the file or
     folder `bar` but not `a/bar`, whereas the pattern `bar` would
     match both (relative to the `.gitignore` file).

I would agree to put this entire paragraph in the example section.


4.

 >> + - An asterisk "`*`" matches anything except a slash.
 >> +   A pattern "foo/*", for example, matches "foo/test.json"
 >> +   (a regular file), "foo/bar" (a diretory), but it does not match
 >> +   "foo/bar/hello.c" (a regular file), as the asterisk in the
 >> +   patter does not match "bar/hello.c" which has a slash in it.

I would also agree to put the 4-line example into the example section.

We could also put this in the example section:

     Note that the pattern `doc/frotz` and `/doc/frotz` have the
     same effect in any `.gitignore` file, while `/bar` and `bar`
     have not the same effect (`/bar` will not match `foo/bar`).


If we do all this, I could imagine the following procedure:

  - Patch 1/2 updates all the changes but do not include
    the examples from 3. and 4.

  - Patch 2/2 improving the example section and including the
    examples from 3. and 4.

I have actually some ideas for the example section that you may see in 
my blog post in the section examples: 
https://dr-nielsen.com/git/gitignore-pattern-explained

I would like to put all of those in the example section of the docs. But 
this is clearly out of scope of patch 1/2.

 > The examples in the Examples section are overly technical by saying
 >
 >     $ cat .gitignore
 >     vmlinux*
 >     $ ls arch/foo/kernel/vm*
 >     arch/foo/kernel/vmlinux.lds.S
 >     $ echo '!/vmlinux*' >arch/foo/kernel/.gitignore
 >
 > I think that this could be made more pleasent to read if one would not
 > have to use a mental shell interpreter. ;)

I agree, I would also vote to remove this one.


All the best,
Adam


