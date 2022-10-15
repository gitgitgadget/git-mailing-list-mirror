Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75BC433FE
	for <git@archiver.kernel.org>; Sat, 15 Oct 2022 19:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJOTkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Oct 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJOTkw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Oct 2022 15:40:52 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803553FA1F
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:40:51 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot12so17090235ejb.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2022 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CbpHS/3hLZVZYkTKm0AAjmgtoEuztCu1lQFs0ORdaj0=;
        b=FV/j52HznjJ2bXrtvpjwwn43Z6YBD8UllKFJWKutfZEFAo3HR1l7gqGQAwO2MlPiwj
         QFod+yKPHGtXBgrUtlBMCv/oxPvK0tHDZdxNgFBl85dv+X06Oy8u69wx6UIYlTGaldWP
         T5zM3GYxU2o6J5KTfVm6ZZus5C3eKD04Nkog1cwodxWLxZwLZIIchq5i/XOwyiRPyXjv
         uPxvjy7G6S/CRpvCoMlLGCB+Bm5iEcE4rjAFN5RFE2684hMSKosWly9zVEwVDl4ugD+A
         thOfFVjDIm9fijDunnIRQyVZKu3hwrk5G2f+eXRx1hdosYb+WUZ0QUsziNJU+Eq7ceX8
         ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbpHS/3hLZVZYkTKm0AAjmgtoEuztCu1lQFs0ORdaj0=;
        b=biiP5oXBdR2r7pWC5iDhRMMHM3cP+uihgE4PQOKo+JKRsXdrnTNmtyOf3Lce9N+cdr
         mtS08uIfVHHuGRphleyTW8RAkpUPAASHAr7i58pBoENLAD23KoojvQLSygcT0/JVej60
         T3HqgSuCEMDkejYGJMgbujj5MH3Inva5+/Tld/O+LLj604doSbDmSt2T8wTnJO2qYRSH
         LQ7sTX1IrucwzYxRbjijw/vb6s0nbxE5a9fZy2ZEZn+nxmPExbzGGDLfbmRo4isFrUQv
         H3xvRGaWxx9vCYKYgqcsPyDefh3zIfud0o+rHdB8cGBeGxFw8roNa5c9/+JpM4XNeBRr
         jNEQ==
X-Gm-Message-State: ACrzQf0K1E149EqUDt7Zi1qnbi+K8BmYwqUGsrnss5AfvBqHyEQ4F2uz
        v5c0oUaB9+ANVbsch1ujpJI=
X-Google-Smtp-Source: AMsMyM7LJxjll00Euinh2k8SDnJNd8lh6ExFV1dyKS4VIGNlXmodMeO0KBY97/pp0nxX9n1AKQFlIg==
X-Received: by 2002:a17:906:9c82:b0:781:5752:4f2b with SMTP id fj2-20020a1709069c8200b0078157524f2bmr2862715ejc.561.1665862849907;
        Sat, 15 Oct 2022 12:40:49 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id a13-20020a50ff0d000000b00451319a43dasm4218264edu.2.2022.10.15.12.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 12:40:49 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b5e97527-433c-53fe-356a-e20ab3e087d2@dunelm.org.uk>
Date:   Sat, 15 Oct 2022 20:40:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note
 are both empty
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        --cc=avarab@gmail.com, tenglong.tl@alibaba-inc.com
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
 <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
 <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
 <221013.86sfjsknlw.gmgdl@evledraar.gmail.com>
In-Reply-To: <221013.86sfjsknlw.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 13/10/2022 11:23, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 13 2022, Phillip Wood wrote:
>>>> diff --git a/builtin/notes.c b/builtin/notes.c
>>>> index 1ca0476a27..cc1e3aa2b6 100644
>>>> --- a/builtin/notes.c
>>>> +++ b/builtin/notes.c
>>>> @@ -567,9 +567,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>>>>    	struct notes_tree *t;
>>>>    	struct object_id object, new_note;
>>>>    	const struct object_id *note;
>>>> -	char *logmsg;
>>>> +	char *logmsg = NULL;
>>> Hrm, interesting that (at least my) gcc doesn't catch if we don't
>>> NULL-initialize this, but -fanalyzer does (usually it's not needed for
>>> such trivial cases0. Anyawy...
>>
>> I don't think its written to if we take the 'else if' branch added by
>> this patch so we need to initialize it for the free() at the end.
> 
> Yes, sorry about not being clear. It *does* need to be uninitialized, I
> was just narrating my surprise at this not being a case where my
> compiler caught it when I was locally testing this.

Ah I think I slightly misunderstood your comment - I agree it is 
surprising that the compiler didn't catch that.

> 	@@ -638,21 +635,16 @@ static int append_edit(int argc, const char **argv, const char *prefix)
> 	 			BUG("combine_notes_overwrite failed");
> 	 		logmsg = xstrfmt("Notes added by 'git notes %s'", argv[0]);
> 	 		commit_notes(the_repository, t, logmsg);
> 	-	} else if (!cp.buf.len) {
> 	+	} else if (!d.buf.len) {
> 	 		fprintf(stderr,
> 	 			_("Both original and appended notes are empty in %s, do nothing\n"),
> 	 			oid_to_hex(&object));
> 	 	} else {
> 	-		fprintf(stderr, _("Removing note for object %s\n"),
> 	-			oid_to_hex(&object));
> 	-		remove_note(t, object.hash);
> 	-		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> 	-		commit_notes(the_repository, t, logmsg);
> 	+		BUG("this is not reachable by any test now");
> 	 	}
> 	
> This 2/2 makes that "else" test-unreachable, so whatever else we do here
> we should start by making sure that by adding the "else if" we still
> have test coverage for the "else".

Oh so we can just use d.buf.len directly - nicely spotted and kudos for 
checking the test coverage. Looking at the existing tests they are 
checking if an empty note is removed which suggests this patch is 
failing to distinguish between an existing empty note and no note. I 
think we probably need to be doing "else if (note && d.buf.len)" but 
I've not looked very closely.

Best Wishes

Phillip

