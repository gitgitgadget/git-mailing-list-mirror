Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180E0C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 23:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbjAFXjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 18:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbjAFXjX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 18:39:23 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589238CD25
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 15:39:21 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso2178208wmq.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 15:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1rtqU64OiJO+IPt4tT6Jb0Z/acR3M0s1K38Y6RA0EQ=;
        b=pLuVfeXG3lLUFvLOLTudpgwR0hvOVLNG8dagG29ELYp/6kIAx1VbPa26+675baYr2F
         DGFGV+D3FTHnOKkt35EO3X1BHhXDHaJXnj8xFs5HwfyqtCA27RLyTrFRyVItbZYSCfND
         TA+JagCmLUYc/rt7B9/RtUCK+JN61CDyeSRalCHzGOtycY18neiB7Fbdk/Sk79b5tATT
         YA3h93kCaZimz6dXyVdrTnX+euqmXY6hlRWbmYWPn4NlUvZzB/+6r/gHM+wEkxuLY7NE
         OSdHVPs9yBAwkRTnav7kqtDDqqsGnFEQkhi+/Zxh/10kJPcm5nZsWA1ToqLEHX1KhkK3
         fBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1rtqU64OiJO+IPt4tT6Jb0Z/acR3M0s1K38Y6RA0EQ=;
        b=ZDeNd0vZr6QvBc9n2howqkn0UQo2YDCIbnZfpZOAFnraftKlequ5P7mGlYzk2Wm7zj
         dFMACvHvEs+NavDCmXSbpDrtv7wVuXtlRLygsrUwtD5dNgCpV3eHkKkGpijBMgzHEMmM
         8oc4dzFhhjrXahXa72y+2cgQFvjlePjEQYCjavRFmZw/U5kWwpGXL6AwbOZmEHUFajvb
         +0fnM1ZaaU6F0k9vLTCJz187lDyW7R5ip+5DleQ1+iw3nDDbIWMHNWv7oqduFDH7srSe
         0XnSkPLw+EsZrqvAdKTGGCFb3QuPoxvk3ZnuabVZf+JReW7rEaz+PmHpLbaAojge8+x+
         f7LQ==
X-Gm-Message-State: AFqh2krbRZJpWHgdvdNG3dZ7zuBltCHFOKpeAuey4IqML2SOdPvy4b3m
        mTiM/BuIMb4WEXcmxDFexy4=
X-Google-Smtp-Source: AMrXdXvmpqxf5FU9BjAgl6jmzb505ZOhU1zyZ8yEe5qx3BBeOgU+iqUXMHiGocUxWRii9dHAXB8/JQ==
X-Received: by 2002:a05:600c:3b21:b0:3d9:bad8:4e9e with SMTP id m33-20020a05600c3b2100b003d9bad84e9emr13089369wms.40.1673048359791;
        Fri, 06 Jan 2023 15:39:19 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003b492753826sm2999560wme.43.2023.01.06.15.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 15:39:18 -0800 (PST)
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <dd86016b-3232-563b-940e-03bc36af917a@gmail.com> <xmqqy1qmhq8k.fsf@gitster.g>
 <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com> <xmqqr0wau6px.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <db348ac3-571c-f6ba-c889-9f476f4ae04b@gmail.com>
Date:   Sat, 7 Jan 2023 00:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr0wau6px.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04-ene-2023 15:58:02, Junio C Hamano wrote:
> 
> > -	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
> > -		if (copy && !strcmp(head, oldname))
> > +	if ((copy || !branch_checked_out(oldref.buf)) && !ref_exists(oldref.buf)) {
> 
> and wondering if the evaluation order to call branch_checked_out()
> unconditionally and then calling ref_exists() still makes sense, or
> now the strcmp() part of the original has become so much more
> costly, if we are better off doing the same thing in a different
> order, e.g.
> 
> 	if (!ref_exists(oldref.buf) && (copy || !branch_checked_out(oldref.buf))) {
> 

Thinking of this as a whole, perhaps after this series we can add:

-- >8 --
Subject: [PATCH] branch: copy_or_rename_branch() unconditionally calls

In previous commits we have introduced changes to
copy_or_rename_branch() that lead to unconditionally calling
ref_exists(), twice in some circumstances.

Optimize copy_or_rename_branch() so that it only calls ref_exists() once
and reorder some conditionals to consider ref_exists() first and avoid
unnecessarily calling other expensive functions.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index c14a7a42e6..6e70377a1a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -515,7 +515,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0;
+	int recovery = 0, oldref_exists;
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -523,12 +523,13 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		 * ref that we used to allow to be created by accident.
 		 */
 		if (ref_exists(oldref.buf))
-			recovery = 1;
+			oldref_exists = recovery = 1;
 		else
 			die(_("Invalid branch name: '%s'"), oldname);
-	}
+	} else
+		oldref_exists = ref_exists(oldref.buf);
 
-	if ((copy || !branch_checked_out(oldref.buf)) && !ref_exists(oldref.buf)) {
+	if (!oldref_exists && (copy || !branch_checked_out(oldref.buf))) {
 		if (copy && branch_checked_out(oldref.buf))
 			die(_("No commit on branch '%s' yet."), oldname);
 		else
@@ -558,8 +559,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!branch_checked_out(oldref.buf) || ref_exists(oldref.buf)) &&
+	if (!copy && oldref_exists &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))

base-commit: 64b4d8c0eb1938fa10477b9bd9aead2773456e3e
--

> >> Do we already cover existing "No branch named" case the same way in
> >> this test script, so that it is OK for these new tests to cover only
> >> the "not yet" cases?  I am asking because if we have existing
> >> coverage, before and after the change to the C code in this patch,
> >> some of the existing tests would change the behaviour (i.e. they
> >> would have said "No branch named X" when somebody else created an
> >> unborn branch in a separate worktree, but now they would say "No
> >> commit on branch X yet"), but I see no such change in the test.  If
> >> we lack existing coverage, we probably should --- otherwise we would
> >> not notice when somebody breaks the command to say "No commit on
> >> branch X yet" when it should say "No such branch X".
> >
> > I think we do, bcfc82bd (branch: description for non-existent branch
> > errors).
> 
> If we already have checks that current code triggers the "no branch
> named X" warning, and because the patch is changing the code to give
> that warning to instead say "branch X has no commits yet" in some
> cases, if the existing test coverage were thorough, some of the
> existing tests that expect "no branch named X" warning should now
> expect "branch X has no commits yet" warning.  Your patch did not
> have any such change in the tests, which was an indication that the
> existing test coverage was lacking, no?

Yes.  We did not have a test for 'No branch named' that implied an
orphan branch.  I think if we had tried that, we would have ended
up doing what we're doing now.

> 
> And given that, do we now have a complete test coverage for all
> cases with the patch we are discussing?

Considering 1/2 and 2/2, I think so. But if you're asking maybe
you're realizing something...
