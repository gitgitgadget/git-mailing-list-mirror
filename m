Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B5031F454
	for <e@80x24.org>; Fri, 19 Oct 2018 03:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeJSLlv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 07:41:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55140 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeJSLlv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 07:41:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so2194936wma.4
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 20:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k9rj7wsGjUB4dZx4s+htbSI+1J/4DHss7rNqcweiPP8=;
        b=SxNvKODM3uFaj05tR/AmM3x/beU5gHgSruhjIuTo746StWSI8tl4dhyf3PiP74wNuf
         8f03ADpUnEuSmRyCWlb9LFyy3uniwr/Gdkw8TmWMMkmSDoO9VitUMdFKz/CLvexBTD1p
         XPBEfDNYqSnySwaBbG7o/SEl35N27wMnINtV+NRVHae7l0h69y7e1HrhUnSmxODMoHRs
         sz2QzTcm44bbOGDu9C7mncRdSJrS9SK/YyDRkyzTYAXFMNfsU3f9vyA7+pnbfANGpTfR
         in/UWjSFabmRnmk7IuGxSvnPQjIYl/eJeVNPpjzGQCI4KNcGTzksuBeb6FIQwZV767GE
         dvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k9rj7wsGjUB4dZx4s+htbSI+1J/4DHss7rNqcweiPP8=;
        b=NdvbVp8fgmolTo2mmyd962nwgf6jXEASoi3Peh5OGph78TLCxYCj0Dl78RZfXA8qdy
         w2X6eHatLLNP3dz2JjNjAjmSZT8Ya9V4eFS8NSWonx2jc8ZGG01dKNXhrIRIiFAftS17
         vncQ9QkFNbWU9V8quc+RkzsnYuIbOMGNoAO3tsTrRFgIo8DtYqbiqdGEdv2u3vdiBo1r
         L/shPvInb5VjPxCcfENn5/pxio7NSbFndjyZVHor1FHRIswQzz/eYvyBW2gH0eD9PHSB
         7+eb5l9yHHYuiT0cMjStoMQlmIffXoYM3Mac8DtrEnZRMOBBzW957ddXmldrpRflSudM
         QLmQ==
X-Gm-Message-State: ABuFfohWBBR7lo4v/kV8aWKqwlzCRyWXjlr2zwXlWkUnqhKvrgSwcvxe
        eWVyc0JzYDrCgKvDQ8Y7clBV2PYqBMc=
X-Google-Smtp-Source: ACcGV61pd4lXqAZElOKEtSrw47MUzX4oRQQIIaGlGEPtAAmEJLmrOInyJleo9FTcZZax8rhJ0gWD8A==
X-Received: by 2002:a1c:8b94:: with SMTP id n142-v6mr3010741wmd.38.1539920259105;
        Thu, 18 Oct 2018 20:37:39 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k7-v6sm1222960wmf.22.2018.10.18.20.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 20:37:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rajesh Madamanchi <rmadamanchi@gmail.com>
Subject: Re: receive.denyCurrentBranch=updateInstead updates working tree even when receive.denyNonFastForwards rejects push
References: <CANahLXm7O6scvLdaL6bm14d5oGM5Zp+S-rpQDo554ssagRFNoQ@mail.gmail.com>
        <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 19 Oct 2018 12:37:36 +0900
In-Reply-To: <xmqqsh124wqb.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 19 Oct 2018 09:16:12 +0900")
Message-ID: <xmqq4ldi38u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Rajesh Madamanchi <rmadamanchi@gmail.com> writes:
>
>> Hi, I am looking to report the below behavior when seems incorrect to
>> me when receive.denyCurrentBranch is set to updateInstead and
>> receive.denyNonFastForwards is set to true.
>
> It seems that we took a lazy but incorrect route while adding the
> DENY_UPDATE_INSTEAD hack to builtin/receive-pack.c::update() and new
> code went to a wrong place in a series of checks.  Everythng else in
> the same switch() statement either refuses or just decides to let
> later step to update without taking actual action, so that later
> checks such as "the new tip commit must have been transferred", "the
> new tip must be a fast-forward of the old tip", etc., but the one
> for DENY_UPDATE_INSTEAD immediately calls update_worktree() there.
> It should be changed to decide to later call the function when
> everybody else in the series of checks agrees that it is OK to let
> this push accepted, and then the actual call is made somewhere near
> where we call run_update_hook(), probably after the hook says it is
> OK to update.

So here is a lunch-time hack that is not even compile tested but
illustrates the idea outlined above.  We'd need to add tests to
protect the fix from future breakages (if the fix is correct, that
is, which I do not quite know---but it feels right ;-).

 builtin/receive-pack.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7f089be11e..4bf316dbba 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1050,9 +1050,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 				refuse_unconfigured_deny();
 			return "branch is currently checked out";
 		case DENY_UPDATE_INSTEAD:
-			ret = update_worktree(new_oid->hash);
-			if (ret)
-				return ret;
+			/* pass -- let other checks intervene first */
 			break;
 		}
 	}
@@ -1117,6 +1115,12 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		return "hook declined";
 	}
 
+	if (deny_current_branch == DENY_UPDATE_INSTEAD) {
+		ret = update_worktree(new_oid->hash);
+		if (ret)
+			return ret;
+	}
+
 	if (is_null_oid(new_oid)) {
 		struct strbuf err = STRBUF_INIT;
 		if (!parse_object(the_repository, old_oid)) {
