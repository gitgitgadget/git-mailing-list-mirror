Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4AAC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7216113C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbhDSJFJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 05:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbhDSJFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 05:05:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27037C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:04:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so17598482wmg.0
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 02:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:from:to:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=0l9wJd/79BrWLu9Ew3SY5aFPlfQ6JU74CUmWds3lj34=;
        b=Av3gCUHIoQQNw4dy6HTUME9koN+8+rf54+Wfaw7+Q8X90dMdXFiBpyqVkGRm/CICx6
         WtiuDbEDFuu7T95CXPxWY9xbjOwwycC57hcO8K24m+CSzgaYNTQhcR5evBqJlodC5CSK
         bCXfxF6FlaIOqu8kxCcLxM6sS4EkMfXnUzgGqsmT3fo5dzgxqpKP1F4+Xk/keXmOkAF3
         g5e3vt5QqMn8p0p0NSlFWtZd1qv7jeUwt8Y/uM43GWMkdrnRWna2S/6x1lnGiHYoJnag
         lntJvYQxWyRp8WtpshIkGvVZfbXTTpj2BDqNpLz4Re3NcyDSd3UT5qvG6WC0dYAQuZmL
         o3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:from:to:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0l9wJd/79BrWLu9Ew3SY5aFPlfQ6JU74CUmWds3lj34=;
        b=kpYOBlr+n9LzRJimtvYWccLph8KehcFS2DE/IL02upjXYjREOycP2BIpeHCZVLniE+
         H+13JbGQedbk23umHngD2btTVHkOORexUpT3MxtorO4u0vNbOXysM5FqNrvric5/+gJw
         YmysP4qmDpSqjXP5ffFNKcQTBSH8/qWl6A8OoL1/V1Qdl9DtiDqpe3pOxBKyVwWPwtn+
         6J72PMbWQamF5PNPwRmsxOjQYOBtYk4Cz6exMx8xYXrrKN3RBp6hoI3PxYH0vBo3jOGL
         aWI4i8IVJNCVRyAE0lhe3ATui0q6FYFt7L+0CQzuU3YrR83rPhAtaikW0OJ3FHdy95IY
         qs+Q==
X-Gm-Message-State: AOAM5332nwJAAIKUfAe4RpBl1IdS/hsYsKyjILMfIhotnqNE4Sb9irwu
        hg/yPozelKPvnt41AVtoe8U1N/Gt7sA=
X-Google-Smtp-Source: ABdhPJxMup8wVF53PU3uNx8cm4UseWWI5TN9wmXGtb4bVC7lFQDOBxlzmwdRFxXF7qZ+kbM9IYfcHA==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr20929494wmb.155.1618823074501;
        Mon, 19 Apr 2021 02:04:34 -0700 (PDT)
Received: from [192.168.3.42] (inv-34.95.247.146.static.fprt.com. [146.247.95.34])
        by smtp.googlemail.com with ESMTPSA id m67sm21954568wme.27.2021.04.19.02.04.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 02:04:34 -0700 (PDT)
Subject: Re: [RFC PATCH v1 00/13][GSoC] doc: (monospace) apply
 CodingGuidelines on a large-scale
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
 <d2e78646-6735-2a27-735c-331de6411ca2@gmail.com>
 <87h7k9hq75.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
From:   =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>
To:     git <git@vger.kernel.org>
Message-ID: <ec10d2ae-f546-90d1-9b7a-96f25893405f@gmail.com>
Date:   Mon, 19 Apr 2021 11:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87h7k9hq75.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 13/04/2021 à 22:42, Firmin Martin a écrit :
> Hi Jean-Noël,
>
> Jean-Noël Avila <avila.jn@gmail.com> writes:
>
>> Le 09/04/2021 à 06:02, Firmin Martin a écrit :
>>> This patch series aims to make the documentation fully compliant to the
>>> CodingGuidelines regarding monospace font. After it, new contributors
>>> who just want to change a little portion of the documention could just
>>> look around how it has been done without being confused by the
>>> inconsistency between the documentation and the CodingGuidelines.
>>
>> Thank you for tackling the task of formating the docu and directing to
>> CodingGuidelines for some markup rules. It appears that the last rule
>> about backticks is wrong with late Asciidoctor, for which backticks are
> Thanks. As a new Git contributor, I used to think that we don't use asciidoctor,
> until I see in Documentation/Makefile:
>
>     ifdef USE_ASCIIDOCTOR
>     ASCIIDOC = asciidoctor
>     ...
>     ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
>     ...
>     endif
>
> So, we actually use both depending the variable USE_ASCIIDOCTOR. 
>
>> only a font switcher and no longer hold any semantic meaning. This means
>> that double-hyphens may need escaping (see:
>> https://asciidoctor.org/docs/migration/#migration-cheatsheet) when
>> switching style and tools.
> In the helpful link that you provide, it says that the "setext-style
> (i.e., two-line) section title" enables compatibility mode.  As far as I
> can tell, most man pages (git.*.txt) fall under this category, except
> the most important one: user-manual.txt.  But this is in fact not
> relevant, because the snippet above of the Makefile suggests that we
> actually explicitly running asciidoctor in compatibility mode.


If we are to continue using asciidoctor, I guess this compatibility mode
will be removed at some point in the future. I don't have all the
required inputs for how asciidoc and asciidoctor will evolve and may
split in their behavior, but here is how I see it:

There's now a working group whose interest is in standardizing asciidoc
and making the format evolve
(https://www.eclipse.org/org/workinggroups/asciidoc-charter.php). It is
led by the authors of asciidoctor, so I guess most of the path forward
for asciidoc format is asciidoctor and leaving compatibility mode behind
as a legacy format.


>
>> One other rule worth adding would be that tabs are banned from asciidoc
>> because they cannot always be matched with correct indentation.
> I'm an absolute novice regarding AsciiDoc vs. Asciidoctor. But from the
> user guide of AsciiDoc (https://asciidoc.org/userguide.html#_tabs), it says
>
>     By default tab characters input files will translated to 8
>     spaces. Tab expansion is set with the tabsize entry in the
>     configuration file [miscellaneous] section and can be overridden in
>     included files by setting a tabsize attribute in the include macro’s
>     attribute list. For example:
>
>     include::addendum.txt[tabsize=2] The tab size can also be set using
>     the attribute command-line option, for example --attribute tabsize=4
>
> ... and we also explicitly set it to 8 spaces (see above). Could you
> elaborate a bit on the matter ?

Tab management in asciidoc and asciidoctor was the source of a number of
bugs, because the markup relies on "visual" alignment instead of
semantic alignment. So you have to define tabsize in order for tabs to
be correctly interpreted. Instead of having to add specification, my
approach would be to just get rid of the source and the solution of the
issue at the same time.


