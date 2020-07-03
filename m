Return-Path: <SRS0=CKFy=AO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE62C433DF
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 06:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5FA204EA
	for <git@archiver.kernel.org>; Fri,  3 Jul 2020 06:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsEJmzEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgGCGW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jul 2020 02:22:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B800C08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 23:22:59 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x62so23163297qtd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 23:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=orerAZOSTQ7BBphuneQv6QpYSEvRtiAmrE5RYpxMdIc=;
        b=DsEJmzEnivmNvYxAek7Ni+z7xrzJKK2mNHwSyBwhzylIBm5UKzmfzoHHiQ+cLDpjCl
         2eXAV7NSu3T/NKdlgjPwY8x+aBC944gFDb2KoKwOnn+hK9I6kngm7QM7Wh8vCwZF+ZdK
         csriI4GJuC+y94H+IxMkLN0I8kK1XBYwC/zv5HyPDHI0xFML5nM9JHgDcKDC8a9rZamS
         ZViurxdjIG6DG5xSKJ+TCFoWtHcSAtoCWRGK0m+eZYrEoPFrmWDgrGVJKgVdUtm31kRj
         duhF9C2Srib+OXd2+IDUp51rsf2JSv+LwynoYUXLn/pReWmu/GuUPenUawRmwaUrBHxL
         HeRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=orerAZOSTQ7BBphuneQv6QpYSEvRtiAmrE5RYpxMdIc=;
        b=Zf2U1nNylhk2g1ltb5lu+87Y4h+/TsC7XKr6xrdi9Pu0edtDq7TmzIA7Um/pYy56r9
         7VHRqbU952jh/pxxV6dOLuz+9lL7ZxLySp5PSI2eCRkvcTDacogTfvc0d/WfnAezhxM9
         cn4YrYfJ48IA8YbwtembNu2MihoPLjPF9FwezJsThVcYUkFb4vidXCBlORCCAgAHqkTZ
         HHkSAPyB+DXUECsYysbiiasco7zowXzXZxDEzItRcF+UKENHhvhoo5ZsV4Z9sF/XH6I4
         eZtaQOY5jJyzCRr+WmFdlAcZxidVIzt7KbShVY4m5aVT6PJB+VEhuG+PM4r6NqfgpYme
         sD8w==
X-Gm-Message-State: AOAM532QfmCSrzbMAd5gBJMy2hPASq+25996++GKX2i2lWdG4ahqMccG
        I2SQQhgtnIaeScDxVNu7JOhB0CXsdTKWJZkQX8A=
X-Google-Smtp-Source: ABdhPJy7Xs3xHgBZiYPR4ZfTBLcshrghNOnDeDnDTYQVXyOsrMJdLSsAVyEiN03Ka+XdPG6NPhj2k4D/VyeeMSPCAbY=
X-Received: by 2002:aed:202e:: with SMTP id 43mr225492qta.85.1593757378278;
 Thu, 02 Jul 2020 23:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com>
 <0e9801d6508d$c1f55560$45e00020$@pdinc.us> <03df01d6508f$873cc320$95b64960$@nexbridge.com>
In-Reply-To: <03df01d6508f$873cc320$95b64960$@nexbridge.com>
From:   demerphq <demerphq@gmail.com>
Date:   Fri, 3 Jul 2020 08:22:47 +0200
Message-ID: <CANgJU+XM2Y-Dp5odRfSecqYeZQ+Ft0okvB6RNUs=hyAdJDJ-gw@mail.gmail.com>
Subject: Re: Is git compliant with GDPR?
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, Git <git@vger.kernel.org>,
        Matthew Horowitz <mhorowitz@pdinc.us>,
        Jakub Trzebiatowski <cubuspl42.1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2 Jul 2020 at 18:42, Randall S. Becker <rsbecker@nexbridge.com> wro=
te:
> I am not speaking for the Git Foundation here, nor am I a lawyer; However=
, to use some practices from some of my customers who have this concern, th=
e team members are directed to use tokenized names and email addresses that=
 can be resolved by their security teams during an audit. Obviously the tea=
m members recognize the tokens so they know who is making what change. This=
 means that externally, any names/emails that might get pushed upstream are=
 non-identifying.

I think this is a really good point. I think git could make itself
much more GDPR friendly by having some support for this type of idea
built in.

Not sure how it could work, maybe some kind of object that can be
deleted after the fact which maps an identifier used for the author
with name and email. If that name and email change the object can be
updated, and if there is a need to "forget" the author, the object can
be deleted. The object would not be shared on clone, so it would stay
private to the repo that held it.

I guess you can argue that this isnt git's problem. But at a corporate
level, it will be seen as git's fault regardless if it cause a big
disruption. It could/would also be a reason that european companies
might decide not to use git.

cheers,
Yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
