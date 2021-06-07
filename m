Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A027C47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E121E60FEF
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFGRAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:00:55 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35645 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhFGRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 13:00:55 -0400
Received: by mail-wr1-f51.google.com with SMTP id m18so18440388wrv.2
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vea0g5WmTYd390n9vVHzgD74ssz5oi9aQx2ohDggjy0=;
        b=uDZ0U0cU0nDhflSwSQuOOHHERBM88yDDf7HUNPKhhtMWdk5rUZuuilrOTZL+xOQHwH
         U74f6lD0fkLBelVgzaciOrtRaC36lFmaJRE/UX1s7jDTgTHzhKAcFnkcBsjHZnrPQxo9
         wzgZQqBpaiXCOL/XeH6OmCgBnrLQdKArgEjFAsp40liI2NL+JOffmfrm1+K2BxDF/Qs2
         0cvaiYKD9b/4u54NCP/VMFKFiFuREWM+OlbX/Lfgl3sDK6zNz/DzJ7puacAQAz0RvARu
         +k0a8TsUqNeT8kiJjZfU/kl9SGRJndDvdb9xoQr3B8SqqxA1M3xc79sk9KOcoJIUH7sn
         9eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vea0g5WmTYd390n9vVHzgD74ssz5oi9aQx2ohDggjy0=;
        b=X8HpalmoeJCGkb+8HklgIQr4ErLXh4OqY4hKwum59KBCMT1aTVR4ps8omtzyaSxbiY
         ENaTmqrFCAooLf8Ca/sVW9nDWvO5WC6Wljgz99I+1MtoLmWOqwVwlP47NcKoWfIR/MAk
         J5amK72YYAk7e+b6OQ1y3XOlSM+3R/k25Elqip62LO1H9vHZwSMNcn4cY+ohU9TvK6fq
         A+DcJfKgIofI3rgC3o7pmMWUm793Jr2MwRc6VN/VsxRPM5P405gr1vsJRGYlvv7nlud4
         9Mljs/xhj/s5FkZ1M8LwcbVrJ0LOcpkoogfTwiBH+bynT+Yx13wyBDvZYxc3DKxG1sU6
         vwTA==
X-Gm-Message-State: AOAM530Iyr+ZI1r4Sra87TcN69XPQwpadIfTd8Av/FbP1C4HMkZ94Trt
        IfArNewkIkImJD0HAuz3LD1kbworb2M=
X-Google-Smtp-Source: ABdhPJw16+cvirpyY22Y7mStIG3BaIMBt0kYktTNYyrtLiyhi3Ct0s00gvpdCC1vcTObM7xo5Xdq1w==
X-Received: by 2002:adf:e60f:: with SMTP id p15mr17706506wrm.135.1623085072772;
        Mon, 07 Jun 2021 09:57:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm18498378wre.8.2021.06.07.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:57:52 -0700 (PDT)
Message-Id: <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 16:57:48 +0000
Subject: [PATCH 4/4] CodingGuidelines: recommend singular they
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Technical writing seeks to convey information with minimal friction. One
way that a reader can experience friction is if they encounter a
description of "a user" that is later simplified using a gendered
pronoun. If the reader does not consider that pronoun to apply to them,
then they can experience cognitive dissonance that removes focus from
the information.

If we use singular "they/them" pronouns instead of "he/him" or "she/her"
pronouns, then we can avoid this congitive load on the reader.

Using singular "they" is also incredibly efficient. Choosing a gendered
pronoun is usually arbitrary between "he" or "she". Using constructs
such as "he or she", "s/he", or "(s)he" are more complicated than
singular "they".

When choosing a gendered pronoun, that pronoun no longer applies to
nearly half of possible readers. Even if we alternated between "he/him"
and "she/her" perfectly evenly, we would still expect male and female
readers to experience an incorrect pronoun half the time. However, some
readers will not prescribe to either of these binary genders. Those
readers hence suffer an incorrect pronoun the entire time. Singular
"they" applies to every reader.

Perhaps due to similar reasons, official style guides have changed their
stance on singuler "they" in recent years. For example, the APA style
guide changed their official recommendation in 2019 [1]. The MLA
handbook also references helpful ways to use singular "they" [2]. While
not fully endorsing it, the Chicago Manual of Style has removed its
blanket ban on singular "they" [3] (the previous recommendation was to
only use "it" as a singular non-gendered pronoun).

[1] https://apastyle.apa.org/blog/singular-they
[2] https://style.mla.org/using-singular-they/
[3] https://libraries.indiana.edu/chicago-manual-style-singular-pronoun-they

While not all styleguides are updating their recommendations, we can
make a choice as a project to adopt the concept because of the
efficiencies above, as well as the benefits of increased inclusion.

To futher justify singular "they" as an acceptable grammatical concept,
I include the careful research of brian m. carlson who collected their
thoughts on this matter [2] (lightly edited):

  Singular "they" has been used by native English speakers as part of
  the language for over half a millennium and is widely used and
  understood. This usage is specified in Merriam Webster[3]:

    The use of they, their, them, and themselves as pronouns of
    indefinite gender and indefinite number is well established in
    speech and writing, even in literary and formal contexts.

  Wiktionary notes[4] (references omitted):

    Usage of they as a singular pronoun began in the 1300s and has been
    common ever since, despite attempts by some grammarians, beginning
    in 1795, to condemn it as a violation of traditional (Latinate)
    agreement rules. Some other grammarians have countered that criticism
    since at least 1896. Fowler's Modern English Usage (third edition)
    notes that it "is being left unaltered by copy editors" and is "not
    widely felt to lie in a prohibited zone." Some authors compare use of
    singular they to widespread use of singular you instead of thou.

  Linguists fit roughly into two camps: prescriptive and descriptive.
  The former specify rules for people to use, and the latter document
  language as it is actually used without forming a judgment.

  Some prescriptivists think it is acceptable, and some do not. But
  descriptivists will rightly note that it is and has been commonly
  used in English across countries, cultures, and contexts for an
  extended period of time and is therefore generally accepted by most
  English speakers as a normal part of the language.  Since we are
  writing text for an English language audience who are mostly not
  linguists, we should probably consider using the language that most
  people will use in this context.

[2] https://lore.kernel.org/git/YKrk4dEjEm6+48ji@camp.crustytoothpaste.net/
[3] https://www.merriam-webster.com/dictionary/they
[4] https://en.wiktionary.org/wiki/they

If we refer to a specific person, then using a gendered pronoun is
appropriate. Examples within the Git codebase include:

* References to real people (e.g. Linus Torvalds, "the Git maintainer").
  Do not misgender real people. If there is any doubt to the gender of a
  person, then use singular "they".

* References to fictional people with clear genders (e.g. Alice and
  Bob).

* Sample text used in test cases (e.g t3702, t6432).

* The official text of the GPL license contains uses of "he or she", but
  modifying the license this way is not within the scope of the Git
  project.

Other cases within the Git project were cleaned up by the previous
changes.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/CodingGuidelines | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index e3af089ecf26..78cd399f7cf5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -648,3 +648,8 @@ Writing Documentation:
  inline substituted text+ instead of `monospaced literal text`, and with
  the former, the part that should not get substituted must be
  quoted/escaped.
+
+ When referring to an anonymous user, use singular "they/them" pronouns
+ as opposed to choosing between "he/him" and "she/her". Do not use more
+ complicated constructs such as "he or she" or "s/he". This recommendation
+ also applies to code comments and commit messages.
-- 
gitgitgadget
