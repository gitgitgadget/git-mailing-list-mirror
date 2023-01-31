Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9AEC38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 15:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjAaP5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:57:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjAaP5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 10:57:00 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F441080
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 07:56:58 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id b4so4156968ioj.0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 07:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyDvpOb1t3TfaoX59VnLPnDQA/G27bOhWM5re4YBxC8=;
        b=h/plPbtAvqOW5WgejPD2S2bMKgnvq1pIIFMUhjqtM/8B2FVufIl5mJC+N7A2GEcysS
         5M/sRi3xETZp/siM6wcOGGz/Ys66k+jp7DiHHODDtyxkA4/NmdSguiu9REy4YmksnxHS
         gFmsR3UAX4Gj6wIsVKQHoMxilmkwqFcGo/g5KG71jVHitXQrJj6RviXIY6yUl+czjj2Q
         TFlCvq4h4WSO2vVLnzlyMV4iOvv16AE8uwi7qtjyYIJv+1CfEybycSjWr/u48vWpD36X
         53eJyaJA+Gr9uipBptICIXViD4oLvQS7ItHmib3eFXlV5B2hzpOWY1kJCjT9asnEamXP
         bi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyDvpOb1t3TfaoX59VnLPnDQA/G27bOhWM5re4YBxC8=;
        b=fLB0cyJ+dVNLliCUMeAXdh0NRZ0qctDIkyZZYvFSW0I1AhXepXBnUrWEwQWKm3gzi9
         PTFlTA6K8DzLxaFlRBH29ve1YUP7XoGLaPMpq2YmA0j/npUCRjXRaSOqC4ogGiE3A5+K
         5ELfPdxttq1RNH8+67TvjNCpX362ZSfch18qg4bx23uc9bHlvOyJ27fuzMHVkVJ6KnQ2
         A5a/6b5vN3jqdQFQR2R6NrBR4bY34OUKv+p1r2k3dBNf1SCCji6zbrzPZR4hACL7Vcrx
         EnDWCqZHVayl16Pp+NxDRkbiLOIoav1UFdIil+ytBJ6dzRCOSRzpRZjYIOEcU73AtUWF
         QCjg==
X-Gm-Message-State: AFqh2krdHxP5FbpmU137XIDJBh9dl3vpTnLaZxnyfnSYfOTvWoCCfduu
        /bErdOnKXWRmHzGHbEM2HzpD1FKnnUGh4w==
X-Google-Smtp-Source: AMrXdXurWUSaAH4PtdYAQxS9LRIeyJ4KY1YhmEcNb7Y91QWkRTbzTXjB8EhdFAzXT6fFTNBy0JXYbw==
X-Received: by 2002:a05:6602:2748:b0:704:cfbe:ce90 with SMTP id b8-20020a056602274800b00704cfbece90mr35982795ioe.7.1675180617751;
        Tue, 31 Jan 2023 07:56:57 -0800 (PST)
Received: from [192.168.1.72] (108-200-163-197.lightspeed.bcvloh.sbcglobal.net. [108.200.163.197])
        by smtp.gmail.com with ESMTPSA id i18-20020a6bee12000000b0070766817820sm5294918ioh.20.2023.01.31.07.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:56:57 -0800 (PST)
Message-ID: <6fc8e122-a190-c291-c347-258a5a2ad9c9@gmail.com>
Date:   Tue, 31 Jan 2023 10:56:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Stability of git-archive, breaking (?) the Github universe, and a
 possible solution
Content-Language: en-US-large
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>
References: <a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com>
 <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
From:   Eli Schwartz <eschwartz93@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <Y9jlWYLzZ/yy4NqD@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/31/23 4:54 AM, brian m. carlson wrote:
> Part of the reason I think this is valuable is that once SHA-1 and
> SHA-256 interoperability is present, git archive will change the
> contents of the archive format, since it will embed a SHA-256 hash into
> the file instead of a SHA-1 hash, since that's what's in the repository.
> Thus, we can't produce an archive that's deterministic in the face of
> SHA-1/SHA-256 interoperability concerns, and we need to create a new
> format that doesn't contain that data embedded in it.


I assume that whatever the reason for originally embedding the OID into
the file is still an applicable reason even if a new PAX format is
established for the use of git-archive.

It may not be a great reason -- I don't know. Perhaps there's an
argument to remove it. But can't that be done irrespective of
standardizing the PAX format?

...

I'm not deeply knowledgeable about the SHA-256 transition work -- or
knowledgeable at all about it, frankly. (Also my understanding was it
seems to have stalled as discussed in https://lwn.net/Articles/898522/
-- I understand that you're still enthusiastic about the work? But that
doesn't really answer "is there a timeframe for that to ever happen".)

But I sort of assumed that the transition work would already have to
embed a fair bit of information into the repository about the whole
process? Would it not be possible to determine whether a given tag
started life as SHA-1 or SHA-256? Maybe even just a date when the
repository was converted to work with both, and embed the OID based on
whether the tag is tagging contents that were created after that conversion?

Seems to me like the problem should be solvable if people want to solve it.

...

git-archive run on a commit obviously doesn't have this problem -- it
can simply embed the OID for the same argument it was called with. But I
assume it's far more common to access tag-based github endpoints. :D


> Having said that, I don't think this should be based on the timestamp of
> the file, since that means that two otherwise identical archives
> differing in timestamp aren't ever going to be the same, and we do see
> people who import or vendor other projects. 


The timestamp of the output file? Surely not. But I only suggested the
timestamp of the commit/tag metadata that git-archive is asked to
produce output for. And we would need that in order to solve the problem
that reproducible github API archive endpoints poses.

I'm not sure what the "import or vendor other projects" angle here
means. Do you mean people who copy a directory of files into their
project? Who expects this to be the same to begin with? And doesn't
embedding the OID kill this idea, since the entire point of git commit
sha's is that you shouldn't (it should be prohibitively unrealistic to)
be able to produce the same one twice in different contexts?

I have never said to myself "ah yes, I really would like to be able to
download a git auto-generated tarball for project A, and compare its
hash to the tarball for project B, and have them compare identical even
though they are different projects with different commits". IMHO this
isn't an interesting problem to solve -- the interesting problem to
solve is that a single absolute URL to a downloadable file should be
able to offer documented guarantees that it will always be the same
file, even though it is generated on the fly.


> Nor do I think we should
> attempt to provide consistent compression, since I believe the output of
> things like zlib has changed in the past, and we can't continually carry
> an old, potentially insecure version of zlib just because the output
> changed.  People should be able to implement compression using gzip,
> zlib, pigz, miniz_oxide, or whatever if they want, since people
> implement Git in many different languages, and we won't want to force
> people using memory-safe languages like Go and Rust to explicitly use
> zlib for archives.


I do not think it is realistic or reasonable for people to implement
compression using intentionally incompatible replacements for gzip and
expect interoperability of any sort.

I also don't think people *have* to implement compression in rust using
zlib, but if they are going to make a git-alike that produces archives,
it would be worth it for them to write whatever memory-safe rust is
necessary to memory-safely produce the same output stream of bytes. It's
no less feasible than making sure that busybox gzip and GNU gzip produce
the same output, surely.

Alternatively, they could just not bother with gzip at all, and make
their git-alike produce zstd-compressed tarballs, which change their
byte outputs every time a new zstd release is published. :D Again, why
limit yourself to gzip if you want to be innovative anyway.


> That may mean that it's important for people to actually decompress the
> archive before checking hashes if they want deterministic behaviour, and
> I'm okay with that.  You already have to do that if you're verifying the
> signature on Git tarballs, since only the uncompressed tar archive is
> signed, so I don't think this is out of the question.


This is a very kernel.org-centric view of things, I think. I have rarely
seen PGP signatures applied to the uncompressed tar except in that
context. The vast majority of tarballs with signatures have signed a
single compressed tarball and don't concern themselves with, say,
providing a rotating backdated changeable list of compression formats
with a single signature covering all of them.

Nevertheless, in order to handle kernel.org-style tarballs, you are
entirely correct that one should be able to handle this.

>From experience, I can say that this needs to be selected on a
per-tarball basis. Since signature files have filenames, we can match
their stems and given foo.tar.asc and foo.tar.gz, check the signature of
the output of gzip -dc < foo.tar.gz, but given foo.tar.gz.asc and
foo.tar.gz, simply check the signature of the original foo.tar.gz.

This doesn't really work for checksums, because you need to settle on
one or the other everywhere or else embed decompression information into
your checksum metadata field.

And for tarballs that are generated once and uploaded to ftp storage,
not repeatedly generated on the fly, we know the checksum will never
legitimately change, so we *want* to hash the compressed file.
Decompressing kernel.org tarballs in order to run PGP on them is *slow*.
Although at least one can verify the checksums first without
decompression, which is virtually guaranteed to catch invalid source
code releases, so if you ever progress to the PGP verification stage
it's unlikely to be wasted effort -- that tarball is definitely getting
used to build something.


-- 
Eli Schwartz
