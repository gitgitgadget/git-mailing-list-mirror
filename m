Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 710612027C
	for <e@80x24.org>; Fri,  2 Jun 2017 23:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdFBXto (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 19:49:44 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35364 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBXtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 19:49:43 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so3196641pgc.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VfyQw9GFm3LO3u/2ZnolwnD54E3xTqWRNQghLTnzWnI=;
        b=rlpSKo0sQcGI3lHX2Nml0LeRWgIr9QBZp5L41XQTZr/LSCdg643L/XHXI+Tc+Tde+J
         8w3JMw7OOP+73raJA6cArfHFPsF4cag0aix2prA7rtCGafUbe8A9zKfluXnRtrfDD3cH
         GFOguxRs46KUp+azy5xk0OUysGZix1NhfqFlDu+0SlDKxuQLXxiXEGuMtxbIcdQcYuRb
         BEO1Km9BhoHLAmyvUY8ubPMQ5/RjLxYeyFOK6YPCIeEkpungrwsDNTsURUoNlagNodBq
         Jp/hnGwN7pwWHwWXj1DTP+ejgfjFZAuR9Iv4ruSFwKYM4kzAT3vLpBqv/e41Ux7XEDD+
         Rg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VfyQw9GFm3LO3u/2ZnolwnD54E3xTqWRNQghLTnzWnI=;
        b=DwrhZ4v5SdQMSEfHCBVk/RMd4K8zMZpJ7tQxP6KEa3FcXovwztKtX8Cd4ahRS+GGD/
         06akWIJJCo3ahVOpb74gY7pugJZEO6SXa+YZ8P6Et3fUGdWpAlNZ9vjJBX90kRIXVPdD
         Tu54cA2i8SW1LScJ7K6KcD2vk1nyNMo8Kpacl2q1j9IUof7qthI4DsEErdYqvS+9kpC/
         KdySv6G5Fruy2s51e8HFJNdYbhcNcD8jmABjSslVfcP6IKt3uItx0Gehg+F0Pn7Ssakw
         hRlBTZDLRU2SHI/frdb1b34muvRQNfXPt0KMusf98x5Z2vGyk++K13hRnbZbS1Efn7WC
         RgmA==
X-Gm-Message-State: AODbwcARQQtjna9Bvfg1Yi378GUeIzQZ876RctF3MWN29522RZXcckDl
        fKmrlsiAK81S4dmYbkouUw==
X-Received: by 10.84.248.73 with SMTP id e9mr2399296pln.76.1496447382704;
        Fri, 02 Jun 2017 16:49:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49ac:b4b9:21bb:8989])
        by smtp.gmail.com with ESMTPSA id e124sm36925171pgc.17.2017.06.02.16.49.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 16:49:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 25/33] notes-merge: convert verify_notes_filepair to struct object_id
References: <20170530173109.54904-1-bmwill@google.com>
        <20170530173109.54904-26-bmwill@google.com>
        <xmqqpoen2p2a.fsf@gitster.mtv.corp.google.com>
        <20170602185528.GC57260@google.com>
Date:   Sat, 03 Jun 2017 08:49:39 +0900
In-Reply-To: <20170602185528.GC57260@google.com> (Brandon Williams's message
        of "Fri, 2 Jun 2017 11:55:28 -0700")
Message-ID: <xmqqlgpax84s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 06/02, Junio C Hamano wrote:
>> 
>> > -static int path_to_sha1(const char *path, unsigned char *sha1)
>> > +static int path_to_oid(const char *path, struct object_id *oid)
>> >  {
>> > -	char hex_sha1[40];
>> > +	char hex_oid[GIT_SHA1_HEXSZ];
>> >  	int i = 0;
>> > -	while (*path && i < 40) {
>> > +	while (*path && i < GIT_SHA1_HEXSZ) {
>> >  		if (*path != '/')
>> > -			hex_sha1[i++] = *path;
>> > +			hex_oid[i++] = *path;
>> >  		path++;
>> >  	}
>> 
>> It's no brainer to do s/GIT_SHA1_HEXSZ/GIT_MAX_HEXSZ/ for all of the
>> above, but ...
>
> I'll fix this.
>
>> 
>> > -	if (*path || i != 40)
>> > +	if (*path || i != GIT_SHA1_HEXSZ)
>> >  		return -1;
>> 
>> ... this one is tricky.  
>> 
>> What's in our envisioned future?  Are we expecing to see object
>> names, named with two or more hash functions, in a same repository?
>> If so, and one is 20 bytes and another one is 32 bytes, then this
>> should check 'i' against 40 and 64 and pass if 'i' is one of these
>> expected lengths?
>
> That's a good question, and at this point in time do we have an
> envisioned future?  From some of our conversations I seem to remember
> that we don't want a single repository to have objects based on two
> different hash functions, but rather some translation layer to convert
> between two hashing functions (for compatibility with other
> non-converted repos).  Though nothing has been settled upon yet so I
> don't know what the future would look like (and the best way to prepare
> for it).

I do not think we know precisely what we want yet.  The "MAX" in the
allocation size is an indication that we are allocating for the
largest variant possible in the version of Git being compiled, which
is a hint that we anticipate that we may have multiple variants with
different sizes.  And that is where my "against 40 and 64 ... one of
these expected lengths" come from.  

But there is no such set of macros that define acceptable/expected
lengths and that tells me that nobody among who defined, reviewed
and accepted the MAX macro has thought this part through yet.

I see Jonathan started talking about experiments with "different
hash" elsewhere; I am reading his message as assuming one hash at a
time, and the repository tells us what the hash is.  And I think
that is one plausible design.

If we were to go that route, then

    - MAX will be the maximum among hashes we can choose at the
      beginning of a process (perhaps by consulting the repository
      extension).

    - In addition to GIT_SHA1_HEXSZ, GIT_SHA2_HEXSZ, and friends, we
      need a variable that records the length of the hash chosen for
      the process at the startup, GIT_OIDHASH_HEXSZ.  That would
      become one of the fields in your "struct repository",

        #define GIT_OIDHASH_HEXSZ (the_repository.oidhash_hexsz)

      among other things like what the oid for an empty blob is.

I'd say in the meantime we can do something like the attached and
use it here, perhaps?

 cache.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cache.h b/cache.h
index 53999418d3..cafb13db9f 100644
--- a/cache.h
+++ b/cache.h
@@ -70,6 +70,10 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
 #define GIT_MAX_RAWSZ GIT_SHA1_RAWSZ
 #define GIT_MAX_HEXSZ GIT_SHA1_HEXSZ
 
+/* The length for the object name hash */
+#define GIT_OIDHASH_RAWSZ GIT_SHA1_RAWSZ
+#define GIT_OIDHASH_HEXSZ GIT_SHA1_HEXSZ
+
 struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
