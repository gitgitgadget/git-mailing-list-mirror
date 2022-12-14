Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39774C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiLNTqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238984AbiLNTqw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:46:52 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8242186C3
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:46:51 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o13so7076320ilc.7
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URsCu/EJdtMqUt1t1KN9feJWUeHfbc52YGNnZeSYdm8=;
        b=KwGZgER5qez8A0FJG+1YYJPDCC0cF89xnZRqUNNoJQ5nq2niFABZSlFNrW+pHTtELt
         85Y8+8PfdDYvV+l/T6Ji9NMWJxkBg9L1vIJ9fzb4Soj6lJnRcJG/YYk7MjStXDeG5gr1
         5DksWiBdABPTts7pQhd4bEZTaUFJ5KKenivFaXR8S6n8aaf1QrVLt97FRhMGIz0G0fLX
         IusytrqdExbDlKeOsnrgIkaYopzgDJyO5vpQu5B4G2k+NEMxIME7z8juv83N6OwTmTjG
         2l/ng9z3+AhOTwyCyA/AbTftUCCSxk99x2UIcJc9o8mJJbJUTk8e72Pdnzl0JECM2WcX
         tbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URsCu/EJdtMqUt1t1KN9feJWUeHfbc52YGNnZeSYdm8=;
        b=ttFAkZcFwGJ/atNxeVhCW7ThJjy6bpKp3DAmUjLRka0MoZupA9zLCgmlLTkzlq8n1H
         Vn0EPwQ3s3P8HJhZ3e6H6IT8BIMOFdEpUYU9TYeo5oAX23h/zwb9p2/PZge/avb4H4TZ
         XUsrmGLLPPZ6M4TU7yjvABBpAyC05NSmhwxEjoV1xyzYBnKYINYhw8ODTTfa4s3V+AjT
         Sjwe3gCG0GYzG4Hm766SC4rvJ135WlmFRcdzqAgjKnCw2PT96L8EDfMihBF4B7Spy5Z2
         3AmSQL8mgPU5h4R0wMm89Zh3GeVHZ5hLM465461VupKp0b37OeljSZJ27s+AsLiJzOKW
         BLpw==
X-Gm-Message-State: ANoB5pm+jRNuhqEgo18RMm/KBvybabk5rtNKPETU2IXz29MEYb04pc3A
        069PjWyzLJEbqT7cTeuOUPsNb9NhDrZsZbj1
X-Google-Smtp-Source: AA0mqf5mJ7xx49c9ZAPMHAzJ5Egj8ar3Z9d//7uO56WIv1Qde7YyXDUFJNiOmWsI5V3mePYvzrSwDA==
X-Received: by 2002:a92:c6c4:0:b0:304:ac69:f9f6 with SMTP id v4-20020a92c6c4000000b00304ac69f9f6mr9913199ilm.22.1671047211139;
        Wed, 14 Dec 2022 11:46:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j12-20020a02630c000000b0038a590b8cb4sm2024678jac.179.2022.12.14.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:46:49 -0800 (PST)
Date:   Wed, 14 Dec 2022 14:46:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
Message-ID: <Y5ooJJLqPP0R2SAS@nand.local>
References: <xmqqiliewbje.fsf@gitster.g>
 <xmqq7cyuw9h4.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cyuw9h4.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 07:44:23PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> > In the past, I tried to re-examine all the topics in 'next' myself
> > to pick and choose the ones to be kept before rewinding and
> > rebuilding 'next' after each release, which took me a while.  This
> > time, to share the burden to expedite the process, I'll reset 'next'
> > to 'master' without any topics merged, and rely on input from list
> > participants.
> >
> > The topics that used to be in 'next' are all marked as "Will merge
> > back to 'next'", but people can tell me to give them a chance to
> > reboot their topics, instead of piling "oops, that was wrong" fixes
> > on top, while I wait for such an input for the coming days.
>
> What is involved in "re-examine to pick and choose the ones to be
> kept" was to go to the original thread (which should not be too
> hard, as Taylor has maintained the "source:" line in the report well
> during my absense) see general consensus and the reason behind the
> consensus back then still applies today.

Since it wasn't obvious to me, I figure it is worth mentioning that the
effort to maintain these source lines can be done via the "amlog" notes,
which are automatically filled in when applying new patches from the
list via your post-applypatch hook.

The relevant parts being:

  message_id="$(...)"
  if test -n "$message_id" && head=$(git rev-parse --verify HEAD 2>/dev/null)
  then
    echo "$head $message_id" >>"$GIT_DIR"/am.log &&
    (
      GIT_NOTES_REF=refs/notes/amlog
      export GIT_NOTES_REF
      git notes add -f -m "Message-Id: $message_id" "$head"
    )
  fi

I just made sure to push `refs/notes/amlog` up when doing new push-outs.
The rest (including the "source:" lines in the WC reports) was made easy
by your Meta/cook script.

Thanks,
Taylor
