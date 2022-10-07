Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F043C433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 11:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJGLMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJGLMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 07:12:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB5FA2207
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 04:12:06 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z3so5563296edc.10
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u/+HPdT+d8YLmXNqPzDBh1DvyFo9AUZ2OnskkQh1gkM=;
        b=aKM7Ijru/RqnkIv1q5B7/JFHsn9Fx1IaRGU2hrE4t1IAU6w7WBR/KWqVHbQMMtY66m
         ItgnUIEVeOl2BCRM1EHaBERERdxydagdfzGeOtZo/487NvmLbWZbgHCdMfYlQO7eWAVO
         kYZrN71GKqNPoVS+R6n+R7oa/yEyvg47c0CedM4pYrkMe0yd8MJ/Kv3dRaiBeKwJBXYr
         jvfH/g2EPUBVL80X0B1bO3d0VfScSzVYi+Ls4skjkurXdrigUVd9R5Bco0UVq4MrFpd+
         avyjvnXGoP6SMiD/RAwYDKEr8qlUB64Gq7jpgj2643mbxFOX+OlzKWixc0douYoniO76
         MaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/+HPdT+d8YLmXNqPzDBh1DvyFo9AUZ2OnskkQh1gkM=;
        b=cYoKyl/kVQQolC6MsH58LLyt+RqgQqgg/2n833KtjylFFgH8PqX+IGXIa4ytJz+P7M
         1eJnOuW7099xJeGVBpH0+VIIRk3il8JWQRUnaTJmFnm1yToH0Tdouirig/aA+/UfRryl
         abLJ8RlOZXF2jIh7m+7/J9QJ9aqNu9wc+S2mQmPo05E2ClWcFsdZjEjf2GOw8Mf40BFs
         6utY82MZSJHz8i9Ftzx60AnY3tHbMFDfb/63IFsrlO+vyfBoqVc1cW9aIYD3NRiBOmHG
         WZe5nb0LAuI9ASUFnPzS6jlXjJt2TTeevw7IA7ANBsdim/wrfNPhBNN8aQv5905nbj/z
         0ByA==
X-Gm-Message-State: ACrzQf3FtgglmMbs+9awdPe6ZK84CrhlTmWpl7lplDEeF4Gm1AWX6eHs
        dwe4iwtJBFlA36xEMK4g6UM=
X-Google-Smtp-Source: AMsMyM4uFe+SvYX5HoKGAEjOp/m067Du4UOWcXMeoUxrGVsn2LkDAUE5m5LKmK37DLnZ4pOaLZq5Uw==
X-Received: by 2002:a05:6402:5162:b0:457:6ef2:df3 with SMTP id d2-20020a056402516200b004576ef20df3mr4073363ede.128.1665141125378;
        Fri, 07 Oct 2022 04:12:05 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id nb36-20020a1709071ca400b007820bb9350fsm1037390ejc.206.2022.10.07.04.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:12:04 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oglGt-003OTE-2e;
        Fri, 07 Oct 2022 13:12:03 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: sudmodule.<name>.recurse ignored
Date:   Fri, 07 Oct 2022 13:09:39 +0200
References: <20221007060713-mutt-send-email-mst@kernel.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221007060713-mutt-send-email-mst@kernel.org>
Message-ID: <221007.86wn9bq458.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 07 2022, Michael S. Tsirkin wrote:

> THE CONFIGURATION OF SUBMODULES
>        Submodule operations can be configured using the following mechani=
sms (from highest to lowest precedence):
>
>        =E2=80=A2   The command line for those commands that support takin=
g submodules as part of their pathspecs. Most commands have a boolean
>            flag --recurse-submodules which specify whether to recurse int=
o submodules. Examples are grep and checkout. Some commands
>            take enums, such as fetch and push, where you can specify how =
submodules are affected.
>
>        =E2=80=A2   The configuration inside the submodule. This includes =
$GIT_DIR/config in the submodule, but also settings in the tree such
>            as a .gitattributes or .gitignore files that specify behavior =
of commands inside the submodule.
>
>            For example an effect from the submodule=E2=80=99s .gitignore =
file would be observed when you run git status
>            --ignore-submodules=3Dnone in the superproject. This collects =
information from the submodule=E2=80=99s working directory by running
>            status in the submodule while paying attention to the .gitigno=
re file of the submodule.
>
>            The submodule=E2=80=99s $GIT_DIR/config file would come into p=
lay when running git push --recurse-submodules=3Dcheck in the
>            superproject, as this would check if the submodule has any cha=
nges not published to any remote. The remotes are configured
>            in the submodule as usual in the $GIT_DIR/config file.
>
>        =E2=80=A2   The configuration file $GIT_DIR/config in the superpro=
ject. Git only recurses into active submodules (see "ACTIVE
>            SUBMODULES" section below).
>
>            If the submodule is not yet initialized, then the configuratio=
n inside the submodule does not exist yet, so where to obtain
>            the submodule from is configured here for example.
>
>        =E2=80=A2   The .gitmodules file inside the superproject. A projec=
t usually uses this file to suggest defaults for the upstream
>            collection of repositories for the mapping that is required be=
tween a submodule=E2=80=99s name and its path.
>
>            This file mainly serves as the mapping between the name and pa=
th of submodules in the superproject, such that the
>            submodule=E2=80=99s Git directory can be located.
>
>            If the submodule has never been initialized, this is the only =
place where submodule configuration is found. It serves as
>            the last fallback to specify where to obtain the submodule fro=
m.
>
>
> However, when we are talking about the recurse attribute, it is
> not taken from .gitmodules - only command line and .git/config seem
> to be consulted.
> Is this a bug or a feature?

It's a (security) feature. We have had disussions[1] about how to safely
read in-repo config, but we are very far away from that becoming a
reality (if it ever happens).

If we read this from the .gitmodules the repo could change how you
interact with your submodules.

1. https://lore.kernel.org/git/YzXwZQbM69eNJfm7@nand.local/
