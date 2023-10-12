Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20243CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 07:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347085AbjJLHw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjJLHw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 03:52:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C3B7
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 00:52:26 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so1240996a12.2
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 00:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697097145; x=1697701945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n4TN59KS42FhWb3cHgM7SuBm/Oko8GV0482SdfWth7A=;
        b=dIgFNxdhQeq8muQg7l8094zDqYHPRwToQJ7Bz3n5bqBVOPzNXHf7yzb50gO0/nAqpo
         dONDibachRiYARTYlhg9wZK9OOhKysO7o1WwmFL0UM1XbTE8kXiXlfXshQxt9tSMuE6j
         PU4frdWlatigGwndfTh4f5PBm1/LmK0RgN09WiP6T8TxKPuxwteYIaqzOTpD9aiKSY3H
         p4qszZlbt/pPD7SZMaS0qIy0q3MwFFAGZjiR8nCK0dodGFwHE9yKUoR0tniskyXhOIY7
         Sdus2HiLq3myULHu/FUxakBQxok1Uteerg3CRdep2wl+0bdp8ZqloF8dPvoKgR78d0fh
         y7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097145; x=1697701945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4TN59KS42FhWb3cHgM7SuBm/Oko8GV0482SdfWth7A=;
        b=SCL67VAOpN1qnoObsMqKw4cXy9BI2k4+v26Fjo3B6H05mK1bKUDQYJR9GBNuoO/zR1
         BNE8BZlOWru9DjRpCNaK/VdpLUtQe7QskN+CVDxcRbk3MzAx7vpZtNA1Bag/+j5ROwJk
         ubHO/Jg4Gewp2DTJ9T3bDmb8xxt1b4FwenlK8U+7VHFka+skACrigusr9LnSuCBR3Va9
         rOpFOvXvH2j9kcZC4pgYiuQ/oAqu/w8PjEKHMnHgYtSSx5gBU03m5WoLTlWh5pwgF7G+
         bZ44O3ShMrJ+BW1KEuVXT0UxeH7CUiX3Py3YaduoG27AYVAgXx5qvglNT0T6c+a4/eMB
         B2BA==
X-Gm-Message-State: AOJu0YyLmqkWHBpGc3F3t1uzMrwAtptoI7CVq76h0UYHcvEaOhhBGLbF
        OmT6Crvacf9fauOLGbXoi7A6KGYMNTbR6JY=
X-Google-Smtp-Source: AGHT+IFno3TEz1I1aRVgmDLS51ELLcn/8jkhSX77EE7Ytv5lCXEbGl7uuBl0jKpUkkapl3aNRAV4cg==
X-Received: by 2002:a17:907:724b:b0:9b2:b9ff:dc35 with SMTP id ds11-20020a170907724b00b009b2b9ffdc35mr23593723ejc.70.1697097144383;
        Thu, 12 Oct 2023 00:52:24 -0700 (PDT)
Received: from dorcaslitunya-virtual-machine ([105.163.2.146])
        by smtp.gmail.com with ESMTPSA id op13-20020a170906bced00b009a13fdc139fsm10788969ejb.183.2023.10.12.00.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:52:24 -0700 (PDT)
Date:   Thu, 12 Oct 2023 10:52:20 +0300
From:   Dorcas Litunya <anonolitunya@gmail.com>
To:     Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc:     benson_muite@emailplus.org, git@vger.kernel.org
Subject: Re: [Outreachy]Introduction and Problem while installing Git
Message-ID: <ZSeltAdIAm4miL3U@dorcaslitunya-virtual-machine>
References: <ZSeYzdx07Cj67lR4@dorcaslitunya-virtual-machine>
 <4c5fef38-a671-dd6b-4b10-a531e1ae254a@emailplus.org>
 <724ff75e-1557-4d87-85a6-a3a58d41af1f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724ff75e-1557-4d87-85a6-a3a58d41af1f@app.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2023 at 09:43:55AM +0200, Kristoffer Haugsbakk wrote:
> On Thu, Oct 12, 2023, at 09:28, Benson Muite wrote:
> > You maybe able to get these from a package manager, for example on Ubuntu
> > sudo apt-get install curl-dev
> 

> This didn't work for me on Ubuntu 22.04. I tried the OpenSSL variant which
> worked.
>
Me too
>     sudo apt-get install libcurl4-openssl-dev
> 

This package has worked for me on Ubuntu 22.04
Thanks for the help!
> Now I can drop `NO_CURL=true`.
> 
> Thanks :)
> 
> -- 
> Kristoffer Haugsbakk
