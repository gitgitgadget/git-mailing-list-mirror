Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62DDC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 14:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjCVOVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 10:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCVOVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 10:21:39 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A24164B3D
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 07:21:22 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a5so1115796qto.6
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nearearth.aero; s=google; t=1679494881;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bwVxBKeDZ/pbXUXqjOAXu1g0MbR4Be2cv26amhxoB8=;
        b=TkBuNIADzbJsvI/IUxBwDuvH562Iz+c9Kpiwie1JbxGztTd/LQRADHaEBUFMHObZpj
         9xhNKA7pOSaaXOBE4Fk3dEvGwenvmQqJcCFBhgS6tgicdssy8Lhe0rotPSc9K9iE56Hr
         tyZqnTctlgaGmrVbNHobBPB1mFvbop8/Sa/Jq3HZW8+C3PgCVmZjSTGXcakeIgZ54deY
         bpYReLO6DqwRGkfEEXmbEZnz1GRraSi1JhTevyC4jvk24SkcMovFR2A7nvFKfmEpPaX6
         EHW/dar7pYw5epTLbKgZrHaTViubxLfAd1zKImurf/BXdzJ7jsRzK84l3jEuMGD7WkmI
         R/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494881;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bwVxBKeDZ/pbXUXqjOAXu1g0MbR4Be2cv26amhxoB8=;
        b=zsBtIR87+lAsAHj5nfY4jNIu0WGqNgOvpQgHLaZIEP45QclR06zqFq6e12VlnHsgv8
         h3Sif4A5zKpsXQpJjrUpMGFl5arP90ZBZ9olBo56jFBhHIu/a7dtHgR3zXJPWT494h9A
         t1tpOKDi7BaIpml8easBtEdGHtaKHy3u+H3hjV4vWwn3eGBkkRv4oPVhHeXCMlGD1d6U
         x49/+mtg3kjkCKl8lGzXJImgJbXJqCye+6nQB1y+XQ+PBXYAV2Gi3OYoQmgZWnYKatdQ
         kcNokbhdjhXcE1KX7Wtu7vod+uk38OAq1wOsA7oHc5c3rrQIlHh7nWPuUQ3L/Q4gKwqt
         qJMA==
X-Gm-Message-State: AO0yUKWk9mRLyZWm/TMx2K4SgYWsTW02uzQZMCxh/h1SEG1B5EA8uI4E
        H2cghVXagvO50OA491vcqa4l16B93tLNRKswUaU=
X-Google-Smtp-Source: AK7set/U7voB94cI/SqhvTsleGesYsxfF25voClvD0TJsaGnLDMBZW/Qbepp3gZAi0ouxY7l3+UOCg==
X-Received: by 2002:ac8:58d0:0:b0:3bf:a5fb:6d6e with SMTP id u16-20020ac858d0000000b003bfa5fb6d6emr6531876qta.29.1679494881115;
        Wed, 22 Mar 2023 07:21:21 -0700 (PDT)
Received: from smtpclient.apple ([184.81.152.146])
        by smtp.gmail.com with ESMTPSA id o22-20020ac85556000000b003e302c1f498sm4510845qtr.37.2023.03.22.07.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:21:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: Feature Request: Ignore Tracked IDE files
From:   Ward Hopeman <ward.hopeman@nearearth.aero>
In-Reply-To: <m0fs9w7upa.fsf@epic96565.epic.com>
Date:   Wed, 22 Mar 2023 10:21:19 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5C64C207-8CE4-4D42-A001-E473D827E99A@nearearth.aero>
References: <94EFF553-E498-46D9-B14A-3500FEDEBB47@nearearth.aero>
 <m0o7ol6ta7.fsf@epic96565.epic.com>
 <ACA3ECE1-689A-4BFD-A8EE-9CFF30128C1C@nearearth.aero>
 <m0fs9w7upa.fsf@epic96565.epic.com>
To:     Sean Allred <allred.sean@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the info Sean. 
Best regards,
Ward
>

> On Mar 22, 2023, at 9:55 AM, Sean Allred <allred.sean@gmail.com> wrote:
> 
> 
> Ward Hopeman <ward.hopeman@nearearth.aero> writes:
>> [...] but I agree there appears to be an alternative available. I will
>> pursue those configurations with the team.
> 
> Best of luck! Managing settings across a team is always an 'interesting'
> experience :-)
> 
>> I am curious if you think there is a class of files, under the
>> paradigm I outlined; that need to be tracked initially but then
>> ignored for regular workflows? Just curious at this point if this was
>> discussed / considered previously.
> 
> It comes up every now and again, but in lieu of specific examples, it
> always 'seems' to be the wrong approach. The Notes section of
> git-update-index(1) talks about this a bit:
> 
>> Users often try to use the assume-unchanged and skip-worktree bits to
>> tell Git to ignore changes to files that are tracked. This does not
>> work as expected, since Git may still check working tree files against
>> the index when performing certain operations. In general, Git does not
>> provide a way to ignore changes to tracked files, so alternate
>> solutions are recommended.
>> 
>> For example, if the file you want to change is some sort of config
>> file, the repository can include a sample config file that can then be
>> copied into the ignored name and modified. The repository can even
>> include a script to treat the sample file as a template, modifying and
>> copying it automatically.
> 
> --
> Sean Allred

