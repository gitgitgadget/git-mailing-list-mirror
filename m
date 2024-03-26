Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE89179
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711412152; cv=none; b=JR+4WEv7sNZaitd6lLqWVsFPhwj/8XKoN9hrdeu61MipcrQ74HVEWlsdK879Po78vdoHFRB3u66GAnJhOMSCoVh9k5qc/PQQxHfrulSsDwUmSfMwKEORcapUvkewxRLNJM9vxxrYnf1Em16yHMiqeDiMLvUmFdupVxgcqioAPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711412152; c=relaxed/simple;
	bh=pjmhFACCQKkH8TIEZbyV9wCVWoZIC0aXC2j8atn8v8w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GakcbG+ymaZ04AMQ7l7PFI4FBqHhq0iaD/4ILKl4rgn08vylKJT1emVJpEx4Rm3GrqOotl4qcwIo9fjja7C3aMWbeFuw61D3Rson6i3uCWokdc9G5MyR+YFQOobTOgonwZC7qo//UkLnPN1FO9IGVjdhlDiTkykboUfyb0XLEbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRbXOuqG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRbXOuqG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-341d730bdfcso142748f8f.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 17:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711412149; x=1712016949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUsNygZHgTImfBJwcfJV4uBH060GgBavC8EkMuPHDvM=;
        b=DRbXOuqGe+fDIWiu/Aq1ryDO8BCpXcZ23aBokMBndYH0h28XsbBrof1DWH7nH3CIbZ
         NnSo/yNwqCHav/Wz3j/45ljR+rDFgf2SIGmy7oL6O1Ch8xIvNjDiabMFU6UMopUJdSrE
         dr8eFyd2OS/qoeq0wyJxfSHEbDD27x2jJtjRtuFR1RzX1gbWEmUPRecM3ra7P1k3kfk+
         QcE8dFU9LliFPXswmejTVXu8zCHjPl2Tlmy8eiCKS+SA0JnAZ88PVEYgicm/cv3XBgkJ
         GxFgxSi3mF9/JQ7au+eVs8NXDlmvof1+cw+3DXUcrlcwWadl5FTZ47RXatTR+M2h3qhm
         ka2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711412149; x=1712016949;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUsNygZHgTImfBJwcfJV4uBH060GgBavC8EkMuPHDvM=;
        b=S/ez8TpwSbhQPPgmCQBW37vs53fprhcSzY6abQ/PlkpwHit/wmKi8/1+4wIJwF+lMY
         UiWtngx7HCwXR5J3enOa4gNPnVBm/qxAj3I6lWPPurVh2wS33MKkJWThYHED71XRj95M
         RMZvcWpbPPkL9sJEzzgnK58H0QhKF/beZksB9WFL2+lC1QhUo5Yyagu/8YJGzM5ahT/x
         upvOspkHyMHiEsb7bRxoUYkyOZw1ZHDGnjmuM6kx8sWOBfwAAQ55CkcYe7X5oqkpsIzF
         7PGoWeaDrJbORilI1SW09zFtrbwJzKEbFMN3OXp8BmCiBVuhwqiuTCamJHBg5Ezxc7l0
         lmDA==
X-Gm-Message-State: AOJu0YzsrcRsYUIE4NmXpnCeRJlLJvhz7p666IuS8ex4giin02vxkz4/
	ieE1Naa0x/iRGZY0c7wB5MwnifZBlh54kftv1U1uQojeEyVWW+jzLPZDnSvU
X-Google-Smtp-Source: AGHT+IFsGVWAluKQG9nKdrVrdVonmxggK2Pii9zsWTXrI1j+E+uRVIMa9yTXoyJDSfs2bcvKMv3X4w==
X-Received: by 2002:a05:600c:511f:b0:414:7db2:8be5 with SMTP id o31-20020a05600c511f00b004147db28be5mr6582417wms.26.1711412148474;
        Mon, 25 Mar 2024 17:15:48 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id g4-20020a05600c310400b0041462294fe3sm9803893wmo.42.2024.03.25.17.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 17:15:48 -0700 (PDT)
Message-ID: <6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
Date: Tue, 26 Mar 2024 01:15:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/2] improve interactive-patch
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
In-Reply-To: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's reduce the verbosity in the interactive-patch process, in order to
make it less confusing.

Rubén Justo (2):
  add-patch: introduce 'p' in interactive-patch
  add-patch: do not print hunks repeatedly

 Documentation/git-add.txt  |  1 +
 add-patch.c                | 20 +++++++++++++++-----
 t/t3701-add-interactive.sh | 22 +++++++++++-----------
 3 files changed, 27 insertions(+), 16 deletions(-)

Range-diff against v1:
1:  48a2c63b78 ! 1:  5e319f439d add-patch: introduce 'p' in interactive-patch
    @@ Commit message
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    + ## Documentation/git-add.txt ##
    +@@ Documentation/git-add.txt: patch::
    +        K - leave this hunk undecided, see previous hunk
    +        s - split the current hunk into smaller hunks
    +        e - manually edit the current hunk
    ++       p - print again the current hunk
    +        ? - print help
    + +
    + After deciding the fate for all hunks, if there is any hunk
    +
      ## add-patch.c ##
     @@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
         "/ - search for a hunk matching the given regex\n"
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				goto soft_increment;
      			}
     +		} else if (s->answer.buf[0] == 'p') {
    -+			/* nothing to do */
    ++			/* nothing special is needed */
      		} else {
      			const char *p = _(help_patch_remainder), *eol = p;
      
2:  1730493096 ! 2:  1177bfeae4 add-patch: do not print hunks repeatedly
    @@ Commit message
             g - select a hunk to go to
             / - search for a hunk matching the given regex
             e - manually edit the current hunk
    +        p - print again the current hunk
             ? - print help
             @@ -1394,7 +1394,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
              static int patch_update_file(struct add_p_state *s,
    @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      				goto soft_increment;
      			}
      		} else if (s->answer.buf[0] == 'p') {
    --			/* nothing to do */
    +-			/* nothing special is needed */
     +			prev_hunk_index = -1;
      		} else {
      			const char *p = _(help_patch_remainder), *eol = p;
-- 
2.44.0.494.gfaa70abb0d
