Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A2571F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 21:12:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732808AbeGLVXo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 17:23:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732341AbeGLVXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 17:23:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id c4-v6so10377286wrs.12
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 14:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F0AmRQdK8L9EUqdhrR+0euy43vRtScVBUkf53sWQHYw=;
        b=GbzxaIamGgUaFk7US1g+u3faFEHh/oWiVtypgwu0fte96bcGfL1oV6M2sO/P7PaxFj
         RngpOQYW0GsdQfDBkBJ5F36YYcH1EIFy1gSDFleFNfFxqKMgbn6sL2TH2fonvZKRsTKZ
         /HkrEvNsEGXfBWhzjTOPmVaSfLwYsqrsu074A/6mRjOQVSH60d5LMw9OoMCyaWvi4dwu
         uvej0SWIj+oOQyXpaeBx6vhQw4sutnb+CbBzbLceJFM6Bh0H8tONqk8nZgUqViU3P5pE
         WclrX+wIeGg6BtCpb5japC0WQmayzDsnOjRs3JQfBmF4Td+FthTbszIZUNTPVRoDT/BN
         DICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F0AmRQdK8L9EUqdhrR+0euy43vRtScVBUkf53sWQHYw=;
        b=mQ6h5QK3NwcTe2XQvOH4qbHqO+ohYfzr/0pWsLtRnhl/WCwNmC2F/il12EtrMpiHgB
         ZvBQ9hSXwCM3+C/xDwTBCux5KPKSPODe8+m7LN87f5+j2jXKhnwFJzngz3iNKCc/aqbh
         0RJotp0Ckmu2+9jXrhoC/Voz7xNqG/g39/EPdAEofM/xAu4KojzEeFhMXq9XUC+pwONT
         zEdTMVXWb1lg3ZMAh3v5Fr/YZTgMYEq45D3lOpNfN7yVBk/kftOf/bSfpYI/iU0PDZ1p
         Oh/igs9OTSp4NgmeP8AKuPPlzmmeryt+Ms64bKlSyqmxZq3aaoe4C/rd4FPFpH9P4sKT
         m84w==
X-Gm-Message-State: AOUpUlGsiD7KvyciDzMpqhuBjeVw7JLGWaM2V56F+vn6dVd2rIW56WOK
        iEeB8fnpKl8N8pMjBuvd/Hx4ec72
X-Google-Smtp-Source: AAOMgpdcgPfce9kcrQIASVhAeE4SI9J+miW/Sbm6hsieWVlFP7RHqSZOlyBpo1kirvbAgn26gtrFzg==
X-Received: by 2002:a5d:4e49:: with SMTP id r9-v6mr2725394wrt.27.1531429942156;
        Thu, 12 Jul 2018 14:12:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a17-v6sm19978956wrr.81.2018.07.12.14.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 14:12:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] git-submodule.sh: align error reporting for update mode to use path
References: <20180712194754.71979-1-sbeller@google.com>
        <20180712194754.71979-2-sbeller@google.com>
Date:   Thu, 12 Jul 2018 14:12:21 -0700
In-Reply-To: <20180712194754.71979-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 12 Jul 2018 12:47:49 -0700")
Message-ID: <xmqqa7qwupje.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> All other error messages in cmd_update are reporting the submodule based
> on its path, so let's do that for invalid update modes, too.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Makes sense.

>  git-submodule.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 5f9d9f6ea37..8a611865397 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -627,7 +627,7 @@ cmd_update()
>  				must_die_on_failure=yes
>  				;;
>  			*)
> -				die "$(eval_gettext "Invalid update mode '$update_module' for submodule '$name'")"
> +				die "$(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
>  			esac
>  
>  			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
