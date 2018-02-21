Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28811F404
	for <e@80x24.org>; Wed, 21 Feb 2018 17:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeBURUq (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 12:20:46 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:44688 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934244AbeBURUp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 12:20:45 -0500
Received: by mail-wr0-f181.google.com with SMTP id v65so6616868wrc.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 09:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ypaGxMFnS3HKP2Innq2YYzAit/dtMA/EUGC4fPxxErQ=;
        b=L8MWvLAQlQHZXok80Tudd5DaohaC/7WUdNZkMXS6/mT5Z/RU4MmCDtWwZCOXO56eTo
         54zIl6oRgpF5DYLC3crMnUYaQPTPGgy8/YgvVA09BLmTbCxYCAP0fvHw8ICcuhD4vAm4
         XHqR9isQUI9lTR9WV1zfDTo9md9nEs5RecYz6H2mkSuClOQJUAcakP9QFNhYQmXKdVQd
         GGAWiSvP2jut5XbDqE++iIwnBNSn1TPBUsJoUXDA3inlawHgqukKp5TQQXeU/vGxn1Bl
         w7Xcb1WnrGVCkvz4gJePqsN1rqvEdEThJdO92M+wac5LVT2QglxeUrfeB72P2XPFSPtw
         JcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ypaGxMFnS3HKP2Innq2YYzAit/dtMA/EUGC4fPxxErQ=;
        b=OitUT1ernU9CxKpFKEHM+8oLX2USv751QMX/y++SpJJD99tHWUCKS80hCWMro6kVFy
         eKC/kQBIJ016iNsvJgTx0ckt+FpfgbXV4PNfWDgblSIigogvknPZ6lGKYQvrYnTOYe4w
         MX9zKx4/zUcz4RuR6p8PYuDFCh8iPbsnhfzUVsYiI17oiBCSlEsnz0Xdkb8+01RjdCqc
         hd5A1HHkx2f8T4QBdNIexTIN7n40Yury1wPJPWKQ3fXFExaoKNW1+cvFgTsBtOc2tpEv
         TmIZhEDQ0KrtHjl94aX65trQa6kBpYaPHZDOtXMaC/SjyCRnsMyLaVRIjuiMHVYcy7eG
         vq4w==
X-Gm-Message-State: APf1xPBMFtasVg5UdEF6YN2MOcG47n8L8MDBKJNPT6b5IaeIjV66hp2V
        AvGJbmlclsH9tbZ5V36Vi4M=
X-Google-Smtp-Source: AH8x225wHVYt1GO7V+PHacLgiOVoE1j2JSn3HZpkVetYgAgO8KfaxgOh4dVj429Q4txeGj3ayBEB6A==
X-Received: by 10.223.163.13 with SMTP id c13mr3401603wrb.201.1519233643561;
        Wed, 21 Feb 2018 09:20:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g52sm3116737wra.20.2018.02.21.09.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 09:20:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git <git@vger.kernel.org>
Subject: Re: Duplicate safecrlf warning for racily clean index entry
References: <1519134146.6055.23.camel@mattmccutchen.net>
        <1519220864.3059.14.camel@mattmccutchen.net>
Date:   Wed, 21 Feb 2018 09:20:40 -0800
In-Reply-To: <1519220864.3059.14.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Wed, 21 Feb 2018 08:47:44 -0500")
Message-ID: <xmqqy3jmz2c7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> ... may be an important optimization.)  If the line endings are changed
> without changing the size or post-conversion content, then no unstaged
> change is reported.  It does not appear that git saves the pre-
> conversion content.

Correct.  The cached-stat information is meant to be compared with
the size on the filesystem.  Based on your observation, it seems
that what you are seeing is not specific to safe-crlf thing.

If you reconfigure anything that affects the checkout conversion
codepath, including the "smudge" filter, an entry in the index that
used to be up-to-date will still have cached-stat info like
timestamp and size that match the on-disk file, even though if you
_were_ to check it out afresh out of the index, the reconfigured
checkout codepath may produce different file contents on-disk.  A
consequence of this is that you may cause Git to still say that the
path is clean, even though it is no longer true.

There is no single "right" solution out of this situation, as it
depends on the reason why you made such a reconfiguration in the
first place.

 - If the reason is because you found that what is stored in the
   index is correct but their contents are checked out incorrectly
   (e.g. both the index and the working tree files end their lines
   with LF, but you want your working tree files to be converted to
   CRLF, and you futzed with .gitattributes or core.crlf), then you
   would want to "correct" it by checking them out, bypassing the
   "if the cached-stat information says we already have the matching
   contents on disk, do not write the file out" optimization.

 - If the reason is the other way around, then you would want to
   "correct" the indexed contents by rehashing what you have on
   disk.  Perhaps a recently added "git add --renormalize" is what
   you are looking for.



