Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F154C6FA99
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGVs5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 16:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjCGVst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 16:48:49 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C209DE0C
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 13:48:34 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p16so8695170wmq.5
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 13:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fangyi-io.20210112.gappssmtp.com; s=20210112; t=1678225713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8lDa0V+55hZDgn1NyZp8OmTliG994nJlF0yFPG1te1c=;
        b=KljpecQwY4v/Qvsmo2fEuyiROefdC0HrvEqdARsgvhdUFAn3YzSRgtDThMfF7uL9XF
         tEK1LnjzvgzLe+xEOrInbFiT32NFxRK2i8EH19uOUJQ3IjDpx1rk0IrP+k9nXit4825c
         1A3qkg658yj+Y37OfakwoXVunuQyRvNUsMyXUHLRGvpi00t14twDSBWop6J3srzAcl6m
         AmwNjrDW7vgB6giKMw6RDtg9VNSQH0jyBL1pdLm3U7sXloNdycwCRvlwzcHuukUNt0C0
         q8zox5OsfStFc2H665dLcHcPLVmqoFL1AcuoDtuyAlER1O1XKN86OqvK9hTLcmAm/W8p
         9A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678225713;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lDa0V+55hZDgn1NyZp8OmTliG994nJlF0yFPG1te1c=;
        b=J2f623VHh2fotnJQAfyRK7I+FIlTFYth/HgR1mqNCE0380Do6fdgAgfHjhIn3rTIUj
         dwOPcXbE3qjDSAmuJAD2sx7PahrzFCfyTCrED9EHnmpAmGaId6Qtbn9F7fBv+cKi8uV1
         7EgDZ6LzKU5eE9y58sxSBmRQYCpnyR85rhDRpUzxqbB6w9exyi2fB6j7Tgn4was16gKp
         oFv4XCUtYKHvH9Z05qTaTpLuKGOXgJzf7cYvpT0vp271Vgm4v4g011pbq77h/ftUI56X
         M4gFf/wyvRXYVe/sz0joY4jU3T503dFEqG9HHXta2mQpBpO8iKz0vGe2df/Jn1tbjMv0
         yvjQ==
X-Gm-Message-State: AO0yUKXYY90iBzf1XT5+nVWp9uzxdUeroXW0VCe4NiF8uMwbfXMc6S/2
        vAOcZnJqVxXXnCjbIuzqu13JCg==
X-Google-Smtp-Source: AK7set+0W1gyuoiOBoaotA1+banfniJhbE6c3zJ242HQ7rL32pmU52aCJYqRM+WIMkRG92ZxxLZyLg==
X-Received: by 2002:a05:600c:ad3:b0:3ea:e667:b1ee with SMTP id c19-20020a05600c0ad300b003eae667b1eemr13684413wmr.38.1678225712857;
        Tue, 07 Mar 2023 13:48:32 -0800 (PST)
Received: from [192.168.0.23] (cpc157871-brnt5-2-0-cust279.4-2.cable.virginm.net. [86.4.97.24])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dd1bd0b915sm19579753wms.22.2023.03.07.13.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 13:48:32 -0800 (PST)
Message-ID: <37ed877d5927c7cebba7e47769be3a069eacd6c6.camel@fangyi.io>
Subject: Re: fz/rebase-msg-update (2023-02-27)
From:   Fangyi Zhou <me@fangyi.io>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Date:   Tue, 07 Mar 2023 21:48:31 +0000
In-Reply-To: <xmqqpm9kw9no.fsf@gitster.g>
References: <xmqqcz5snyxz.fsf@gitster.g>
         <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
         <xmqqttyww9tl.fsf@gitster.g> <xmqqpm9kw9no.fsf@gitster.g>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2023-03-07 at 13:09 -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > Fangyi Zhou <me@fangyi.io> writes:
> >=20
> > > This patch is actually a hotfix for a topic added in v2.40.0 RC
> > > 2c6e5b32aa (Merge branch 'en/rebase-incompatible-opts', 2023-02-
> > > 03),
> > > could it be reviewed and included in the release?
> >=20
> > Is it?=C2=A0=20
> >=20
> > If a message used to say autoSquash 2.39 series and 2.40-rc2
> > has it autosquash, then it may be a hotfix, but otherwise no.
>=20
> Besides, localizaiton teams are already working on what has been
> in 'master'; it disrupts their workflow to change end-user message
> under them.
>=20

The patch fixes a newly added i18n string, not the option itself,
see
https://github.com/git-l10n/pot-changes/blob/pot/main/2023-02-04.diff
I found the issue while conducting the localisation for v2.40.0.
