Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B1FC20401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752946AbdF0Sqa (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:46:30 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35980 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbdF0Sq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:46:28 -0400
Received: by mail-pf0-f182.google.com with SMTP id q86so20731282pfl.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xfWSl9YBMImByb3DwK1jSrQi0Lwg0V/DKNQbFOBBgII=;
        b=KI9oDUxQPOmuT/dfOzo2EmpEd0Mj3L2bq9OuxtiaEHl1V4uGu2C9bvsloE+qFkJjop
         Cc69fjDDZMVnV28BE7C2kS24NXnc5rP1suCkVLEc4vHWoDZQ4JR9cgMIhApT13KoRyfj
         Y0ax+cazq/6xJ+hUhS+UzAfnh93N92nZS9QbpMRec6x+ykg3noTJGFX40PU7SHSfgadN
         nCm8fKidRhBfXau0uzwm8kXHDIo2gIdYmfVq51+E6oaKrF/i8fzk4TB7FdxmbiGqnAQv
         zBF8imKXRUaW19S6znzovfhCKKR+uPlKljIwMpS4xa/7KKTit9Uf5vorH+Xo+EeXSk9U
         l7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xfWSl9YBMImByb3DwK1jSrQi0Lwg0V/DKNQbFOBBgII=;
        b=KMGO5ywkKBl4ylwXeMb5sbdCVeIdlqSr/IrhL7VK+DPRKtnr9RFb25FK3oqE/x4CGp
         x+twOKoVf4ERZ75qXeLFFNSSypAHMWq7V5XvktH/M9qrSSKnT+p2NvymrjOqO3iaW9AE
         KOLkYJtzKx9kEKx/qVRG8Yd4IXfpxaRLSOJ7J0A/1NJjqvAv6XJcJvP3KDGKLTAv9hnh
         EIrsfZDZghb5WC5zCov0441OlvmYF++BugFhtN0APoXmkNVi0TdQ3c/LtjT9v67dGnZ7
         aYsTmo5buYv90/XPxC4pU4yFClYRodGE2C+3XMmfrQxFMmKHPeka3P5V5C8sm1rwI7rN
         op/A==
X-Gm-Message-State: AKS2vOyjdfuJnyrV46+K5nbTmMxkA8Rw+9PkMjB5Zzm+Ad45/PMOsPD/
        6ZhQAXxWKwzVel5aX0dfdrQetYr1I8jT
X-Received: by 10.99.141.76 with SMTP id z73mr6690196pgd.40.1498589188198;
 Tue, 27 Jun 2017 11:46:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 27 Jun 2017 11:46:27 -0700 (PDT)
In-Reply-To: <20170627121718.12078-3-avarab@gmail.com>
References: <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
 <20170627121718.12078-1-avarab@gmail.com> <20170627121718.12078-3-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Jun 2017 11:46:27 -0700
Message-ID: <CAGZ79kYzZqAm9AgiXAanBTzJfHStebCy9Z6MvhniRjS3s1wG-Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] sha1dc: optionally use sha1collisiondetection as a submodule
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 5:17 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Add an option to use the sha1collisiondetection library from the
> submodule in sha1collisiondetection/ instead of in the copy in the
> sha1dc/ directory.
>
> This allows us to try out the submodule in sha1collisiondetection
> without breaking the build for anyone who's not expecting them as we
> work out any kinks.
>
> This uses my own fork which integrates PR #36. See the preceding
> commit ("sha1dc: update from my PR #36", 2017-06-27) for details.
>

> +++ b/.gitmodules
> @@ -0,0 +1,4 @@
> +[submodule "sha1collisiondetection"]
> +       path =3D sha1collisiondetection
> +       url =3D https://github.com/avar/sha1collisiondetection.git
> +       branch =3D bigend-detect-solaris-again

What is the motivation for the branch field here?
While this series fixes a hot issue, in the long run we'd rather
want to plug in the original upstream with the master branch?
