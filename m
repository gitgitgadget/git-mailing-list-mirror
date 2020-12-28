Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC78C43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC760223E8
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 15:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441040AbgL1PTP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 10:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408383AbgL1PTO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 10:19:14 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8203AC061796
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 07:18:33 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id j18so5053412qvu.3
        for <git@vger.kernel.org>; Mon, 28 Dec 2020 07:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZOMOBFrpzo2QG51CyjOywFxbWpPp6wqdvfG/khVPxP4=;
        b=DaU00P04dGhakG0A9PAPamb6FS7WY/y+CHbBdldm8/3W+wdCSxPM6oBVM7/Sam79yp
         lDvJFNmiZVQ230/vgwWV8btGGCALwSQYpptksNDNkJRsg1w2l5WigvCdscSrhQX6LhNV
         HiKWuhfCAE6hZD/HD1xwkwoYvIw95cS0xpobucM87/jWYMkDxQqMq7gEpFrhY5SbVMTb
         ztCMPNCYOIusO9wrHkyy49+wwLbwKA+ScqvZBEJmzYzsOIvtt/zcKycTRhOgk7pw5XBy
         hIzctNxvcwB8wRERtC6bxo79baWZekBaAjWkEgkanrRnPKFHtOXC0717rssT8KpjOgup
         DsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZOMOBFrpzo2QG51CyjOywFxbWpPp6wqdvfG/khVPxP4=;
        b=hPDL6CzC2D++akWqmyZ2kagyLqOLN+GjCbnr2Rxovwf7dfUgK3fgxWyxOnTPAUb7dF
         t8LKr8GHxmSrHpymJOFwx7GhkyrFGy1XSTJ+HaUkglaxEwKbkOhRuHiLaN2vgO4gNIh+
         ydyH4+owHTS/xbny2/KnG8Jzc7DWCgcZHd+1NvCxf6gbw3IgbTSwK60z/yu7Yi85i2Ya
         nIbBxp/KFFchvu2VgzoyYexyS1GbkV37HvtIsgGoAUSCFqVb8WSQNzsWgJ5NKkXhYhih
         mqIIWYFdVdosGrtNMEbLPRYWo0B/YjozyCU2IZ+dxDGa5DLpj1A+0ZqlXrEQHuz4lmX/
         yi6A==
X-Gm-Message-State: AOAM531xqYMoncEf/oibItrnYen7LuYk7ou5QeqmZgLHcgA5/iD4fJ7V
        pOBDbMfVl1ydi2eux8OP3CcsCv4wC9xfPw==
X-Google-Smtp-Source: ABdhPJwKPtTrWoRHR4mMAUcoMguGanArXLUV7o92zFVBHJdQ7aa3aJsvfnbpYN0vxpdKBCxZP82xVQ==
X-Received: by 2002:ad4:4083:: with SMTP id l3mr47213703qvp.17.1609168712081;
        Mon, 28 Dec 2020 07:18:32 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id g26sm23477264qkl.60.2020.12.28.07.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 07:18:31 -0800 (PST)
Subject: Re: [PATCH] CoC: update to 2.0
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b92d69e-bb21-5c49-b1de-c5474c6660b9@gmail.com>
Date:   Mon, 28 Dec 2020 10:18:30 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 7:59 AM, Junio C Hamano wrote:
> At 5cdf2301 (add a Code of Conduct document, 2019-09-24) we adopted
> a Code of Conduct from www.contributor-covenant.org; back then the
> version adopted, 1.4, was the latest one.
> 
> Version 2.0 tightens language in examples of unacceptable behaviour,
> generalizes the audience from "contributors and maintainers" to
> "community", and enhances the enforcement section.

I approve of using the contributor covenant verbatim, and keeping
it updated occasionally as they find ways to improve it is a good
idea.

Acked-by: Derrick Stolee <dstolee@microsoft.com>

> -In the interest of fostering an open and welcoming environment, we as
> -contributors and maintainers pledge to make participation in our project and
> -our community a harassment-free experience for everyone, regardless of age,
> -body size, disability, ethnicity, sex characteristics, gender identity and
> -expression, level of experience, education, socio-economic status,
> -nationality, personal appearance, race, religion, or sexual identity and
> -orientation.
> +We as members, contributors, and leaders pledge to make participation in our
> +community a harassment-free experience for everyone, regardless of age, body
> +size, visible or invisible disability, ethnicity, sex characteristics, gender
> +identity and expression, level of experience, education, socio-economic status,
> +nationality, personal appearance, race, religion, or sexual identity
> +and orientation.
> +
> +We pledge to act and interact in ways that contribute to an open, welcoming,
> +diverse, inclusive, and healthy community.

This is a more active-voice way to say the same thing. Good.
  
>  ## Our Standards
>  
> -Examples of behavior that contributes to creating a positive environment
> -include:
> +Examples of behavior that contributes to a positive environment for our
> +community include:
>  
> -* Using welcoming and inclusive language
> -* Being respectful of differing viewpoints and experiences
> -* Gracefully accepting constructive criticism
> -* Focusing on what is best for the community
> -* Showing empathy towards other community members
> +* Demonstrating empathy and kindness toward other people

I like that this one is at the top.

> +* Being respectful of differing opinions, viewpoints, and experiences
> +* Giving and gracefully accepting constructive feedback
> +* Accepting responsibility and apologizing to those affected by our mistakes,
> +  and learning from the experience
> +* Focusing on what is best not just for us as individuals, but for the
> +  overall community
>  
> -Examples of unacceptable behavior by participants include:
> +Examples of unacceptable behavior include:
>  
> -* The use of sexualized language or imagery and unwelcome sexual attention or
> -  advances
> -* Trolling, insulting/derogatory comments, and personal or political attacks
> +* The use of sexualized language or imagery, and sexual attention or
> +  advances of any kind
> +* Trolling, insulting or derogatory comments, and personal or political attacks
>  * Public or private harassment
> -* Publishing others' private information, such as a physical or electronic
> -  address, without explicit permission
> +* Publishing others' private information, such as a physical or email
> +  address, without their explicit permission
>  * Other conduct which could reasonably be considered inappropriate in a
>    professional setting

This last one is a good reminder that remains constant: behavior in the
community should be assumed to meet the bar of a professional setting.
This means different things to different people, so the extra examples
help clarify the expectations.

> -## Our Responsibilities
> +## Enforcement Responsibilities
>  
> -Project maintainers are responsible for clarifying the standards of acceptable
> -behavior and are expected to take appropriate and fair corrective action in
> -response to any instances of unacceptable behavior.
> +Community leaders are responsible for clarifying and enforcing our standards of
> +acceptable behavior and will take appropriate and fair corrective action in
> +response to any behavior that they deem inappropriate, threatening, offensive,
> +or harmful.
>  
> -Project maintainers have the right and responsibility to remove, edit, or
> -reject comments, commits, code, wiki edits, issues, and other contributions
> -that are not aligned to this Code of Conduct, or to ban temporarily or
> -permanently any contributor for other behaviors that they deem inappropriate,
> -threatening, offensive, or harmful.
> +Community leaders have the right and responsibility to remove, edit, or reject
> +comments, commits, code, wiki edits, issues, and other contributions that are
> +not aligned to this Code of Conduct, and will communicate reasons for moderation
> +decisions when appropriate.
>  
>  ## Scope
>  
> -This Code of Conduct applies within all project spaces, and it also applies
> -when an individual is representing the project or its community in public
> -spaces. Examples of representing a project or community include using an
> -official project e-mail address, posting via an official social media account,
> -or acting as an appointed representative at an online or offline event.
> -Representation of a project may be further defined and clarified by project
> -maintainers.
> +This Code of Conduct applies within all community spaces, and also applies when
> +an individual is officially representing the community in public spaces.
> +Examples of representing our community include using an official e-mail address,
> +posting via an official social media account, or acting as an appointed
> +representative at an online or offline event.
>  
>  ## Enforcement
>  
>  Instances of abusive, harassing, or otherwise unacceptable behavior may be
> -reported by contacting the project team at git@sfconservancy.org. All
> -complaints will be reviewed and investigated and will result in a response
> -that is deemed necessary and appropriate to the circumstances. The project
> -team is obligated to maintain confidentiality with regard to the reporter of
> -an incident. Further details of specific enforcement policies may be posted
> -separately.
> -
> -Project maintainers who do not follow or enforce the Code of Conduct in good
> -faith may face temporary or permanent repercussions as determined by other
> -members of the project's leadership.
> -
> -The project leadership team can be contacted by email as a whole at
> -git@sfconservancy.org, or individually:
> +reported to the community leaders responsible for enforcement by
> +email as a whole at git@sfconservancy.org, or individually:
>  
>    - Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>    - Christian Couder <christian.couder@gmail.com>
>    - Jeff King <peff@peff.net>
>    - Junio C Hamano <gitster@pobox.com>
>  
> +All complaints will be reviewed and investigated promptly and fairly.
> +
> +All community leaders are obligated to respect the privacy and security of the
> +reporter of any incident.
> +
> +## Enforcement Guidelines
> +
> +Community leaders will follow these Community Impact Guidelines in determining
> +the consequences for any action they deem in violation of this Code of Conduct:
> +
> +### 1. Correction
> +
> +**Community Impact**: Use of inappropriate language or other behavior deemed
> +unprofessional or unwelcome in the community.
> +
> +**Consequence**: A private, written warning from community leaders, providing
> +clarity around the nature of the violation and an explanation of why the
> +behavior was inappropriate. A public apology may be requested.
> +
> +### 2. Warning
> +
> +**Community Impact**: A violation through a single incident or series
> +of actions.
> +
> +**Consequence**: A warning with consequences for continued behavior. No
> +interaction with the people involved, including unsolicited interaction with
> +those enforcing the Code of Conduct, for a specified period of time. This
> +includes avoiding interactions in community spaces as well as external channels
> +like social media. Violating these terms may lead to a temporary or
> +permanent ban.
> +
> +### 3. Temporary Ban
> +
> +**Community Impact**: A serious violation of community standards, including
> +sustained inappropriate behavior.
> +
> +**Consequence**: A temporary ban from any sort of interaction or public
> +communication with the community for a specified period of time. No public or
> +private interaction with the people involved, including unsolicited interaction
> +with those enforcing the Code of Conduct, is allowed during this period.
> +Violating these terms may lead to a permanent ban.
> +
> +### 4. Permanent Ban
> +
> +**Community Impact**: Demonstrating a pattern of violation of community
> +standards, including sustained inappropriate behavior,  harassment of an
> +individual, or aggression toward or disparagement of classes of individuals.
> +
> +**Consequence**: A permanent ban from any sort of public interaction within
> +the community.
> +

This new "mechanisms of enforcement" section is new, but helpful.
It provides guidelines for leaders and expectations for community
members.

>  ## Attribution
>  
> -This Code of Conduct is adapted from the [Contributor Covenant][homepage],
> -version 1.4, available at https://www.contributor-covenant.org/version/1/4/code-of-conduct.html
> +This Code of Conduct is adapted from the Contributor Covenant,
> +version 2.0, available at
> +https://www.contributor-covenant.org/version/2/0/code_of_conduct.html.
>  
> -[homepage]: https://www.contributor-covenant.org
> +Community Impact Guidelines were inspired by
> +Mozilla's code of conduct enforcement ladder.
>  
> -For answers to common questions about this code of conduct, see
> -https://www.contributor-covenant.org/faq
> +For answers to common questions about this code of conduct, see the FAQ at
> +https://www.contributor-covenant.org/faq. Translations are available
> +at https://www.contributor-covenant.org/translations.

I approve of this change in its entirety. Thanks for putting up with
my (supportive) comments.

Thanks,
-Stolee
