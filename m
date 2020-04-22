Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F1FC2BA19
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3746206D5
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 01:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNWKWMvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVB2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726024AbgDVB2U (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 21:28:20 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D481C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 18:28:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id hi11so155547pjb.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1l1QILQ5jZAP507QizSlJcIZxczZzNPbxyfn/PJszYc=;
        b=XNWKWMvDY4dfgRZeDHyw7p6nFCEighYzwonPEV+YurP5dnTNFZED+AnOLbqoEcOpEy
         9kAMgPq5nSaWh5zVRl5cEHvXsBNxbO+DyNmV4MjTyBv9B5zyGhM01cHXE9QIm5gTweNo
         H+w0wU0GtudHvYxRPe/f4i8Jnyhq2HgcuOQYi9bMoWsYyWv4G6Kgx9rbB8/HkJYThnbo
         QiKr0F4kifSVXL7Alc4tv3HOJ+4o7EQFyN/yxmIQsFbWm7OnYQb2nFOZYu/IoXqsB/Mw
         2W+4BofIGsyJvCMtI4ox4slov0W/mR5ZMNkG6KPWoXpNtKbvhg2ev6QiDXRNj/eNhdNo
         so7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1l1QILQ5jZAP507QizSlJcIZxczZzNPbxyfn/PJszYc=;
        b=QBuilcROdLErogEIFmxVBrng97iF8SjpXKUeGNjPZbMFZML0K8YkiF4rW4JJ0CuJbb
         QCF21ugJqtW+z8eILaTXGAgfZMXC5aZmmQhmGeo9/LZUyCv694So2FUJVPkvOSoLTEEw
         WNaTOppdXNJ4viuE+p6IXNTcP7lrb2zZ0N04N0iGY6kSrirmuudlx5g71H3ajvhBOiL6
         B1zAvB8zgQoyywVsl7RHFrvi/2JLNbd6PTh79SE6llw/QOghGDKZfXJxcUHSHCOP2zcG
         XpDIzUpaquT8zNVoOcKoItmKwSdNLG/PqeDbv/Tnkgiyv8OuTl9IEDn9+y/rkcMuYgzw
         HTsg==
X-Gm-Message-State: AGi0Puaw0MaZlhr4CxF5saZDqwkeA84iofRHS03pKHUMvZOG3CRgb/wf
        CF1AgXwu2kiI+Ey4xrMXIYM=
X-Google-Smtp-Source: APiQypKxsQ3gXSBvyb6vu8GWNeH8Gx9lJNehs0fPfM1gHugMpKeUTqTYTJecjqAz+E7uq7T07OZu7A==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr8877504pjq.100.1587518899304;
        Tue, 21 Apr 2020 18:28:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id p24sm3270943pff.92.2020.04.21.18.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 18:28:18 -0700 (PDT)
Date:   Tue, 21 Apr 2020 18:28:17 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Ilya Tretyakov <it@it3xl.ru>,
        "brian m. carlson" <bk2204@github.com>, git@vger.kernel.org
Subject: Re: Credential helpers are no longer invoked in case of having
 sub-folder parts in a repository URL. Since 2.26.1 version
Message-ID: <20200422012817.GD103469@google.com>
References: <CAOrRacVviJP3w98-=QpFKYp630cN3gZQYnvAWZXeKqZRk2UDXg@mail.gmail.com>
 <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422010943.GD6465@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422010943.GD6465@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2020-04-21 at 22:58:37, Jeff King wrote:

>> This is unrelated to the recent helper fixes in v2.26.x. Here's a simple
>> reproduction:
>>
>>   url=https://git.example.com/my-proj/my-repo.git
>>   echo url=$url |
>>   GIT_TERMINAL_PROMPT=0 \
>>   ./git \
>>     -c credential.helper= \
>>     -c credential.$url.helper='!echo username=foo; echo password=bar;:' \
>>     credential fill
>> 
>> which should print a filled credential (with "foo/bar"), but will fail
>> with recent versions. It bisects to brian's 46fd7b3900 (credential:
>> allow wildcard patterns when matching config, 2020-02-20).
>
> Yeah, I can reproduce this.  It looks like what's happening is that
> we're percent-encoding the slash in the paths as %2f, which of course
> isn't going to match in the urlmatch code.  We probably need to tell the
> percent encoding function not to encode slashes in this case.
>
> I'm testing a patch now and hope to have it on the list a little later
> this evening.  Thanks for reporting and bisecting, and sorry for the
> breakage.

Thanks.  Here's another (though I haven't tried bisecting yet):

	echo url='https://github.com/git/git' |
	GIT_TERMINAL_PROMPT=0 \
	git -c credential.helper= \
		-c credential.github.com.helper='!echo username=foo; echo password=bar;:' \
		credential fill

produces

	fatal: could not read Username for 'https://github.com': terminal prompts disabled

Jonathan
