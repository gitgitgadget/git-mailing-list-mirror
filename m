Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE5C43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiGVNXS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNXR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 09:23:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF914093
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:23:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b10so4378237pjq.5
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 06:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pN1dbpZSwg7+7VvbMcL3wgphNgvUAWPnuuM3ieQL7GM=;
        b=k9139zFZqYdSyqK7LgVkHcE5oHmDQjH++tRUQgFKMOnEnOT1BYRQgLxXSrhWWGwDXJ
         58X7EBvw7Od5j9ZXsdkNx3IvUS8/gY8jULfkX8KNHXrEyT5BAcGz4iInJs6hY931wCcq
         eGoJnaMZjUD+5YwEKG8UNaC+tnap82VnzzppzWoYv7nAperrb677DZ9wUAkYkwNTfZxy
         6qDFP7len6zBLwy41kX8ovXIIiUEiEMvkhGpnN8fuEys84/YqNPAR18gYFwx0SXvtjv9
         w1CAUysMMi7R5XMBytL917l0TbzIfx8H9ObjX/H3jsJL6wN9jkQUZ9XRMEF71+DsB7MX
         JT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pN1dbpZSwg7+7VvbMcL3wgphNgvUAWPnuuM3ieQL7GM=;
        b=kxmacJhV4lE6mdNJAPXF5s9ffjkFQspv2AoRACn5IMdVQNmsBd6g4/U2EJkufQd4D0
         IxbVY1n5duqYxKpVYxDWxw7eEhVn862Td6q0kLlPPoP4qy8q0tPyN9cvck2xZqPkKK21
         ceAOSD/250xhnbZNQBxuw/fNNe5DLAyfuPKpM5RFBP8fA73wAplV8x67dXdjg2/ZHb+4
         AJLub540cw6ZxVoXGdutl+CP7/usBD8zgteHDEJleDNZNDMCg7pd2oLEU2vMotrKfIdy
         vOpabHb746njvZSlZ70bbeRDdUmxDlRdARXqlNM8OXxB5MoLKTV/U3tRoUoe1ZGmmgbZ
         o6rA==
X-Gm-Message-State: AJIora9pstXXZJAmjMt4ne4DEbSfAvsSVjX8xo5a8tp17Qo1fGCDHl9F
        BYbI9hCfeZZ2ji777qhHeLY6k5eBfMOPag==
X-Google-Smtp-Source: AGRyM1uDaxEAc9bLV9zMFK3jp22tVjFClc/GfPZM22Jzb8uxdV2SuqPWlyJR3n+bLdMwAFDPJlHQdQ==
X-Received: by 2002:a17:902:ec90:b0:16d:2e8f:27cb with SMTP id x16-20020a170902ec9000b0016d2e8f27cbmr381889plg.12.1658496194736;
        Fri, 22 Jul 2022 06:23:14 -0700 (PDT)
Received: from cosmos.melik.windwireless.net (melik.windwireless.net. [206.63.237.146])
        by smtp.gmail.com with ESMTPSA id g126-20020a625284000000b00518285976cdsm3889213pfb.9.2022.07.22.06.23.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 06:23:14 -0700 (PDT)
Reply-To: davidnchmelik@gmail.com
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
To:     git-l <git@vger.kernel.org>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
From:   David Chmelik <dchmelik@gmail.com>
Message-ID: <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
Date:   Fri, 22 Jul 2022 06:23:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/22 4:06 AM, Beat Bolli wrote:
> On Fri, Jul 15, 2022 at 03:35:49AM -0700, David Chmelik wrote:
>> What did you do before the bug happened?
>> 'git clone,' built various software (with gcc, BSD & GNU make, autotools,
>> cmake, etc.)
>>
>> What did you expect to happen?
>> Option: keep cloned/built/etc. files user-writable.
>>
>> What happened instead?
>> Needed chmod or 'sudo rm -rf.'
>>
>> What's different between what you expected and what actually happened?
>> Option: keep cloned/built/etc. files user-writable, otherwise (has been said
>> 15+ years) encourages 'sudo rm -rf.'
>>
>> Anything else you want to add:
>>          I try/test/debug (and report bugs) many software commits but don't
>> commit so need cloned/built/etc. files writable as user & even system-wide
>> options: who hasn't made 'rm -rf' mistakes? (unrelated but someone might
>> claim is: I don't use non-UNIX-like OS that shell alias 'rm -rf' to confirm
>> every file (potentially thousands) and though made my own alias (confirm
>> once) it's longer, sometimes unavailable so don't always use (many people
>> don't)... software should always have user-writable files option.)  Below
>> indicates GNU/Linux but also have often used git on *BSD/Unix.  I'm not on
>> git mailing list but you can CC me all replies.
> When building software as the current user, the build artefacts are
> owned by this user.
Ownership, permissions are different: one can own files yet have zero 
permission to write/delete and be denied that.  After cloning, 
archiving, building most/all projects I tried from (hundreds/thousands) 
git commits I typically/always had zero permission to write/delete some 
files/directories within--despite owning--which led to more steps to 
delete and temptation to sudo 'rm -rf' (or preferably alias or script 
such as 'rm -RfI' (FreeBSD UNIX) or 'rm -rf --interactive=once' (GNU) 
but may not always be available).

> Are you building the software using Docker containers that run as root?
I don't use containers.  I noticed some projects' cmake & 'sudo make 
install' put root-owned files in build directory but doesn't seem to 
happen with other build systems--especially not plain make (BSD nor GNU 
nor with autotools)--still-used by almost all projects I try commits from.
         So, I don't think root is the problem; IIRC usually problem was 
cloned directories had one or more subdirectories (such as .git* or 
files/subdirectories further in those) that were/became user 
non-writeable so I ended up writing a bash function (on SlackWiki.com & 
docs.Slackware.com) to make git clones user-writable: should be by 
default (before & after building in .git*, etc.) and/or a 
well-documented beginner/easy option (is it even an option?) because 
surely many more people only test than commit.  Instructions say 'git 
clone URL' assuming someone will commit rather than only test and want 
to avoid user-non-writeable files (I doubt I even need .git* 
subdirectories until ever start committing (don't plan to: I only like 
decimal-numbered tarballs made manually rather than version control) so 
would rather opt-out).  I don't recall commits from three other/older 
major version control systems be(com)ing user non-writeable (though all 
less-used apart from on classic UNIX/*BSD I don't use much anymore 
besides servers but wish had more hardware support to be more 
desktop-useable).
