From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Using bitmaps to accelerate fetch and clone
Date: Thu, 27 Sep 2012 07:33:30 -0700
Message-ID: <CAJo=hJt0PdpDT5ROUSfZ80Zh2ep=r5Sg1BS=v7Ve-djydHhp-w@mail.gmail.com>
References: <CAJo=hJstK1tGrWhtBt3s+R1a6C0ge3wMtJnoo43Fjfg5A57eVw@mail.gmail.com>
 <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 16:34:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THFAB-0006jE-Rg
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 16:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab2I0Odx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 10:33:53 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:56359 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab2I0Odw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 10:33:52 -0400
Received: by qchd3 with SMTP id d3so1072748qch.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0olDVRuWZs2sRJwBmbvH7X2pVd2PoBz4LbksW035PHA=;
        b=FRMaH1DNfnQ7n+0+w3ZjsWfmURdJKdG7dCPAFrNtMHm/p+FzCGZfTTjQsuvLVpw9w0
         p6/e24SiKMw4UsuyP1OwfJt/8orOqFPDxd56uGnuTXQSeyJsB8t9/UA7whyiyUxn9EBD
         mU/VYKfkQicOyVxc07psSnmnr/kQcNL4wdHTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=0olDVRuWZs2sRJwBmbvH7X2pVd2PoBz4LbksW035PHA=;
        b=Y5bJgoqcivq+xm2zxyDMAaFcLaoSECTjLhCXwh3qJ92kIWJd9AtGBWgFpWrocr6WUB
         +1TfYgisJ4hBzInUtTkJnDyoU0zTwJJlFYdyEth6GAfx2OTgVn55ZqwWMz8mSBlg6bnK
         DiHVYz7pusO+apQLFrqIbC38J3tjYKFeMp5GrLSSc5WBNto/v0xjzn/XdD8u+cGkIKOO
         hm21WTnWVQHAIW+WDp5RN9yj1VwcDTFXznoBG7iTkFjnkuvgs+LhOgN0edX4SkHG35HU
         tQHLx53RLGywWJwPd8Mbp2KGVAZU+wdPpYHPNlYKt9aEWQTH1T6hB7KAXknySi/lLlgQ
         YgHg==
Received: by 10.224.220.84 with SMTP id hx20mr9970738qab.5.1348756431220; Thu,
 27 Sep 2012 07:33:51 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 27 Sep 2012 07:33:30 -0700 (PDT)
In-Reply-To: <CACsJy8D0vkyEArNChXE0igUkanH6PwjmPitq22a9sudfmWF4kA@mail.gmail.com>
X-Gm-Message-State: ALoCoQmutntt33CfMHshpvwSp1eNKwjH+D3WbEs5UF5V/hvwkouiMRb/oiiya8n9n9oaSeuDW6Gn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206482>

On Thu, Sep 27, 2012 at 5:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Sep 27, 2012 at 7:47 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> Google has published a series of patches (see links below) to JGit to
>
> Should discussions about this series happen in here, jgit mailing or
> gerrit? I just want to make sure I'll discuss it at the right place.

I think we should have a concrete discussion about the implementation
in Java on the Gerrit changes (e.g.  "you should fix this comment it
doesn't sufficiently describe the method"), and a discussion about the
file format and algorithm here where everyone can contribute.

The format is named E003 because its still experimental. Its not set
in stone. Future iterations might be named E004, etc. If we get
something final we will look to rename it to just version 3.

>> improve fetch and clone performance by adding compressed bitmaps to
>> the pack-*.idx structure.
>>
>> Operation                   Index V2               Index VE003
>> Clone                       37530ms (524.06 MiB)     82ms (524.06 MiB)
>> Fetch (1 commit back)          75ms                 107ms
>> Fetch (10 commits back)       456ms (269.51 KiB)    341ms (265.19 KiB)
>> Fetch (100 commits back)      449ms (269.91 KiB)    337ms (267.28 KiB)
>> Fetch (1000 commits back)    2229ms ( 14.75 MiB)    189ms ( 14.42 MiB)
>> Fetch (10000 commits back)   2177ms ( 16.30 MiB)    254ms ( 15.88 MiB)
>> Fetch (100000 commits back) 14340ms (185.83 MiB)   1655ms (189.39 MiB)
>
> Beautiful. And curious, why do 100->1000 and 10000->10000 have such
> big leaps in time (V2)?

We didn't investigate this. Colby just reported on what the current
JGit code does. I suspect there is something specific about the shape
of the history graph for this repository combined with the way JGit
wrote the pack file that caused these sorts of large increases.
Perhaps they could be smaller. Not sure I care anymore when the E003
approach gives us such low times. :-)

>> The basic gist of the implementation is a bitmap has a 1 bit set for
>> each object that is reachable from the commit the bitmap is associated
>> with. An index file may have a unique bitmap for hundreds of commits
>> in the corresponding pack file. The set of objects to send is
>> performed by doing a simple computation:
>>
>>   OR (all want lines) AND NOT OR (all have lines)
>>
>> There are two key patches in the series that implement the file format
>> change and logic involved:
>>
>> * https://git.eclipse.org/r/7939
>>
>>   Defines the new E003 index format and the bit set
>>   implementation logic.
>
> I suppose the index format is not set in stone yet?

For E003, yes, we already have some data encoded with it. But as a
file format change, no. We are willing to iterate on this if there is
tangible benefit displayed by an alternative. Future versions would
have to be E004 or some other new version number to disambiguate from
E003.

> My java-foo is
> rusty and I'm not familiar with jgit, so I more likely read things
> wrong.

Or maybe not. :-)

> It seems the bitmap data follows directly after regular index content.

Correct. It is after the regular content, but before the 2 SHA-1 trailers.

> I'd like to see some sort of extension mechanism like in
> $GIT_DIR/index, so that we don't have to increase pack index version
> often.

This might be worthwhile. I dislike the way $GIT_DIR/index encodes
extensions. Forcing an extension to fully materialize itself to
determine its length so the length can be placed before the data is
painful to work with when writing the file out to disk. I would prefer
writing an index catalog at the trailer of the file. We already
require random access to the index file, so its possible for a reader
to read a fixed size trailer record that has the 2 SHA-1s we normally
end an index with, and an extension catalog footer that has a length
and CRC-32 of the catalog. The catalog would immediately appear before
the footer, so a reader can find the start of the extension catalog by
subtracting from the end of the file the catalog length and the file
footer and catalog footer lengths. The catalog can then supply a
starting offset for each extension section, and writers don't need to
predict in advance how much data they need to store. Readers trying to
use extensions aren't really hurt, Git already randomly seeks to read
the tail of an index file to compare the pack SHA-1 before assuming
the index is valid.

> What I have in mind is optional commit cache to speed up
> rev-list and merge, which could be stored in pack index too.

We should also look into using the commit bitmap data to feed the
rev-list traversal. The bitmaps can tell us which objects are commits,
and their rough ordering given the packing rules. That may be
sufficient to feed the walker without having a priority queue.

> In PackIndexVE003 class
>
> +               // Read the bitmaps for the Git types
> +               SimpleDataInput dataInput = new SimpleDataInput(fd);
> +               this.commits = readBitmap(dataInput);
> +               this.trees = readBitmap(dataInput);
> +               this.blobs = readBitmap(dataInput);
> +               this.tags = readBitmap(dataInput);
>
> Am I correct in saying that you have four different on-disk bitmaps,
> one for each object type? If so, for compression efficient reasons?

Yes. The packer needs to know the type of each object its going to
pack. Instead of reading this from the individual object headers in
the pack files, we store them in compressed type bitmaps. This is much
faster to test than reading in the base data from the pack file.

> Definitely :-). I have shown my interest in this topic before. So I
> should probably say that I'm going to work on this on C Git, but
> sllloooowwwly. As this benefits the server side greatly, perhaps a
> GitHubber ;-) might want to work on this on C Git, for GitHub itself
> of course, and, as a side effect, make the rest of us happy?

Google may also contribute towards this work, we really want to see an
improvement in git-core too. Its just a lot of work, and we are also a
limited team. :-)
