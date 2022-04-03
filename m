Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A81C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 14:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiDCOmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 10:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiDCOmp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 10:42:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CED632ED0
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 07:40:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ot30so5144645ejb.12
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=aoLMPEmIE+gwx8CYVLsAoCv4bD+3gXh7kECV6wOJjd0=;
        b=FXkZfo+LnRcczelRuffea9sPCOq1gJihTqI6f+8Wu0FAtS1Ol45TBbUTPgtauadPlE
         9R6en4GpImo5CmOfKyOMEtJi8RfO82yAqN3yKhppWKXdGhIHzLoM+Kzwl6wixh8qzolt
         QD8RLtpxEGZGXknWGlvWkmBwAIfQ1mU4PzIF66DJEhjNl/m5pz1Qoj3N61DterGXmHzh
         HLTUaLSDeXSg0CiXJp6C7+aA7j2gwS9YS2tyT1uhgJlWuwxbPIgKZXvYlrr/0Vd36YMO
         b9UIou4Skx/7LlXF3r3vNS7qHOj3KGMa2N/OLFrDPl2QEwJtifQFencnVOgdJ7x0ghC2
         dqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=aoLMPEmIE+gwx8CYVLsAoCv4bD+3gXh7kECV6wOJjd0=;
        b=2lh93jLCCkTOoauMI0+cfdspalMNg3U0iloV/1kl14fH31k0qhe69szLXsc4/ejafz
         xMtR6fb2HVj0YAjStDASfhDXmLP+Qolu1ac/GB5rIBrKMXXdXaOq88E/E8CeYG1puu3S
         0gqpnJhDvDL31VYOLRYAWCGB3Z4YW1S/xfbgUiz80a4PfEPMWkcD/OMxANwSi8C2HAql
         +LA8LbGThSVCCBK61Gwvq+v/Dy0WkuGsqv4RUU6ynR5VHNdGac756lQN37s/1qlj48yf
         vsxoDbDF/lwl2Pg9dr05cGGPUtO21wVst+RaLrRebY025UdBbsqRT/9dLzPKVbaHt2xM
         BSJw==
X-Gm-Message-State: AOAM5330P+nSeHC2UXFkGXDlv7pL9QzJ0NQf7Dv69zkpXECuC4JMu9Zb
        rn9kwTnHJ5J8oL+lqtxoGd4SSGldwLA=
X-Google-Smtp-Source: ABdhPJySZ38ucSL/WqXWrwkbqv5bVW19OZ7SDGrvU0Zjl5kqsX7lVMZAL5Jrg8YOhBfJikeojsw8Pw==
X-Received: by 2002:a17:906:99c2:b0:6d7:4a6a:e35d with SMTP id s2-20020a17090699c200b006d74a6ae35dmr7029448ejn.633.1648996850078;
        Sun, 03 Apr 2022 07:40:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qp27-20020a170907207b00b006e66a4e924bsm1859285ejb.201.2022.04.03.07.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:40:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nb1PM-002F0y-Om;
        Sun, 03 Apr 2022 16:40:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 4/6] i18n: factorize "foo does not take arguments"
 messages
Date:   Sun, 03 Apr 2022 16:39:43 +0200
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
 <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
 <6221c37145c22a79bc1598be1e82be50d61636cc.1648915853.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6221c37145c22a79bc1598be1e82be50d61636cc.1648915853.git.gitgitgadget@gmail.com>
Message-ID: <220403.86sfqukz67.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 02 2022, Jean-No=C3=ABl Avila via GitGitGadget wrote:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> The messages are split into the ones for ref-filter which deal with
> atoms and scalar which has an option.

I see the git-for-each-ref manpage doesn't really refer to these
consistently, but I tihnk s/atom/format/g or s/atom/name/g would be lot
more obvious, especially in the context of how these are already
discussed in the manpage.

> @@ -317,7 +317,7 @@ static int objecttype_atom_parser(struct ref_format *=
format, struct used_atom *a
>  				  const char *arg, struct strbuf *err)
>  {
>  	if (arg)
> -		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take argume=
nts"));
> +		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take argumen=
ts"), "%(objecttype)");
>  	if (*atom->name =3D=3D '*')
>  		oi_deref.info.typep =3D &oi_deref.type;
>  	else

