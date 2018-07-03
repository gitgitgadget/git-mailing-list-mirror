Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D9721F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 17:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934187AbeGCRpz (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 13:45:55 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33140 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934004AbeGCRpy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 13:45:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so2831787wrq.0
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RsUDT+eaJMfDYZrGyS3TL24IlOzuT3xcw7S3apaVKfU=;
        b=heyBTN25QIPeE2PmkZWKjuhAUPY+uzrDmY9Zz/fl1w0Wl8HysRpqyYtRjC7O3QtSbU
         3BkpjyBvk3bm9b4ed4inRgfk8JlUQV3ship4HKmbDLnynKZj4IBmop/hEiYMaHKITFGm
         SJ1N/jejOeeG7h9Rjc9qXAzn7qkResNAei5KiCGjR32NYSc3UEYoNq4dwjdWuwBM0dbn
         0hWXl5LRN+/+KEr3T/f49isAoXscprfVqBlT2cfrhqSv5nXsHpwoYm5jaK4koG5WzPzq
         56aMm187VguSsh+Oa2l3oB8Fcen5hhhGOV5quyNgHXkMSskPAcHgbgum5FPUvjR40N1h
         z5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RsUDT+eaJMfDYZrGyS3TL24IlOzuT3xcw7S3apaVKfU=;
        b=VyOA2kWADKx/M4nKOuAMEcfJTpif1A6bJPdNaJw09YzFdyl9NRgvZzVO+ObdHogDZM
         v6w69Hq1uDkhGcjG9e5zM+1VueaZI+uqnxeRjOoFzxv8wS3hwbEGSI4WekFG+VH6uL98
         R/FaQLhwQJterQ19zNR88mQ81TSJjHz/VyJn3FbQgMh6TVpujJ3GIhVMMDZzw55GBdf3
         10wal41XalmZMyHICWI2/PmCorupL1+31LFkuMaQjlP2ahetIO9I80TgDcKC777A33l3
         QPhBpZe6NUmzbVJLWkRXK2nU9xGned3JVi1NE8178KcF9LgSZXDn9DEgNtp1968OBC5N
         RmEg==
X-Gm-Message-State: APt69E04fVYaChYJbEa9ZTVENjWX3QAvPHzvBb0PRKwWGTcJ2GDpb0a+
        AR9/TKedNNuPgK/zdrjTmhHHioDA
X-Google-Smtp-Source: AAOMgpc46JtdgecoJY6PYvIOJjRY4rnCdWtwdOuQRz+1MHDgKLSXcIIv0SYq0F7zxpXh/Qwr94QMbg==
X-Received: by 2002:adf:e311:: with SMTP id b17-v6mr24633677wrj.158.1530639952863;
        Tue, 03 Jul 2018 10:45:52 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s124-v6sm2885503wmf.47.2018.07.03.10.45.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 10:45:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: Checks added for CVE-2018-11235 too restrictive?
References: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
        <20180703141518.GA21629@sigill.intra.peff.net>
Date:   Tue, 03 Jul 2018 10:45:51 -0700
In-Reply-To: <20180703141518.GA21629@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Jul 2018 10:15:19 -0400")
Message-ID: <xmqqh8lgrz5c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> A small testcase to reproduce looks like this:
>> 
>> $ git init bar; cd bar
>> $ git fast-import <<EOF
>> commit refs/heads/bar
>> committer Bar <bar@bar> 0 +0000
>> data 0
>>                                                                  
>> M 160000 81eae74b046d284c47e788143bbbcc681cb53418 bar/.gitmodules
>>                                                                  
>> EOF
>>
>> [...]
>> 
>> Would it be reasonable to make the transfer.fsckObject checks ignore
>> non-blob .gitmodules?
>
> I'm open to the idea that the new checks are too restrictive (both this
> and the gitmodulesParse error we're discussing in [1]). They definitely
> outlaw things that _used_ to be OK. And the security benefit is a little
> hand-wavy. They're not strictly needed to block the recent
> vulnerability[2].  However, they _could_ protect us from future problems
> (e.g., an overflow in the config-parsing code, which is not accessible
> to attackers outside of .gitmodules). So there is some value in being
> restrictive, but it's mostly hypothetical for now.

As you said elsewhere, the above example would probably not cause
harm to the production use of .gitmodules (as opposed to what fsck
checks) as it is not at the top of the working tree, but does the
production code do a wrong thing if a directory, a symbolic link or
a gitlink appear at ".gitmodules" at the top level?

If so, we probably need to tighten code in submodules.c and
elsewhere to ignore such ".gitmodules" directory etc [*1*].

And if not, I think it is OK to loosen fsck to exclude ".gitmodules"
that are not regular files, e.g. in fsck.c::fsck_tree(), we have
this for each entry we encounter in a tree:

		...
		has_zero_pad |= *(char *)desc.buffer == '0';

		if (is_hfs_dotgitmodules(name) || is_ntfs_dotgitmodules(name)) {
			if (!S_ISLNK(mode))
				oidset_insert(&gitmodules_found, oid);
			else
				retval += report(options, &item->object,
						 FSCK_MSG_GITMODULES_SYMLINK,
						 ".gitmodules is a symbolic link");
		}

Can mode be 160000 or 40000 here?  The code seems to assume that, as
long as the thing is named ".gitmodules", we are looking at a blob,
so symlinks are worth reporting immediately and all others are worth
investigating later by marking them in the gitmodules_found oidset.

I think it is a good idea to be tighter than necessary by default,
so rejecting a gitlink ".gitmodules" unless the user tells us with
some configuration knob is a good thing to do, but it probably makes
sense to have users a way to opt-out of this "There is .gitmodules
but it is not a readable blob" sanity check.



[Footnote]

*1* A quick scan of the code there looking for GITMODULES_FILE did
not give me a very good feeling---it seems that the code trusts what
is in the index and in the working tree to be non-hostile a bit too
much.
